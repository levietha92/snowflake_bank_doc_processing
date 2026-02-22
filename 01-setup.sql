-- Setting up Github integration
USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE API INTEGRATION my_github_oauth_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com')
  API_USER_AUTHENTICATION = (TYPE = SNOWFLAKE_GITHUB_APP)
  ENABLED = TRUE;

-- Grant access to the role(s) that will use it
GRANT USAGE ON INTEGRATION my_github_oauth_integration TO ROLE PUBLIC;

-- 3. Create the Git repository object in Snowflake
USE DATABASE RAW_DB;
USE SCHEMA PUBLIC;
CREATE OR REPLACE GIT REPOSITORY my_repo
  API_INTEGRATION = my_github_oauth_integration
  ORIGIN = 'https://github.com/levietha92/snowflake_bank_doc_processing.git';