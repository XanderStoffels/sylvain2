/*
  Warnings:

  - You are about to drop the `Reservations` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Spots` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Reservations";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Spots";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Reservation" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "reservationCode" TEXT NOT NULL,
    "state" INTEGER NOT NULL,
    "from" DATETIME NOT NULL,
    "to" DATETIME NOT NULL,
    "requestedAt" DATETIME NOT NULL,
    "bookedAt" DATETIME,
    "canceledAt" DATETIME,
    "note" TEXT,
    "contactName" TEXT NOT NULL,
    "contactEmail" TEXT NOT NULL,
    "contactPhone" TEXT NOT NULL,
    "amountOfPeople" TEXT NOT NULL,
    "peopleInfo" TEXT NOT NULL,
    "price" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Spot" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "from" DATETIME NOT NULL,
    "to" DATETIME NOT NULL,
    "price" INTEGER NOT NULL,
    "note" TEXT,
    "isEnabled" BOOLEAN NOT NULL DEFAULT true,
    "reservedById" TEXT NOT NULL,
    CONSTRAINT "Spot_reservedById_fkey" FOREIGN KEY ("reservedById") REFERENCES "Reservation" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Reservation_reservationCode_key" ON "Reservation"("reservationCode");
