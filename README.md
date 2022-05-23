# Table of Contents
- [Table of Contents](#table-of-contents)
- [PK, FK CONSTRAINT](#pk-fk-constraint)
    - [in CREATE TABLE](#in-create-table)
    - [in ALTER TABLE](#in-alter-table)
- [CREATE TABLE & INDEX](#create-table--index)
- [CONSTRAINT](#constraint)
  - [UNIQUE KEY (고유키)](#unique-key-고유키)
  - [PRIMARY KEY (기본키)](#primary-key-기본키)
  - [FOREIGN KEY (외래키)](#foreign-key-외래키)
  - [NOT NULL](#not-null)
  - [CHECK](#check)
- [TABLE & COLUMN NAME](#table--column-name)
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

# CREATE TABLE & INDEX
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


# CONSTRAINT
`CONSTRAINT (제약조건)` 이란 테이블의 특정 컬럼에 설정하는 제약으로, 데이터 무결성을 유지하기 위해서 사용된다.

## UNIQUE KEY (고유키)
- 테이블 내에서 중복되는 값은 없지만 NULL 입력이 가능하다.
## PRIMARY KEY (기본키)
- `PK = UNIQUE + NOT NULL`
- `PK` 테이블 당 1개만 생성이 가능하다.

## FOREIGN KEY (외래키)
- FK는 테이블 생성 시 설정할 수 있다.
- **FK는 테이블 당 여러 개 존재할 수 있다**.
- **FK는 NULL 값을 가질 수 있다**.
- FK 값은 참조 무결성 제약을 받을 수 있다.

## NOT NULL
- `NOT NULL` 명시적으로 NULL 입력을 방지한다.

## CHECK
- 입력할 수 있는 값의 범위 등을 제한한다.
- `CHECK` 제약으로는 `TRUE` or `FALSE` 로 평가할 수 있는 논리식을 지정한다.
- `CHECK` 제약조건은 데이터베이스에서 데이터의 무결성을 유지학 ㅣ위하여 테이블의 특정 컬럼에 설정하는 제약이다.

# TABLE & COLUMN NAME
`A-Z` `a-z` `0-9` `_` `$` `#` 만 허용한다.

- **`EMP_10` (O)**
- `100-EMO` (X)
- `EMP-100` (X)
- `100_EMP` (X)
# NULL 관련 함수
## NVL / ISNULL
```sql
NVL(exp1, exp2)
ISNULL(exp1, exp2)
```
`exp1` 의 값이 NULL이면 `exp2` 값을 반환한다.
(단, `exp1`, `exp2` 데이터의 타입이 같아야 함)

## NULLIF
```sql
NULLIF(exp1, exp2)
```
- `exp1` 의 값이 `exp2` 와 **같으면** NULL 값을
- **같지 않으면** `exp1` 값을

반환한다.

## COALESCE
```sql
COALESCE(exp1, exp2, ...)
```
NULL이 아닌 최초의 표현식을 반환한다. 모든 표현식이 NULL이라면 NULL을 반환한다.