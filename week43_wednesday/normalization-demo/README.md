## Demo: Normalisering  
**DBMS**: DBeaver

**Tips**: Se material i Discord för referens. I DBeaver fungerar kortkommandot:
- **Ctrl+Enter** för att exekvera en specifik rad eller markering i SQL.
- **Alt+X** för att köra hela scriptfilen.

---

### Turordning för detta demo:
1. **`normalization_start.sql`**  
   - Innehåller `CREATE DATABASE`, ifall du inte skapar databasen via DBeaver/MySQL Workbench GUI.
   - Kom ihåg: `John Doe` ska förekomma mer än en gång och `Foo Bar` endast en gång. Lägg gärna till fler namn.

2. **`1NF.sql`**

3. **`2NF.sql`**

4. **`3NF.sql`**

5. **`normalization_finish.sql`**  
   - Ny del för att tydligare visa när en kund har gjort en specifik beställning kopplat till menyvaror på en snabbmatsrestaurang.

--- 

Följ ovanstående ordning för att stegvis genomgå normalisering från start till 3NF.
