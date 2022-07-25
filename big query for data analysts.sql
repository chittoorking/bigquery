#standardSQL
# copy one day of ecommerce data to explore
CREATE OR REPLACE TABLE ecommerce.all_sessions_raw_20170801
 OPTIONS(
   description="Raw data from analyst team into our dataset for 08/01/2017"
 ) AS
 SELECT  * FROM `data-to-insights.ecommerce.all_sessions_raw`
 WHERE date = '20170801'  #56,989 records
;
