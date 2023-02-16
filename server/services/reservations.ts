import { PrismaClient, Spot } from '@prisma/client';
const prisma = new PrismaClient();

enum ReservationState {
    REQUESTED = 0,
    BOOKED = 1,
    CANCELED_BY_USER = 2,
    CANCELED_BY_ADMIN = 3
}

function getDatesBetween(startDate: Date, endDate: Date) {
    const dates = [];
    const theDate = new Date(startDate);
    while (theDate < endDate) {
        dates.push(new Date(theDate));
        theDate.setDate(theDate.getDate() + 1);
    }
    dates.push(endDate);
    return dates;
}

class TreeNode<T> {
    parent: TreeNode<T> | null;
    children: TreeNode<T>[];
    value: T;

    constructor(value: T) {
        this.value = value;
        this.parent = null;
        this.children = [];
    }

    addChild(child: T | TreeNode<T>) {
        if (child instanceof TreeNode) {
            child.parent = this;
            this.children.push(child);
        } else {
            const newChild = new TreeNode(child);
            newChild.parent = this;
            this.children.push(newChild);
        }
    }

}

class ReservationService {
    public async getReservationProposalsAsync(startDate: Date) {
        const until = new Date(startDate.getMonth() + 3);
        return null;
    }

    public async getUnavailableDatesAsync(from: Date, to: Date): Promise<Date[]> {
        const reservations = await prisma.reservation.findMany({
            select: {
                from: true,
                to: true
            },
            where: {
                from: {
                    gte: from
                },
                to: {
                    lte: to
                },
                OR: [
                    {
                        state: ReservationState.BOOKED
                    },
                    {
                        state: ReservationState.REQUESTED
                    }
                ]

            }
        });

        const allDates = reservations.flatMap(r => getDatesBetween(r.from, r.to));
        const uniqueDates = [...new Set(allDates)];
        return uniqueDates;
    }

    private async readSpotsAsync(from: Date, to: Date): Promise<Spot[]> {
        return await prisma.spot.findMany({
            where: {
                from: {
                    gte: from
                },
                to: {
                    lte: to
                },
                isEnabled: true,
                reservedBy: null
            }
        });
    }


    private async buildSpotTreeAsync(startDate: Date, endDate: Date): Promise<TreeNode<Spot>[]> {
        if (startDate > endDate) return [];

        const pool = await this.readSpotsAsync(startDate, endDate);
        if (pool.length === 0) return [];

        const onSameDay = (d1: Date, d2: Date) =>
            d1.getFullYear() === d2.getFullYear() && d1.getMonth() === d2.getMonth() && d1.getDate() === d2.getDate();

        const roots = pool
            .filter(s => onSameDay(s.from, startDate))
            .map(s => new TreeNode<Spot>(s))

        if (roots.length === 0) return [];

        const followUpSpots = (spot: Spot) => {
            if (spot.to.getDay() != 0) return [];
            const nextDay = new Date(spot.to.getDate() + 1);
            return pool.filter(s => onSameDay(s.from, nextDay) && s.isEnabled && !s.reservedById);
        }

        const expandTree = (tree: TreeNode<Spot>) => {
            const children = followUpSpots(tree.value);
            children.forEach(c => {
                tree.addChild(c);
                expandTree(tree.children[tree.children.length - 1]);
            });
        }

        const chains: TreeNode<Spot>[] = [];
        roots.forEach(r => {
            expandTree(r);
            chains.push(r);
        });

        return chains;
    }

}

export { ReservationService, ReservationState };