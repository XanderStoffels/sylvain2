import { PrismaClient, Spot } from '@prisma/client';
const prisma = new PrismaClient();

export default defineEventHandler(async event => {
    // Requires 'to' and 'from' to be set in the query.
    const { from } = getQuery(event) as { from: string };

    // Should be defined.
    if (!from)
        throw createError({
            statusCode: 400,
            statusMessage: 'Missing required query parameters "from"',
        });

    // To and From should be valid Dates in ISO UTC format.
    const dateFrom = new Date(from);
    if (isNaN(dateFrom.getTime()))
        throw createError({
            statusCode: 400,
            statusMessage: 'Invalid query parameters "from". Should be a parsable date.',
        });

    // Create until which is a date 3 months after from.
    const dateUntil = new Date(dateFrom);
    dateUntil.setMonth(dateFrom.getMonth() + 3);

    // Get the user's calendar.


    return {
        data: {
            from: dateFrom.toISOString()
        }
    }
})

async function buildSpotTreeAsync(startDate: Date, endDate: Date): Promise<TreeNode<Spot>[]> {
    if (startDate > endDate) return [];

    const pool = await readSpotsAsync(startDate, endDate);
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



    return [];
}

async function readSpotsAsync(from: Date, to: Date): Promise<Spot[]> {
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