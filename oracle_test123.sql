-- 테이블 생성
create table member(no int not null, id varchar(20) primary key, pw varchar(300), name varchar(100), birth timestamp, email varchar(300));

-- 시퀀스 생성
create sequence c##test123.mem_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;


-- 데이터 삽입
insert into member values (mem_seq.nextval, 'jang', '1234', '장인범', '1996-11-13', 'dlsqja@naver.com');
insert into member values (mem_seq.nextval, 'kim', '4321', '김대희', '1992-01-24', 'eogml@naver.com');
insert into member values (mem_seq.nextval, 'eom', '1214', '엄지훈', '1983-07-05', 'djawlgns@naver.com');
insert into member values (mem_seq.nextval, 'park', '1004', '박민수', '1978-05-15', 'quincepark@naver.com');
insert into member values (mem_seq.nextval, 'JI', '4545', '지창훈', '1999-12-25', 'changhoon@naver.com');


-- 데이터 검색
select * from member;

-- id,name,birth 컬럼 검색
select id,name,birth from member;

-- 생일이 1970-01-01 ~ 1989-12-31 사이인 회원의 id,name,birth 컬럼 검색
select id,name,birth from member where birth between '1970-01-01' and '1989-12-31';

-- id에 i나 e가 포함된 회원의 정보를 검색
select id,name from member where id like '%i%' or id like '%e%';
-- id like 'i%' : i로 시작하는 id
-- id like '%i' : i로 끝나는 id
-- id like '%i%' : i가 포함된 id

-- id가 'kim','park','bae' 인 회원 검색
select * from member where id='kim' or id='park' or id='bae';
select * from member where id in ('kim','park','bae');

-- id가 'kim','park','bae' 가 아닌 회원 검색
select * from member where id not in ('kim','park','bae');

-- 컬럼명이 길거나 수식이나 함수를 적용하여 컬럼을 구성할 경우 컬럼에 대한 alias(별칭)를 붙일 수 있다.
-- 회원 테이블로 부터 id,name, 이름 중에서 성씨를 검색하고, 그 컬럼 이름에 surname이라는 alias를 붙임
select id,name,substr(name,1,1) as surname from member;
-- java 에서 rs.getString("surname"); 처럼 alias로 호출해야함


-- 데이터 수정
update member set email='bae@naver.com' where id='bae';


-- 데이터 삭제
delete from member where id='kim';


-- 테이블 수정
alter table member add regdate timestamp default sysdate;

-- 컬럼명 변경
alter table member rename column regdate to reg;

-- 컬럼의 데이터 타입 변경
alter table member modify pw varchar(200);

-- 컬럼 삭제
alter table member drop column point;

-- 테이블명 변경
alter table member rename to temp1;

create table temp2(no int, name varchar(200), point int);

insert into temp2 values(1, '장인범', 94);
insert into temp2 values(2, '박민수', 87);
insert into temp2 values(3, '최민정', 75);
insert into temp2(name, point) values ('이가돔', 62);

delete from temp2 where no is null;
select * from temp2;
alter table temp2 add constraints key1 primary key (no);


create table emp(no int, name varchar(100), pcode int) constraints key2 primary key(no);
alter table emp add constraints key2 primary key (no); 

insert into emp values (1, '최민정', 1);
insert into emp values (2, '장인범', 2);
insert into emp values (3, '박민수', 3);
insert into emp values (4, '이미나', 4);
insert into emp values (5, '배태수', 5);
select * from emp;
update emp set pcode=3 where no = 2;

create table pos(pcode int primary key, pname varchar(100));
insert into pos values(1, '이사');
insert into pos values(2, '부장');
insert into pos values(3, '과장');
insert into pos values(4, '사원');
insert into pos values(5, '인턴');
select  * from pos;

alter table emp add constraints fkey foreign key (pcode) references pos(pcode);

select * from all_constraints where OWNER='C##TEST123';
select * from ALL_CONSTRAINTS where TABLE_NAME='EMP';

alter table emp drop constraints key2;

drop table pos cascade constraints;
drop table emp cascade constraints;
desc emp;
commit;

-- view의 생성
create view view_emp as select * from emp;
select view view_emp;
drop view view_emp;
-- alter view view_emp2 as select * from emp where no>=2 or name like '%e%';

-- 시퀀스(자동 순번) 생성/수정/제거/적용/조회
-- 시퀀스 생성
create sequence emp_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;

-- 시퀀스 수정(시작 번호는 바꿀 수 없음)
alter sequence emp_seq increment by 1;

-- 시퀀스 삭제
drop sequence emp_seq;

-- 시퀀스 검색
select * from all_sequences where sequence_name='EMP_SEQ';

-- emp 테이블에 no의 값을 다음 순번(nextval)으로 적용하여 레코드 추가
insert into emp values(emp_seq.nextval, '고', 3);

-- 현재 시퀀스 값 조회
select emp_seq.currval from dual;

-- 테이블 복제(단, 제약조건은 복제되지 않는다.)
create table emp2 as select * from emp;


-- inner join
select a.no, a.name, b.pname from emp a inner join pos b on a.pcode = b.pcode;

-- left outer join
select a.no, a.name, b.pname from emp a left join pos b on a.pcode = b.pcode;

-- right outer join
select a.no, a.name, b.pname from emp a right join pos b on a.pcode = b.pcode;

-- 연관쿼리
select a.no, a.name, b.pname from emp a, pos b where a.pcode = b.pcode;

delete from emp2 where no=3 or no=5;
insert into emp2 values(7, '오', 4);
insert into emp2 values(8, '정', 5);

-- 서브쿼리 = 이중쿼리
-- 서브쿼리(emp2 테이블에 존재하는 no만 emp 테이블에서 조회) => 일치 쿼리(교집합)
select emp.no, emp.name from emp where emp.no in (select no from emp2);

-- 서브쿼리(emp2 테이블에 존재하지 않는 no만 emp 테이블에서 조회) => 불일치 쿼리(차집합)
select emp.no, emp.name from emp where emp.no not in (select no from emp2);

-- 그룹화하는 항목과 출력되는 그룹 항목이 같아야한다.
-- 직위별 인원 수 join문 -> 그룹화하는 항목 : 직위명(pname)
select distinct b.pname, count(*) as cnt from emp a, pos b where a.pcode = b.pcode group by a.pname;

-- 집계함수 : count, sum, avg, max, min

-- 반드시 order by 구절은 맨 끝에다 지정해야하며, 출력되는 항목이어야 함
-- order by : 정렬
-- desc : 내림차순
-- 생략 or asc : 오름차순
select * from emp order by name desc;

-- 집합연산시에는 연산하는 두 개의 테이블의 구조가 같거나 연산하는 컬럼타입이 같아야 함.
-- 집합연산 UNION(합집합), INTERSECT(교집합), MINUS(차집합)
create view uni_view as (select * from emp union select * from emp2);
create view int_view as (select * from emp intersect select * from emp2);
create view min_view1 as (select * from emp minus select * from emp2);
create view min_view1 as (select * from emp2 minus select * from emp);




-- 오라클 명령문법 실습

-- 직원(emp) 테이블 생성
create table emp(u_id varchar(8) primary key, name varchar(20) not null, password varchar(20) not null, 
position varchar(4) not null, workplace varchar(20) not null, 
address varchar(50), birth date, regday date, wedday date);

-- 급여(sal) 테이블 생성
create table sal(u_id varchar(8) primary key, salary int not null, from_date date, to_date date);











