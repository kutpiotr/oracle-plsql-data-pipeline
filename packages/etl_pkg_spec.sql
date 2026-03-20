CREATE OR REPLACE PACKAGE etl_pkg AS

    PROCEDURE load_to_staging;

    PROCEDURE validate_staging_data;

    PROCEDURE log_errors;

    PROCEDURE load_clean_data;

    PROCEDURE run_full_pipeline;

END etl_pkg;
/