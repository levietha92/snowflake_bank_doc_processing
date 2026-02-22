    
select * from TRANSFORM_DB.INT.HISTORY_VIB_BS
--wrong results
    where file_source  = 'VIB_IMG_5284'
    -- where file_source  = 'VIB_IMG_5288'
    -- where file_source  = 'VIB_IMG_5289'
    -- where file_source = 'VIB_IMG_5294'
    -- where file_source = 'VIB_IMG_5296'
    -- where file_source = 'VIB_IMG_5299'
    
;
SELECT AI_PARSE_DOCUMENT (
    TO_FILE('@"RAW_DB"."PDF"."VIB_HISTORY_STAGE"','IMG_5284.jpeg'),
    {'mode': 'LAYOUT', 'page_split': false}) AS content;

SELECT AI_PARSE_DOCUMENT (
    TO_FILE('@"RAW_DB"."PDF"."VIB_HISTORY_STAGE"','IMG_5288.jpeg'),
    {'mode': 'LAYOUT', 'page_split': false}) AS content;    

SELECT AI_PARSE_DOCUMENT (
    TO_FILE('@"RAW_DB"."PDF"."VIB_HISTORY_STAGE"','IMG_5288.jpeg'),
    {'mode': 'LAYOUT', 'page_split': false}) AS content;

SELECT AI_PARSE_DOCUMENT ( --keep running for very long time
    TO_FILE('@"RAW_DB"."PDF"."VIB_HISTORY_STAGE"','IMG_5289.jpeg'),
    {'mode': 'LAYOUT', 'page_split': false}) AS content;    

SELECT AI_PARSE_DOCUMENT (
    TO_FILE('@"RAW_DB"."PDF"."VIB_HISTORY_STAGE"','IMG_5294.jpeg'),
    {'mode': 'LAYOUT', 'page_split': false}) AS content;

SELECT AI_PARSE_DOCUMENT (
    TO_FILE('@"RAW_DB"."PDF"."TCB_HISTORY_STAGE"','IMG_5114.jpeg'),
    {'mode': 'LAYOUT', 'page_split': false}) AS content;    