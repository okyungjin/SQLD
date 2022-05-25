# 👉 Table of Contents
- [👉 Table of Contents](#-table-of-contents)
- [👉 PK, FK CONSTRAINT](#-pk-fk-constraint)
    - [in CREATE TABLE](#in-create-table)
    - [in ALTER TABLE](#in-alter-table)
- [👉 CREATE TABLE & INDEX](#-create-table--index)
- [👉 CONSTRAINT](#-constraint)
  - [UNIQUE KEY (고유키)](#unique-key-고유키)
  - [PRIMARY KEY (기본키)](#primary-key-기본키)
  - [FOREIGN KEY (외래키)](#foreign-key-외래키)
    - [[FK] DELETE / UPDATE RULE](#fk-delete--update-rule)
    - [[FK] INSERT RULE](#fk-insert-rule)
  - [NOT NULL](#not-null)
  - [CHECK](#check)
- [👉 TABLE & COLUMN NAME](#-table--column-name)
- [👉 RENAME](#-rename)
  - [RENAME TABLE](#rename-table)
  - [RENAME COLUMN](#rename-column)
- [👉 DROP / TRUNCATE / DELETE](#-drop--truncate--delete)
- [👉 DATABASE TRANSACTION](#-database-transaction)
  - [트랜잭션의 4가지 특징](#트랜잭션의-4가지-특징)
  - [트랜잭션의 격리성이 낮은 경우 발생할 수 있는 문제점](#트랜잭션의-격리성이-낮은-경우-발생할-수-있는-문제점)
  - [ROLLBACK](#rollback)
  - [SAVEPOINT](#savepoint)
- [👉 내장 함수 (Built-in Function)](#-내장-함수-built-in-function)
  - [단일행 함수](#단일행-함수)
  - [다중행 함수](#다중행-함수)
- [👉 NULL](#-null)
  - [INSERT NULL](#insert-null)
  - [NULL 관련 함수](#null-관련-함수)
    - [NVL / ISNULL](#nvl--isnull)
    - [NULLIF](#nullif)
    - [COALESCE](#coalesce)

# 👉 PK, FK CONSTRAINT
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

# 👉 CREATE TABLE & INDEX
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


# 👉 CONSTRAINT
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

### [FK] DELETE / UPDATE RULE
- **`RESTRICT` Child 테이블에 PK 값이 없는 경우에만 Master 삭제 허용**
- `CASCADE` Master 삭제 시 Child 같이 삭제
- `SET NULL` Master 삭제 시 Child 해당 필드 NULL
- `SET DEFAULT` Master 삭제 시 Child 해당 필드 Default 값으로 설정
- `NO ACTION` 참조 무결성을 위반하는 삭제 / 수정 action을 취하지 않음

<br>

### [FK] INSERT RULE
- **`AUTOMATIC` Master 테이블에 PK가 없는 경우 Master PK 생성 후 Child 입력**
- **`DEPENDENT` Master 테이블에 PK가 존재할 때만 Child 입력 허용**
- `SET NULL` Maseter 테이블에 PK가 없는 경우 Child 외부키를 NULL 값으로 처리
- `SET DEFAULT` Maseter 테이블에 PK가 없는 경우 Child 외부키를 Default 값으로 처리
- `NO ACTION` 참조 무결성을 위반하는 입력 액션을 취하지 않음

## NOT NULL
- `NOT NULL` 명시적으로 NULL 입력을 방지한다.

## CHECK
- 입력할 수 있는 값의 범위 등을 제한한다.
- `CHECK` 제약으로는 `TRUE` or `FALSE` 로 평가할 수 있는 논리식을 지정한다.
- `CHECK` 제약조건은 데이터베이스에서 데이터의 무결성을 유지학 ㅣ위하여 테이블의 특정 컬럼에 설정하는 제약이다.

# 👉 TABLE & COLUMN NAME
`A-Z` `a-z` `0-9` `_` `$` `#` 만 허용한다.

- **`EMP_10` (O)**
- `100-EMO` (X)
- `EMP-100` (X)
- `100_EMP` (X)

# 👉 RENAME
## RENAME TABLE
> STADIUM 테이블의 이름을 STADIUM_JSC로 변경하는 SQL을 작성하시오. (ANSI 표준 기준)

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
# 👉 DROP / TRUNCATE / DELETE
| DROP  | TRUNCATE | DELETE |
| ------------- | ------------- | ------------- | 
| DDL | DDL  <br>  (일부 DML 성격 가짐) | DML |
| Rollback 불가능 | Rollback 불가능 | Commit 이전 Rollback 가능 | 
| Auto Commit | Auto Commit | **사용자 Commit** |
| 테이블이 사용했던 Storage를 모두 release | 테이블이 사용했던 Storage 중 최초 테이블 생성 시 할당된 Storage만 남기고 release | 데이터를 모두 Delete해도 사용했던 Storage는 release되지 않음 |
| 테이블의 정의 자체를 완전히 삭제함 | 테이블을 최초 생성된 초기 상태로 만듬 | 데이터만 삭제

# 👉 DATABASE TRANSACTION
## 트랜잭션의 4가지 특징
- `원자성(atomicity)` **All or Nothing**, 트랜잭선에서 정의된 연산들은 모두 성공적으로 실행되던지, 아니면 전혀 실행되지 않은 상태로 남아 있어야 한다. 
- `일관성(consistency)` 트랜잭션이 실행되기 전의 데이터베이스 내용이 잘못 되어 있지 않다면,  트랜잭션이 실행된 이후에도 데이터베이스의 내용에 잘못이 있으면 안 된다.
- `고립성(isolation)` 트랜잭션이 실행되는 도중에 다른 트랜잭션의 영향을 받아 잘못된 결과를 만들어서는 안 된다.
- `지속성(durability)` 트랜잭션이 성공적으로 수행되면 그 트랜잭션이 갱신한 데이터베이스의 내용은 영구적으로 저장된다.

## 트랜잭션의 격리성이 낮은 경우 발생할 수 있는 문제점
- `Dirty Read` 다른 트랙잭션에 의해 수정되었지만 **아직 커밋되지 않은 데이터**를 읽는 것
- `Non-Repeatable Read` 한 트랜잭션 내에서 같은 쿼리를 두 번 수행했는데, 그 사이에 다른 트랜잭션이 값을 수정 또는 삭제하는 바람에 두 쿼리 결과가 다르게 나타나는 현상을 말한다.
- `Phantom Read` 한 트랜잭션 내에서 같은 쿼리를 두 번 수행했는데, 첫 번째 쿼리에 없던 유령 레코드가 두 번째 쿼리에서 나타나는 현상을 말한다.

## ROLLBACK
`ROLLBACK` 구문은 `COMMIT`되지 않은 상위의 모든 트랜잭션을 rollack한다.

## SAVEPOINT
`SAVEPOINT(저장점)` 을 정의하면 롤백할 때 트랜잭션에 포함된 전체 작업을 롤백하는 것이 아니라, **현 시점에서 SAVEPOINT**까지 트랜잭션의 일부만 롤백할 수 있다.

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

# 👉 내장 함수 (Built-in Function)
```
벤더 제공 함수/
├── 내장 함수/
│   ├── 단일행 함수
│   └── 다중행 함수
└── 사용자 정의 함수
```
## 단일행 함수
단일행 값이 입력되는 함수이다.

> 단일행 함수는 `SELECT`, `WHERE`, `ORDER BY`, `UPDATE의 SET절`에 사용이 가능하다.

- `문자형 함수` ex) LOWER, UPPER, SUBSTR, LENGTH, TRIM, ...
- `숫자형 함수` ex) ABS, ROUND, CEIL, FLOOR, ...
- `날짜형 함수` ex) SYSDATE, TO_NUMBER, TO_CHAR, YAER | MONTH | DAY, ...
- `변환형 함수` ex) TO_NUMBER, TO_CHAR, TO_DATE, CAST, CONVERT
- `NULL 관련 함수` ex) NVL / ISNULL, NULLIF, COALESCE
  

## 다중행 함수
여러 행의 값이 입력되는 함수이다.
- 집계 함수 (Aggregate Function)
- 그룹 함수 (Group Function)
- 윈도우 함수 (Window Function)
 

# 👉 NULL
## INSERT NULL
**Oracle에서는 공백 문자(`''`)를 INSERT 시에 데이터가 `NULL`로 입력된다.**

(SQL Server는 공백 문자로 INSERT 된다.)

```sql
INSERT INTO 서비스 VALUES ('999', '', '2015-11-11');
```

따라서 SELECT 다음과 같이 검색하면 검색 결과가 나오지 않는다.
```sql
-- 🥲 BAD
SELECT * FROM 서비스 WHERE 서비스명 = '';

-- 😎 GOOD 
SELECT * FROM 서비스 WHERE 서비스명 IS NULL;
```

<br>

##  NULL 관련 함수
### NVL / ISNULL

> Oracle: `NVL`  /  SQL Server: `ISNULL`

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

