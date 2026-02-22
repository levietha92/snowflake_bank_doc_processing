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

;

SELECT distinct
        metadata$filename as file_name,
        metadata$file_last_modified as file_last_modified,
        'TCB_CREDIT_' || split(file_name, '_')[1]::string as table_name
    -- FROM @"{DATABASE}"."{SCHEMA}"."{VIB_STAGE}"
    from @"RAW_DB"."PDF"."TCB_CREDIT_STAGE"

;
ALTER TABLE RAW_DB.PDF.HISTORY_MANUAL_ROW_COUNT RENAME TO RAW_DB.AUDIT_FILES.HISTORY_MANUAL_ROW_COUNT;
ALTER TABLE TRANSFORM_DB.INT.UNIONED_HISTORICAL_PDF RENAME TO TRANSFORM_DB.BASE.UNIONED_HISTORICAL_PDF;
ALTER TABLE TRANSFORM_DB.INT.UNIONED_TCB_CREDIT RENAME TO TRANSFORM_DB.BASE.UNIONED_TCB_CREDIT;
ALTER TABLE TRANSFORM_DB.INT.CHECK_ROW_COUNT_RESULT RENAME TO TRANSFORM_DB.AUDIT_FILES.CHECK_ROW_COUNT_HISTORY_BS;