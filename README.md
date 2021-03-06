# ð Table of Contents
- [ð Table of Contents](#-table-of-contents)
- [ð PK, FK CONSTRAINT](#-pk-fk-constraint)
    - [in CREATE TABLE](#in-create-table)
    - [in ALTER TABLE](#in-alter-table)
- [ð CREATE TABLE & INDEX](#-create-table--index)
- [ð CONSTRAINT](#-constraint)
  - [UNIQUE KEY (ê³ ì í¤)](#unique-key-ê³ ì í¤)
  - [PRIMARY KEY (ê¸°ë³¸í¤)](#primary-key-ê¸°ë³¸í¤)
  - [FOREIGN KEY (ì¸ëí¤)](#foreign-key-ì¸ëí¤)
    - [[FK] DELETE / UPDATE RULE](#fk-delete--update-rule)
    - [[FK] INSERT RULE](#fk-insert-rule)
  - [NOT NULL](#not-null)
  - [CHECK](#check)
- [ð TABLE & COLUMN NAME](#-table--column-name)
- [ð RENAME](#-rename)
  - [RENAME TABLE](#rename-table)
  - [RENAME COLUMN](#rename-column)
- [ð DROP / TRUNCATE / DELETE](#-drop--truncate--delete)
- [ð DATABASE TRANSACTION](#-database-transaction)
  - [í¸ëì­ìì 4ê°ì§ í¹ì§](#í¸ëì­ìì-4ê°ì§-í¹ì§)
  - [í¸ëì­ìì ê²©ë¦¬ì±ì´ ë®ì ê²½ì° ë°ìí  ì ìë ë¬¸ì ì ](#í¸ëì­ìì-ê²©ë¦¬ì±ì´-ë®ì-ê²½ì°-ë°ìí -ì-ìë-ë¬¸ì ì )
  - [ROLLBACK](#rollback)
  - [SAVEPOINT](#savepoint)
- [ð ë´ì¥ í¨ì (Built-in Function)](#-ë´ì¥-í¨ì-built-in-function)
  - [ë¨ì¼í í¨ì](#ë¨ì¼í-í¨ì)
  - [ë¤ì¤í í¨ì](#ë¤ì¤í-í¨ì)
- [ð NULL](#-null)
  - [INSERT NULL](#insert-null)
  - [NULL ê´ë ¨ í¨ì](#null-ê´ë ¨-í¨ì)
    - [NVL / ISNULL](#nvl--isnull)
    - [NULLIF](#nullif)
    - [COALESCE](#coalesce)
  - [NULLì¸ì§ ê²ì¬í  ëë `IS NULL`](#nullì¸ì§-ê²ì¬í -ëë-is-null)
  - [NULLì ORDER BY ìì](#nullì-order-by-ìì)
- [ð STANDARD SQL](#-standard-sql)
  - [ì¼ë° ì§í© ì°ì°ì](#ì¼ë°-ì§í©-ì°ì°ì)
  - [ìì ê´ê³ ì°ì°ì](#ìì-ê´ê³-ì°ì°ì)

# ð PK, FK CONSTRAINT
### in CREATE TABLE
> Oracle, SQL Server ëì¼
```sql
CREATE TABLE PLAYER (
  PLAYER_ID CHAR(7) NOT NULL,
  PLAYER_NAME VHARCHAR2(20) NOT NULL,
  TEAM_ID CHAR(3) NOT NULL,
  NICKNAME VHARCHAR2(30),
  CONSTRAINT PLAYER_PK PRIMARY KEY (PLAYER_ID),
  CONSTRAINT TEAM_ID FOREIGN KEY (PLAYER) REFERENCES TEAM(TEAM_ID)
);
```

### in ALTER TABLE
> Oracle, SQL Server ëì¼
```sql
-- PRIMARY KEY
ALTER TABLE PLAYER ADD CONSTRAINT PLAYER_PK PRIMARY KEY (PLAYER_ID);

-- FOREIGN KEY
ALTER TABLE PLAYER ADD CONSTRAINT PLAYER_FK FOREIGN KEY (TEAM_ID) REFERENCES TEAM(TEAM_ID);
```

# ð CREATE TABLE & INDEX
```sql
-- Option 1)
CREATE TABLE EMP (
  EMP_NO      VARCHAR2(10) PRIMARY KEY,
  EMP_NM      VARCHAR2(30) NOT NULL,
  DEPT_CDODE  VARCHAR2(4) DEFAULT '0000' NOT NULL,
  JOIN_DATE   DATE NOT NULL,
  REGIST_DATE DATE NULL
);
CREATE INDEX IDX_EMP_01 ON EMP (JOIN_DATE);
```
```sql
-- Option 2)
CREATE TABLE EMP (
  EMP_NO      VARCHAR2(10) NOT NULL,
  EMP_NM      VARCHAR2(30) NOT NULL,
  DEPT_CDODE  VARCHAR2(4) DEFAULT '0000' NOT NULL,
  JOIN_DATE   DATE NOT NULL,
  REGIST_DATE DATE NULL
);
ALTER TABLE EMP ADD CONSTRAINT EMP_PK PRIMARY KEY (EMP_NO);
CREATE INDEX IDX_EMP_01 ON EMP (JOIN_DATE);
```


# ð CONSTRAINT
`CONSTRAINT (ì ì½ì¡°ê±´)` ì´ë íì´ë¸ì í¹ì  ì»¬ë¼ì ì¤ì íë ì ì½ì¼ë¡, ë°ì´í° ë¬´ê²°ì±ì ì ì§íê¸° ìí´ì ì¬ì©ëë¤.

## UNIQUE KEY (ê³ ì í¤)
- íì´ë¸ ë´ìì ì¤ë³µëë ê°ì ìì§ë§ NULL ìë ¥ì´ ê°ë¥íë¤.
## PRIMARY KEY (ê¸°ë³¸í¤)
- `PK = UNIQUE + NOT NULL`
- `PK` íì´ë¸ ë¹ 1ê°ë§ ìì±ì´ ê°ë¥íë¤.

## FOREIGN KEY (ì¸ëí¤)
- FKë íì´ë¸ ìì± ì ì¤ì í  ì ìë¤.
- **FKë íì´ë¸ ë¹ ì¬ë¬ ê° ì¡´ì¬í  ì ìë¤**.
- **FKë NULL ê°ì ê°ì§ ì ìë¤**.
- FK ê°ì ì°¸ì¡° ë¬´ê²°ì± ì ì½ì ë°ì ì ìë¤.

### [FK] DELETE / UPDATE RULE
- **`RESTRICT` Child íì´ë¸ì PK ê°ì´ ìë ê²½ì°ìë§ Master ì­ì  íì©**
- `CASCADE` Master ì­ì  ì Child ê°ì´ ì­ì 
- `SET NULL` Master ì­ì  ì Child í´ë¹ íë NULL
- `SET DEFAULT` Master ì­ì  ì Child í´ë¹ íë Default ê°ì¼ë¡ ì¤ì 
- `NO ACTION` ì°¸ì¡° ë¬´ê²°ì±ì ìë°íë ì­ì  / ìì  actionì ì·¨íì§ ìì

<br>

### [FK] INSERT RULE
- **`AUTOMATIC` Master íì´ë¸ì PKê° ìë ê²½ì° Master PK ìì± í Child ìë ¥**
- **`DEPENDENT` Master íì´ë¸ì PKê° ì¡´ì¬í  ëë§ Child ìë ¥ íì©**
- `SET NULL` Maseter íì´ë¸ì PKê° ìë ê²½ì° Child ì¸ë¶í¤ë¥¼ NULL ê°ì¼ë¡ ì²ë¦¬
- `SET DEFAULT` Maseter íì´ë¸ì PKê° ìë ê²½ì° Child ì¸ë¶í¤ë¥¼ Default ê°ì¼ë¡ ì²ë¦¬
- `NO ACTION` ì°¸ì¡° ë¬´ê²°ì±ì ìë°íë ìë ¥ ì¡ìì ì·¨íì§ ìì

## NOT NULL
- `NOT NULL` ëªìì ì¼ë¡ NULL ìë ¥ì ë°©ì§íë¤.

## CHECK
- ìë ¥í  ì ìë ê°ì ë²ì ë±ì ì ííë¤.
- `CHECK` ì ì½ì¼ë¡ë `TRUE` or `FALSE` ë¡ íê°í  ì ìë ë¼ë¦¬ìì ì§ì íë¤.
- `CHECK` ì ì½ì¡°ê±´ì ë°ì´í°ë² ì´ì¤ìì ë°ì´í°ì ë¬´ê²°ì±ì ì ì§í ã£ìíì¬ íì´ë¸ì í¹ì  ì»¬ë¼ì ì¤ì íë ì ì½ì´ë¤.

# ð TABLE & COLUMN NAME
`A-Z` `a-z` `0-9` `_` `$` `#` ë§ íì©íë¤.

- **`EMP_10` (O)**
- `100-EMO` (X)
- `EMP-100` (X)
- `100_EMP` (X)

# ð RENAME
## RENAME TABLE
> STADIUM íì´ë¸ì ì´ë¦ì STADIUM_JSCë¡ ë³ê²½íë SQLì ìì±íìì¤. (ANSI íì¤ ê¸°ì¤)

`Oracle`
```sql
RENAME STADIUM TO STADIUM_JSC;
```

<br>

`SQL Server`
```sql
sp_rename 'dbo.STADIUM', 'STADIUM_JSC';
```

## RENAME COLUMN
`Oracle`
```sql
ALTER TABLE STADIUM RENAME COLUMN STADIUM_ID TO STD_ID;
```

<br>

`SQL Server`
```sql
sp_rename 'dbo.STADIUM.STADIUM_ID', 'STD_ID', 'COLUMN';
```
# ð DROP / TRUNCATE / DELETE
| DROP  | TRUNCATE | DELETE |
| ------------- | ------------- | ------------- | 
| DDL | DDL  <br>  (ì¼ë¶ DML ì±ê²© ê°ì§) | DML |
| Rollback ë¶ê°ë¥ | Rollback ë¶ê°ë¥ | Commit ì´ì  Rollback ê°ë¥ | 
| Auto Commit | Auto Commit | **ì¬ì©ì Commit** |
| íì´ë¸ì´ ì¬ì©íë Storageë¥¼ ëª¨ë release | íì´ë¸ì´ ì¬ì©íë Storage ì¤ ìµì´ íì´ë¸ ìì± ì í ë¹ë Storageë§ ë¨ê¸°ê³  release | ë°ì´í°ë¥¼ ëª¨ë Deleteí´ë ì¬ì©íë Storageë releaseëì§ ìì |
| íì´ë¸ì ì ì ìì²´ë¥¼ ìì í ì­ì í¨ | íì´ë¸ì ìµì´ ìì±ë ì´ê¸° ìíë¡ ë§ë¬ | ë°ì´í°ë§ ì­ì 

# ð DATABASE TRANSACTION
## í¸ëì­ìì 4ê°ì§ í¹ì§
- `ììì±(atomicity)` **All or Nothing**, í¸ëì­ì ìì ì ìë ì°ì°ë¤ì ëª¨ë ì±ê³µì ì¼ë¡ ì¤íëëì§, ìëë©´ ì í ì¤íëì§ ìì ìíë¡ ë¨ì ìì´ì¼ íë¤. 
- `ì¼ê´ì±(consistency)` í¸ëì­ìì´ ì¤íëê¸° ì ì ë°ì´í°ë² ì´ì¤ ë´ì©ì´ ìëª» ëì´ ìì§ ìë¤ë©´,  í¸ëì­ìì´ ì¤íë ì´íìë ë°ì´í°ë² ì´ì¤ì ë´ì©ì ìëª»ì´ ìì¼ë©´ ì ëë¤.
- `ê³ ë¦½ì±(isolation)` í¸ëì­ìì´ ì¤íëë ëì¤ì ë¤ë¥¸ í¸ëì­ìì ìí¥ì ë°ì ìëª»ë ê²°ê³¼ë¥¼ ë§ë¤ì´ìë ì ëë¤.
- `ì§ìì±(durability)` í¸ëì­ìì´ ì±ê³µì ì¼ë¡ ìíëë©´ ê·¸ í¸ëì­ìì´ ê°±ì í ë°ì´í°ë² ì´ì¤ì ë´ì©ì ìêµ¬ì ì¼ë¡ ì ì¥ëë¤.

## í¸ëì­ìì ê²©ë¦¬ì±ì´ ë®ì ê²½ì° ë°ìí  ì ìë ë¬¸ì ì 
- `Dirty Read` ë¤ë¥¸ í¸ëì­ìì ìí´ ìì ëìì§ë§ **ìì§ ì»¤ë°ëì§ ìì ë°ì´í°**ë¥¼ ì½ë ê²
- `Non-Repeatable Read` í í¸ëì­ì ë´ìì ê°ì ì¿¼ë¦¬ë¥¼ ë ë² ìííëë°, ê·¸ ì¬ì´ì ë¤ë¥¸ í¸ëì­ìì´ ê°ì ìì  ëë ì­ì íë ë°ëì ë ì¿¼ë¦¬ ê²°ê³¼ê° ë¤ë¥´ê² ëíëë íìì ë§íë¤.
- `Phantom Read` í í¸ëì­ì ë´ìì ê°ì ì¿¼ë¦¬ë¥¼ ë ë² ìííëë°, ì²« ë²ì§¸ ì¿¼ë¦¬ì ìë ì ë ¹ ë ì½ëê° ë ë²ì§¸ ì¿¼ë¦¬ìì ëíëë íìì ë§íë¤.

## ROLLBACK
`ROLLBACK` êµ¬ë¬¸ì `COMMIT`ëì§ ìì ììì ëª¨ë  í¸ëì­ìì rollackíë¤.

## SAVEPOINT
`SAVEPOINT(ì ì¥ì )` ì ì ìíë©´ ë¡¤ë°±í  ë í¸ëì­ìì í¬í¨ë ì ì²´ ììì ë¡¤ë°±íë ê²ì´ ìëë¼, **í ìì ìì SAVEPOINT**ê¹ì§ í¸ëì­ìì ì¼ë¶ë§ ë¡¤ë°±í  ì ìë¤.

`Oracle`
```sql
SAVEPOINT SVPT1;
...
ROLLBACK TO SVPT1
```

<br>

`SQL Server`
```sql
SAVE TRANSACTION SVTR1;
...
ROLLBACK TRANSACTION SVTR1;
```

# ð ë´ì¥ í¨ì (Built-in Function)
```
ë²¤ë ì ê³µ í¨ì/
âââ ë´ì¥ í¨ì/
â   âââ ë¨ì¼í í¨ì
â   âââ ë¤ì¤í í¨ì
âââ ì¬ì©ì ì ì í¨ì
```
## ë¨ì¼í í¨ì
ë¨ì¼í ê°ì´ ìë ¥ëë í¨ìì´ë¤.

> ë¨ì¼í í¨ìë `SELECT`, `WHERE`, `ORDER BY`, `UPDATEì SETì `ì ì¬ì©ì´ ê°ë¥íë¤.

- `ë¬¸ìí í¨ì` ex) LOWER, UPPER, SUBSTR, LENGTH, TRIM, ...
- `ì«ìí í¨ì` ex) ABS, ROUND, CEIL, FLOOR, ...
- `ë ì§í í¨ì` ex) SYSDATE, TO_NUMBER, TO_CHAR, YAER | MONTH | DAY, ...
- `ë³íí í¨ì` ex) TO_NUMBER, TO_CHAR, TO_DATE, CAST, CONVERT
- `NULL ê´ë ¨ í¨ì` ex) NVL / ISNULL, NULLIF, COALESCE
  

## ë¤ì¤í í¨ì
ì¬ë¬ íì ê°ì´ ìë ¥ëë í¨ìì´ë¤.
> ë¤ì¤í í¨ìë ë¨ì¼í í¨ìì ëì¼íê² **ë¨ì¼ ê°ì ë°í**íë¤.

- ì§ê³ í¨ì (Aggregate Function)
- ê·¸ë£¹ í¨ì (Group Function)
- ìëì° í¨ì (Window Function)
 

# ð NULL
## INSERT NULL
**Oracleììë ê³µë°± ë¬¸ì(`''`)ë¥¼ INSERT ìì ë°ì´í°ê° `NULL`ë¡ ìë ¥ëë¤.**

(SQL Serverë ê³µë°± ë¬¸ìë¡ INSERT ëë¤.)

```sql
INSERT INTO ìë¹ì¤ VALUES ('999', '', '2015-11-11');
```

ë°ë¼ì SELECT ë¤ìê³¼ ê°ì´ ê²ìíë©´ ê²ì ê²°ê³¼ê° ëì¤ì§ ìëë¤.
```sql
-- ð¥² BAD
SELECT * FROM ìë¹ì¤ WHERE ìë¹ì¤ëª = '';

-- ð GOOD 
SELECT * FROM ìë¹ì¤ WHERE ìë¹ì¤ëª IS NULL;
```

<br>

##  NULL ê´ë ¨ í¨ì
### NVL / ISNULL

> Oracle: `NVL`  /  SQL Server: `ISNULL`

```sql
NVL(exp1, exp2)
ISNULL(exp1, exp2)
```
`exp1` ì ê°ì´ NULLì´ë©´ `exp2` ê°ì ë°ííë¤.
(ë¨, `exp1`, `exp2` ë°ì´í°ì íìì´ ê°ìì¼ í¨)

### NULLIF
> **`IFNULL` ì´ ìë**ì ì£¼ì

```sql
NULLIF(exp1, exp2)
```
- `exp1` ì ê°ì´ `exp2` ì **ê°ì¼ë©´** NULL ê°ì
- **ê°ì§ ìì¼ë©´** `exp1` ê°ì

ë°ííë¤.

### COALESCE
```sql
COALESCE(exp1, exp2, ...)
```
NULLì´ ìë ìµì´ì ííìì ë°ííë¤. ëª¨ë  ííìì´ NULLì´ë¼ë©´ NULLì ë°ííë¤.

<br>

## NULLì¸ì§ ê²ì¬í  ëë `IS NULL`
> NULLì¸ì§ ê²ì¬í  ëë `IS NULL` ì ì¬ì©í´ì¼ íë¤. ë¤ìê³¼ ê°ì ë¬¸ì ì ëì´ì§ ë§ì!

```sql
SELECT COUNT(C0L1) FROM TAB1 WHERE COL2 = NULL;
```

<br>

## NULLì ORDER BY ìì
- **Oracleììë NULL ê°ì ê°ì¥ í° ê°ì¼ë¡ ê°ì£¼**íì¬ ì¤ë¦ì°¨ìì¼ë¡ ì ë ¬ ì ê°ì¥ ë§ì§ë§ì, ë´ë¦¼ì°¨ìì¼ë¡ ì ë ¬ ì ê°ì¥ ì²ìì ìì¹íë¤.

- **SQL Serverììë NULL ê°ì ê°ì¥ ìì ê°ì¼ë¡ ê°ì£¼**íì¬ Oracleì NULLê³¼ ì ë ¬ì´ ë°ëì´ë¤.


<br>

# ð STANDARD SQL
## ì¼ë° ì§í© ì°ì°ì
1. UNION `UNION`
2. INTERSECTION `INTERSECT`
3. DIFFERENCE `MINUS / EXCEPT`
4. PRODUCT `CROSS JOIN`

![image](https://user-images.githubusercontent.com/31913666/170523271-1e072708-d55b-4464-b569-e38619668dc5.png)


## ìì ê´ê³ ì°ì°ì
1. SELECT `WHERE`
2. PROJECT `SELECT` ð *CARTESIAN PRODUCT* ë¼ê³ ë ë¶ë¥¸ë¤
3. JOIN `JOIN`
4. DIVIDE (íì¬ë ì¬ì©ëì§ ìì)

![image](https://user-images.githubusercontent.com/31913666/170523614-0318d69e-e521-40ed-80ed-a0c414353bd4.png)
