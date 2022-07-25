
Goal: In the Query Editor, create a new permanent table that stores all the transactions with revenue for August 1st, 2017.

Use the below rules as a guide:

Create a new table in your ecommerce dataset titled revenue_transactions_20170801. Replace the table if it already exists.

Source your raw data from the data-to-insights.ecommerce.all_sessions_raw table.

Divide the revenue field by 1,000,000 and store it as a FLOAT64 instead of an INTEGER.

Only include transactions with revenue in your final table (hint: use a WHERE clause).

Only include transactions on 20170801.

Include these fields:

fullVisitorId as a REQUIRED string field.
visitId as a REQUIRED string field (hint: you will need to type convert).
channelGrouping as a REQUIRED string field.
totalTransactionRevenue as a FLOAT64 field.
Add short descriptions for the above four fields by referring to the schema.

Be sure to deduplicate records that have the same fullVisitorId and visitId (hint: use DISTINCT).















#standardSQL
# copy one day of ecommerce data to explore
CREATE OR REPLACE TABLE ecommerce.revenue_transactions_20170801
#schema
(
  fullVisitorId STRING NOT NULL OPTIONS(description="Unique visitor ID"),
  visitId STRING NOT NULL OPTIONS(description="ID of the session, not unique across all users"),
  channelGrouping STRING NOT NULL OPTIONS(description="Channel e.g. Direct, Organic, Referral..."),
  totalTransactionRevenue FLOAT64 NOT NULL OPTIONS(description="Revenue for the transaction")
)
 OPTIONS(
   description="Revenue transactions for 08/01/2017"
 ) AS
 SELECT DISTINCT
  fullVisitorId,
  CAST(visitId AS STRING) AS visitId,
  channelGrouping,
  totalTransactionRevenue / 1000000 AS totalTransactionRevenue
 FROM `data-to-insights.ecommerce.all_sessions_raw`
 WHERE date = '20170801'
      AND totalTransactionRevenue IS NOT NULL #XX transactions
;
