with flattened as (
    select 
        file_source,
        p.index + 1 as page,    
        p.value['content']::string as page_content_text,
        pt.index,
        pt.value,
        row_number() over(order by file_source, p.index, pt.index) as seq
    from TRANSFORM_DB.BASE.UNIONED_TCB_CREDIT,
    lateral flatten(input => content['pages']) as p,
    lateral split_to_table(page_content_text,'|') as pt
    order by file_source, page, seq
),
anchors as (
    select 
        file_source,
        case 
            when file_source = 'TCB_CREDIT_20250520' and value like '%Ghi nợ%' then seq 
            when file_source != 'TCB_CREDIT_20250520' and value like '%Diễn giải%' then seq
        else null end
        as anchor_index
    from flattened
    where anchor_index is not null
)
, data_rows as (
    select
        t.*,
        t.seq - a.anchor_index - 9 as offset_from_anchor
    from flattened t
    join anchors a 
        on t.seq >= a.anchor_index + 9 --has to be seq, not index
        and t.file_source = a.file_source
        
)
        
, numbered as (
    select
        file_source,
        page,
        page_content_text,
        index,
        value,
        seq,
        offset_from_anchor,
        case 
            -- special case
            when file_source = 'TCB_CREDIT_20250520' and page = 1 and mod(offset_from_anchor, 6) = 4 then 5
            when file_source = 'TCB_CREDIT_20250520' and page = 1 and mod(offset_from_anchor, 6) = 5 then 6
            when file_source = 'TCB_CREDIT_20250520' and page = 1 then mod(offset_from_anchor, 6)
            when file_source = 'TCB_CREDIT_20250520' and page = 2 and mod(index - 1, 6) < 5 then mod(index - 1, 6) - 1 
            when file_source = 'TCB_CREDIT_20250520' and page = 2 and mod(index - 1, 6) >= 5 then mod(index - 1, 6)
            --else
            when file_source != 'TCB_CREDIT_20250520' and page = 1 then mod(offset_from_anchor, 7) 
            when file_source != 'TCB_CREDIT_20250520' and page = 2 and mod(index - 1, 6) < 5 then mod(index - 1, 6) - 1 
            when file_source != 'TCB_CREDIT_20250520' and page = 2 and mod(index - 1, 6) >= 5 then mod(index - 1, 6)
        end 
            as col_pos, 
        row_number() over(partition by file_source, page, col_pos order by index) as record_num        
    from data_rows
    order by seq
)

, pivoted as (
select
    file_source,
    page,
    record_num,
    max(case when col_pos = 0 then value end) as transaction_date_tmp,
    max(case when col_pos = 1 then value end) as post_date_tmp,
    max(case when col_pos = 2 then value end) as original_amount_tmp,
    max(case when col_pos = 3 then value end) as debit_tmp,
    max(case when col_pos = 4 then value end) as credit_tmp,
    max(case when col_pos = 5 then value end) as description
    --ignore col 6
from numbered
group by all
order by 1,2,3
)
-- , final_result as (
select 
    file_source,
    page,
    record_num,
    -- transaction_date_tmp,
    interpolate_bfill(
        try_to_date(transaction_date_tmp, 'dd/mm/yyyy')) 
        over(partition by file_source, page order by record_num desc) as transaction_date,
    try_to_date(post_date_tmp, 'dd/mm/yyyy') as post_date,
    
    try_cast(replace(
        split(original_amount_tmp, ' ')[1]::string,
        ',','') as decimal(18,2))
        as original_amount,
    split(original_amount_tmp, ' ')[2]::string as original_curr,
    coalesce(case when description ilike '%the tin dung%' or description ilike '%merchandi%return%' or description ilike '%tindung%' or description ilike '%tín dụng%'then 0
        else try_cast(replace(debit_tmp, ',', '') as decimal(18,2)) end,0) as debit,
    coalesce(case when description ilike '%the tin dung%' or description ilike '%merchandi%return%' or description ilike '%tindung%' or description ilike '%tín dụng%'then 
        coalesce(try_cast(replace(credit_tmp, ',', '') as decimal(18,2)), original_amount)
        else try_cast(replace(credit_tmp, ',', '') as decimal(18,2)) end,0) as credit,
    description
from pivoted 
where post_date is not null
order by 1,2,3
)
-- select * from flattened
-- select * from anchors
-- select * from data_rows
-- select * from numbered
-- select * from pivoted 
-- select * from final_result
-- where file_source = 'TCB_CREDIT_20251218';


, test as (
select 
    f.file_source,
    try_cast(replace(f.paper_debit, ',','') as decimal(18,2)) as debit,
    try_cast(replace(f.paper_credit, ',','') as decimal(18,2)) as credit,
    sum(fr.debit) as sql_debit, 
    sum(fr.credit) as sql_credit,
from raw_db.audit_files.tcb_credit_balance as f
left join final_result as fr using (file_source)
group by all
order by 1
)
select * ,
    debit - sql_debit as diff_dr,
    credit - sql_credit as diff_cr
from test
where diff_dr !=0 or diff_cr != 0
