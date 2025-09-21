SELECT LOWER(event_type) AS event_type, COUNT(*) 
FROM `suvimarketingdataanalysis.marketing_data.ad_events`
GROUP BY 1 ORDER BY 2 DESC;

SELECT
  (SELECT COUNT(*) FROM `suvimarketingdataanalysis.marketing_data.ad_events` WHERE LOWER(event_type)='purchase') AS purchases_raw,
  (SELECT COUNT(*) FROM `suvimarketingdataanalysis.marketing_data_stg.ad_events_purchases_clean`) AS purchases_clean;


SELECT order_id, COUNT(*) AS cnt
FROM `suvimarketingdataanalysis.marketing_data_stg.ad_events_purchases_clean`
GROUP BY order_id
HAVING COUNT(*) > 1;

WITH t AS (
  SELECT model,
         SUM(attributed_orders)  AS orders,
         SUM(attributed_revenue) AS revenue
  FROM `suvimarketingdataanalysis.marketing_data_stg.revenue_by_model_campaign_daily`
  GROUP BY model
)
SELECT * FROM t;

SELECT *
FROM `suvimarketingdataanalysis.marketing_data_stg.ad_spend_daily_clean`
WHERE clicks > impressions;


