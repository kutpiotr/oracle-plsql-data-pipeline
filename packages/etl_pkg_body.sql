CREATE OR REPLACE PACKAGE BODY etl_pkg AS

    PROCEDURE load_to_staging IS
    BEGIN
        DELETE FROM stg_sales;

        INSERT INTO stg_sales (
            product_name,
            quantity,
            price,
            sale_date,
            load_date,
            status
        )
        SELECT
            product_name,
            quantity,
            price,
            sale_date,
            SYSDATE,
            'NEW'
        FROM raw_sales;
    END load_to_staging;

    PROCEDURE validate_staging_data IS
    BEGIN
        UPDATE stg_sales
        SET status = 'INVALID'
        WHERE product_name IS NULL
           OR quantity IS NULL
           OR quantity <= 0
           OR price IS NULL
           OR price <= 0
           OR sale_date IS NULL;

        UPDATE stg_sales
        SET status = 'VALID'
        WHERE product_name IS NOT NULL
          AND quantity IS NOT NULL
          AND quantity > 0
          AND price IS NOT NULL
          AND price > 0
          AND sale_date IS NOT NULL;
    END validate_staging_data;

    PROCEDURE log_errors IS
    BEGIN
        DELETE FROM etl_error_log;

        INSERT INTO etl_error_log (
            raw_id,
            error_message,
            created_at
        )
        SELECT
            r.id,
            CASE
                WHEN r.product_name IS NULL THEN 'Missing product name'
                WHEN r.quantity IS NULL THEN 'Missing quantity'
                WHEN r.quantity <= 0 THEN 'Quantity must be greater than 0'
                WHEN r.price IS NULL THEN 'Missing price'
                WHEN r.price <= 0 THEN 'Price must be greater than 0'
                WHEN r.sale_date IS NULL THEN 'Missing sale date'
                ELSE 'Unknown validation error'
            END,
            SYSDATE
        FROM raw_sales r
        WHERE r.product_name IS NULL
           OR r.quantity IS NULL
           OR r.quantity <= 0
           OR r.price IS NULL
           OR r.price <= 0
           OR r.sale_date IS NULL;
    END log_errors;

    PROCEDURE load_clean_data IS
    BEGIN
        DELETE FROM clean_sales;

        INSERT INTO clean_sales (
            product_name,
            quantity,
            price,
            total_amount,
            sale_date,
            created_at
        )
        SELECT
            product_name,
            quantity,
            price,
            quantity * price,
            sale_date,
            SYSDATE
        FROM stg_sales
        WHERE status = 'VALID';
    END load_clean_data;

    PROCEDURE run_full_pipeline IS
        v_log_id NUMBER;
        v_processed_count NUMBER;
        v_error_count NUMBER;
    BEGIN
        INSERT INTO etl_log (
            process_name,
            start_time,
            status,
            processed_count,
            error_count
        )
        VALUES (
            'FULL_ETL_PIPELINE',
            SYSDATE,
            'STARTED',
            0,
            0
        )
        RETURNING id INTO v_log_id;

        load_to_staging;
        validate_staging_data;
        log_errors;
        load_clean_data;

        SELECT COUNT(*)
        INTO v_processed_count
        FROM clean_sales;

        SELECT COUNT(*)
        INTO v_error_count
        FROM etl_error_log;

        UPDATE etl_log
        SET end_time = SYSDATE,
            status = 'SUCCESS',
            processed_count = v_processed_count,
            error_count = v_error_count
        WHERE id = v_log_id;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            UPDATE etl_log
            SET end_time = SYSDATE,
                status = 'FAILED'
            WHERE id = v_log_id;

            COMMIT;
            RAISE;
    END run_full_pipeline;

END etl_pkg;
/