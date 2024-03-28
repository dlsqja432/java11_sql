use kh;

show tables;

-- Select 문을 활용한 Update Safe Mode => sql_safe_updates
-- SQL 실행 시 자동 커밋 => autocommit
-- 아래의 내용을 수정하고, MySQL 서버를 재시작하게 되면 Safe Mode와 AutoCommit이 비할성화됨.
-- c:\programData\MySQL\MySQL Server 8.0\my.ini
-- [mysqld]
-- sql_safe_updates = 0
-- autocommit = 0

-- WorkBench 에서 해당 내용을 설정하고 싶다면,
-- SET 명령에 해당 옵션을 설정하면 된다. (SET 명령은 설정 명령어)
-- SET SQL_SAFE_UPDATES = 0
-- SET AUTOCOMMIT = FALSE : 트랜잭션 처리가 필요한 경우 반드시 OFF(FALSE)이어야 한다.

-- 1. 회원 테이블에 다음과 같은 내용을 추가하시오.
insert into member values ('kkt', 'a1004', '김기태', '가산동 123','010-1004-1004' , '2023-09-12');

-- 2. 도서 테이블에 다음 데이터를 추가하시오.
insert into book values (default, 'IT', '스프링프레임워크', 38000, 8, '김기태', '정복사', '2022-09-10');

-- 3. 판매 테이블에 다음 튜플(레코드)을 추가하시오.
insert into sales values (default, 1, 'kkt', 2, null, now());
update sales set money = (select bookprice from book where book.bookid = sales.bno) * amount;

-- 4. 회원 테이블에 기본 값이 0인 숫자 데이터를 저장할 포인트(pt) 컬럼을 추가하시오.
alter table member add pt int default 0;

-- 5. 회원 테이블에 방문횟수(visited) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table member add visited int default 1;

-- 6. 회원 테이블에 이메일(email) 컬럼을 추가하시오(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table member add email varchar(40);

-- 7. 회원 테이블에 지역코드(areacode) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table member add areacode varchar(10);

-- 8. 회원 테이블에 있는 컬럼 중에서 방문횟수 컬럼을 제거하시오.
alter table member drop column visited;

-- 9. 회원 테이블에 지역(areacode) 컬럼의 이름을 areadata 로 변경하시오.
alter table member rename column areadate to areadata;

-- 10. 판매(sales) 테이블을 복제하여 판매2(sales2) 테이블을 만드시오.
create table sales2 as select * from sales;

-- 11. 도서 테이블을 복제하여 도서2(book2) 테이블을 만드시오.
create table book2 as select * from book;

-- 12. 회원 테이블을 복제하여 회원2(member2) 테이블을 만드시오.
create table member2 as select * from member;

-- 13. 판매2(sales2) 테이블을 제거하시오.
drop table sales2;

-- 14. 복제된 회원2(member2) 테이블에서 아이디가 j가 포함된 회원을 삭제하시오.
delete from member2 where id like '%j%';

-- 15. 회원(member) 테이블에서 모든 회원에 대한 포인트를 100 이 지급될 수 있도록 변경하시오.
update member set pt=pt+100;

-- 16. 회원(member) 테이블에서 회원의 아이디가 lsh인 회원의 주소를 '도화동 27'로 변경하시오.
update member set address='도화동 27' where id='lsh';

-- 17. 회원2(member2) 테이블에서 연락처가 02인 회원에 대하여 가입일을 오늘날짜로 변경하시오.
update member set reg_date = current_date() where tel like '02%';

-- 18. 도서2(book2) 테이블에서 도서 분류가 HC인 레코드에 대하여 도서 수량을 5로 변경하시오.
update book2 set bookcount = 5 where bookkind='HC';

-- 19. 도서2(book2) 테이블에서 도서 분류가 TC인 튜플을 제거하시오.
delete from book2 where bookkind='TC';

-- 20. 도서2(book2) 테이블에 도서상태(ckdata) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table book2 add ckdata varchar(20);

-- 21. 도서2(book2) 테이블에 도서 수량이 7이하인 튜플에 대하여 도서상태를 '재입고요망' 으로 내용을 추가하시오.
update book2 set ckdata='재입고요망' where bookcount <=7;

-- 22. 회원2(member2) 테이블에 id를 기본키로 추가하시오.
alter table member2 add constraint pkey primary key (id);

-- 23. 도서2(book2) 테이블에 도서코드(bookid)를 기본키로 도서분류(bookkind)를 외래키로 추가하시오.
alter table book2 modify column bookid int primary key;
create table bookkind(name varchar(40), kindcode varchar(5));
insert into bookkind values('아이티', 'IT');
insert into bookkind values('엔브이', 'NV');
insert into bookkind values('디브이', 'DV');
insert into bookkind values('엣치씨', 'HC');
alter table bookkind modify column kindcode varchar(5) primary key;
alter table book2 add constraint fkey foreign key (bookkind) references bookkind(kindcode);

-- 24. 도서2(book2) 테이블에서 출판일(pubdate)가 2022년 8월 인 데이터의 수량을 5씩 더 증가시키시오.
update book2 set bookcount = bookcount + 5 where pubdate between '2022-08-01' and '2022-08-31';

-- 25. 회원(member) 테이블에서 모든 회원의 모든 정보를 조회하시오.
select * from member;

-- 26. 판매(sales) 테이블에서 구매한 적이 있는 회원의 아이디를 중복을 제거하여 조회하시오.
select distinct id from sales;

-- 27. 도서(book) 테이블에서 도서종류(bookkind)가 IT인 튜플을 검색하시오.
select * from book where bookkind='IT';

-- 28. 회원(member) 테이블에서 아이디가 k가 포함된 회원의 이름(name),  연락처(tel) 컬럼을 검색하시오.
select name, tel from member where id like '%k%';

-- 29. 판매(sales) 테이블에서 수량(amount)이 2이상인 레코드를 검색하시오.
select * from sales where amount>=2;

-- 30. 도서(book) 테이블에서 단가(bookprice)가 19000이상 30000이하인 데이터의 도서명(booktitle), 도서가격(bookprice), 저자(author) 를 조회하시오.
select booktitle, bookprice, author from book where bookprice between 19000 and 30000;

-- 31. 도서(book) 테이블에서 출판사(pubcom)이 한빛미디어 이거나 남가람북스인 튜플의 도서명(booktitle), 저자(author), 수량(bookcount)를 조회하시오.
select booktitle, author, bookcount from book where pubcom in ('한빛미디어', '남가람북스');

-- 32. 도서(book) 테이블에서 출판일(pubdate)이 2022년인 튜플을 검색하시오.
select * from book where pubdate between '2022-01-01' and '2022-12-31';

-- 33. 회원(member) 테이블에서 비밀번호(password)가 5글자 이상인 회원의 아이디(id), 이름(name), 주소(tel)을 검색하시오.
select id, name, tel from member where length(password) >= 5;

-- 34. 도서(book) 테이블에서 출판일(pubdate)을 기준으로 오름차순하여 검색하되 출판일(pubdate)이 같은 경우 도서코드(bookid)의 내림차순으로 하시오.
select * from book order by pubdate asc, bookid desc;

-- 35. 도서(book) 테이블에서 도서의 수량(bookcount)가 10권 미만인 튜플에 대하여 도서분류(bookkind), 도서명(booktitle), 출판사(pubcom) 을 검색하되 
--     그 결과가 저자(author)의 오름차순으로 정렬하여 표시되도록 하시오.
select bookkind, booktitle, pubcom 
from book 
where bookcount < 10 
order by author asc; 

-- 36.  도서(book) 테이블에서 도서분류(bookkind)가 IT, NV, TC가 아닌 레코드의 도서코드(bookid), 도서명(booktitle), 저자(author) 를 검색하되
-- 		그 결과가 출판일을 기준으로 내림차순되어 표시되도록 하시오.
select bookid, booktitle, author
from book 
where bookkind not in('IT','NV','TC') 
order by pubdate;

-- 36. 판매(sales) 테이블의 전체 구매 건수를 출력하되 표시되는 컬럼명은 구매건수로 출력될 수 있도록 조회하시오.
select count(*) as "구매건수"
from sales;

-- 37. 판매(sales) 테이블의 회원별 구매 건수를 출력하되 회원아이디(id)와 구매건수를 표시하되 컬럼명은 cnt로 하며 cnt 2이상인, 회원아이디(id)의 오름차순 정렬되어 표시되도록 하시오.
select id, sum(amount) as cnt
from sales
group by id
having cnt>=2
order by id;

-- 38. 판매(sales) 테이블의 도서별 판매금액의 합계를 구하여 표시하되, 도서코드(bno), 판매금액합계 로 출력되게 하시오.
select bno, sum(money) as "판매금액합계"
from sales
group by bno;

-- 39. 판매(sales) 테이블에서 가장 큰 판매금액을 출력하되, 회원아이디(id), 도서코드(bno), 판매금액이 표시되도록 하시오.
select id, bno, money as "판매금액"
from sales
where money = (select max(money) from sales);

select id, bno, max(money) as "판매금액"
from sales
group by id, bno;

-- 40. 회원(member) 테이블에서 가입일별 인원수를 구하여 출력하되, 가입일 오름차순으로 출력되도록 하시오.
select reg_date, count(*) as "가입일별 인원수"
from member
group by reg_date
order by reg_date;

-- 41. 도서(book) 테이블에서 도서수량(bookcount)가 남은 수량이 적은 것을 기준으로 5위권까지 모든 도서 정보가 출력되도록 하시오.
select *
from book
order by bookcount
limit 5;

-- 42. 판매(sales) 테이블에서 판매금액(money)가 큰 순으로 3위 까지인 튜플의 판매코드(sno), 도서코드(bno), 회원아이디(id)가 출력될 수 있도록 하시오.
select sno, bno, id
from sales
order by money
limit 3;

-- 43. 회원 뷰(mem_view)를 생성하되 회원2(member2) 테이블을 활용하고, 회원 데이터 중에서 가입일을 기준으로 2022년 09월 이후에 가입한 회원을 대상으로 하시오.
create view mem_view 
as select * 
from member2 
where reg_date >= '2022-09-01';

-- 44. 판매 뷰(sales_view)를 생성하되 판매2(sales2) 테이블을 활용하고, 판매코드(sno), 도서코드(bno), 아이디(id), 판매금액(money) 컬럼만 추출되어 생성되게 하시오.
create view sales_view
as select sno,bno,id,money from sales;

-- 45. 도서 뷰(book_view)를 생성하되 도서2(book2) 테이블을 활용하고, 도서 데이터 중에서 도서분류(bookkind)가 'IT', 'TC', 'HC' 인 데이터를 대상으로 하며,
-- 	   컬럼은 도서분류(bookkind), 도서명(booktitle), 도서가격(bookprice), 출판사(pubcom) 만으로 구성되게 하시오.
create view book_view
as select bookkind, booktitle, bookprice 
from book2 
where bookkind in ('IT', 'TC', 'HC');

-- 46. 도서 뷰(book_view)에서 도서가격(bookprice)가 현재 가격에서 10% 인상이 될 수 있도록 데이터를 갱신하시오.
update book_view set bookprice = bookprice * 1.1;

-- 47. 판매 뷰(sales_view)를 편집하되 기존 select 구문에서 수량(amount) 가 2이상인 조건을 추가되게 하시오.
create or replace view sales_view
as select sno,bno,id,money from sales
where amount>=2;

-- 48. 회원 뷰(mem_view)에서 아이디(id)가 y로 끝나는 회원의 데이터를 삭제하시오.
delete from mem_view where id='%y';

-- 49. 판매 뷰(sales_view) 를 제거하시오.
drop view sales_view;

-- 50. 판매 뷰(mem_view) 를 제거하시오.
drop view mem_view;

-- 51. 상반기 판매순번 시퀀스(sd_seq)를 만들되 1부터 1씩 증가하도록 생성하시오.
-- MariaDB와 MySQL은 시퀀스 개념이 사용되지 않는다. 또한 사용하려면 별도의 설치가 필요하다.

-- 52. 상반기 판매순번 시퀀스(sd_seq)를 시작값이 6부터 될수 있도록 수정하시오.

-- 53. 상반기 판매순번 시퀀스(sd_seq)의 현재값이 조회될 수 있도록 하시오.

-- 54. 상반기 판매순번 시퀀스(sd_seq)를 제거하시오.

-- 55. 서브쿼리를 이용하여 구매한 적이 있는 (판매 테이블에 있는) 회원의 이름(name)을 중복성을 제거하여 조회하시오.
select name , id
from member 
where id in (select distinct id from sales);

-- 56. 서브쿼리를 이용하여 판매되지 않은 (판매 테이블에 있는) 도서의 정보를 조회하시오.
select *
from book
where bookid not in (select bno from sales);

-- 57. 서브쿼리를 활용하여 판매 테이블에서 판매금액의 평균이상인 모든 컬럼을 조회하시오.
select *
from sales
where money >= (select avg(money) from sales);

-- 58. 내부조인을 활용하여 판매된 적이 있는 도서이름(booktitle), 도서가격(bookprice), 총판매수량합계(amount), 총판매금액(money) 을 조회하시오.
select a.bookid, a.booktitle, sum(b.amount) as "총판매수량합계", sum(b.money) as "총판매금액"
from book a
inner join sales b on a.bookid=b.bno
group by a.bookid, a.booktitle
order by a.bookid;

-- 58. 내부조인을 활용하여 구매한 적이 있는 회원아이디(id), 회원명(name), 판매수량(amount), 판매금액(money) 을 조회하시오.
select m.id, m.name, s.amount, s.money
from member m
inner join sales s on m.id = s.id;

-- 59. 외부조인을 활용하여 판매되지 않은 도서의 도서명(booktitle), 도서가격(bookprice), 저자(author) 을 조회하시오.
select distinct booktitle, bookprice, author
from book
where bookid not in (select bno from sales);

-- 차집합
select distinct a.booktitle, a.bookprice, a.author
from book a 
left join sales b
on a.bookid = b.bno
where b.bno is null;

-- 연관쿼리
select distinct a.booktitle, a.bookprice, a.author
from book a where not exists (
	select 1 from sales b where a.bookid = b.bno
);

-- 60. 외부조인을 활용하여 구매한 적이 없는 회원의 회원아이디(id), 회원명(name) 을 조회하시오.
select id, name
from member
where id not in (select id from sales); 

select m.id, m.name
from member m
left join sales s
on m.id = s.id
where s.id is null;

select m.id, m.name
from member m
where not exists(
	select 1 from sales s where m.id=s.id
);

-- 61. 판매(sales)와 판매2(sales2) 테이블을 합집합하여 종합 판매 뷰(tot_sales_view)를 생성하시오. 
create view tot_sales_view
as (select * from sales union select * from sales2);

-- 62. 회원(member)와 회원2(member2) 테이블을 교집합하여 중복회원 뷰(cross_mem_view)를 생성하시오.
-- MySQL은 연관쿼리를 활용하여 교집합 생성
create view cross_mem_view as
select a.id, a.password, a.name, a.address
from member a, member b
where a.id = b.id;

-- 63. 도서(book)와 도서2(book2) 테이블을 차집합하여 도서(book)에만 있는 도서 뷰(minus_book_view)를 생성하시오. 
-- 서브쿼리를 이용한 차집합 뷰 작성
create view minus_book_view as
select bookid, bookkind, booktitle, bookcount from book
where bookid not in (select distinct bookid from book2);

-- 외부조인을 이용한 차집합 뷰 작성
create view minus_book_view2 as
select a.bookid, a.bookking, a.booktitle, a.bookcount
from book a left join book2 b on a.bookid = b.bookid
where b.bookid is null;

set SQL_SAFE_UPDATEs = 0;
select * from member;
select * from book;
select * from sales;










-- TEST EXAM

-- TB_AREA 테이블 생성
CREATE TABLE TB_AREA(AREA_CODE VARCHAR(20), AREA_NAME VARCHAR(20));

-- TB_AREA 테이블 데이터 삽입
INSERT INTO TB_AREA VALUES('02', '서울');
INSERT INTO TB_AREA VALUES('031', '경기');
INSERT INTO TB_AREA VALUES('032', '인천');

-- TB_GRADE 테이블 생성
CREATE TABLE TB_GRADE(GRADE_CODE INT, GRADE_NAME VARCHAR(40));

-- TB_GRADE 테이블 데이터 삽입
INSERT INTO TB_GRADE VALUES(10, '일반회원');
INSERT INTO TB_GRADE VALUES(20, '우수회원');
INSERT INTO TB_GRADE VALUES(30, '특별회원');

-- TB_MEMBER 테이블 생성
CREATE TABLE TB_MEMBER(MEMBER_ID VARCHAR(50), MEMBER_PWD VARCHAR(50), MEMBER_NAME VARCHAR(50), GRADE INT, AREA_CODE VARCHAR(20));

-- TB_MEMBER 테이블 데이터 삽입
INSERT INTO TB_MEMBER VALUES('hong01', 'pass01', '홍길동', 10, '02');
INSERT INTO TB_MEMBER VALUES('leess99', 'pass02', '이순신', 10, '032');
INSERT INTO TB_MEMBER VALUES('ss50000', 'pass03', '신사임당', 30, '031');
INSERT INTO TB_MEMBER VALUES('iu93', 'pass04', '아이유', 30, '02');
INSERT INTO TB_MEMBER VALUES('pcs1234', 'pass05', '박철수', 20, '031');
INSERT INTO TB_MEMBER VALUES('you_js', 'pass06', '유재석', 10, '02');
INSERT INTO TB_MEMBER VALUES('kyh9876', 'pass07', '김영희', 20, '031');

SELECT * FROM TB_AREA;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_MEMBER;

-- 1. 김영희 회원과 같은 지역에 사는 회원들의 지역명, 아이디, 이름, 등급명을 이름 오름차순으로 조회
SELECT AREA_NAME 지역명, MEMBER_ID 아이디, MEMBER_NAME 이름, GRADE_NAME 등급명
FROM TB_MEMBER
JOIN TB_GRADE ON(GRADE = GRADE_CODE)
-- AREA_CODE 이름이 같아서
JOIN TB_AREA USING(AREA_CODE)
-- alias는 괄호안에서 인지하지 못하기 때문에 에러발생
WHERE AREA_CODE = (SELECT AREA_CODE FROM TB_MEMBER WHERE MEMBER_NAME = '김영희')
ORDER BY 이름;


-- 1-2. 아이디에 1234가 포함되는 회원과 같은 등급, 같은지역인 회원들의 아이디, 비밀번호, 이름, 등급명, 지역명을 아이디 내림차순으로 조회
SELECT MEMBER_ID AS 아이디, MEMBER_PWD AS 비밀번호, MEMBER_NAME AS 이름, GRAND_NAME AS 등급명
FROM TB_MEMBER
-- USING은 양 테이블의 컬럼이름이 같을 때만 사용함. 컬럼이름 불일치의 오류가 발생함
JOIN TB_GRADE ON(GRADE = GRADE_CODE)
JOIN TB_AREA USING(AREA_CODE)
-- ID에 1234가 포함된 데이터를 검색해야하는데, ID가 1234인 데이터만 검색하기 때문에 잘못된 결과가 나온다.
WHERE (GRADE, AREA_CODE) = (SELECT GRADE, AREA_CODE FROM TR_MEMBER WHERE MEMBER_ID LIKE '%1234%')
ORDER BY MEMBER_ID DESC;


-- 1-3. 서울, 경기 지역에 사는 회원들의 정보를 번호, 아이디, 이름, 등급명, 지역명을 아이디 오름차순으로 정렬
-- (번호는 ROWNUM을 이용. 메인 쿼리 조회 결과의 번호는 1,2,3,... 순서대로 조회되어야 함.)
-- ROWNUM이라는 컬럼이름이 존재하지 않기 때문에 오류발생
-- 2중으로 SELECT문이 들어감
SELECT ROWNUM AS 번호, MEMBER_ID AS 아이디, MEMBER_NAME AS 이름, GRADE_NAME AS 등급명, AREA_NAME AS 지역명
FROM (
	-- AREA_NAME이 없음
	SELECT MEMBER_ID, MEMBER_NAME, GRADE_NAME, AREA
	FROM TB_MEMBER
	JOIN TB_GRADE ON(GRADE = GRADE_CODE)
    JOIN TB_AREA USING(AREA_CODE)
	-- = 이아니라 IN 사용해야함
    WHERE AREA_NAME IN ('서울', '경기'))
    -- ORDER BY는 괄호안에 들어가야함. 밖에있어서 실제로 정렬되지못한다.
    ORDER BY MEMBER_ID;


-- 2-1. 아래의 SQL구문은 부서 별 평균 월급이 2800000을 초과하는 부서를 조회한 것이다.
-- 결과가 올바르지 않다고 할 때, 그 원인(20점)과 올바르게 수정한 조치사항(20점)을 각각 항목에 맞게 기술하시오. (총 40점)

-- 컬럼에 별명을 붙이려면 컬럼명 뒤에 alias를 쓰고 별명을 써야하는데, alias가 빠져있음
SELECT DEPT, SUM(SALARY) AS 합계, FLOOR(AVG(SALARY)) AS 평균, COUNT(*) AS 인원수
FROM EMP
WHERE SALARY > 2800000
GROUP BY DEPT
ORDER BY DEPT ASC;


-- 2-2. LIMIT를 이용해서 월급이 가장 높은 3명을 뽑을려고 하였으나, 올바른 결과가 조회 되지 않았다.
-- 결과가 잘못 조회된 이유를 [원인](30점)에 기술하고, 아래의 구문을 수정하여 [조치내용](30점)에 기술하시오. (총 60점)
SELECT EMPNAME, SAL
FROM EMP
-- LIMIT는 ORDER BY 뒤에 와야함
ORDER BY SAL DESC
LIMIT 0,3;


-- 3-1. 다음 테이블에 값을 추가하려 할 때 다음과 같은 에러가 발생한다.
-- 그 원인(20점)과 조치사항(20점)이 무엇인지 기술하시오. (총 40점)
-- KH_LIBRARY테이블의 TITLE 컬럼의 제약조건으로 NOT NULL이 선언되어있어서 TITLE컬럼에 데이터를 입력하지 않는 질의라 에러발생
INSERT INTO KH_LIBRARY(BOOK_NO, AUTHOR, PUB_DATE) VALUES(5, '생텍쥐페리', '1943/04/01')


-- 3-2. MNO 컬럼을 기본키로 삼는 MEMBER_KH 테이블을 만들었다.
-- 해당 테이블에 데이터를 추가하려 하였으나, 문제가 발생한다고 할 때,
-- [원인](40점)과 해결할 수 있는 [조치사항](20점)을 기술하시오. (총 60점)
-- PRIMARY KEY인 MNO 컬럼에는 동일한 값을 넣을 수 없는데, 같은 값을 넣으려고 하여 개체무결성이 위반됨


-- 4-1. 다음 보기를 확인하여 결과가 올바르지 않은 원인(20점)을 찾아 기술하고,
-- 올바른 107번이 아닌 사원을 삭제하는 SQL을 조치사항(20점)에 작성하시오. (총 40점)
-- 이름은 같지만, 사원번호와 부서가 다른 튜플이 존재하는데 이를 고려하지 않고 select문의 where문에 이름이 다니엘인 사람을 모두 검색하여
-- 결과값이 여러개가 나옴
DELETE FROM EMP_TBL WHERE ENO=107 AND ENAME=다니엘 AND ADDRESS='명동'
DELETE FROM EMP_TBL WHERE ENO=105 AND ENAME=다니엘 AND ADDRESS='명동'


-- 4-2. 다음은 '해외 1부'와 '해외 2부'에서 근무하는 직원들을 '해외 기획부'로 변경하는 UPDATE 문이다.
-- 주어진 데이터를 참조하여 현재 UPDATE를 수행하였을 때 문제가 발생한다면
-- 원인(30점)이 무엇이고, 이를 해결하기 위한 조치사항(30점)은 무엇인지 각각 작성하시오. (총 60점)
-- DEPT_TITLE like '해외 %' 의 의미는 부서명앞이 '해외 '로 시작하는 부서명을 의미하기 때문에 해외 2부만 바뀌는 것이아니라
-- 해외가 붙은 모든 부서명이 바뀌게되기 때문에 문제 발생
WHERE DEPT_TITLE LIKE '해외 2부';










