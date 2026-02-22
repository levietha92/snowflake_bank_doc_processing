with unioned as (
select 'VIB_IMG_5293' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5293 union all  --1  

            select 'VIB_IMG_5292' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5292 union all  --2  

            select 'VIB_IMG_5286' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5286 union all  --3  

            select 'VIB_IMG_5305' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5305 union all  --4  

            select 'VIB_IMG_5303' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5303 union all  --5  

            select 'VIB_IMG_5304' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5304 union all  --6  

            select 'VIB_IMG_5298' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5298 union all  --7  

            select 'VIB_IMG_5302' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5302 union all  --8  

            select 'TCB_IMG_5075' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5075 union all  --9  

            select 'TCB_IMG_5072' as file_source, content::string as content    
            from RAW_DB.PDF.TCB_IMG_5072 union all  --10  

            select 'TCB_IMG_5102' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5102 union all  --11  

            select 'TCB_IMG_5099' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5099 union all  --12  

            select 'TCB_IMG_5088' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5088 union all  --13  

            select 'TCB_IMG_5077' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5077 union all  --14  

            select 'TCB_IMG_5089' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5089 union all  --15  

            select 'VIB_IMG_5283' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5283 union all  --16  

            select 'VIB_IMG_5301' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5301 union all  --17  

            select 'VIB_IMG_5282' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5282 union all  --18  

            select 'TCB_IMG_5076' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5076 union all  --19  

            select 'TCB_IMG_5084' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5084 union all  --20  

            select 'TCB_IMG_5085' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5085 union all  --21  

            select 'TCB_IMG_5086' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5086 union all  --22  

            select 'TCB_IMG_5110' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5110 union all  --23  

            select 'TCB_IMG_5094' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5094 union all  --24  

            select 'VIB_IMG_5297' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5297 union all  --25  

            select 'VIB_IMG_5287' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5287 union all  --26  

            select 'VIB_IMG_5300' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5300 union all  --27  

            select 'VIB_IMG_5289' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5289 union all  --28  

            select 'TCB_IMG_5083' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5083 union all  --29  

            select 'TCB_IMG_5104' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5104 union all  --30  

            select 'TCB_IMG_5111' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5111 union all  --31  

            select 'TCB_IMG_5120' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5120 union all  --32  

            select 'TCB_IMG_5087' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5087 union all  --33  

            select 'TCB_IMG_5105' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5105 union all  --34  

            select 'TCB_IMG_5081' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5081 union all  --35  

            select 'VIB_IMG_5295' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5295 union all  --36  

            select 'VIB_IMG_5285' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5285 union all  --37  

            select 'TCB_IMG_5073' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5073 union all  --38  

            select 'TCB_IMG_5091' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5091 union all  --39  

            select 'TCB_IMG_5079' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5079 union all  --40  

            select 'TCB_IMG_5113' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5113 union all  --41  

            select 'TCB_IMG_5109' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5109 union all  --42  

            select 'TCB_IMG_5106' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5106 union all  --43  

            select 'VIB_IMG_5290' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5290 union all  --44  

            select 'VIB_IMG_5284' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5284 union all  --45  

            select 'VIB_IMG_5294' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5294 union all  --46  

            select 'VIB_IMG_5291' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5291 union all  --47  

            select 'VIB_IMG_5296' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5296 union all  --48  

            select 'TCB_IMG_5103' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5103 union all  --49  

            select 'TCB_IMG_5112' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5112 union all  --50  

            select 'TCB_IMG_5096' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5096 union all  --51  

            select 'TCB_IMG_5090' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5090 union all  --52  

            select 'TCB_IMG_5098' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5098 union all  --53  

            select 'TCB_IMG_5108' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5108 union all  --54  

            select 'TCB_IMG_5118' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5118 union all  --55  

            select 'TCB_IMG_5095' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5095 union all  --56  

            select 'TCB_IMG_5115' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5115 union all  --57  

            select 'TCB_IMG_5093' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5093 union all  --58  

            select 'TCB_IMG_5078' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5078 union all  --59  

            select 'TCB_IMG_5116' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5116 union all  --60  

            select 'VIB_IMG_5299' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5299 union all  --61  

            select 'VIB_IMG_5281' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5281 union all  --62  

            select 'VIB_IMG_5306' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5306 union all  --63  

            select 'VIB_IMG_5288' as file_source, content::string as content  
            from RAW_DB.PDF.VIB_IMG_5288 union all  --64  

            select 'TCB_IMG_5082' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5082 union all  --65  

            select 'TCB_IMG_5100' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5100 union all  --66  

            select 'TCB_IMG_5117' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5117 union all  --67  

            select 'TCB_IMG_5119' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5119 union all  --68  

            select 'TCB_IMG_5097' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5097 union all  --69  

            select 'TCB_IMG_5092' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5092 union all  --70  

            select 'TCB_IMG_5107' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5107 union all  --71  

            select 'TCB_IMG_5114' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5114 union all  --72  

            select 'TCB_IMG_5080' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5080 union all  --73  

            select 'TCB_IMG_5101' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5101 union all  --74  

            select 'TCB_IMG_5074' as file_source, content::string as content  
            from RAW_DB.PDF.TCB_IMG_5074  --75
        )
            select 
            file_source,
            try_parse_json(content) as content
        
            from unioned