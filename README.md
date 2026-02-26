# Bank docs processing with Snowflake

## Intro
🌟 A repo for:
1. setting up objects
2. using AI_PARSE_DOCUMENT function to parse bank and credits statements (PDF, JPEG) to text output, batch processing.
3. transforming text output into **structured** table form per original documents.


## Scope

- TCB credit statement and bank statement
- VIB bank statement

👆This matters because at step 3, the transformation logic heavily depends on the structured table format. So if you want to use the script for other bank formats, you would need to modify the transformation logic:

- number of columns, denoted by fields `col_pos` or `position_in_group`
- naming of columns
- how to detect the first record value correctly


## How to use this
- Have a Snowflake instance
- Clone the repo into Snowflake's workspace (you can refer to [01-setup.sql](https://github.com/levietha92/snowflake_bank_doc_processing/blob/08d911a5c5aa26093886054ba6ae70a87cc90cc3/01-setup.sql)) for relevant integration setup step.
- Start running the other scripts in sequential order.
    - [02-historical_parse.ipynb](https://github.com/levietha92/snowflake_bank_doc_processing/blob/face63af6309d0760a820c7485007221476a28c6/02-historical_parse.ipynb): use this for batch processing VIB and TCB "sao ke giao dich" documents. The script's default is on JPEG type.
    - [03-tcb_credit_stmt.ipynb](https://github.com/levietha92/snowflake_bank_doc_processing/blob/e5111a72ac65895424b0ac5fbc0e3c94387c3274/03-tcb_credit_stmt.ipynb): use this for batch processing TCB credit statement PDF files. 
    
    🔴 Please note that TCB's credit statement formats may vary between:
    - the ones the bank sends via email (Password encrypted recently)
    - vs. the ones the bank sends via email prior to Password encryption
    - vs. the one you download directly via mobile app

    You should decrypt the PDFs before loading to Snowflake stage. Recommend using [qpdf](https://qpdf.readthedocs.io/en/stable/cli.html) for decryption in batch.


## Alternatives

1. Why not use Document AI in Snowflake?
- I tried this, but Snowflake is deprecating this feature by end of Feb 2026.

2. Why not use AI_EXTRACT in Snowflake?
- Will try if it's kept GA for more than 6 months.

3. Why not 🐍 python?
- Been there tried that 🙃. Some python packages out there are really helpful and gave me a good start, but as time goes on, maintaining and adjusting and customizing the script to accommodate for bank's (table) 🫨 *monthly / quarterly* 🫨 format changes is a big pain. Not to mention the big hurdle of solving OCR and line-less PDFs.
