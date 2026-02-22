create table RAW_DB.PDF.TCB_CREDIT_20251020 as (
select AI_PARSE_DOCUMENT (
            TO_FILE('@"RAW_DB"."PDF"."TCB_CREDIT_STAGE"/19735078602016_20251020_16012324880950.pdf'),
            {'mode': 'LAYOUT', 'page_split': true}) as content
);
create table RAW_DB.PDF.TCB_CREDIT_20251120 as (            
select AI_PARSE_DOCUMENT (
            TO_FILE('@"RAW_DB"."PDF"."TCB_CREDIT_STAGE"/19735078602016_20251120_16012324880950.pdf'),
            {'mode': 'LAYOUT', 'page_split': true}) as content
          
);

with flattened as ( --466 rows
    select 
        '20251120' as file_source,
        p.index + 1 as page,    
        p.value['content']::string as page_content_text,
        pt.index,
        pt.value,
        row_number() over(order by p.index, pt.index) as seq
    from RAW_DB.PDF.TCB_CREDIT_20251020,
    lateral flatten(input => content['pages']) as p,
    lateral split_to_table(page_content_text,'|') as pt
    -- where pt.value not ilike '%content%'
    order by seq
),
anchors as (
    select 
        file_source,
        seq as anchor_index
    from flattened
    where value like '%Diễn giải%'
)
-- select * from anchors;
, data_rows as (
    select
        t.*,
        t.seq - a.anchor_index - 9 as offset_from_anchor
    from flattened t
    join anchors a 
        on t.seq >= a.anchor_index + 9 --has to be seq, not index
        and t.file_source = a.file_source
        
)
-- select * from data_rows ;
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
            -- col 0 to 5 are valid
            when page = 1 then mod(offset_from_anchor, 7) 
            -- page 2 onwards fails to read the "credit" column, col 1 to 5 are valid, but need shifting to match with page 1
            else 
                case when mod(index - 1, 6) < 5 then mod(index - 1, 6) - 1 else mod(index - 1, 6) end 
        end as col_pos, 
        row_number() over(partition by page, col_pos order by index) as record_num        
    from data_rows
    order by seq
)
-- select * from numbered;
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
    try_cast(replace(debit_tmp, ',', '') as decimal(18,2)) as debit,
    try_cast(replace(credit_tmp, ',', '') as decimal(18,2)) as credit,
    description
from pivoted 
where post_date is not null
order by 1,2,3

;

