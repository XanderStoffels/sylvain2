/*
  Warnings:

  - You are about to drop the `Reservation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Spot` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Reservation";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Spot";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Reservations" (
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
CREATE TABLE "Spots" (
    "Id" TEXT NOT NULL PRIMARY KEY,
    "From" DATETIME NOT NULL,
    "To" DATETIME NOT NULL,
    "Price" INTEGER NOT NULL,
    "Note" TEXT,
    "IsEnabled" BOOLEAN NOT NULL DEFAULT true,
    "ReservedById" TEXT NOT NULL,
    CONSTRAINT "Spots_ReservedById_fkey" FOREIGN KEY ("ReservedById") REFERENCES "Reservations" ("Id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Reservations_ReservationCode_key" ON "Reservations"("ReservationCode");
