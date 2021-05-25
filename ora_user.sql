CREATE TABLE ex2_1(
COLUMN1 CHAR(10),
COLUMN2 VARCHAR2(10),
COLUMN3 NVARCHAR2(10),
COLUMN4 NUMBER
);

INSERT INTO ex2_1 (column1, column2) VALUES ('abc','abc');

SELECT column1, LENGTH(column1) as len1,
column2, LENGTH(column2) as len2
FROM ex2_1;

CREATE TABLE ex2_2(
COLUMN1 VARCHAR2(3),
COLUMN2 VARCHAR2(3 byte),
COLUMN3 VARCHAR2(3 char)
);

INSERT INTO ex2_2 VALUES('abc', 'abc', 'abc');

SELECT column1, LENGTH(column1) AS len1,
column2, LENGTH(column2) AS len2,
column3, LENGTH(column3) AS len3
FROM ex2_2;

INSERT INTO ex2_2 (column3) VALUES ('È«±æµ¿');

SELECT column3, LENGTH(column3) AS len3, LENGTHB(column3) AS bytelen FROM ex2_2;

CREATE TABLE ex2_3(
COL_INT INTEGER,
COL_DEC DECIMAL,
COL_NUM NUMBER
);

SELECT column_id, column_name, data_type, data_length
    FROM user_tab_cols
    WHERE table_name = 'EX2_3'
    ORDER BY column_id;

CREATE TABLE EX2_4(
    COL_FLOT1 FLOAT(32),
    COL_FLOT2 FLOAT
);

INSERT INTO ex2_4 (col_flot1, col_flot2) VALUES (1234567891234, 1234567891234);

CREATE TABLE EX2_5(
    COL_DATE DATE,
    COL_TIMESTAMP TIMESTAMP
);

INSERT INTO EX2_5 VALUES (SYSDATE, SYSTIMESTAMP);
SELECT *
FROM EX2_5;


CREATE TABLE EX2_6(
    COL_NULL VARCHAR2(10),
    COL_NOT_NULL VARCHAR2(10) NOT NULL
);

INSERT INTO EX2_6 VALUES ('AA','BB');

SELECT constraint_name, constraint_type, table_name, search_condition
FROM user_constraints
WHERE table_name = 'EX2_6';

CREATE TABLE EX2_7(
COL_UNIQUE_NULL VARCHAR2(10) UNIQUE,
COL_UNIQUE_NNULL VARCHAR2(10) UNIQUE NOT NULL,
COL_UNIQUE VARCHAR2(10),
CONSTRAINTS unique_nm1 UNIQUE (COL_UNIQUE)
);

SELECT constraint_name, constraint_type, table_name, search_condition FROM user_constraints WHERE table_name = 'EX2_7';

INSERT INTO EX2_7 VALUES ('AA', 'AA', 'AA');
INSERT INTO EX2_7 VALUES ('AA', 'AA', 'AA');

INSERT INTO EX2_7 VALUES ('', 'BB', 'BB');
INSERT INTO EX2_7 VALUES ('', 'CC', 'CC');

CREATE TABLE EX2_8(
    COL1 VARCHAR2(10) PRIMARY KEY,
    COL2 VARCHAR2(10)
);

SELECT constraint_name, constraint_type, table_name, search_condition
FROM user_constraints
WHERE table_name = 'EX2_8';

--INSERT INTO EX2_8 VALUES ('','AA'); NULL 입력 불가

INSERT INTO EX2_8 VALUES ('AA','AA');

--INSERT INTO EX2_8 VALUES ('AA','AA'); 무결성 제약 조건 위배

CREATE TABLE EX2_9(
num1 NUMBER
CONSTRAINT check1 CHECK (num1 BETWEEN 1 AND 9),
gender VARCHAR2(10)
CONSTRAINT check2 CHECK (gender IN ('MALE','FEMALE'))
);

SELECT constraint_name, constraint_type, table_name, search_condition
FROM user_constraints
WHERE table_name = 'EX2_9';

--INSERT INTO EX2_9 VALUES (10, 'MAN'); <- 제약조건 위배

INSERT INTO EX2_9 VALUES (5,'FEMALE'); 

-- 21/05/18

-- 시간 컬럼의 DEFAULT 값을 명시해줌
CREATE TABLE EX2_10(
    Col1 VARCHAR2(10) NOT NULL,
    Col2 VARCHAR2(10) NULL,
    Create_date DATE DEFAULT SYSDATE);


INSERT INTO EX2_10 (Col1, Col2) VALUES ('AA','BB');

SELECT *
    FROM EX2_10;

-- 테이블 삭제 [CASCADE CONSTRAINTS] 생략 가능 <- 제약조건 삭제
--DROP TABLE EX2_10 [CASCADE CONSTRAINTS];

-- 컬럼 이름 바꾸기
--ALTER TABLE EX2_10 RENAME COLUMN COL1 TO COL11;
--AlTER TABLE  EX2_10 RENAME COLUMN Col11 TO Col1;

SELECT *
    FROM EX2_10;
    
-- 컬럼 내역 확인    
DESC EX2_10;

-- 컬럼 타입 변경
ALTER TABLE EX2_10 MODIFY COL2 VARCHAR2(30);

DESC EX2_10;

-- 컬럼 추가 
ALTER TABLE EX2_10 ADD COL3 NUMBER;

DESC EX2_10;

-- EX2_10 의 COL3 삭제
ALTER TABLE EX2_10 DROP COLUMN COL3;

DESC EX2_10;

-- COL1 에 PRIMARY KEY 제약조건 추가하기
ALTER TABLE EX2_10 ADD CONSTRAINT PK_EX2_10 PRIMARY KEY (COL1);

-- 확인
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
    FROM USER_CONSTRAINTS
    WHERE TABLE_NAME = 'EX2_10';

-- CO1의 제약조건 삭제 (PRAMARY KEY) 제약조건명이 존재하므로 추가나 삭제 모두 가능하다.   
ALTER TABLE EX2_10 DROP CONSTRAINT PK_EX2_10;

-- 확인
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
    FROM USER_CONSTRAINTS
    WHERE TABLE_NAME = 'EX2_10';

-- 테이블 복사 CREATE TABLE [테이블명] AS(~처럼) SELECT [COLUMN1,...]  FROM [복사할 테이블명]   
CREATE TABLE EX2_9_1 AS
SELECT *
    FROM EX2_9;

-- 5.21

SELECT a.employee_id, a.emp_name, a.department_id, b.department_name
 FROM employees a,
 departments b
 WHERE a.department_id = b.department_id;
 
 -- VIEW 만들기
  
 CREATE OR REPLACE VIEW EMP_DEPART_V1 AS
 SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.DEPARTMENT_ID,
 B.DEPARTMENT_NAME
 
 FROM EMPLOYEES A,
    DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;

-- 21.05.24

-- SYNONYM 삭제
DROP SYNONYM SYN_CHANNEL;

-- SYNONYM 생성
CREATE OR REPLACE SYNONYM SYN_CHANNEL
    FOR CHANNELS;

-- SYNONYM 조회
SELECT COUNT(*)
    FROM SYN_CHANNEL;

-- HR 사용자는 DEFAULT로 계정이 LOCK 이므로 UNLOCK
ALTER USER HR IDENTIFIED BY HR ACCOUNT UNLOCK;

-- HR 유저에게 SYN_CHANNEL에 대한 권한 부여
GRANT SELECT ON SYN_CHANNEL TO HR;

-- SYN_CHANNEL2 생성
CREATE OR REPLACE PUBLIC SYNONYM SYN_CHANNEL2
    FOR CHANNELS;

-- PUBLIC SYNONYM 삭제
DROP PUBLIC SYNONYM SYN_CHANNEL2;

CREATE SEQUENCE my_seq1
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000
NOCYCLE
NOCACHE;

DELETE EX2_8;

-- INSERT 1회
INSERT INTO EX2_8 (col1) VALUES (MY_SEQ1.NEXTVAL);
-- INSERT 2회 실행
INSERT INTO EX2_8 (col1) VALUES (MY_SEQ1.NEXTVAL);

SELECT *
    FROM EX2_8;

-- 해당 시퀀스의 현재 값 확인하기
SELECT MY_SEQ1.CURRVAL
FROM DUAL;
-- INSERT 3회 실행
INSERT INTO EX2_8 (COL1) VALUES (MY_SEQ1.NEXTVAL);

-- 테이블 확인
SELECT *
    FROM EX2_8;

-- 주의 NEXTVAL 사용시 INSERT문 외에 SELECT문에서도 값이 증가된다.

SELECT MY_SEQ1.NEXTVAL
FROM DUAL;

-- INSERT 4회 실행
INSERT INTO EX2_8 (COL1) VALUES (MY_SEQ1.NEXTVAL);

SELECT *
    FROM EX2_8;
-- INSERT문을 4번만 실행하였는데 4행의 COL1열의 값이 5가 됨을 볼 수 있다.

DROP SEQUENCE MY_SEQ1;

-- 예제 1
CREATE TABLE ORDERS(
    ORDER_ID NUMBER(12,0) PRIMARY KEY,
    ORDER_DATE DATE,
    ORDER_MODE VARCHAR2(8 BYTE) CONSTRAINT CHECK_ORDER_MODE CHECK (ORDER_MODE IN ('direct','online')),
    CUSTOMER_ID NUMBER(6,0),
    ORDER_STATUS NUMBER(2,0),
    ORDER_TOTAL NUMBER(8,2) DEFAULT 0,
    SALES_REP_ID NUMBER(6,0),
    PROMOTION_ID NUMBER(6,0)
);

-- 예제 2
CREATE TABLE ORDER_ITEMS(
    ORDER_ID NUMBER(12,0),
    LINE_ITEM_ID NUMBER(3,0),
    CONSTRAINT CHECK_ID PRIMARY KEY(ORDER_ID,LINE_ITEM_ID),
    PRODUCT_ID NUMBER(3,0),
    UNIT_PRICE NUMBER(8,2) DEFAULT 0,
    QUANTITY NUMBER(8,0) DEFAULT 0
);
-- DEFAULT 옵션 넣기(변경)
ALTER TABLE ORDER_ITEMS MODIFY (PRODUCT_ID DEFAULT 0);

--예제 3

CREATE TABLE PROMOTIONS(
    PROMO_ID NUMBER(6,0) PRIMARY KEY,
    PROMO_NAME VARCHAR2(20)
);

-- 최소 1 , 최대 99999999, 1000 시작, 1 증가, ORDER_SEQ 시퀸스 생성

CREATE SEQUENCE ORDERS_SEQ
    INCREMENT BY 1
    START WITH 1000
    MINVALUE 1
    MAXVALUE 99999999
    NOCYCLE
    NOCACHE;
    
--- SELECT 학습하기 ---


-- 사원 테이블에서 급여가 5000 이 넘는 사원번호와 사원명을 조회하기
SELECT EMPLOYEE_ID, EMP_NAME
FROM EMPLOYEES
WHERE SALARY > 5000

-- JOB_ID 가 IT_PROG AND 조건 추가
-- AND JOB_ID = 'IT_PROG'

-- JOB_ID 가 IT_PROG OR 조건 추가
OR  JOB_ID = 'IT_PROG'
ORDER BY EMPLOYEE_ID;  -- 사번으로 정렬해서 보기

-- 한 개 이상의 테이블에서 데이터를 조회하기

SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.DEPARTMENT_ID,
    B.DEPARTMENT_NAME AS DEP_NAME

FROM EMPLOYEES A,
    DEPARTMENTS B

WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;



-- 210525


CREATE TABLE EX3_1(
COL1 VARCHAR2(10),
COL2 NUMBER,
COL3 DATE
);

-- INSERT 학습하기

INSERT INTO EX3_1(COL3,COL1,COL2)
VALUES (SYSDATE, 'DEF', 20);

-- 실패 , 컬럼 값의 수와 순서, 데이터타입이 일치해야한다.
INSERT INTO EX3_1(COL1,COL2,COL3)
VALUES ('ABC', 10, 30);

-- 컬럼명 기술 생략 형태

-- 컬럼명을 생략하더라도 테이블 생성시 기술했던 컬럼 순서대로 값을 나열하면 가능
INSERT INTO EX3_1
VALUES ('GHI', 1, SYSDATE);


INSERT INTO EX3_1 (COL1,COL2)
VALUES ('GHI', 20);

-- 컬럼명을 기술하지 않음 == 테이블에 있는 모든 컬럼에 값을 입력
-- 총 3개의 컬럼이 있고 입력할 컬럼을 명시하지 않았으므로 2개 나열시 오류 발생
INSERT INTO EX3_1
VALUES ('GHI', 30);

-- INSERT ~ SELECT 형태

CREATE TABLE EX3_2(
    emp_id NUMBER,
    emp_name VARCHAR2(100)
);

-- 컬럼 순서와 데이터 타입을 맞춤
INSERT INTO EX3_2(emp_id, emp_name)
SELECT employee_id, emp_name
FROM employees
WHERE salary > 5000;

-- 데이터 타입을 맞추지 않았는데 INSERT 성공
-- 묵시적 형변환의 예시
INSERT INTO EX3_1 (col1,col2,col3)
VALUES (10,'10','2014-01-01');

SELECT *
FROM EX3_1;

UPDATE EX3_1
SET COL2 = 50;
