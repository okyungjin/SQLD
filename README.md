# Table of Contents
- [Table of Contents](#table-of-contents)
- [PK, FK CONSTRAINT](#pk-fk-constraint)
    - [in CREATE TABLE](#in-create-table)
    - [in ALTER TABLE](#in-alter-table)
- [CONSTRAINT](#constraint)
- [TABLE & COLUMN NAME](#table--column-name)
- [FUNCTION](#function)
  - [NULL 관련 함수](#null-관련-함수)
    - [NVL / ISNULL](#nvl--isnull)
    - [NULLIF](#nullif)
    - [COALESCE](#coalesce)

# PK, FK CONSTRAINT
### in CREATE TABLE
> Oracle, SQL Server 동일
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
> Oracle, SQL Server 동일
```sql
-- PRIMARY KEY
ALTER TABLE PLAYER ADD CONSTRAINT PLAYER_PK PRIMARY KEY (PLAYER_ID);

-- FOREIGN KEY
ALTER TABLE PLAYER ADD CONSTRAINT PLAYER_FK FOREIGN KEY (TEAM_ID) REFERENCES TEAM(TEAM_ID);
```
# CONSTRAINT
- `UNIQUE` = PK + NOT NULL, 테이블 내에서 중복되는 값은 없지만 NULL 입력이 가능하다.
- `PK` 테이블 당 1개만 생성이 가능하다.
- `FK` 테이블 당 여러 개 생성이 가능하다.
- `NOT NULL` 명시적으로 NULL 입력을 방지한다.

# TABLE & COLUMN NAME
`A-Z` `a-z` `0-9` `_` `$` `#` 만 허용한다.

- **`EMP_10` (O)**
- `100-EMO` (X)
- `EMP-100` (X)
- `100_EMP` (X)
# FUNCTION
## NULL 관련 함수
### NVL / ISNULL
```sql
NVL(exp1, exp2)
ISNULL(exp1, exp2)
```
`exp1` 의 값이 NULL이면 `exp2` 값을 반환한다.
(단, `exp1`, `exp2` 데이터의 타입이 같아야 함)

### NULLIF
```sql
NULLIF(exp1, exp2)
```
- `exp1` 의 값이 `exp2` 와 **같으면** NULL 값을
- **같지 않으면** `exp1` 값을

반환한다.

### COALESCE
```sql
COALESCE(exp1, exp2, ...)
```
NULL이 아닌 최초의 표현식을 반환한다. 모든 표현식이 NULL이라면 NULL을 반환한다.