-- 데이터조회 : SELECT 구문
-- e : 별칭(임의로 지정 가능), 생략가능
-- * : 전체 필드(컬럼)
SELECT * FROM EMP e;

-- 특정 컬럼에 해당하는 내용 보기
SELECT EMPNO ,ENAME ,SAL  FROM EMP e;

-- 중복데이터 제거하고 조회
SELECT DISTINCT DEPTNO FROM EMP e;

-- 데이터 출력 시 필드명 별칭 부여(원본은 바뀌지 않음, 출력할때만 바뀐거로 보인다)
-- AS 생략 가능
-- 쌍따옴표는 별칭에 공백이 있는 경우 무조건 사용한다
SELECT EMPNO AS 사원번호, MGR 매니저번호, DEPTNO "부서번호" FROM EMP e;

-- 계산
SELECT EMPNO ,SAL ,SAL*12 AS 연봉 FROM EMP e;

-- 정렬 (ORDER BY 정렬기준컬럼명 DESC or ASC), ASC(오름차순-default)
SELECT * FROM EMP e ORDER BY SAL DESC ;
SELECT * FROM EMP e ORDER BY DEPTNO DESC ,SAL DESC ;

-- 조건부여 : WHERE 구문 (=, >, <, >=, =<)
SELECT * FROM EMP e WHERE DEPTNO = 30;
SELECT * FROM EMP e WHERE SAL >= 1000 ORDER BY SAL DESC;

-- AND
-- deptno 가 30이고, job이 salesman 사원조회
-- 데이터는 대소문자 구별함 salesman(x)  SALESMAN(o)
SELECT * FROM EMP e WHERE DEPTNO =30 AND JOB ='SALESMAN';

-- OR
-- 부서번호가 30 이거나 직책이 SALESMAN 사원 조회
SELECT * FROM EMP e WHERE DEPTNO =30 OR JOB ='SALESMAN';

----------------------------------------------------------------------------------------------------------------------------------2024-04-25

-- 날짜 데이터도 산술 연산 가능, 날짜 데이터는 ''로 처리
-- HIREDATE 가 1981-10-31 이후에 고용된 사원 조회
SELECT * FROM EMP WHERE HIREDATE > '1981-10-31';

-- IN
SELECT * FROM EMP m WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- NOT IN
SELECT * FROM EMP m WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- BETWEEN A AND B
-- SAL 2500 이상 3000 이하인 사원조회
SELECT * FROM EMP WHERE SAL BETWEEN 2500 AND 3000;

-- NOT BETWEEN A AND B
-- SAL 2500 미만 3000 초과인 사원조회
SELECT * FROM EMP WHERE SAL NOT BETWEEN 2500 AND 3000;

-- LIKE 연산자와 와일드 카드(_, %)
-- _ : 문자 하나
-- % : 문자 개수는 무한대

-- 사원 이름이 S로 시작하는 사원 조회
SELECT * FROM EMP WHERE ENAME LIKE 'S%';

-- 사원 이름의 두번째 글자가 L인 사원 조회
SELECT * FROM EMP WHERE ENAME LIKE '_L%';

-- 사원 이름에 AM 문자가 포함된 사원 조회
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';

-- 사원 이름에 AM 문자가 포함되지 않은 사원 조회
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%';

-- NULL : 값이 없는 상태 (0이 아니다, 0은 값이 존재)
-- '' : 빈 값
-- ' ' : 스페이스바도 문자값이다
-- NULL 비교 : IS

-- comm 이 null 인 사원 조회
--SELECT * FROM EMP WHERE COMM = NULL (X)
SELECT * FROM EMP WHERE COMM IS NULL ;

-- comm 이 null 이 아닌 사원 조회
SELECT * FROM EMP WHERE COMM IS NOT NULL ;

----------------------------------------------------------------------------------------------------------------------------------2024-04-26

-- 집합연산자
-- 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)

-- 부서번호가 20 혹은 30 사원 조회 (OR 를 사용해도 됨)
SELECT * FROM EMP WHERE DEPTNO = 20 
UNION 
SELECT * FROM EMP WHERE DEPTNO = 30;

-- 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.
SELECT empno, ENAME, SAL ,DEPTNO FROM EMP e WHERE DEPTNO = 10
UNION 
SELECT empno, ENAME, SAL FROM EMP e WHERE DEPTNO = 20;

-- 집합 연산자 UNION 을 사용할때 출력 열 개수, 타입 동일 (empno 와 SAL 이 같은 NUMBER타입)
SELECT empno, ENAME, SAL ,DEPTNO FROM EMP e WHERE DEPTNO = 10
UNION 
SELECT SAL, JOB, DEPTNO , SAL FROM EMP e WHERE DEPTNO = 20;

-- UNION : 결과 값의 중복 데이터를 제거 해준다
SELECT empno, ENAME, SAL ,DEPTNO FROM EMP e WHERE DEPTNO = 10
UNION 
SELECT empno, ENAME, SAL ,DEPTNO FROM EMP e WHERE DEPTNO = 10;

-- UNION ALL : 결과 값의 중복 데이터를 제거 하지않는다
SELECT empno, ENAME, SAL ,DEPTNO FROM EMP e WHERE DEPTNO = 10
UNION ALL 
SELECT empno, ENAME, SAL ,DEPTNO FROM EMP e WHERE DEPTNO = 10;

-- MINUS
SELECT EMPNO ,ENAME ,SAL ,DEPTNO FROM EMP e WHERE DEPTNO = 10
MINUS 
SELECT EMPNO ,ENAME ,SAL ,DEPTNO FROM EMP e WHERE DEPTNO = 20;


-- INTERSECT
SELECT empno, ENAME, SAL ,DEPTNO FROM EMP e WHERE DEPTNO = 10
INTERSECT 
SELECT empno, ENAME, SAL ,DEPTNO FROM EMP e WHERE DEPTNO = 10;


-- 오라클 함수(내장 함수 , 함수는 사용하는 DBMS 에 따라 다르게 제공)

--  1. 문자 함수
--  	1) 대소문자 변경
-- 		 - UPPER(문자열) : 괄호 안 문자를 모두 대문자로 변환하여 반환
-- 		 - LOWER(문자열) : 괄호 안 문자를 모두 소문자로 변환하여 반환
-- 		 - INITCAP(문자열) : 괄호 안 문자 데이터 중 첫번째 문자만 대문자로 나머지는 소문자로 변환하여 반환
SELECT * FROM EMP e WHERE ENAME = 'clark'; -- (x) '' 안은 대소문자 구별

SELECT * FROM EMP e WHERE LOWER(ENAME)= 'clark'; -- (o)

SELECT * FROM EMP e WHERE ENAME = UPPER('clark'); -- (o)

SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) FROM EMP e ;

--		2) 문자열 길이 : LENGTH
-- 		 - LENGTHB : 문자열에 사용된 바이트 수 반환
SELECT ENAME, LENGTH(ENAME), LENGTHB(ENAME) FROM EMP e ;

--		 - DUAL 테이블 : 함수 결과를 보고 싶은데 테이블이 없을경우 임시 테이블로 DUAL 사용
-- 		 - 한글은 문자 하나당 3byte 할당, 영어는 1byte (사용하는 오라클 버전마다 다를수있음)
SELECT LENGTH('한글'), LENGTHB('한글') FROM DUAL ;

-- 		 - 직책 이름이 6글자 이상인 사원 조회
SELECT * FROM EMP e WHERE LENGTH(JOB) >= 6;

----------------------------------------------------------------------------------------------------------------------------------2024-04-29

-- 3) 문자열 일부 추출 : substr (문자열데이터, 시작위치, 추출길이)
--    추출길이는 생략가능, 생략하면 시작위치부터 마지막까지 출력
SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5) FROM EMP m;

--    시작위치가 음수라면 오른쪽 끝부터 시작
SELECT JOB, SUBSTR(JOB,-1,2), SUBSTR(JOB,-3,2), SUBSTR(JOB,-5) FROM EMP e ;

-- 4) INSTR(문자열데이터, 위치를 찾으려는 문자, 시작위치, 시작위치에서 몇번째 위치)
--    문자열 데이터 안에서 특정 문자 위치 찾기
SELECT INSTR('HELLO, ORACLE!','L') AS "첫번째 L",
 INSTR('HELLO, ORACLE!','L', 5) AS "세번째 L",
 INSTR('HELLO, ORACLE!','L', 2, 2) AS "두번째 L"
FROM DUAL ;

--    사원 이름에 S 가 들어있는 사원 조회
--    LIKE, INSTR 값이있다면 0 보다 큰 부등호 줄수있다 값이없으면 0으로 표시
SELECT * FROM EMP WHERE INSTR(ENAME,'S') > 0; 

-- 5) REPLACE (문자열데이터, 찾는문자, 변경할문자)
--    특정 문자를 다른 문자로 변경
--    변경할문자 '' = 생략 , ' ' = 공백 (스페이스바)
SELECT '010-1234-5678' AS REPLACE_BEFORE,
       REPLACE ('010-1234-5678','-','') AS REPLACE_1,
       REPLACE ('010-1234-5678','-') AS REPLACE_2,
       REPLACE ('010-1234-5678','-',' ') AS REPLACE_3
FROM DUAL ;

-- 6) CONCAT : 두 문자열 데이터를 합하는 함수
--             CONCAT(문자열데이터1,문자열데이터2)

--    인수의 개수가 부적합합니다
SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO,ENAME,JOB) FROM EMP e WHERE ENAME ='SCOTT'; -- (x)

--    세 문자열 을 합칠경우 CONCAT 한번 더쓰는 방법
SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO,CONCAT(JOB ,ENAME)) FROM EMP e WHERE ENAME ='SMITH';

--    세 문자열 을 합칠경우 || 를 사용하는 방법 (7369 : SMITH) 
SELECT EMPNO || ' : ' || ENAME FROM EMP WHERE ENAME = 'SMITH';

-- 7) TRIM : 공백 제거(기본탑제)
--    TRIM(삭제옵션(생략가능), 삭제할문자) FROM 원본문자열
--    예시) 'SMITH' = 'SMITH ' 비교할때 공백이 있어서 같지 않음
SELECT
	'[' || ' __Oracle__ ' || ']' AS trim_BEFORE,
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || LTRIM(' __Oracle__ ') || ']' AS Ltrim,
	'[' || RTRIM(' __Oracle__ ') || ']' AS Rtrim
FROM
	DUAL ;

SELECT
	'[' || ' __Oracle__ ' || ']' AS trim_BEFORE,
	'[' || TRIM(LEADING '_' FROM '__Oracle__') || ']' AS trim_READING,
	'[' || TRIM(TRAILING '_' FROM '__Oracle__') || ']' AS trim_TRAILING,
	'[' || TRIM(BOTH '_' FROM '__Oracle__') || ']' AS trim_BOTH
FROM
	DUAL ;

----------------------------------------------------------------------------------------------------------------------------------2024-04-30

-- 2. 숫자함수 : 숫자 데이터에 적용
--    반올림, 올림 ,버림, 나머지 값 구하기
--    ROUND, CEIL,FLOOR , TRUNC, MOD

-- ROUND(숫자, 반올림위치) 반올림위치 생략하면 0 이다
SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678,0) AS ROUND1,
	ROUND(1234.5678,1) AS ROUND2,
	ROUND(1234.5678,2) AS ROUND3,
	ROUND(1234.5678,-1) AS ROUND_MINUS1,
	ROUND(1234.5678,-2) AS ROUND_MINUS2
FROM DUAL ;

-- TRUNC(숫자, 버릴위치) : 버림
SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678,0) AS TRUNC0,
	TRUNC(1234.5678,1) AS TRUNC1,
	TRUNC(1234.5678,2) AS TRUNC2,
	TRUNC(1234.5678,-1) AS TRUNC_MINUS1,
	TRUNC(1234.5678,-2) AS TRUNC_MINUS2
FROM DUAL ;

-- CEIL, FLOOR : 지정한 숫자와 가까운 정수를 찾기
-- CEIL : 지정한 숫자보다 큰 정수 중 가장 작은 정수 반환
-- FLOOR : 지정한 숫자보다 작은 정수 중 가장 큰 정수 반환
SELECT
	CEIL (3.14),
	FLOOR(3.14),
	CEIL (-3.14),
	FLOOR(-3.14)
FROM
	DUAL ;

-- MOD : 나머지 값 출력
SELECT 11/5, MOD (11,5)
FROM DUAL ;




-- 3. 날짜 함수
-- 2023-01-24 OR 2023/01/24

-- 오늘날짜
SELECT
	SYSDATE ,
	CURRENT_DATE ,
	CURRENT_TIMESTAMP 
FROM
	DUAL ;
	
-- 날짜데이터 + 숫자 : 날짜 데이터보다 숫자만큼 이후의 날짜
SELECT
	SYSDATE ,
	SYSDATE +1,
	SYSDATE -1
FROM
	DUAL ;


-- ADD_MONTHS(날짜데이터,더할숫자) : 몇 개월 이후의 날짜 구하기
SELECT
	SYSDATE ,
	ADD_MONTHS(SYSDATE,3)
FROM
	DUAL ;
	
-- 입사 30주년이 되는 날짜 구하기
SELECT ENAME , HIREDATE , ADD_MONTHS(HIREDATE,360)  FROM EMP ;



-- MONTHS_BETWEEN(날짜1,날짜2) : 두 개의 날짜 데이터를 입력하고 두 날짜간의 개월 수 차이 구하기
-- 고용일과 오늘날짜 차이를 구하시오
SELECT EMPNO , ENAME , HIREDATE , SYSDATE , ROUND(MONTHS_BETWEEN(SYSDATE ,HIREDATE),1) FROM EMP ;



-- NEXT_DAY, LAST_DAY
-- NEXT_DAY(날짜,요일) : 특정 날짜를 기준으로 돌아로는 요일의 날짜 출력
-- LAST_DAY(날짜) : 특정 날짜가 속한 달의 마지막 날짜
SELECT SYSDATE , NEXT_DAY(SYSDATE,'월요일'), LAST_DAY(SYSDATE)  
FROM DUAL ;

----------------------------------------------------------------------------------------------------------------------------------2024-05-02

-- 데이터 타입(자료형)
-- NUBER(숫자), VARCHAR2(문자), DATE(날짜/시간)
-- 자료형을 변환 해야하는 경우 : 날짜 -> 문자, 문자 -> 숫자

-- 자동 형 변환
-- NUMBER + 문자숫자(숫자에 '' 씌우면 가능) : 자동 형 변환으로 계산 처리
SELECT ENAME ,EMPNO , EMPNO + '500' FROM EMP e WHERE ENAME ='FORD';

-- 수치가 부적합합니다 : 더할수 없는 값을 적용한 경우
SELECT ENAME ,EMPNO , EMPNO + 'ABCD' FROM EMP e WHERE ENAME ='FORD';


-- 명시적 형 변환
-- TO_CHAR(날짜(숫자)데이터,'출력되기를 원하는 문자 형태') : 숫자,날짜 -> 문자 (날짜를 많이씀)
-- TO_NUMBER(문자열, 숫자형식) : 문자 -> 숫자
-- TO_DATE() : 문자 -> 날짜
-- Y : 연도, M : 월, D : 일
-- HH : 시, MI : 분, SS : 초, HH24 : 시를 24시간으로, AM(PM) : 오전,오후
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD'), SYSDATE 
FROM DUAL ;

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD'), SYSDATE, TO_CHAR(SYSDATE, 'YY/MM/DD HH:MI:SS') 
FROM DUAL ;

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD'), SYSDATE, TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') 
FROM DUAL ;

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD'), SYSDATE, TO_CHAR(SYSDATE, 'YY/MM/DD HH:MI:SS AM') 
FROM DUAL ;

-- 숫자데이터에 콤마를 넣을경우(원하는 결과가 안나옴)
SELECT 1,300 - '1500', '1300' + 1,500 FROM DUAL ;

-- 수치가 부적합 합니다
SELECT '1,300' + '1,500' FROM DUAL ;



----------------------------------------------------------------------------------------------------------------------------------2024-05-03
