-- 2024-04-16
-- 검색 조건 sql 로 해본다면
-- WHERE title LIKE '%title%' OR content LIKE '%content%'
-- WHERE title LIKE '%title%' OR content LIKE '%content%' OR writer LIKE '%writer%'
-- WHERE gno > 0 AND title LIKE '%title%' OR content LIKE '%content%' OR writer LIKE '%writer%'

-- 2024-04-17
-- board(전체조회), member email 조회
-- bno, title, content, member_email
SELECT b.BNO ,b.TITLE ,b.CONTENT ,b.WRITER_EMAIL  FROM BOARD b LEFT JOIN MEMBER m ON b.WRITER_EMAIL = m.EMAIL ;

SELECT r.BOARD_BNO , COUNT(r.BOARD_BNO) FROM REPLY r GROUP BY r.BOARD_BNO ;

SELECT
	b.BNO ,
	b.TITLE ,
	b.CONTENT ,
	b.WRITER_EMAIL,
	a.cnt
FROM
	BOARD b
LEFT JOIN MEMBER m ON
	b.WRITER_EMAIL = m.EMAIL
LEFT JOIN (
	SELECT
		r.BOARD_BNO AS bno ,
		COUNT(r.BOARD_BNO) AS cnt
	FROM
		REPLY r
	GROUP BY
		r.BOARD_BNO) a ON
	b.BNO = a.bno;

-- 서브쿼리
SELECT
	b.BNO ,
	b.TITLE ,
	b.CONTENT ,
	b.WRITER_EMAIL,
	(
	SELECT
		COUNT(r.BOARD_BNO)
	FROM
		REPLY r
	WHERE
		r.BOARD_BNO = b.BNO
	GROUP BY
		r.BOARD_BNO) AS cnt
FROM
	BOARD b
LEFT JOIN MEMBER m ON
	b.WRITER_EMAIL = m.EMAIL;


-- 2024-04-19
-- 게시글 + 댓글 조회
SELECT
	*
FROM
	BOARD b
JOIN REPLY r ON
	b.BNO = r.BOARD_BNO
WHERE
	b.BNO = 100;
	
SELECT * FROM REPLY r WHERE r.BOARD_BNO = 100;



-- 2024-04-25
-- movie, movie_image, reivew 3개 테이블을 같이 화면단에 사용해야함
-- 영화별 리뷰 개수와 평점조회(review : movie_mno)
SELECT r.MOVIE_MNO, COUNT(*) ,AVG(r.GRADE) FROM REVIEW r GROUP BY r.MOVIE_MNO ;

-- 추가로 영화 정보 조회
-- 리뷰가 없을수도 있으니깐 LEFT JOIN 사용
SELECT
	*
FROM
	MOVIE m
LEFT JOIN (
	SELECT
		r.MOVIE_MNO,
		COUNT(*) ,
		AVG(r.GRADE)
	FROM
		REVIEW r
	GROUP BY
		r.MOVIE_MNO) r1 ON
	m.MNO = r1.MOVIE_MNO;

-- 값의 수가 너무 많습니다 : SELECT (COUNT(*) ,AVG(r.GRADE)) 괄호안에 동시에 있으면 뽑을수가 없다
-- SELECT m.*,(SELECT r.MOVIE_MNO, COUNT(*) ,AVG(r.GRADE) FROM REVIEW r GROUP BY r.MOVIE_MNO) FROM MOVIE m;
SELECT m.*,(SELECT COUNT(DISTINCT r.review_no) FROM REVIEW r WHERE r.MOVIE_MNO=m.MNO) AS review_cnt,
(SELECT AVG(r.grade) FROM REVIEW r WHERE r.MOVIE_MNO=m.MNO) AS grade_avg
FROM MOVIE m;

-- 영화별 리뷰 개수와 평균 평점 조회
-- 추가로 영화 정보 조회
-- 추가로 영화별 이미지 조회(하나의 영화에 여러개의 이미지가 존재, 가장낮은 번호의 이미지만 가져오기)

-- movie_image 조회
-- GROUP BY 표현식이 아닙니다 (집계함수와 일반필드는 같이 조회할수 없음) 단, 집계함수1개(GROUP BY mi.MOVIE_MNO) 일반필드1개(mi.MOVIE_MNO) 면 가능
-- SELECT mi.MOVIE_MNO,mi.IMG_NAME ,mi."PATH" ,mi.UUID ,MIN(mi.INUM) FROM MOVIE_IMAGE mi GROUP BY mi.MOVIE_MNO;
SELECT mi.MOVIE_MNO ,MIN(mi.INUM) FROM MOVIE_IMAGE mi GROUP BY mi.MOVIE_MNO;

-- movie_image 의 다른 필드 조회
SELECT * FROM MOVIE_IMAGE mi2 WHERE mi2.INUM in (SELECT MIN(mi.INUM) FROM MOVIE_IMAGE mi GROUP BY mi.MOVIE_MNO);

-- movie List 에 필요한 컬럼
-- 영화번호, 대표이미지(path/uuid_imgName), 영화명, 리뷰개수, 별점평균, 영화등록일
-- movie_image 의 다른 필드 조회 + 추가로 영화 정보 조회
-- SELECT 절에 서브쿼리가 있는 sql 구문을 넣어봤는데 @Query(nativeQuery = true) 가 인식을 못함
-- MovieImageReviewRepositoryImpl 에 getTotalList 메소드 참고용
-- Movie 전체리스트
-- WHERE mi2.INUM IN (SELECT MIN(mi.INUM) FROM MOVIE_IMAGE mi GROUP BY mi.MOVIE_MNO) : 이미지 한개만 가져와야해서 번호가 제일 작은걸로 조건을 줌
SELECT
	m.CREATED_DATE ,
	m.TITLE ,
	m.mno,
	mi2.img_name,
	mi2."PATH",
	mi2.uuid,
	(
	SELECT
		COUNT(DISTINCT r.review_no)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO) AS review_cnt,
	(
	SELECT
		AVG(r.grade)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO) AS grade_avg
FROM
	MOVIE_IMAGE mi2
LEFT JOIN MOVIE m ON
	mi2.MOVIE_MNO = m.MNO
WHERE
	mi2.INUM IN (
	SELECT
		MIN(mi.INUM)
	FROM
		MOVIE_IMAGE mi
	GROUP BY
		mi.MOVIE_MNO);
	
-- MovieRepository 에서 Page<Object[]> getListPage(Pageable pageable) 에 사용
-- Movie 전체리스트
SELECT * FROM MOVIE m LEFT JOIN 
(SELECT r.MOVIE_MNO, COUNT(*) ,AVG(r.GRADE) FROM REVIEW r GROUP BY r.MOVIE_MNO) r1
ON m.MNO = r1.movie_mno
LEFT JOIN (SELECT mi2.* FROM MOVIE_IMAGE mi2 WHERE mi2.inum
IN (SELECT MIN(mi.INUM) FROM MOVIE_IMAGE mi GROUP BY mi.MOVIE_MNO)) A ON m.mno = A.movie_mno;


-- 2024-04-26
-- 특정 영화의 정보+평균평점+리뷰수+영화이미지
-- 이번에는 이미지를 다 가져와야 한다
SELECT
	m.mno,
	m.TITLE ,
	mi2.img_name,
	mi2."PATH",
	mi2.uuid,
	(
	SELECT
		COUNT(DISTINCT r.review_no)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO) AS review_cnt,
	(
	SELECT
		AVG(r.grade)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO) AS grade_avg
FROM
	MOVIE_IMAGE mi2
LEFT JOIN MOVIE m ON
	mi2.MOVIE_MNO = m.MNO
WHERE
	mi2.MOVIE_MNO = 100;

-- 영화삭제(자식먼저 삭제해야한다, 이미지 와 리뷰 를 먼저 삭제)
-- 이미지 삭제
DELETE FROM MOVIE_IMAGE mi WHERE movie_mno=1;
-- 리뷰 삭제
DELETE FROM REVIEW r WHERE movie_mno=1;
-- 영화 삭제
DELETE FROM MOVIE WHERE mno=1;
	

-- 2024-05-08
-- 어제날짜의 이미지 추출
SELECT * FROM MOVIE_IMAGE mi WHERE mi."PATH" = TO_CHAR(SYSDATE -1,'yyyy\mm\dd');
	
	
	
	
	
	
	
	
	
	
	
	
