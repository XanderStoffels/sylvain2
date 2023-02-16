-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Spot" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "from" DATETIME NOT NULL,
    "to" DATETIME NOT NULL,
    "price" INTEGER NOT NULL,
    "note" TEXT,
    "isEnabled" BOOLEAN NOT NULL DEFAULT true,
    "reservedById" TEXT,
    CONSTRAINT "Spot_reservedById_fkey" FOREIGN KEY ("reservedById") REFERENCES "Reservation" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Spot" ("from", "id", "isEnabled", "note", "price", "reservedById", "to") SELECT "from", "id", "isEnabled", "note", "price", "reservedById", "to" FROM "Spot";
DROP TABLE "Spot";
ALTER TABLE "new_Spot" RENAME TO "Spot";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
