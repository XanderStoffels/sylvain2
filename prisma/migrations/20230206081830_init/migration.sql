-- CreateTable
CREATE TABLE "Reservation" (
    "Id" TEXT NOT NULL PRIMARY KEY,
    "ReservationCode" TEXT NOT NULL,
    "State" INTEGER NOT NULL,
    "From" DATETIME NOT NULL,
    "To" DATETIME NOT NULL,
    "RequestedAt" DATETIME NOT NULL,
    "BookedAt" DATETIME,
    "CanceledAt" DATETIME,
    "Note" TEXT,
    "ContactName" TEXT NOT NULL,
    "ContactEmail" TEXT NOT NULL,
    "ContactPhone" TEXT NOT NULL,
    "AmountOfPeople" TEXT NOT NULL,
    "PeopleInfo" TEXT NOT NULL,
    "Price" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Spot" (
    "Id" TEXT NOT NULL PRIMARY KEY,
    "From" DATETIME NOT NULL,
    "To" DATETIME NOT NULL,
    "Price" INTEGER NOT NULL,
    "Note" TEXT,
    "IsEnabled" BOOLEAN NOT NULL DEFAULT true,
    "ReservedById" TEXT NOT NULL,
    CONSTRAINT "Spot_ReservedById_fkey" FOREIGN KEY ("ReservedById") REFERENCES "Reservation" ("Id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Reservation_ReservationCode_key" ON "Reservation"("ReservationCode");
