CREATE OR REPLACE VIEW vw_sales_by_day AS
SELECT
    sale_date,
    COUNT(*) AS sales_count,
    SUM(quantity) AS total_quantity,
    SUM(total_amount) AS total_sales_amount
FROM clean_sales
GROUP BY sale_date;

CREATE OR REPLACE VIEW vw_sales_by_product AS
SELECT
    product_name,
    COUNT(*) AS sales_count,
    SUM(quantity) AS total_quantity,
    SUM(total_amount) AS total_sales_amount
FROM clean_sales
GROUP BY product_name;

CREATE OR REPLACE VIEW vw_etl_error_summary AS
SELECT
    error_message,
    COUNT(*) AS error_count
FROM etl_error_log
GROUP BY error_message;

CREATE OR REPLACE VIEW vw_etl_run_summary AS
SELECT
    id,
    process_name,
    start_time,
    end_time,
    status,
    processed_count,
    error_count
FROM etl_log;