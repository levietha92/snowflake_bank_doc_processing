    
with joined as (
    select *,
        'VIB' as from_where
    from TRANSFORM_DB.INT.UNIONED_HISTORICAL_PDF
    where file_source like 'VIB%'
)
-- select * from joined;
,cleansed as (
    select
        from_where,
        file_source,
        index,
        mod(index - 1, 10) as position_in_group,
        value,
        row_number() over(partition by file_source, position_in_group order by index) as record_group
    from joined,
    lateral split_to_table(content['content']::string,'|')
    order by file_source,index 
)
-- select * from cleansed;
,transformed_data AS (
    SELECT 
        file_source,
        record_group,
        MAX(CASE WHEN position_in_group = 1 THEN trim(value) END) AS seq_no,
        MAX(CASE WHEN position_in_group = 2 THEN trim(value) END) AS transaction_date,
        MAX(CASE WHEN position_in_group = 3 THEN trim(value) END) AS effective_date,
        MAX(CASE WHEN position_in_group = 4 THEN trim(value) END) AS transaction_type,
        MAX(CASE WHEN position_in_group = 5 THEN trim(value) END) AS cheque_ref,
        MAX(CASE WHEN position_in_group = 6 THEN trim(value) END) AS debit,
        MAX(CASE WHEN position_in_group = 7 THEN trim(value) END) AS credit,
        MAX(CASE WHEN position_in_group = 8 THEN trim(value) END) AS balance,
        MAX(CASE WHEN position_in_group = 9 THEN trim(value) END) AS description,
    from cleansed
    group by all
    
)
-- select * from transformed_data order by file_source, record_group ;
, casting as (
select 
    file_source,
    record_group,
    row_number() over(order by record_group) AS record_sequence,
    try_to_decimal(seq_no) as seq_no, --removed the TK doi ung texts
    try_to_date(transaction_date, 'dd/mm/yyyy') AS transaction_date,
    try_to_date(effective_date, 'dd/mm/yyyy') AS effective_date,
    case when len(transaction_type) = 0 then null else transaction_type end as transaction_type,
    case when len(description) = 0 then null else description end as description,
    TRY_CAST(REPLACE(debit, ',', '') AS DECIMAL(18,2)) AS debit,
    TRY_CAST(REPLACE(credit, ',', '') AS DECIMAL(18,2)) AS credit,
    TRY_CAST(REPLACE(balance, ',', '') AS DECIMAL(18,2)) AS balance,
    
from transformed_data
-- where len(seq_no) = 10 
order by file_source, record_group
)
-- select * from casting;

, ffill as (
select
    file_source,
    record_group,
    record_sequence,
    interpolate_ffill(seq_no) over(partition by file_source order by record_group) as seq_no,
    interpolate_ffill(transaction_date) over(partition by file_source order by record_group)  as transaction_date,
    interpolate_ffill(effective_date) over(partition by file_source order by record_group)  as effective_date,
    interpolate_ffill(transaction_type) over(partition by file_source order by record_group)  as transaction_type,
    description,
    interpolate_ffill(debit) over(partition by file_source order by record_group)  as debit,
    interpolate_ffill(credit) over(partition by file_source order by record_group)  as credit,
    interpolate_ffill(balance) over(partition by file_source order by record_group)  as balance,
    
from casting 
order by file_source, seq_no 
)
-- select * from ffill;
select
    file_source,
    listagg(record_group, ',') as record_group_agg,
    listagg(record_sequence, ',') as record_sequence_agg,
    seq_no,
    transaction_date,
    effective_date,
    transaction_type,
    listagg(description, ' ') as description,
    debit,
    credit,
    balance
    
from ffill
group by all
order by file_source, seq_no

;

