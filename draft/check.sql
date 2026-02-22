SELECT distinct
    metadata$filename as file_name,
    metadata$file_last_modified as file_last_modified,
    'VIB_HISTORY_STAGE' as from_where,
    split_part(file_name, '.',1) as table_name
FROM @"RAW_DB"."PDF"."VIB_HISTORY_STAGE"
union all
SELECT distinct
    metadata$filename as file_name,
    metadata$file_last_modified as file_last_modified,
    'TCB_HISTORY_STAGE' as from_where,
    split_part(file_name, '.',1) as table_name
FROM @"RAW_DB"."PDF"."TCB_HISTORY_STAGE"
;
select count(distinct file_source) from TRANSFORM_DB.INT.UNIONED_HISTORICAL_PDF
;
select 'VIB_HISTORY_STAGE' as from_where, count(distinct file_source) as file_count 
    from TRANSFORM_DB.INT.HISTORY_VIB_BS
    union all
    select 'TCB_HISTORY_STAGE' as from_where, count(distinct file_source) as file_count 
    from TRANSFORM_DB.INT.HISTORY_TCB_BS
;

SELECT AI_PARSE_DOCUMENT (
            TO_FILE('@"RAW_DB"."PDF"."VIB_HISTORY_STAGE"/IMG_5281.jpeg'),
            {'mode': 'LAYOUT', 'page_split': false}) AS content;

SELECT AI_PARSE_DOCUMENT (
            TO_FILE('@"RAW_DB"."PDF"."TCB_HISTORY_STAGE"/IMG_5072.jpeg'),
            {'mode': 'LAYOUT', 'page_split': false})::object AS content;            



select count(*) from raw_db.information_schema.tables
where table_name like 'TCB%' or table_name like 'VIB%'

;

select file_source, count(*) as sql_records 
from TRANSFORM_DB.INT.HISTORY_VIB_BS
group by 1
union all
select file_source, count(*) as sql_records 
from TRANSFORM_DB.INT.HISTORY_TCB_BS
group by 1

;
REMOVE '@"RAW_DB"."PDF"."TCB_HISTORY_STAGE"/IMG_5072.jpg';