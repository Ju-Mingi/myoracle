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
