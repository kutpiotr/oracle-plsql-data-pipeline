CREATE TABLE raw_sales (
id NUMBER PRIMARY KEY,
source_system VARCHAR2(50),
product_name VARCHAR2(100),
quantity NUMBER,
price NUMBER(10,2),
sale_date DATE,
created_at DATE DEFAULT SYSDATE
);

CREATE TABLE stg_sales (
id NUMBER PRIMARY KEY,
raw_id NUMBER,
product_name VARCHAR2(100),
quantity NUMBER,
price NUMBER(10,2),
sale_date DATE,
load_date DATE DEFAULT SYSDATE,
status VARCHAR2(20),
CONSTRAINT fk_stg_raw FOREIGN KEY (raw_id) REFERENCES raw_sales(id)
);

CREATE TABLE clean_sales (
id NUMBER PRIMARY KEY,
stg_id NUMBER,
product_name VARCHAR2(100) NOT NULL,
quantity NUMBER NOT NULL,
price NUMBER(10,2) NOT NULL,
total_amount NUMBER(12,2) NOT NULL,
sale_date DATE NOT NULL,
created_at DATE DEFAULT SYSDATE,
CONSTRAINT fk_clean_stg FOREIGN KEY (stg_id) REFERENCES stg_sales(id)
);

CREATE TABLE etl_log (
id NUMBER PRIMARY KEY,
process_name VARCHAR2(100),
start_time DATE,
end_time DATE,
status VARCHAR2(20),
processed_count NUMBER,
error_count NUMBER,
message VARCHAR2(4000)
);

CREATE TABLE etl_error_log (
id NUMBER PRIMARY KEY,
raw_id NUMBER,
stg_id NUMBER,
error_message VARCHAR2(4000),
created_at DATE DEFAULT SYSDATE
);
