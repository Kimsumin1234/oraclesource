CREATE TABLE EMP(
EMPNO NUMBER
);

INSERT INTO EMP VALUES(1);

-- booktbl 생성
-- code, title, writer, price 컬럼 생성
-- 숫자4자리(PK), 문자, 문자, 숫자
CREATE TABLE booktbl (code NUMBER(4) PRIMARY KEY,
title nvarchar2(10)NOT NULL,
writer nvarchar2(10)NOT NULL,
price NUMBER(8)NOT NULL
);

INSERT INTO BOOKTBL (CODE,TITLE,WRITER,PRICE)
VALUES(1001,'자바의 정석','남궁성',30500);
INSERT INTO BOOKTBL (CODE,TITLE,WRITER,PRICE)
VALUES(1002,'오라클','홍길동',32000);
INSERT INTO BOOKTBL (CODE,TITLE,WRITER,PRICE)
VALUES(1003,'HTML','장은석',22500);
INSERT INTO BOOKTBL (CODE,TITLE,WRITER,PRICE)
VALUES(1004,'CSS','김현주',25500);

-- 조회
SELECT * FROM BOOKTBL ;

-- 특정 조회
SELECT * FROM BOOKTBL WHERE CODE = 1000;
SELECT * FROM BOOKTBL WHERE WRITER ='장은석';

-- 자바로 시작하는 책 검색
SELECT * FROM BOOKTBL WHERE TITLE LIKE '자바%';

-- 수정
UPDATE BOOKTBL SET PRICE = 35000 WHERE CODE = 1000;

UPDATE BOOKTBL SET PRICE = 35000,TITLE = '' WHERE CODE = 1000;

-- 삭제, FROM 생략가능
DELETE FROM BOOKTBL WHERE CODE = 1004;

-- MEMBERTBL 생성
-- 회원정보 저장
-- userid(숫자,문자,특수문자 PK 20), password(숫자,문자,특수문자 20), name(문자 10), email(숫자,문자,특수문자 50)
CREATE TABLE memberTBL(userid nvarchar2(20) PRIMARY KEY,
password nvarchar2(20) NOT NULL,
name nvarchar2(10) NOT NULL,
email nvarchar2(50) NOT NULL );

INSERT INTO  MEMBERTBL (USERID,PASSWORD,NAME,EMAIL)
values('hong123','hong123','홍길동','hong123@java.com');

INSERT INTO  MEMBERTBL (USERID,PASSWORD,NAME,EMAIL)
values('kong123','kong123','공길동','kong123@java.com');

SELECT * FROM MEMBERTBL WHERE USERID = 'hong123';

SELECT * FROM MEMBERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong123';

SELECT * FROM MEMBERTBL ;

UPDATE MEMBERTBL SET PASSWORD ='hong456' WHERE USERID ='hong123';

DELETE FROM MEMBERTBL WHERE userid = 'hong123';

DELETE FROM MEMBERTBL WHERE userid = 'hong123' ;

CREATE TABLE todotbl(
NO NUMBER(8) PRIMARY KEY,
title nvarchar2(100) NOT NULL,
created_at DATE DEFAULT sysdate,
completed char(1) DEFAULT '0',
description nvarchar2(1000));

-- 시퀀스 생성 (todo_seq)
CREATE SEQUENCE todo_seq;

-- INSERT
INSERT
	INTO
	TODOTBL(NO,
	TITLE,
	DESCRIPTION)
VALUES(todo_seq.nextval,
'자바환경설정',
'자바환경설정 및 정리');

-- 하나 조회
SELECT * FROM TODOTBL WHERE NO=1;
SELECT * FROM TODOTBL WHERE TITLE='자바환경설정';

-- 1번만 completed=1 로 변경 update

UPDATE TODOTBL SET COMPLETED ='1' WHERE NO=1;


-- completed, description 변경하는 update

UPDATE TODOTBL SET  COMPLETED ='1',DESCRIPTION ='변경' WHERE NO=1;

-- 삭제
DELETE FROM TODOTBL WHERE NO =1;

-- book 프로젝트
-- 도서목록 전체 조회
SELECT * FROM BOOKTBL ;

-- 도서목록 한개를 상세조회
SELECT * FROM BOOKTBL WHERE CODE =1000;
SELECT * FROM BOOKTBL WHERE WRITER  ='홍길동';

-- BOOKTBL 에 컬럼추가 description nvarchar2(1000)
ALTER TABLE BOOKTBL ADD description nvarchar2(1000);
SELECT * FROM BOOKTBL ;

-- BOOKTBL insert 하기
INSERT INTO BOOKTBL (CODE,TITLE,WRITER,PRICE,description) VALUES (?,?,?,?,?);

-- BOOKTBL UPDATE 하기
UPDATE BOOKTBL SET PRICE ='10' WHERE CODE ='1000';

-- BOOKTBL 삭제
DELETE FROM BOOKTBL WHERE CODE = 1000;
DELETE FROM BOOKTBL WHERE CODE = 1006 AND writer='김수민3';

-- 로그인 작업 아이디 비밀번호 일치
SELECT * FROM MEMBERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong123';
SELECT USERID ,NAME  FROM MEMBERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong123';

-- 비밀번호 변경
UPDATE MEMBERTBL SET PASSWORD ='hong456' WHERE USERID ='hong123';

-- 회원탈퇴
DELETE FROM MEMBERTBL WHERE userid='' AND password='';

-- 연습) SHOPTBL 생성하기
CREATE TABLE SHOPTBL (id NUMBER(10) PRIMARY KEY,
price NUMBER(20) NOT NULL,
title nvarchar2(100) NOT NULL,
writer nvarchar2(20) NOT NULL,
content nvarchar2(1000) NOT NULL);

CREATE SEQUENCE shop_seq;

-- 연습) SHOPTBL INSERT 하기
INSERT INTO SHOPTBL (ID,PRICE,TITLE,WRITER,CONTENT) VALUES (shop_seq.nextval,'70000','Blossom Dress','홍길동','제품입니다');
INSERT INTO SHOPTBL (ID,PRICE,TITLE,WRITER,CONTENT) VALUES (shop_seq.nextval,'50000','Springfild Shirt','김길동','제품입니다');
INSERT INTO SHOPTBL (ID,PRICE,TITLE,WRITER,CONTENT) VALUES (shop_seq.nextval,'60000','Black Monastery','박길동','제품입니다');
INSERT INTO SHOPTBL (ID,PRICE,TITLE,WRITER,CONTENT) VALUES (shop_seq.nextval,'30000','Red Cap','고길동','제품입니다');
-- Board 생성 (bno,name,password,title,content,attach,re_ref,re_lev,re_seq,read_count,regdate)
-- bno : pk, number (글번호)
-- name : nvarchar2(10) (작성자) not null
-- password : nvarchar2(20) (비밀번호) not null
-- title : nvarchar2(20) (제목) not null
-- content : nvarchar2(1000) (내용) not null
-- attach : nvarchar2(100) (업로드 파일명)
-- re_ref,re_lev,re_seq : number(8),not null
-- read_count : number, default 0 (조회수)
-- regdate : date, default sysdate (작성일자)

CREATE TABLE BOARDTBL (bno NUMBER(8) PRIMARY KEY,
name nvarchar2(10) NOT null,
password nvarchar2(20) NOT NULL,
title nvarchar2(20) not NULL,
content nvarchar2(1000) not NULL,
attach nvarchar2(100),
re_ref number(8) not NULL,
re_lev number(8) not NULL,
re_seq number(8) not NULL,
read_count number(8) default '0',
regdate date default sysdate
);

DROP TABLE BOARDTBL ;

INSERT INTO BOARDTBL (BNO,NAME,PASSWORD,TITLE,CONTENT,ATTACH,RE_REF,RE_LEV,RE_SEQ)
VALUES (board_seq.nextval,'홍길동','12345','게시판 작성','게시판 작성',NULL,board_seq.currval,0,0);

-- sequence 생성
-- board_seq
CREATE SEQUENCE board_seq;

-- board 요소 가져오기
SELECT BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT  FROM BOARDTBL ORDER BY BNO DESC ;

-- board 조회
SELECT NAME ,TITLE ,CONTENT ,ATTACH  FROM BOARDTBL WHERE BNO ='1';

-- board 수정
UPDATE BOARDTBL SET TITLE ='',CONTENT ='' WHERE BNO ='' AND PASSWORD ='';

-- 연습) SHOPTBL 조회하기
SELECT * FROM SHOPTBL ORDER BY ID DESC  ;

-- board 삭제 (bno 와 password 일치시)
DELETE FROM BOARDTBL WHERE BNO ='' AND PASSWORD ='';

-- board 검색
SELECT * FROM BOARDTBL WHERE TITLE ='수민수민';

-- 더미 데이터 삽입
-- 서브 쿼리
-- 이미 가지고 있는 값을 복사 붙여넣기 해줘(한번 실행하면 여러번 복사된다)
INSERT INTO BOARDTBL (BNO,NAME,PASSWORD,TITLE,CONTENT,RE_REF,RE_LEV,RE_SEQ)
(SELECT board_seq.nextval,NAME,PASSWORD,TITLE,CONTENT,board_seq.currval,RE_LEV,RE_SEQ FROM BOARDTBL);

-- 몇개가 복사됬는지 확인
SELECT COUNT(*) FROM BOARDTBL ;

-- 댓글작업
SELECT * FROM BOARDTBL ORDER BY BNO DESC ;
-- 마지막 게시물에 댓글 삽입 (확인하기 편하게 마지막에 삽입)

-- 첫번째 댓글 달기
-- 댓글 re_ref : 원본글의 re_ref 번호를 그대로 따라간다
-- 댓글 re_lev : 원본글 re_lev + 1 => 댓글 깊이 (댓글, 댓글의 댓글...) 구별
-- 댓글 re_seq : 원본글 re_seq + 1
INSERT INTO BOARDTBL (BNO,NAME,PASSWORD,TITLE,CONTENT,ATTACH,RE_REF,RE_LEV,RE_SEQ)
VALUES (board_seq.nextval,'홍길동','12345','re:게시판 작성','re:게시판 작성',NULL,1930,1,1);

-- 두번째 댓글 달기
-- 댓글도 최신 댓글로 정렬 필요
-- 댓글 re_seq : 댓글 정렬 시 낮을 수록 최신글
-- 기존 댓글의 re_seq 값을 + 1(update) 한 후 insert 작업
-- 댓글 RE_REF = 원본글 RE_REF AND 댓글 RE_SEQ > 원본글의 RE_SEQ 값
UPDATE BOARDTBL SET RE_SEQ = RE_SEQ + 1 WHERE RE_REF = 1930 AND RE_SEQ > 0;

INSERT INTO BOARDTBL (BNO,NAME,PASSWORD,TITLE,CONTENT,ATTACH,RE_REF,RE_LEV,RE_SEQ)
VALUES (board_seq.nextval,'홍길동','12345','re:게시판 작성','re:게시판 작성',NULL,1930,1,1);

SELECT * FROM BOARDTBL WHERE RE_REF = 1930 ORDER BY RE_REF DESC ,RE_SEQ ASC ;

SELECT BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT ,RE_LEV  FROM BOARDTBL ORDER BY RE_REF DESC ,RE_SEQ ASC ;

-- board 조회수 업데이트
-- bno 1930번 의 조회수 증가
UPDATE BOARDTBL SET read_count = read_count + 1 WHERE BNO = 1930;

-- board 검색
SELECT BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT ,RE_LEV  FROM BOARDTBL WHERE TITLE ='' ORDER BY RE_REF DESC ,RE_SEQ ASC ;















-- 페이지 나누기
-- Oracle 의 경우일때 (db 마다 페이지 나누기 방법이 다르다)
-- rownum : 가상컬럼 (조회된 결과값에 번호를 부여)
-- 지금 만들고 있는 board 는 페이지 나누기 할때 기준으로 bno 를 사용못한다(댓글도 bno가 생기기 때문에)
-- rownum 을 사용해서 번호를 새로 매겨줘야 한다
SELECT rownum,bno,title FROM BOARDTBL ORDER BY bno DESC ;
-- 이거는 안나온다
SELECT rownum,bno,title FROM BOARDTBL WHERE rownum > 1;

SELECT rownum,bno,title FROM BOARDTBL WHERE rownum <= 10 ORDER BY bno DESC;

-- rownum 이 먼저 부여가 되기 때문에 (정렬이 된후 번호가 붙는게 아니다) 이상태로는 사용할수없다
SELECT rownum, BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT ,RE_LEV FROM BOARDTBL WHERE rownum <=1940 ORDER BY RE_REF DESC ,RE_SEQ ASC;

-- 그래서 정렬을 먼저 한후 rownum 으로 번호를 붙인다
-- 서브쿼리 를 사용 (select,from,where 절에 각각 작성 가능)
-- sql 실행순서는 from 절이 제일 먼저 실행이 된다
-- 1 페이지만 할경우
SELECT rownum, BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT ,RE_LEV
FROM (SELECT rownum, BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT ,RE_LEV FROM BOARDTBL ORDER BY RE_REF DESC ,RE_SEQ ASC)
WHERE rownum <= 30;

-- 2 페이지 부터는
SELECT BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT ,RE_LEV
FROM (SELECT rownum AS rnum, A.*
FROM (SELECT rownum, BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT ,RE_LEV FROM BOARDTBL b WHERE bno > 0 ORDER BY RE_REF DESC ,RE_SEQ ASC) A
WHERE rownum <= 60)
WHERE rnum > 30;

-- 페이지 당 30개 게시물을 보여준다 할 때
-- 1 page => 1~30
-- 2 page => 31~60

-- 1 * 30 = 30
-- (1-1) * 30 = 0

-- start = 페이지번호 * 한 페이지당 게시물 수
-- end = (페이지번호-1) * 한 페이지당 게시물 수

-- 검색 시에도 페이지 나누기를 해야한다
-- AND title LIKE '%게시판%'
SELECT BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT ,RE_LEV
FROM (SELECT rownum AS rnum, A.*
FROM (SELECT rownum, BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT ,RE_LEV FROM BOARDTBL b WHERE bno > 0 AND title LIKE '%게시판%' ORDER BY RE_REF DESC ,RE_SEQ ASC) A
WHERE rownum <= 60)
WHERE rnum > 30;

-- 전체 게시물 개수
SELECT COUNT(*) FROM BOARDTBL ;
-- 검색 게시물 전체 개수
SELECT COUNT(*) FROM BOARDTBL WHERE TITLE LIKE '%게시판%';

-- 부모글,댓글 관계인 경우 삭제를 따져본다면
SELECT * FROM BOARDTBL WHERE RE_REF =1960;
-- 댓글만 삭제
DELETE FROM BOARDTBL WHERE bno=1961;
-- 부모글 삭제 (댓글도 다 삭제)
DELETE FROM BOARDTBL WHERE re_ref = 1960;
-- 비밀번호와 아이디가 일치하면 숫자가 뜬다 라는 의미
-- bno 는 pk 라서 둘이 일치하는건 어차피 1 만 뜬다 일치하지 않으면 0 해서 boolean 으로 구별 가능
SELECT count(*) FROM BOARDTBL WHERE bno =1960 AND PASSWORD ='123';