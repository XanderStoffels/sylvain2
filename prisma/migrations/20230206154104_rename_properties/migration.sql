/*
  Warnings:

  - The primary key for the `Reservations` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `AmountOfPeople` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `BookedAt` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `CanceledAt` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `ContactEmail` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `ContactName` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `ContactPhone` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `From` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `Note` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `PeopleInfo` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `Price` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `RequestedAt` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `ReservationCode` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `State` on the `Reservations` table. All the data in the column will be lost.
  - You are about to drop the column `To` on the `Reservations` table. All the data in the column will be lost.
  - The primary key for the `Spots` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `From` on the `Spots` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Spots` table. All the data in the column will be lost.
  - You are about to drop the column `IsEnabled` on the `Spots` table. All the data in the column will be lost.
  - You are about to drop the column `Note` on the `Spots` table. All the data in the column will be lost.
  - You are about to drop the column `Price` on the `Spots` table. All the data in the column will be lost.
  - You are about to drop the column `ReservedById` on the `Spots` table. All the data in the column will be lost.
  - You are about to drop the column `To` on the `Spots` table. All the data in the column will be lost.
  - Added the required column `amountOfPeople` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `contactEmail` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `contactName` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `contactPhone` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `from` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - The required column `id` was added to the `Reservations` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `peopleInfo` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `requestedAt` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `reservationCode` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `state` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `to` to the `Reservations` table without a default value. This is not possible if the table is not empty.
  - Added the required column `from` to the `Spots` table without a default value. This is not possible if the table is not empty.
  - The required column `id` was added to the `Spots` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `price` to the `Spots` table without a default value. This is not possible if the table is not empty.
  - Added the required column `reservedById` to the `Spots` table without a default value. This is not possible if the table is not empty.
  - Added the required column `to` to the `Spots` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Reservations" (
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
DROP TABLE "Reservations";
ALTER TABLE "new_Reservations" RENAME TO "Reservations";
CREATE UNIQUE INDEX "Reservations_reservationCode_key" ON "Reservations"("reservationCode");
CREATE TABLE "new_Spots" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "from" DATETIME NOT NULL,
    "to" DATETIME NOT NULL,
    "price" INTEGER NOT NULL,
    "note" TEXT,
    "isEnabled" BOOLEAN NOT NULL DEFAULT true,
    "reservedById" TEXT NOT NULL,
    CONSTRAINT "Spots_reservedById_fkey" FOREIGN KEY ("reservedById") REFERENCES "Reservations" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
DROP TABLE "Spots";
ALTER TABLE "new_Spots" RENAME TO "Spots";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
