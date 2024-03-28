-- 회원(member) 테이블 생성
create table member(id varchar(12), password varchar(12) not null, name varchar(20) not null,
address varchar(100), tel varchar(20) not null, reg_data date default sysdate);

-- book 시퀀스 생성
create sequence bseq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;

-- 도서(book) 테이블 생성
create table book(bookid int default bseq.nextval primary key, bookkind varchar(3) not null,
booktitle varchar(50) not null, bookprice int not null, bookcount int not null, author varchar(20),
pubcorn varchar(20), pubdate date);


-- sales 시퀀스 생성
create sequence sseq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;

-- 판매(sales) 테이블 생성
create table sales(sno int default sseq.nextval primary key, bno int not null, id varchar(12) not null,
amount int default 1, money int, salesday date default sysdate);

-- 회원 데이터 추가
insert into member values('bgh', 'a1234', '배곤희', '신사동 912', '010-1111-2222', '2023-09-13');
insert into member values('yjh', 'a3421', '유정환', '강일동 128', '02-2222-3333', '2023-09-13');
insert into member values('lmk', 'b1111', '이민규', '수유동 1004', '010-3333-4444', '2023-09-14');
insert into member values('lsh', 'c456', '이성하', '화곡1동 37', '010-4444-5555', '2023-09-15');
insert into member values('lyj', 'z675', '이연정', '난곡동 67', '02-4444-2222', '2023-09-11');
insert into member values('lyl', 'q789', '이예린', '능동 13', '010-5555-6666', '2023-09-15');
insert into member values('lws', 'g478', '이원석', '고척1동 178', '010-6666-7777', '2023-09-13');
insert into member values('ljh', 'd666', '이정희', '독산1동 75', '010-7777-8888', '2023-09-14');
insert into member values('ljw', 'e964', '이종우', '상계동 777', '02-5555-2222', '2023-09-05');
insert into member values('jib', 'h369', '장인범', '쌍문3동 888', '010-8888-9999', '2023-09-16');

-- 도서 데이터 추가
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate) 
values('it', '이것이 자바다', 30000, 10, '신용권', '한빛미디어', '2021-08-20');
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate) 
values('it', '자바웹개발워크북', 31500, 19, '코딩단', '남가람북스', '2022-08-04');
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate) 
values('NV', '하얼빈', 14400, 15, '김훈', '문학동네', '2022-08-03');
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate) 
values('NV', '불편한편의점', 12600, 10, '김호연', '나무옆의자', '2022-08-10');
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate) 
values('DV', '역행자', 15750, 8, '자청', '웅진출판', '2022-05-30');
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate) 
values('DV', '자소서바이블', 18000, 15, '이형', '엔알디', '2022-08-25');
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate) 
values('HC', '벌거벗은한국사', 17500, 10, 'tvn', '프런트페이지', '2022-08-22');
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate) 
values('HC', '난중일기', 14000, 30, '이순신', '스타북스', '2022-07-27');
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate) 
values('TC', '진짜쓰는실무엑셀', 20000, 10, '전진권', '제이펍', '2022-02-15');
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate) 
values('TC', '빅데이터인공지능', 25000, 15, '박해선', '한빛미디어', '2020-12-21');

-- 판매 데이터 추가
insert into sales(bno, id, amount) values(1, 'lhy', 1);
insert into sales(bno, id, amount) values(2, 'ykh', 1);
insert into sales(bno, id, amount) values(1, 'jjs', 2);
insert into sales(bno, id, amount) values(9, 'lhy', 1);
insert into sales(bno, id, amount) values(2, 'cmj', 5);
insert into sales(bno, id, amount) values(2, 'jjs', 3);
insert into sales(bno, id, amount) values(3, 'yjh', 2);
insert into sales(bno, id, amount) values(5, 'hsy', 4);
insert into sales(bno, id, amount) values(4, 'nsy', 8);
insert into sales(bno, id, amount) values(1, 'jbj', 3);
insert into sales(bno, id, amount) values(2, 'kyj', 4);
insert into sales(bno, id, amount) values(7, 'lhn', 1);
insert into sales(bno, id, amount) values(8, 'hth', 2);
insert into sales(bno, id, amount) values(10, 'cmj', 5);
insert into sales(bno, id, amount) values(1, 'lhy', 3);
insert into sales(bno, id, amount) values(2, 'cmj', 2);
insert into sales(bno, id, amount) values(2, 'lhy', 1);
insert into sales(bno, id, amount) values(1, 'ykh', 3);

-- 구매금액(money)에 도서테이블에서 해당 도서에 대한 가격과 수량을 곱한 금액을 삽입
update sales a set a.money = (select b.bookprice*a.amount from book b where a.bno = b.bookid);

update sales set money = (select bookprice from book where book.bookid = sales.bno)*amount;


-- 회원(member), 도서(book), 판매(sales) 테이블 select
select * from member;
select * from book;
select * from sales;


-- 1. 회원테이블에 다음과 같은 내용을 추가하시오.
insert into member values('kkt', 'a1004', '김기태', '가산동 123', '010-1004-1004', '2023-09-12');

-- 2. 도서 테이블에 다음 데이터를 추가하시오.
insert into book(bookkind, booktitle, bookprice, bookcount, author, pubcorn, pubdate)
values('IT', '스프링프레임워크', 38000, 8, '김기태', '정복사', '2022-09-10');

-- 3. 판매 테이블에 다음 튜플을 추가
insert into sales(bno, id, amount) values(1, 'kkt', 2);
update sales a set a.money = (select a.amount * b.bookprice from book where a.bno = b.bookid);

-- 4. 회원 테이블에 기본값이 0인 숫자 데이터를 저장할 포인트(pt) 컬럼 추가
alter table member add pt int default 0;

-- 5. 회원 테이블에 방문횟수(visited) 컬럼을 추가
alter table member add visited int;

-- 6. 회원 테이블에 이메일 컬럼 추가
alter table member add email varchar(100);

-- 7. 회원 테이블에 지역코드(areacode) 컬럼을 추가
alter table member add areacode varchar(20);

-- 8. 회원 테이블에 있는 컬럼 중에서 방문횟수 컬럼을 제거
alter table member drop column visited;

-- 9. 회원 테이블에 지역(areacode) 컬럼의 이름을 areadata로 변경
alter table member rename column areacode to areadata;

-- 10. 판매(sales) 테이블을 복제하여 판매2(sales2) 테이블 생성
create table sales2 as select * from sales;

-- 11. 도서 테이블을 복제하여 도서2(book2) 테이블 생성
create table book2 as select * from book;

-- 12. 회원 테이블을 복제하여 회원2(member2) 테이블 생성
create table member2 as select * from member;

-- 13. 판매2(sales2) 테이블 제거
drop table sales2;

-- 14. 복제된 회원2(member2) 테이블에서 아이디가 j가 포함된 회원을 삭제하시오.
delete from member2 where id like '%j%';

-- 15. 회원(member) 테이블에서 모든 회원에 대한 포인트를 100이 지급될 수 있도록 변경
update member set pt=100;

-- 16. 회원(member) 테이블에서 회원의 아이디가 lsh인 회원의 주소를 '도화동 27'로 변경
update member set address='도화동 27' where id='lsh';

-- 17. 회원2(member2) 테이블에서 연락처가 02인 회원의 가입일을 오늘날짜로 변경
update member2 set reg_data = sysdate where tel like '010%';

-- 18. 도서2(book2) 테이블에서 도서 분류가 HC인 레코드에 대하여 도서 수량 5로 변경
update book2 set bookcount=5 where bookkind='HC';

-- 19. 도서2(book2) 테이블에서 도서 분류가 TC인 튜플을 제거
delete from book2 where bookkind='TC';

-- 20. 도서2(book2) 테이블에 도서상태(ckdata) 컬럼을 추가
alter table book2 add ckdata varchar(30);

-- 21. 도서2 테이블에 도서 수량이 7이하인 튜플에 도서상태 '재입고요망'으로 추가
update book2 set ckdata='재입고요망' where bookcount<=7;

-- 22. 회원2(member2) 테이블에 id를 기본키로 추가
alter table member2 add constraints key1 primary key (id);
alter table member2 modify id varchar(12) primary key;

-- * 23. 도서2 테이블에 도서코드(bookid)를 기본키로 도서분류(bookkind)를 외래키로 추가
alter table book2 add constraints pkey primary key (bookid);
create table bookkind(kindcode varchar(6) primary key, kindname varchar(50));
insert into bookkind values('IT', '아이티');
insert into bookkind values('NV', '엔브이');
insert into bookkind values('DV', '디브이');
insert into bookkind values('HC', '엣치씨');
alter table book2 add constraints fkey foreign key (bookkind) references bookkind(kindcode);

-- 24. 도서2 테이블에서 출판일이 2022년 8월인 데이터의 수량 5씩 증가
update book2 set bookcount = bookcount+5 where pubdate between '2022-08-01' and '2022-08-31';

-- 25. 회원 테이블에서 모든 회원의 모든 정보 조회
select * from member;

-- 26. 판매 테이블에서 구매한 적이 있는 회원의 아이디의 중복을 제거하여 조회
select distinct id from sales;

-- 27. 도서(book) 테이블에서 도서종류(bookkind)가 IT인 튜플 검색
select * from book where bookkind='IT';

-- 28. 회원(member) 테이블에서 아이디가 k가 포함된 회원의 이름(name), 연락처(tel) 컬럼 검색
select name, tel from member where id like '%k%';

-- 29. 판매(sales) 테이블에서 수량이 2이상인 레코드 검색
select * from sales where amount>=2;

-- 30. 도서(book) 테이블에서 단가(bookprice)가 19000이상 30000이하인 데이터의 도서명, 도서가격, 저자 조회
select booktitle, bookprice, author from book where bookprice between 19000 and 30000;

-- 31. 도서테이블에서 출판사가 한빛미디어 이거나 남가람북스인 튜플의 도서명, 저자, 수량을 조회
select booktitle, author, bookcount from book where pubcorn='한빛미디어' or pubcorn='남가람북스';

-- 32. 도서 테이블에서 출판일이 2022년인 튜플을 검색
select * from book where pubdate between '2022-01-01' and '2022-12-31';

-- 33. 회원 테이블에서 비밀번호가 5글자 이상인 회원의 아이디, 이름, 주소 검색
select id, name, tel from member where length(password)>=5;

-- 34. 도서 테이블에서 출판일을 기준으로 오름차순하여 검색하되 출판일이 같은 경우 도서코드의 내림차순
select * from book order by pubdate asc, bookid desc;

-- 35. 도서테이블에서 도서의 수량이 10권 미만인 튜플에 대하여 도서분류, 도서명, 출판사를 검색하되 그 결과가
-- 저자의 오름차순으로 정렬하여 표시
select bookkind, booktitle, pubcorn from book asc where bookcount<10 order by author;

-- 36. 도서 테이블에서 도서분류가 IT, NV, TC가 아닌 레코드의 도서코드, 도서명, 저자를 검색하되 그 결과가
-- 출판일을 기준으로 내림차순 표시
select bookid, booktitle, author from book where bookkind not in('IT','NV','TC') order by pubdate desc;

-- 37. 판매 테이블의 회원별 구매 건수를 출력하되 회원아이디와 구매건수를 표시하되 컬럼명은 구매건수로 하며,
-- 회원아이디의 오름차순 정렬로 표시
select id, amount as 구매건수 from sales order by id asc;

-- 38. 판매 테이블의 도서별 판매금액의 합계를 구하여 표시하되, 도서코드, 판매금액합계로 출력
select bno, sum(money) as 판매금액합계 from sales group by bno;

-- 39. 판매 테이블에서 가장 큰 판매금액을 출력하되, 회원아이디, 도서코드, 판매금액 표시
select id,bno, money as 베스트셀러 from sales where money=(select max(money) from sales);
select id, bno, max(money) as 판매금액 from sales group by id, bno;

-- 40. 회원 테이블에서 가입일별 인원수를 구하여 출력하되, 가입일 오름차순으로 출력되도록 하시오.
select reg_data, count(*)인원수 from member group by reg_data order by reg_data asc;

-- 41. 도서 테이블에서 도서수량이 남은 수량이 적은 것을 기준으로 5위권까지 모든 정보가 출력되도록 하시오.
select * from (select * from book order by bookcount asc) where rownum <= 5;

-- 42. 판매 테이블에서 판매금액이 큰 순으로 3위 까지인 튜플의 판매코드, 도서코드, 회원아이디 출력
select sno, bno, id 
from (select * from sales order by money desc)
where rownum <= 3;

-- 43. 회원 뷰를 생성하되 회원2 테이블을 활용하고, 회원 데이터 중에서 가입일을 기준으로 2022년 09월
-- 이후 가입한 회원을 대상으로 함
create view mem_view as select * from member where reg_data >= '2023-09-10';
select * from mem_view;

-- 44. 판매 뷰를 생성하되 판매2 테이블을 활용하고, 판매코드, 도서코드, 아이디, 판매금액 컬럼만 추출
create view sales_view as select sno,bno,id,money from sales;
select * from sales_view;

-- 45. 도서 뷰를 생성하되 도서2 테이블을 활용하고, 도서 데이터 중에서 도서분류가 'IT', 'TC', 'HC'인
-- 데이터를 대상으로 하며, 컬럼은 도서분류, 도서명, 도서가격, 출판사로 구성
create view book_view as select bookkind, booktitle, bookprice, pubcorn
from book
where bookkind in('IT', 'TC', 'HC');
select * from book_view;

-- * 46. 도서 뷰에서 도서가격이 현재 가격에서 10% 인상 될 수 있도록 데이터 갱신
update book_view set bookprice=bookprice*1.1
select * from book_view;

-- 47. 판매 뷰를 편집하되 기존 select 구문에서 수량이 2이상인 조건 추가
create or replace view sales_view as select sno,bno,id,money
from sales
where amount>=2;

-- * 48. 회원 뷰에서 아이디가 y로 끝나는 회원의 데이터를 삭제
create or replace view mem_view as select *
from member
where id not like '%b';

-- 49. 도서 뷰 제거
drop view book_view;

-- 50. 판매 뷰 제거
drop view sales_view;

-- 51. 상반기 판매순번 시퀀스를 만들되 1부터 1씩 증가하도록 생성
create sequence sd_seq increment by 1 start with 1;

-- 52. 상반기 판매순번 시퀀스를 시작값이 6부터 될 수 있도록 수정 (시퀀스 시작 번호는 변경 불가)
alter sequence sd_seq start with 6;

-- 53. 상반기 판매순번 시퀀스의 현재값 조회
select system.sd_seq.currval from sales;

-- 54. 상반기 판매순번 시퀀스를 제거
drop sequence sd_seq;

-- 55. 서브쿼리를 이용하여 구매한 적이 있는 회원의 이름을 중복성을 제거하여 조회
select distinct name from member where id in (select id from sales);

-- 56. 서브쿼리를 이용하여 판매되지 않은 도서의 정보를 조회
select * from book where bookid not in(select bno from sales);

-- 57. 서브쿼리를 활용하여 판매 테이블에서 판매금액의 평균 이상인 모든 컬럼 조회
select * from sales where money >= (select avg(money) from sales);

-- 58. 내부조인을 활용하여 판매된 적이 있는 도서이름, 도서가격, 판매수량, 판매금액을 조회
select b.booktitle, b.bookprice, s.amount, s.money
from book b inner join sales s on b.bookid = s.bno;

-- 59. 외부조인을 활용하여 판매되지 않은 도서의 도서명, 도서가격, 저자 조회
select b.booktitle, b.bookprice, b.author from book b left join sales s on b.bookid=s.bno
where s.bno is null;

select b.booktitle, b.bookprice, b.author from book b left join sales s on b.bookid=s.bno
minus
select distinct a.booktitle, a.bookprice, a.author
from book a right join sales b on a.bookid=b.bno;

-- * 60. 외부조인을 활용하여 구매한 적이 없는 회원의 회원아이디, 회원명을 조회
select m.id, m.name from member m left join sales s on m.id = s.id
where s.id is null;

select m.id, m.name from member m left join sales s on m.id = s.id
minus
select distinct a.id, a.name from member a right outer join sales b on a.id=b.id;

-- 61. 판매와 판매2 테이블을 합집합하여 종합 판매 뷰를 생성
create view tot_sales_view as (select * from sales union select * from sales2);

-- 62. 회원과 회원2 테이블을 교집합하여 중복회원뷰 생성
create view cross_mem_view as (select * from member intersect select * from member2);

-- 63. 도서와 도서2 테이블을 차집합하여 도서에만 있는 도서뷰 생성
create view minus_book_view as (select * from book minus select * from book2);


select * from member2;
select * from book2;
desc book;
select * from member;
select * from book;
select * from sales;

alter table book rename column pubcorn to pubcom;
desc book;









