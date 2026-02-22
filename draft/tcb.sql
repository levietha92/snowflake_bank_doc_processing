
with joined as (
    select *,
        'TCB' as from_where,
    from transform_db.int.UNIONED_HISTORICAL_PDF
    where file_source like 'TCB%'
),
cleansed as (
    select
        from_where,
        file_source,
        index,
        mod(index - 1, 11) as position_in_group,
        value,
        row_number() over(partition by file_source, position_in_group order by index) as record_group
    from joined,
    lateral split_to_table(content['content']::string,'|')
    order by file_source,index 
),
-- select * from cleansed;
transformed_data AS (
    SELECT 
        file_source,
        record_group,
        MAX(CASE WHEN position_in_group = 1 THEN trim(value) END) AS transaction_date,
        MAX(CASE WHEN position_in_group = 2 THEN trim(value) END) AS remitter,
        MAX(CASE WHEN position_in_group = 3 THEN trim(value) END) AS remitter_bank,
        MAX(CASE WHEN position_in_group = 4 THEN trim(value) END) AS details,
        MAX(CASE WHEN position_in_group = 5 THEN trim(value) END) AS transaction_no,
        MAX(CASE WHEN position_in_group = 6 THEN trim(value) END) AS debit,
        MAX(CASE WHEN position_in_group = 7 THEN trim(value) END) AS credit,
        MAX(CASE WHEN position_in_group = 8 THEN trim(value) END) AS fee_interest,
        MAX(CASE WHEN position_in_group = 9 THEN trim(value) END) AS tax,
        MAX(CASE WHEN position_in_group = 10 THEN trim(value) END) AS balance
    from cleansed
    group by all    
)
-- select * from transformed_data order by file_source, record_group ;
, final_result as (
select 
    file_source,
    record_group,
    try_to_date(transaction_date, 'dd/mm/yyyy') AS transaction_date,
    remitter,
    remitter_bank,
    details,
    transaction_no,
    TRY_CAST(REPLACE(debit, ',', '') AS DECIMAL(18,2)) AS debit,
    TRY_CAST(REPLACE(credit, ',', '') AS DECIMAL(18,2)) AS credit,
    TRY_CAST(REPLACE(fee_interest, ',', '') AS DECIMAL(18,2)) AS fee_interest,
    TRY_CAST(REPLACE(tax, ',', '') AS DECIMAL(18,2)) AS tax,
    TRY_CAST(REPLACE(balance, ',', '') AS DECIMAL(18,2)) AS balance,
    row_number() over(order by file_source,record_group) AS record_sequence
from transformed_data 
order by file_source, record_group 
)
-- select * from final_result
-- select count(distinct file_source) from final_result
-- where transaction_date is not null --623 records, missing 1 page
-- where  (debit is not null or credit is not null)
-- where balance is not null
-- where file_source in ('TCB_IMG_5114','TCB_IMG_5116');

-- ;

select 
    h.* exclude(seq),
    count(fr.file_source) as row_count,
    h.manual_row_count - row_count as diff
from raw_db.pdf.history_manual_row_count as h
left join final_result as fr using (file_source)
where file_source like 'TCB%'
and balance is not null
group by all
order by 1

;
 select *,
        'TCB' as from_where
    from TRANSFORM_DB.INT.UNIONED_HISTORICAL_PDF
    where file_source like 'TCB%'
;