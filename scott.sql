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

-- MONTHS_BETWEEN(날짜1,날짜2) : 두 개의 날짜 데이터를 입력하고 두 날짜간의 개월 수 차이 구하기
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
	
-- (실습3) EMP 테이블의 모든 사원을 대상으로 직속 상
--관의 사원 번호(MGR)를 다음과 같은 조건을 기준으로
--변환해서 CHG_MGR 열에 출력하시오.
--직속상관의 사원 번호가 존재하지 않을 경우 : 0000
--직속상관의 사원 번호 앞 두자리가 75일 경우 : 5555
--직속상관의 사원 번호 앞 두자리가 76일 경우 : 6666
--직속상관의 사원 번호 앞 두자리가 77일 경우 : 7777
--직속상관의 사원 번호 앞 두자리가 78일 경우 : 8888
--그 외 직속 상관 사원 번호의 경우 : 본래 직속 상관의 사
--원번호 그대로 출력
-- 힌트) SUBSTR 은 문자열데이터를 추출, MGR은 숫자타입

SELECT
	EMPNO ,
	ENAME ,
	MGR ,
	CASE
		WHEN MGR IS NULL THEN '0000'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '75' THEN '5555'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '77' THEN '7777'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '78' THEN '8888'
		ELSE TO_CHAR(MGR)
	END AS CHG_MGR
FROM
	EMP e ;

-- NULL이 = 로 비교 할수없기때문에 NVL을 사용해서 임의로 0으로 부여해서 간단히 만들수있다
SELECT
	EMPNO ,
	ENAME ,
	MGR ,
	CASE SUBSTR(TO_CHAR(NVL(MGR,0)), 1, 2)
		WHEN '0' THEN '0000'
		WHEN '75' THEN '5555'
		WHEN '76' THEN '6666'
		WHEN '77' THEN '7777'
		WHEN '78' THEN '8888'
		ELSE TO_CHAR(MGR)
	END AS CHG_MGR
FROM
	EMP e ;

SELECT
	EMPNO ,
	ENAME ,
	MGR ,
	DECODE(SUBSTR(TO_CHAR(MGR), 1, 2), NULL, '0000', '75', '5555', '76', '6666', '77', '7777', '78', '8888', TO_CHAR(MGR)) AS CHG_MGR
FROM
	EMP e ;


-- 이전까지 했던 작업은 단일 행 이었다

-- 다중 행 함수
-- SUM(), AVG(), COUNT(0), MAX(), MIN()
-- 단일 그룹의 그룹 함수가 아닙니다(여러 행이 나올수 있는 컬럼을 추가한 경우)
-- 그룹함수 결과는 1개 행만 나오지만 ENAME 은 결과행이 여러개 나오기 때문에 같이 못씀
SELECT SUM(SAL), AVG(SAL), COUNT(SAL), MAX(SAL), MIN(SAL), ENAME 
FROM EMP e ;

-- 동일한 급여를 하나만 선택해서 합계 (중복을 제거해준다)
SELECT SUM(DISTINCT SAL) 
FROM EMP e ;
-- 일반적으로 전체 행수를 알고싶을때 * 사용 다른 컬럼 넣어도 됨
SELECT COUNT(*) 
FROM EMP e ;
-- 부서번호가 30인 사원 수 출력
SELECT COUNT(*) 
FROM EMP e 
WHERE DEPTNO = 30;
-- 부서번호가 30인 사원 중에서 급여의 최대값
SELECT MAX(SAL)
FROM EMP e 
WHERE DEPTNO = 30;
-- 부서번호가 20인 사원의 입사일 중에서 제일 최근 입사일 조회
SELECT MAX(HIREDATE)
FROM EMP e 
WHERE DEPTNO = 20;
-- 부서번호가 20인 사원의 입사일 중에서 제일 오래된 입사일 조회
SELECT MIN(HIREDATE) 
FROM EMP e 
WHERE DEPTNO =20;
-- 부서번호가 30인 사원 중에서 SAL 중복값 제거한 후 평균구하기
SELECT AVG(DISTINCT SAL) 
FROM EMP e 
WHERE DEPTNO = 30;

-- 부서별 급여 합계 구하기
SELECT '10' AS DEPTNO, SUM(SAL)
FROM EMP e
WHERE DEPTNO = 10
UNION
SELECT '20' AS DEPTNO, SUM(SAL)
FROM EMP e
WHERE DEPTNO = 20
UNION
SELECT '30' AS DEPTNO, SUM(SAL)
FROM EMP e
WHERE DEPTNO = 30;

-- 결과 값을 원하는 열로 묶기 : GROUP BY
-- GROUP BY 표현식이 아닙니다
-- GROUP BY 옆에 오는 컬럼만 SELECT 절에 사용 가능
--SELECT 보고싶은 컬럼(열이름),....                        ①
--FROM 테이블명                                            ②
--WHERE 조건들 나열                                        ③
--GROUP BY 그룹화할 열 이름.... (HAVING = 옵션,생략가능)   ④
--ORDER BY 정렬조건                                        ⑤

--실행순서 : ② -> ③ -> GROUP BY -> HAVING -> ① - > ⑤
SELECT DEPTNO ,SUM(SAL) 
FROM EMP e 
GROUP BY DEPTNO ;

-- 부서별 급여 평균
SELECT DEPTNO ,AVG(SAL) 
FROM EMP e 
GROUP BY DEPTNO ;
-- 부서번호, 직무별 급여 평균
SELECT DEPTNO ,JOB ,AVG(SAL) 
FROM EMP e 
GROUP BY DEPTNO, JOB  
ORDER BY DEPTNO ;

-- HAVING : GROUP BY 절에 조건을 사용할 때
-- 부서별 직책의 평균 급여가 500 이상인 사원들의 부서번호, 직책,부서별 직책 평균급여
SELECT DEPTNO ,JOB ,AVG(SAL) 
FROM EMP e 
GROUP BY DEPTNO ,JOB HAVING AVG(SAL) >= 500 
ORDER BY DEPTNO ,JOB ;
-- WHERE 순서가 먼저이다
SELECT DEPTNO ,JOB ,AVG(SAL) 
FROM EMP e 
WHERE SAL <= 3000
GROUP BY DEPTNO ,JOB HAVING AVG(SAL) >= 2000 
ORDER BY DEPTNO ,JOB ;

-- 같은 직무에 종사하는 사원이 3명 이상인 직무와 인원수 조회
SELECT JOB ,COUNT(JOB) 
FROM EMP e 
GROUP BY JOB HAVING COUNT(JOB) >= 3 
ORDER BY JOB ;
-- 사원들의 입사연도를 기준으로 부서별 몇명이 입사했는지 조회
-- 예시) 1981도 10번부서 3명
SELECT
	TO_CHAR(HIREDATE, 'YYYY') AS 입사연도,
	DEPTNO ,
	COUNT(DEPTNO) AS 인원수
FROM
	EMP e
GROUP BY
	TO_CHAR(HIREDATE, 'YYYY'),
	DEPTNO
ORDER BY
	TO_CHAR(HIREDATE, 'YYYY'),
	DEPTNO ;

-- JOIN : 여러 테이블을 하나의 테이블처럼 사용
-- 1) 내부조인(일치하는 값이 있는 경우)

-- EMP 와 DEPT JOIN
SELECT *
FROM EMP e ,DEPT d 
WHERE e.DEPTNO = d.DEPTNO ;

-- 열의 정의가 애매합니다 (DEPTNO가 두테이블에 다있어서)
--SELECT ENAME, SAL, DEPTNO ,DNAME ,LOC 
--FROM EMP e ,DEPT d 
--WHERE e.DEPTNO = d.DEPTNO ;

-- 어디테이블에 무슨컬럼인지 별칭을 정해준다
SELECT e.ENAME, e.SAL, d.DEPTNO ,d.DNAME ,d.LOC 
FROM EMP e ,DEPT d 
WHERE e.DEPTNO = d.DEPTNO ; 

-- JOIN 할때 WHERE 절 조건을 주지 않을경우 나올수 있는 모든 조합이 결과로 나옴
-- JOIN 할경우 대부분 WHERE 와 같이 쓴다
SELECT e.ENAME, e.SAL, d.DEPTNO ,d.DNAME ,d.LOC 
FROM EMP e ,DEPT d ;
-- 조건 추가 (같은 컬럼이 있을경우)
SELECT e.ENAME, e.SAL, d.DEPTNO ,d.DNAME ,d.LOC 
FROM EMP e ,DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND SAL >= 3000;
-- SQL99버전 표준구문
-- 조건 추가 (같은 컬럼이 있을경우)
SELECT e.ENAME, e.SAL, d.DEPTNO ,d.DNAME ,d.LOC 
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.SAL >= 3000;


-- EMP, SALGRADE 조인
-- 조건 추가(특정범위 안에)
SELECT *
FROM EMP e ,SALGRADE s 
WHERE e.SAL BETWEEN S.LOSAL AND S.HISAL ;

-- EMP, EMP 조인 (SELF 조인)
-- JOIN은 옆으로 출력되는 특성을 활용한 경우
SELECT E.EMPNO, E.ENAME, E.MGR , E2.ENAME AS MGR_NAME
FROM EMP e ,EMP e2 
WHERE E.MGR = E2.EMPNO ;


-- 2) 외부 조인 (일치하지 않는걸 출력)
--  (1) 왼쪽 외부조인 (왼쪽 테이블 기준) : LEFT OUTER JOIN, 공통된것도 출력하고 공통이 아닌걸 왼쪽기준 출력
--  (2) 오른쪽 외부조인 (오른쪽 테이블 기준) : RIGHT OUTER JOIN
SELECT E.EMPNO, E.ENAME, E.MGR , E2.ENAME AS MGR_NAME
FROM EMP e LEFT OUTER JOIN EMP e2 ON E.MGR = E2.EMPNO;

SELECT E.EMPNO, E.ENAME, E.MGR , E2.ENAME AS MGR_NAME
FROM EMP e RIGHT OUTER JOIN EMP e2 ON E.MGR = E2.EMPNO;

-- 각 부서별 평균급여, 최대급여, 최소급여, 사원수
-- 부서번호, 부서명, 평균급여, 최대급여, 최소급여, 사원수 를 뽑고싶다
SELECT E.DEPTNO, D.DNAME, AVG(SAL), MAX(SAL), MIN(SAL), COUNT(*)  
FROM EMP e JOIN DEPT d ON E.DEPTNO = D.DEPTNO 
GROUP BY E.DEPTNO, D.DNAME  ;

-- 세 개의 테이블 조인하기
SELECT *
FROM
	EMP e1
JOIN EMP e2 ON
	E1.EMPNO = E2.EMPNO
JOIN EMP e3 ON
	E2.EMPNO = E3.EMPNO ;

-- 모든 부서 정보와 사원 정보를 출력
-- 부서번호, 사원 이름 순으로 출력
--부서번호, 부서명, 사원번호, 사원명, 직무, 급여
-- DEPT 테이블 기준으로 출력
-- 둘이 일치하는 것만 출력해서 40번 부서가 나오지않음
SELECT D.DEPTNO ,D.DNAME ,E.EMPNO ,E.ENAME ,E.JOB ,E.SAL
FROM DEPT d JOIN EMP e ON D.DEPTNO = E.DEPTNO
ORDER BY D.DEPTNO ,E.ENAME ;
-- DEPT 테이블에 40번 부서까지 출력하고 싶다(일치하지 않은것까지 출력하고 싶다)
SELECT D.DEPTNO ,D.DNAME ,E.EMPNO ,E.ENAME ,E.JOB ,E.SAL
FROM DEPT d LEFT OUTER JOIN EMP e ON D.DEPTNO = E.DEPTNO
ORDER BY D.DEPTNO ,E.ENAME ;

SELECT D.DEPTNO ,D.DNAME ,E.EMPNO ,E.ENAME ,E.JOB ,E.SAL
FROM EMP e RIGHT OUTER JOIN DEPT d ON D.DEPTNO = E.DEPTNO
ORDER BY D.DEPTNO ,E.ENAME ;


-- 모든 부서 정보와 사원 정보를 출력
-- 부서번호, 사원 이름 순으로 출력
--부서번호, 부서명, 사원번호, 사원명, 직무, 급여, LOSAL,HISAL,GRADE
-- DEPT 테이블 기준으로 출력
SELECT
	D.DEPTNO ,
	D.DNAME ,
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.SAL ,
	S.LOSAL ,
	S.HISAL ,
	S.GRADE
FROM
	DEPT d
LEFT OUTER JOIN EMP e ON
	D.DEPTNO = E.DEPTNO
LEFT OUTER JOIN SALGRADE s ON
	e.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY
	D.DEPTNO ,
	E.ENAME ;


-- 서브쿼리
-- SQL 문 안에 내부에서 SELECT 문을 사용
-- 괄호로 묶어서 사용
-- 메인쿼리의 비교대상과 같은 자료형과 같은개수로 서브쿼리를 지정해야한다

-- JONES 사원의 급여보다 높은 급여를 받는 사원 조회
-- JONES 급여 알아내기 -> 비교
SELECT SAL 
FROM EMP e 
WHERE ENAME = 'JONES';

SELECT *
FROM EMP e 
WHERE SAL > 2975 ;

SELECT
	*
FROM
	EMP e
WHERE
	SAL > (
	SELECT
		SAL
	FROM
		EMP e
	WHERE
		ENAME = 'JONES') ;

-- ALLEN 이 받는 COMM 보다 많은 추가수당을 받는 사원조회
SELECT
	*
FROM
	EMP e
WHERE
	COMM > (
	SELECT
		COMM
	FROM
		EMP e
	WHERE
		ENAME = 'ALLEN') ;

-- WARD 사원의 입사일보다 빠른 입사자 조회
SELECT
	*
FROM
	EMP e
WHERE
	HIREDATE < (
	SELECT
		HIREDATE
	FROM
		EMP e
	WHERE
		ENAME = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
	
SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.SAL ,
	E.DEPTNO ,
	D.DNAME ,
	D.LOC
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
WHERE
	E.DEPTNO = 20
	AND E.SAL > (
	SELECT
		AVG(SAL)
	FROM
		EMP e );

-- 단일행 서브쿼리 : 서브쿼리 실행결과가 단 하나의 행으로 나오는 서브쿼리
--                   사용가능한 연산자(>,<,>=,<=,<>,^=,!=)

-- 다중행 서브쿼리 : 서브쿼리 실행결과가 단 여러개의 행으로 나오는 서브쿼리
--                   사용가능한 연산자(IN,ANY=SOME,ALL,EXISTS)
--                   IN,ANY,SOME : 메인쿼리의 조건식을 만족하는 서브쿼리가 하나이상
--                   ALL : 메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족
--                   EXISTS : 서브쿼리의 결과가 존재하면

-- 단일행 하위 질의에 2개 이상의 행이 리턴되었습니다
-- 서브쿼리가 여러개의 결과값을 리턴하는데 단일행 서브쿼리에 사용하는 연산자가 사용된 경우
--SELECT *
--FROM EMP e 
--WHERE SAL >= (SELECT MAX(SAL) FROM EMP e GROUP BY DEPTNO);
	
SELECT
	*
FROM
	EMP e
WHERE
	SAL IN (
	SELECT
		MAX(SAL)
	FROM
		EMP e
	GROUP BY
		DEPTNO);
-- IN 사용과 동일한 결과
SELECT
	*
FROM
	EMP e
WHERE
	SAL = ANY (
	SELECT
		MAX(SAL)
	FROM
		EMP e
	GROUP BY
		DEPTNO);

-- ANY 를 사용할경우 앞에 연산자 사용가능
-- 30번 부서 사원들의 최대급여보다 적은 급여를 받는 사원조회
-- ANY 를 쓰면 MAX(SAL) 을 쓰지않아도 1개이상 조건이 맞기 때문에 2850이상 넘어가지 않는다
SELECT
	*
FROM
	EMP e
WHERE
	SAL < ANY (
	SELECT
		SAL
	FROM
		EMP e
	WHERE DEPTNO = 30);

-- ALL 은 모든조건이 맞는게 800 1개 나온다
SELECT
	*
FROM
	EMP e
WHERE
	SAL < ALL (
	SELECT
		SAL
	FROM
		EMP e
	WHERE DEPTNO = 30);

-- 메인쿼리에 어떻게는 맞는 조건만 있으면 결과가 나오기 때문에 서브쿼리에 다른 테이블을 써도된다
SELECT
	*
FROM
	EMP e
WHERE
	EXISTS (
	SELECT
		DNAME
	FROM
		DEPT d 
	WHERE DEPTNO = 20);

--실습2)전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서
--정보, 급여 등급 정보를 출력하는 SQL문을 작성하시오(단, 출력할 때 급여가
--많은 순으로 정렬하되 급여가 같을 경우에는 사원 번호를 기준으로 오름차순으
--로 정렬하기

SELECT
	E.EMPNO ,
	E.ENAME ,
	D.DNAME ,
	E.HIREDATE ,
	D.LOC ,
	E.SAL ,
	S.GRADE
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
JOIN SALGRADE s ON
	e.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE
	E.SAL > (
	SELECT
		AVG(E.SAL)
	FROM
		EMP e)
ORDER BY
	E.SAL DESC,
	E.EMPNO ASC;


	
--(실습1)전체 사원 중 ALLEN과 같은 직책인 사원들의 사원정보, 부서 정보를
--다음과 같이 출력하는 SQL문을 작성하시오

SELECT
	E.JOB,
	E.EMPNO ,
	E.ENAME ,
	E.SAL,
	D.DEPTNO ,
	D.DNAME
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
WHERE
	E.JOB IN (
	SELECT
		JOB
	FROM
		EMP e
	WHERE
		ENAME = 'ALLEN');
		
-- 다중 열 서브쿼리
-- 메인쿼리 열도 괄호로 묶어줘라
-- 부서별 급여 최대값
SELECT
	*
FROM
	EMP e
WHERE
	(DEPTNO ,
	SAL) IN (
	SELECT
		DEPTNO ,
		MAX(SAL)
	FROM
		EMP e
	GROUP BY
		DEPTNO);

-- FROM 절에 사용하는 서브쿼리(인라인 뷰)
-- 보통 FROM절이 길어질경우 출력하는데 시간이 오래걸릴수 있어서 길게 사용하지 않는게 좋다
 
SELECT E10.EMPNO, E10.ENAME ,E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP e WHERE DEPTNO=10) E10,
(SELECT * FROM DEPT d) D
WHERE E10.DEPTNO = D.DEPTNO;

-- SELECT 절에 사용하는 서브쿼리(스칼라 서브쿼리)
-- 아래 쿼리문은 조인문을 사용해서 출력할수있다, 쿼리문을 작성할떄 조인문을 쓸지 서브쿼리를 쓸지 개발자 나름
SELECT
	EMPNO ,
	ENAME ,
	JOB ,
	SAL ,
	(
	SELECT
		GRADE
	FROM
		SALGRADE s
	WHERE
		E.SAL BETWEEN S.LOSAL AND S.HISAL) AS SALGRADE
FROM
	EMP e ;

------------------------------------------------------------------------------------------------------SELECT 구문


-- DML(DATA MANIPULATION LANGUAGE-데이터 조작 언어)
-- SELECT(조회), INSERT(삽입), UPDATE(수정), DELETE(삭제)

-- 기존 테이블 복제해서 새로운 테이블 생성
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT ;

-- 새로운 부서 추가
-- INSERT INTO 테이블명(열이름1, 열이름2....)
-- VALUES(데이터,데이터...)
INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
VALUES(60,'DATABASE','BUSAN');
-- 열이름 생략도 가능하지만 실수를 줄이기위해 넣는게 좋음
INSERT INTO DEPT_TEMP
VALUES(70,'DATABASE','BUSAN');
-- 값의 수가 충분하지 않습니다
--INSERT INTO DEPT_TEMP
--VALUES(80,'DATABASE');
-- 값의 수를 줄이려면 열이름을 넣어줘야 한다
INSERT INTO DEPT_TEMP(DEPTNO,DNAME)
VALUES(80,'DATABASE');
--이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
--DEPTNO-NUMBER(2,0) 2가 두자릿수 까지 의미 하기때문에
--INSERT INTO DEPT_TEMP(DEPTNO,DNAME)
--VALUES(800,'DATABASE');

INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
VALUES(90,'DATABASE',NULL);



CREATE TABLE EMP_TEMP AS SELECT * FROM EMP ;

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(8000,'HONG','MANAGER',7902,'2015-03-15',1000,NULL,50);

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(9000,'SUNG','MANAGER',7782,SYSDATE,1200,800,50);

-- 테이블의 구조만 복사(데이터는 복사하지 않을때)
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP WHERE 1<>1;

------------------------------------------------------------------------------------------------------INSERT 구문


-- 수정
-- UPDATE 테이블명 SET 수정할 내용,...,... ;
-- UPDATE 테이블명 SET 수정할 내용,...,... WHERE 조건 ;

-- WHERE 안쓰고 UPDATE 시 할꺼냐고 주의 메세지를 줌
UPDATE DEPT_TEMP SET LOC = 'BUSAN';

UPDATE DEPT_TEMP SET LOC = 'SEOUL'
WHERE  DEPTNO = 50;

UPDATE DEPT_TEMP SET LOC = 'SEOUL',DNAME = 'NETWORK'
WHERE  DEPTNO = 40;


------------------------------------------------------------------------------------------------------UPDATE 구문

-- 삭제 (행단위)
-- DELETE 테이블명 WHERE 조건
-- DELETE FROM 테이블명 WHERE 조건

DELETE DEPT_TEMP
WHERE DEPTNO=20;

DELETE FROM DEPT_TEMP
WHERE DEPTNO=30;

------------------------------------------------------------------------------------------------------DELETE 구문

-- 서브쿼리 + DELETE
-- 급여등급이 3등급이고 30번 부서의 사원들을 삭제
DELETE
FROM
	EMP_TEMP
WHERE
	ENAME IN (
	SELECT
		ENAME
	FROM
		EMP_TEMP et
	JOIN SALGRADE s ON
		ET.SAL BETWEEN S.LOSAL AND S.HISAL
		AND S.GRADE = 3
		AND ET.DEPTNO = 30);

-- 서브쿼리 + UPDATE
UPDATE
	DEPT_TEMP
SET
	(DNAME,
	LOC) = (
	SELECT
		DNAME,
		LOC
	FROM
		DEPT
	WHERE
		DEPTNO = 40)
WHERE
	DEPTNO = 40;
	
-- 서브쿼리 + INSERT
INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
SELECT E1.EMPNO ,E1.ENAME ,E1.JOB ,E1.MGR,E1.HIREDATE ,E1.SAL ,E1.COMM ,E1.DEPTNO 
FROM EMP e1 JOIN SALGRADE s ON E1.SAL BETWEEN S.LOSAL AND S.HISAL;


-- [실습1] 실습을 위하여 기존 테이블을 이용하여 테이블을 생성한다. 
--① EMP 테이블의 내용을 이용하여 EXAM_EMP 생성
--② DEPT 테이블의 내용을 이용하여 EXAM_DEPT 생성
--③ SALGRADE 테이블의 내용을 이용하여 EXAM_SALGRADE 생성

CREATE TABLE EXAM_EMP AS SELECT * FROM EMP ;

CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT ;

CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE ;

-- [실습2] 다음의 정보를 EXAM_EMP 테이블에 입력하시오.

-- 새로운 부서 추가
-- INSERT INTO 테이블명(열이름1, 열이름2....)
-- VALUES(데이터,데이터...)
INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
VALUES(60,'DATABASE','BUSAN');

INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,50);

INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7202,'TEST_USER2','CLERK',7201,'2016-02-21',1800,NULL,50);

INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7203,'TEST_USER3','ANALYST',7201,'2016-04-11',3400,NULL,60);

INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7204,'TEST_USER4','SALESMAN',7201,'2016-05-31',2700,300,60);

INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7205,'TEST_USER5','CLERK',7201,'2016-07-20',2600,NULL,70);

INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7206,'TEST_USER6','CLERK',7201,'2016-09-08',2600,NULL,70);

INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7207,'TEST_USER7','LECTURER',7201,'2016-10-28',2300,NULL,80);

INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7208,'TEST_USER8','STUDENT',7201,'2016-03-09',1200,NULL,80);

COMMIT;


-- [실습3] EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균
-- 급여보다 많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL 문 작성하기
-- 수정
-- UPDATE 테이블명 SET 수정할 내용,...,... ;
-- UPDATE 테이블명 SET 수정할 내용,...,... WHERE 조건 ;

-- WHERE 안쓰고 UPDATE 시 할꺼냐고 주의 메세지를 줌
UPDATE
	EXAM_EMP
SET
	DEPTNO = 70
WHERE
	SAL > (
	SELECT
		AVG(SAL)
	FROM
		EXAM_EMP
	WHERE
		DEPTNO = 50);

-- [실습4] EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장
-- 빠른 사원보다 늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는
-- SQL 문 작성하기
UPDATE
	EXAM_EMP
SET
	SAL = SAL * 1.1,
	DEPTNO = 80
WHERE
	HIREDATE > (
	SELECT
		MIN(HIREDATE)
	FROM
		EXAM_EMP
	WHERE
		DEPTNO = 60);

-- [실습5] EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL
-- 문을 작성하기
DELETE
FROM
	EXAM_EMP
WHERE
	empno IN (
	SELECT
		empno
	FROM
		EXAM_EMP,
		SALGRADE
	WHERE
		sal BETWEEN losal AND hisal
		AND grade = 5);

-- TRANSACTION
-- 하나의 작업 또는 밀접하게 연관되어 있는 작업 수행을 위해 나눌 수 없는 최소 작업 단위
-- 트랜잭션 최종반영(COMMIT) / 트랜잭션 모두취소(ROLLBACK)
	
-- DBEAVER 설정에서 커밋 모드 변경가능(데이터베이스-트랜잭션모드-매뉴얼커밋)
-- 기본은 AUTO COMMIT 상태임
INSERT INTO DEPT_TEMP VALUES(55,'NETWORK','SEOUL');
UPDATE DEPT_TEMP SET LOC='BUSAN' WHERE DEPTNO =55;

COMMIT;
ROLLBACK; -- COMMIT 하기 전에 할수있음

SELECT * FROM DEPT_TEMP dt ;

DELETE FROM DEPT_TEMP dt WHERE DEPTNO=55;
UPDATE DEPT_TEMP SET DNAME ='WEB' WHERE DEPTNO =10;

COMMIT;

-- LOCK -> 한 세션에서 트랜잭션 작업이 완료되지 않으면
--           다른 세션에서 작업을 처리할수 없는 상태
--           (DML - insert, update, delete)



-- 테이블 정의, 사용자 정의, 권한 부여, 권한 취소



