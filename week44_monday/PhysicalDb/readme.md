Fysisk databas

1. Från logisk till fysisk modell

   * Tidigare steg: konceptuell + logisk modell → fokus på objekt och relationer.
   * Fysisk design: anpassas till en specifik DBMS (MySQL).
   * Här bestäms kolumntyper, index, constraints och tabellstruktur.

2. Primärnycklar (Primary Key, PK)

   * Varje tabell har en unik identifierare.
   * I MySQL används ofta `INT AUTO_INCREMENT` för att skapa unika värden.
   * PK garanterar att inga duplicerade värden kan infogas → dataintegritet.

3. Främmande nycklar (Foreign Key, FK)

   * Implementerar relationer mellan tabeller.
   * 1:N-relation: PK på "1"-sidan blir FK på "N"-sidan.
   * M:N-relation: kräver en kopplingstabell som innehåller PK från båda tabellerna.
   * FK ser till att endast giltiga referenser finns → referensintegritet.
   * Viktigt: Tabellerna måste använda InnoDB-motorn för FK-stöd.

4. Kopplingstabeller för M:N-relationer

   * Exempel: `Book` ↔ `Author` → `BookAuthor`.
   * Kopplingstabellen innehåller båda främmande nycklarna.
   * PK i kopplingstabellen är ofta en kombination av dessa FK (sammanfogad nyckel).

5. Index och prestanda

   * Primärnycklar skapar automatiskt ett clustered index i InnoDB.
   * FK och ofta använda kolumner kan få egna index för snabbare sökningar och JOINs.
   * Effektiva datatyper + välplanerade index förbättrar prestandan vid stora datamängder.

6. Constraints och dataintegritet

   * `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, `NOT NULL` används för att skydda datan.
   * Fysisk design säkerställer att felaktig data inte kan lagras i databasen.
   * MySQL 8+ stöder `CHECK` constraints (tidigare versioner ignorerade dem).

7. TL;DR

   * Logisk design visar vad som ska finnas; fysisk design visar hur det lagras.
   * I MySQL innebär fysisk design att definiera datatyper, index och constraints så att databasen fungerar effektivt och säkert.
   * Fysisk design = "hur databasen faktiskt implementerar relationerna och integriteten i MySQL".