import { ReservationService } from "~~/server/services/reservations";
const reservationService = new ReservationService();

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

    // Get unavailable dates.
    await reservationService.getUnavailableDatesAsync(dateFrom, dateUntil);



    return {
        data: {
            from: dateFrom.toISOString()
        }
    }
})





