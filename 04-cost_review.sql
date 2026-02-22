--this needs revision
select * from snowflake.account_usage.document_ai_usage_history; --outdated
select * from snowflake.account_usage.cortex_document_processing_usage_history; 
select 
    warehouse_name,
    sum(credits_used) as credits_used
from snowflake.account_usage.warehouse_metering_history --21.2, 
group by 1
;
select
    qh.warehouse_name,
    -- qh.warehouse_size,
    qh.is_client_generated_statement,
    sum(qh.total_elapsed_time) total_elapsed_time,
    sum(qah.credits_attributed_compute) credits_attributed_compute,
    sum(qah.credits_used_query_acceleration) credits_used_query_acceleration
from snowflake.account_usage.query_history as qh
left join snowflake.account_usage.query_attribution_history as qah
    on qh.query_id = qah.query_id    
group by all