# Table of Contents
- [Table of Contents](#table-of-contents)
- [FUNCTION](#function)
  - [NULL 관련 함수](#null-관련-함수)
    - [NVL / ISNULL](#nvl--isnull)
    - [NULLIF](#nullif)
    - [COALESCE](#coalesce)

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