import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

export default defineEventHandler(async (e) => {

    const unavailableDates: Date[] = [];
    const data = await prisma.reservation.findMany({
        select: {
            from: true,
            to: true,
        }
    });

    data.forEach(r => {
        const dates = getDates(r.from, r.to);
        unavailableDates.push(...dates);
    });

    return { data };

});

// A function that returns all dates between two dates.
function getDates(startDate: Date, endDate: Date) {
    const dates = [];
    const theDate = new Date(startDate);
    while (theDate < endDate) {
        dates.push(new Date(theDate));
        theDate.setDate(theDate.getDate() + 1);
    }
    dates.push(endDate);
    return dates;
}