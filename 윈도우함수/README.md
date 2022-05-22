# WINDOW FUNCTION
- 행과 행간의 관계를 쉽게 정의하기 위해 만든 함수

```sql
SELECT 윈도우함수(인자)
OVER ([PARTITION BY] [ORDER BY] [WINDOWING])
FROM 테이블명;
```
- `PARTITION BY`: 전체 집합을 기준에 의해 소그룹화
- `ORDER BY` 어떤 항목에 대해 순위를 지정할지
- `WINDOWING` 함수의 대상이 되는 행 기준의 범위 지정 (`ROWS` or `RANGE`)

<img width="700" alt="windowing" src="https://user-images.githubusercontent.com/31913666/169701228-a8e46b70-addc-4205-bf33-60ea26de458b.png">
(출처: https://youtu.be/6FUWUhfdIG4)
