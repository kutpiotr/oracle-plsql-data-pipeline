PROMPT === RUN ETL PIPELINE ===

BEGIN
    etl_pkg.run_full_pipeline;
END;
/

PROMPT === TEST 1: COUNT OF VALID RECORDS IN CLEAN_SALES ===
SELECT COUNT(*) AS clean_sales_count
FROM clean_sales;

PROMPT === TEST 2: COUNT OF INVALID RECORDS IN ETL_ERROR_LOG ===
SELECT COUNT(*) AS error_log_count
FROM etl_error_log;

PROMPT === TEST 3: STATUS DISTRIBUTION IN STG_SALES ===
SELECT status, COUNT(*) AS record_count
FROM stg_sales
GROUP BY status
ORDER BY status;

PROMPT === TEST 4: ETL LOG ENTRIES ===
SELECT id, process_name, status, processed_count, error_count
FROM etl_log
ORDER BY id;

PROMPT === TEST 5: SAMPLE VALID RECORDS ===
SELECT id, product_name, quantity, price, total_amount
FROM clean_sales
ORDER BY id;

PROMPT === TEST 6: SAMPLE ERROR RECORDS ===
SELECT id, raw_id, error_message
FROM etl_error_log
ORDER BY id;