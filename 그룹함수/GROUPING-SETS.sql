-- Q.111
-- GROUPING SETS: 주어진 컬럼을 하나씩 GROUP BY하여 UNION한 것과 결과가 같음

SELECT 상품ID, 월, SUM(매출액) AS 매출액
  FROM 월별매출
 WHERE 월 BETWEEN '2014.01' AND '2014.12'
 GROUP BY GROUPING SETS((상품ID, 월))
 ORDER BY 상품ID, 월;

-- GROUPING SETS에 괄호가 한 번 감싸져 있으므로 아래 쿼리와 결과가 같음
SELECT 상품ID, 월, SUM(매출액) AS 매출액
  FROM 월별매출
 WHERE 월 BETWEEN '2014.01' AND '2014.12'
 GROUP BY (상품ID, 월)
 ORDER BY 상품ID, 월;



-- GROUPING SETS에 괄호가 없다면
SELECT 상품ID, 월, SUM(매출액) AS 매출액
  FROM 월별매출
 WHERE 월 BETWEEN '2014.01' AND '2014.12'
 GROUP BY GROUPING SETS(상품ID, 월)
 ORDER BY 상품ID, 월;

-- 다음 쿼리와 동일한 결과이다
SELECT 상품ID, NULL AS 월, SUM(매출액) AS 매출액
  FROM 월별매출
 WHERE 월 BETWEEN '2014.01' AND '2014.12'
 GROUP BY 상품ID
UNION ALL
SELECT NULL, 월, SUM(매출액) AS 매출액
  FROM 월별매출
 WHERE 월 BETWEEN '2014.01' AND '2014.12'
 GROUP BY 월


