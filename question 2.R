library(DBI)
library(RPostgres)

# --- Define Credentials ---
# Replace with your actual credentials from Brightspace
cred <- list(
  host = "159.223.30.236",
  port = "6432",
  dbname = "user59db",
  user = "user59",     # <--- FILL THIS IN
  pass = "dbmng_dv_59"      # <--- FILL THIS IN
)

# --- 1. Create Schema and Table ---
# We use psql_manipulate for DDL (Data Definition Language) commands

# Create Schema
psql_manipulate(cred, "CREATE SCHEMA IF NOT EXISTS marketing;")

# Create Table
# [cite_start]- campaign_id: SERIAL (autoincrementing integer) and PRIMARY KEY [cite: 28]
# [cite_start]- campaign_name: TEXT [cite: 39]
# [cite_start]- budget: DECIMAL(6,1) [cite: 40]
# [cite_start]- start_date: TIMESTAMP [cite: 41]
# [cite_start]- is_active: BOOLEAN [cite: 42]

create_table_query <- "
CREATE TABLE IF NOT EXISTS marketing.marketing_campaign (
    campaign_id SERIAL PRIMARY KEY,
    campaign_name TEXT,
    budget DECIMAL(6,1),
    start_date TIMESTAMP,
    is_active BOOLEAN
);
"
psql_manipulate(cred, create_table_query)


# --- 2. Create Data Frame and Insert Data ---
# [cite_start]Create the dataframe [cite: 29, 30]
marketing_df <- data.frame(
  campaign_name = "Holiday Sale Campaign",
  budget = 5000,
  # [cite_start]Convert string to timestamp as hinted [cite: 31, 32]
  start_date = as.POSIXct("2024-12-01 08:00:00.00", format = "%Y-%m-%d %H:%M:%S"),
  is_active = TRUE # 1 maps to TRUE for Boolean
)

# Insert the dataframe
# Note: psql_append_df takes schema_name and tab_name separately
psql_append_df(cred, "marketing", "marketing_campaign", marketing_df)