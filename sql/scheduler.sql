BEGIN
    DBMS_SCHEDULER.DROP_JOB(
        job_name => 'ETL_PIPELINE_JOB',
        force => TRUE
    );
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'ETL_PIPELINE_JOB',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN etl_pkg.run_full_pipeline; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY;BYHOUR=8;BYMINUTE=0;BYSECOND=0',
        enabled         => TRUE,
        comments        => 'Daily ETL pipeline job'
    );
END;
/