-- scott 권한 부여

-- SELECT(데이터 조회) SQL 구문
-- e : 별칭(임의 지정 가능) / 없어도 됨
-- * : 전체 필드(컬럼)를 의미함
SELECT * FROM EMP e;

-- 특정 컬럼에 해당하는 내용 보기
SELECT
	EMPNO ,
	ENAME ,
	JOB
FROM
	EMP e;


-- emp 테이블
-- empno(사원번호), ename(사원명), job(직책) ,mgr(매니저번호), hiredate(고용일), sal(급여), comm(보너스), deptno(부서번호)

-- 예시) emp 테이블에서 사원번호, 매니저번호, 부서번호만 조회가 하고싶다
SELECT
	EMPNO ,
	MGR ,
	DEPTNO
FROM
	EMP e;


-- 예시) emp 테이블에서 부서번호만(중복 데이터 제거 distinct) 조회
SELECT
	DISTINCT deptno
FROM
	EMP e ;


-- 데이터 출력 시 필드명 별칭 부여(원본은 안바뀜 출력할때만 바뀐거로 보임)
-- 쌍따옴표는 별칭에 공백이 있는 경우 무조건 사용
-- as 생략 가능
SELECT
	EMPNO AS 사원번호,
	MGR 매니저번호,
	DEPTNO "부서 번호"
FROM
	EMP e;
	

-- 연봉 계산
-- 월급 * 12 + 수당
-- sal * 12 + comm
SELECT empno, SAL , sal * 12 + comm AS "연봉"
FROM EMP e ;

-- 정렬
-- order by 정렬기준컬럼명 DESC or ASC
-- DESC(내림차순), ASC(오름차순-default)
SELECT
	*
FROM
	EMP
ORDER BY SAL DESC ;

-- emp 테이블에서 empno, ename, sal 조화(단, empno 내림차순)
SELECT
	empno,
	ename,
	sal
FROM
	EMP
ORDER BY sal;

-- 전체조회, 부서번호 오름차순, sal 내림차순
SELECT *
FROM EMP e 
ORDER BY DEPTNO, SAL DESC;

-- 조건부여
-- 부서번호가 30번인 사원 조회
-- sal > 1000 이상인 사원 조회
-- =(같다), 산술연산자가능(>,<,>=,=<)
SELECT *
FROM EMP e 
WHERE DEPTNO = 30;

SELECT *
FROM EMP e 
WHERE SAL >= 1000
ORDER BY sal DESC; 

-- empno 가 7782 인 사원 조회
SELECT *
FROM EMP e 
WHERE EMPNO = 7782;

-- deptno 가 30이고, job이 salesman 사원조회
-- 데이터는 대소문자 구별함 salesman(x)  SALESMAN(o)
SELECT *
FROM EMP e 
WHERE deptno = 30 AND  JOB = 'SALESMAN';

-- 사원번호가 7499 이고 부서번호가 30인 사원 조회
SELECT *
FROM EMP e 
WHERE EMPNO = 7499 AND DEPTNO = 30;

-- 이거나(혹은) : OR
-- 부서번호가 30 이거나 직책이 SALESMAN 사원 조회
SELECT  *
FROM EMP e 
WHERE DEPTNO = 30 OR JOB = 'SALESMAN';

-- 연봉이 36000 인 사원 조회
-- SAL * 12 + COMM
SELECT *
FROM EMP e 
WHERE SAL * 12 + COMM = 36000;

-- 문자 비교도 산술연산 기호 사용가능
-- 알파벳 순서로 F 다음에 있는
SELECT *
FROM EMP e
WHERE ENAME >= 'F';

-- SAL 이 3000 이 아닌 사원 조회
-- ~ 이 아닌 : != , <> , ^=  (!= 주로 사용)
SELECT *
FROM EMP e 
WHERE SAL != 3000;

SELECT *
FROM EMP e 
WHERE SAL <> 3000;

SELECT *
FROM EMP e 

-- job이 MANAGER OR SALESMAN OR CLERK
SELECT *
FROM EMP e 
WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' OR JOB = 'CLERK';
WHERE SAL ^= 3000;

-- IN
SELECT *
FROM EMP e 
WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- NOT IN
SELECT *
FROM EMP e 
WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- HIREDATE 가 1981 10 31 이후에 고용된 사원 조회
-- 날짜 데이터 산술 연산 가능, 날짜 데이터 ''로 처리
SELECT *
FROM EMP e 
WHERE HIREDATE > '1981-10-31';

-- BETWEEN A AND B
-- SAL 2000 이상 3000 이하인 사원조회
SELECT *
FROM EMP e 
WHERE SAL >= 2000 AND SAL <= 3000;

SELECT *
FROM EMP e 
WHERE SAL BETWEEN 2000 AND 3000;

-- NOT BETWEEN A AND B
SELECT *
FROM EMP e 
WHERE SAL NOT BETWEEN 2000 AND 3000;

-- LIKE 연산자와 와일드 카드(_, %)
-- _ : 문자 하나
-- % : 문자 개수는 무한대

-- 사원 이름이 S로 시작하는 사원 조회
SELECT * 
FROM EMP e 
WHERE ENAME LIKE 'S%';

-- 사원 이름의 두번째 글자가 L인 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME LIKE '_L%';

-- 사원 이름에 AM 문자가 포함된 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME LIKE '%AM%';

-- 사원 이름에 AM 문자가 포함되지 않은 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME NOT LIKE '%AM%';

--
SELECT * FROM EMP e ;

-- NULL : 값이 없는 상태 (0이 아니다, 0은 값이 존재)
-- '' : 빈 값
-- ' ' : 스페이스바도 문자임

-- comm 이 null 인 사원 조회
-- NULL 비교 : IS
SELECT * FROM EMP e WHERE COMM = NULL ;  (x)
SELECT * FROM EMP e WHERE COMM IS NULL ; 

-- MGR 이 NULL 인 사원 조회
SELECT * FROM EMP e WHERE MGR IS NULL ;
-- MGR 이 NULL 이 아닌 사원 조회
SELECT * FROM EMP e WHERE MGR IS NOT NULL ;


-- 집합연산자
-- 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)

-- 부서번호가 10 혹은 20 사원 조회
-- OR 사용해도됨
-- 합집합을 사용해도됨
SELECT empno, ENAME, SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 10
UNION 
SELECT empno, ENAME, SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 20;

-- 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다
SELECT empno, ENAME, SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 10
UNION 
SELECT empno, ENAME, SAL           
FROM EMP e 
WHERE DEPTNO = 20;         (x) 블록처리, 열개수가 맞지않음

-- 집합 연산자 UNION 을 사용할때 출력 열 개수, 타입 동일 (EMPNO 와 SAL 이 같은 NUMBER타입)
SELECT empno, ENAME, SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 10
UNION 
SELECT SAL, JOB, DEPTNO , SAL        
FROM EMP e 
WHERE DEPTNO = 20;


-- UNION : 결과 값의 중복 제거 해줘
SELECT empno, ENAME, SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 10
UNION 
SELECT empno, ENAME, SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 10;

-- UNION ALL : 결과 값의 중복 제거 하지마
SELECT empno, ENAME, SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 10
UNION ALL 
SELECT empno, ENAME, SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 10;


-- MINUS
SELECT EMPNO ,ENAME ,SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 10
MINUS 
SELECT EMPNO ,ENAME ,SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 20;


-- INTERSECT
SELECT empno, ENAME, SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 10
INTERSECT 
SELECT empno, ENAME, SAL ,DEPTNO 
FROM EMP e 
WHERE DEPTNO = 10;


-- 오라클 함수(내장 함수)
-- 함수는 사용하는 DBMS 에 따라 다르게 제공
-- 1. 문자 함수
-- 대소문자 변경 
SELECT *
FROM EMP e 
WHERE ENAME = 'clark'; (x)

SELECT *
FROM EMP e 
WHERE LOWER(ENAME)= 'clark'; (o)

SELECT *
FROM EMP e 
WHERE ENAME = UPPER('clark'); (o)

-- UPPER(문자열) : 괄호 안 문자를 모두 대문자로 변환하여 반환
-- LOWER(문자열) : 괄호 안 문자를 모두 소문자로 변환하여 반환
-- INITCAP(문자열) : 괄호 안 문자 데이터 중 첫번째 문자만 대문자로 나머지는 소문자로 변환하여 반환
SELECT ENAME,UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP e ;


-- 2) 문자열 길이 : LENGTH
-- LENGTHB : 문자열에 사용된 바이트 수 반환
SELECT ENAME, LENGTH (ENAME), LENGTHB(ENAME)
FROM EMP e ;

-- 함수 결과를 보고 싶은데 테이블이 없을경우 임시 테이블로 DUAL 사용
-- 한글은 문자 하나당 3byte 할당, 영어는 1byte (사용하는 오라클 버전마다 다를수있음)
SELECT LENGTH ('한글'), LENGTHB('한글')
FROM DUAL ;

-- 직책 이름이 6글자 이상인 사원 조회
SELECT *
FROM EMP e 
WHERE LENGTH (JOB)>= 6;

-- 3) 문자열 일부 추출 : substr (문자열데이터, 시작위치, 추출길이)  JOB이 바차로 문자열임
-- 추출길이는 생략가능, 생략하면 시작위치부터 마지막까지 출력
SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5)
FROM EMP e ;

-- 시작위치가 음수라면 오른쪽 끝부터 시작
SELECT JOB, SUBSTR(JOB,-1,2), SUBSTR(JOB,-3,2), SUBSTR(JOB,-5)
FROM EMP e ;

-- 4) INSTR(문자열데이터, 위치를 찾으려는 문자,시작위치, 시작위치에서 몇번째 위치)
--    문자열 데이터 안에서 특정 문자 위치 찾기

SELECT INSTR('HELLO, ORACLE!','L') AS instr_1,
INSTR('HELLO, ORACLE!','L', 5) AS instr_2,
INSTR('HELLO, ORACLE!','L', 2, 2) AS instr_3
FROM
DUAL ;


-- 사원 이름에 S 가 들어있는 사원 조회
-- LIKE, INSTR 값이있다면 0 보다 큰 부등호 줄수있다 값이없으면 0으로 표시
SELECT *
FROM EMP e 
WHERE INSTR(ENAME,'S') > 0; 


-- 5) REPLACE : 특정 문자를 다른 문자로 변경
--              REPLACE (문자열데이터,찾는문자,변경할문자)
--              변경할문자 ''=생략 , ' '=공백 스페이스바 
SELECT '010-1234-5678' AS REPLACE_BEFORE,
       REPLACE ('010-1234-5678','-','') AS REPLACE_1,
       REPLACE ('010-1234-5678','-') AS REPLACE_2,
       REPLACE ('010-1234-5678','-',' ') AS REPLACE_3
 FROM DUAL ;
 

-- 6) CONCAT : 두 문자열 데이터를 합하는 함수
--             CONCAT(문자열데이터1,문자열데이터2)
--SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO,ENAME,JOB)  
--FROM EMP e 
--WHERE ENAME ='SCOTT'; (x)

-- 7369 : SMITH 세문자열 합칠경우 CONCAT 한번 더씀
SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO,CONCAT(' : ',ENAME)) 
FROM EMP e 
WHERE ENAME ='SMITH';

-- 세 문자열 합칠경우 || 를 사용
SELECT EMPNO || ' : ' || ENAME 
FROM EMP e 
WHERE ENAME ='SMITH';


-- 7) TRIM : 공백 제거(기본탑제)
-- TRIM(삭제옵션(생략가능), 삭제할문자) FROM 원본문자열
-- 예시) 'SMITH' = 'SMITH ' 비교할때 공백이 있어서 같지 않음
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
SELECT EMPNO ,ENAME ,HIREDATE ,ADD_MONTHS(HIREDATE,360)
FROM EMP e ;

-- MONTH_BETWEEN(날짜1,날짜2) : 두 개의 날짜 데이터를 입력하고 두 날짜간의 개월 수 차이 구하기
-- 고용일과 오늘날짜 차이를 구하시오
SELECT
	EMPNO ,
	ENAME ,
	HIREDATE ,
	SYSDATE ,
	MONTHS_BETWEEN(HIREDATE,SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE,HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS MONTH3
FROM
	EMP e;
	
-- NEXT_DAY, LAST_DAY
-- NEXT_DAY(날짜,요일) : 특정 날짜를 기준으로 돌아로는 요일의 날짜 출력
-- LAST_DAY(날짜) : 특정 날짜가 속한 달의 마지막 날짜
SELECT SYSDATE , NEXT_DAY(SYSDATE,'월요일'), LAST_DAY(SYSDATE)  
FROM DUAL ;


-- 데이터 타입(자료형)
-- NUBER(숫자), VARCHAR2(문자), DATE(날짜/시간)
-- 자료형을 변환 해야하는 경우 : 날짜 -> 문자, 문자 -> 숫자

-- NUMBER + 문자숫자(숫자에 '' 씌우면 가능) : 자동 형 변환으로 계산 처리
SELECT EMPNO ,ENAME , EMPNO + '500'
FROM EMP e 
WHERE ENAME ='FORD';

-- 더할수 없는 값을 적용하면 부적합
--SELECT EMPNO ,ENAME , EMPNO + 'ABCD'
--FROM EMP e 
--WHERE ENAME ='FORD';


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

-- 숫자데이터에 콤마를 넣을경우
SELECT 1,300 - '1500', '1300' + 1,500
FROM DUAL ;                            원하는 형태가 안나옴

SELECT 1300 - '1500', '1300' + 1500
FROM DUAL ;

SELECT '1300' + '1500'
FROM DUAL ;

-- 수치가 부적합 합니다
--SELECT '1,300' + '1,500'
--FROM DUAL ;

-- 9 : 숫자의 한 자리를 의미함(빈자리를 채우지 않음)
-- 0 : 사용가능 하지만 빈 자리를 0으로 채움
SELECT TO_NUMBER('1,300','999,999') + TO_NUMBER('1,500','999,999') 
FROM DUAL ;

SELECT
	TO_CHAR(SAL, '999,999.00') AS SAL1,
	TO_CHAR(SAL, '000,999,999.00') AS SAL2
FROM
	EMP e ;

-- TO_DATE('20240124') : 형식이 맞으면 알아서 날짜데이터로 바꿔줌
SELECT
	TO_DATE('2024-01-24') AS TODATE1,
	TO_DATE('20240124') AS TODATE2
FROM DUAL ;

-- 수치가 부적합 합니다
-- '2024-01-24' 를 날짜로 인식을 못함
--SELECT '2024-01-24' - '2024-12-31'
--FROM DUAL ;

-- TO_DATE() 를 사용해서 날짜데이터로 바꿔줘야함
SELECT TO_DATE('2024-01-24') - TO_DATE('2023-12-31')
FROM DUAL;


-- 널 처리 함수
-- 널 * 숫자 = NULL, 널 + 숫자 = NULL
-- 널을 다른 값으로 변경하는 함수가 필요, 널이 연산이 안되기 때문에
SELECT EMPNO ,ENAME , SAL , COMM , SAL + COMM 
FROM EMP e ;

-- NVL(NULL인지 검사할 열이름(OR 데이터), 대체할 데이터)
SELECT EMPNO ,ENAME , SAL , COMM , SAL + NVL(COMM,0)  
FROM EMP e ;

-- NVL2(NULL인지 검사할 열이름(OR 데이터),NULL이 아닌경우 반환 데이터(OR 계산식),
--                                        NULL 인경우 반환 데이터(OR 계산식))
SELECT EMPNO ,ENAME , SAL , COMM , NVL2(COMM,'O','X')  
FROM EMP e ;

-- NVL2
-- COMM 이 NULL이면 연봉=SAL*12, NULL이 아니면 연봉=SAL*12+COMM
SELECT EMPNO ,ENAME , SAL , COMM , NVL2(COMM,SAL*12+COMM,SAL*12) AS 연봉
FROM EMP e ;

-- DECODE 함수와 CASE 문
-- DECODE(검사대상, 조건1, 조건1이 참일때 반환할 결과, 조건2, 조건2가 참일떄 반환할결과,..., 
--                                                                      조건1~조건n 일치하지 않는 경우 반환할 결과 )
-- JOB 이 MANAGER 라면 SAL * 1.1    10% 인상
-- JOB 이 SALESMAN 라면 SAL * 1.05  5% 인상
-- JOB 이 ANALYST 라면 SAL          동결
--         나머지 직무 SAL * 1.03   3% 인상
SELECT
	EMPNO ,
	ENAME ,
	JOB ,
	SAL ,
	DECODE(JOB, 'MANAGER', SAL * 1.1,'SALESMAN', SAL * 1.05,'ANALYST', SAL, SAL *1.03) AS UPSAL
FROM
	EMP e ;

-- 이때 CASE 는 단순히 같다라는 의미만 사용해서 JOB 통합해서 사용해도됨
SELECT
	EMPNO ,
	ENAME ,
	JOB ,
	SAL ,
	CASE
		JOB 
		WHEN 'MANAGER' THEN SAL * 1.1
		WHEN 'SALESMAN' THEN SAL * 1.05
		WHEN 'ANALYST' THEN SAL
		ELSE SAL * 1.03
	END AS UPAL2,
	DECODE(JOB, 'MANAGER', SAL * 1.1, 'SALESMAN', SAL * 1.05, 'ANALYST', SAL, SAL * 1.03) AS UPSAL
FROM
	EMP e ;

-- COMM 이 NULL 이라면 해당사항 없음 으로 나오게
-- COMM 이 0 일경우 수당없음
-- COMM 이 > 0  수당 : COMM
-- 이때는 같다 말고 다른의미로도 사용하기 때문에 각각 적용시킴
SELECT
	EMPNO ,
	ENAME ,
	COMM,
	CASE 
		WHEN COMM IS NULL THEN '해당사항 없음'
		WHEN COMM = 0 THEN '수당 없음'
		WHEN COMM > 0 THEN '수당 : ' || COMM
	END AS COMM_NEXT
FROM
	EMP e ;

-- (실습1) SQL 작성
SELECT
	EMPNO ,
	ENAME ,
	SAL ,
	TRUNC(SAL / 21.5, 2) AS DAY_PAY,
	ROUND((SAL / 21.5)/ 8, 1) AS TIME_PAY
FROM
	EMP e ;
	
-- (실습2)  EMP 테이블에서 사원들은 입사일(HIREDATE)을 기준으로 3개월이 지난후 첫 월요일에 정직원이 된다.
-- 사원들이 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 아래 와 같이 출력하시오.
-- 단, 추가수당(COMM)이 없는 사원의 추가 수당은 N/A 로 출력하시오
-- 힌트) COMM 은 NUBER 타입이라서 'N/A' 문자가 바로 출력이 안됨
SELECT
	EMPNO ,
	ENAME ,
	HIREDATE,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'),'YYYY-MM-DD')  AS R_JOB,
	NVL(TO_CHAR(COMM),'N/A') AS COMM 
FROM
	EMP e ;