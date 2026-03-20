CREATE OR REPLACE TRIGGER trg_raw_sales_id
BEFORE INSERT ON raw_sales
FOR EACH ROW
BEGIN
    :NEW.id := seq_raw_sales.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER trg_stg_sales_id
BEFORE INSERT ON stg_sales
FOR EACH ROW
BEGIN
    :NEW.id := seq_stg_sales.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER trg_clean_sales_id
BEFORE INSERT ON clean_sales
FOR EACH ROW
BEGIN
    :NEW.id := seq_clean_sales.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER trg_etl_log_id
BEFORE INSERT ON etl_log
FOR EACH ROW
BEGIN
    :NEW.id := seq_etl_log.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER trg_etl_error_id
BEFORE INSERT ON etl_error_log
FOR EACH ROW
BEGIN
    :NEW.id := seq_etl_error_log.NEXTVAL;
END;
/