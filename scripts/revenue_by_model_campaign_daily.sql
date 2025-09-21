CREATE OR REPLACE TABLE `suvimarketingdataanalysis.marketing_data_stg.revenue_by_model_campaign_daily` AS
WITH clicks AS (
  SELECT user_id, click_ts, campaign_id, campaign_name, channel
  FROM `suvimarketingdataanalysis.marketing_data_stg.ad_events_clicks_clean`
),
purchases AS (
  SELECT user_id, purchase_ts, purchase_date, order_id, order_value
  FROM `suvimarketingdataanalysis.marketing_data_stg.ad_events_purchases_clean`
),
eligible AS (
  SELECT
    p.order_id,
    p.order_value,
    p.purchase_ts,
    p.purchase_date,
    c.campaign_id,
    c.campaign_name,
    c.channel,
    c.click_ts
  FROM purchases p
  JOIN clicks c
    ON c.user_id = p.user_id
   AND c.click_ts BETWEEN TIMESTAMP_SUB(p.purchase_ts, INTERVAL 7 DAY)
                       AND TIMESTAMP_SUB(p.purchase_ts, INTERVAL 1 SECOND)
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY click_ts ASC)  AS rn_first,
    ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY click_ts DESC) AS rn_last
  FROM eligible
),
first_click AS (
  SELECT
    purchase_date AS date,
    campaign_id,
    campaign_name,
    channel,
    'first_click' AS model,
    order_value   AS order_value,
    1.0           AS weight,
    order_id
  FROM ranked
  WHERE rn_first = 1
),
last_click AS (
  SELECT
    purchase_date AS date,
    campaign_id,
    campaign_name,
    channel,
    'last_click'  AS model,
    order_value   AS order_value,
    1.0           AS weight,
    order_id
  FROM ranked
  WHERE rn_last = 1
),
unioned AS (
  SELECT * FROM first_click
  UNION ALL
  SELECT * FROM last_click
)
SELECT
  date,
  campaign_id,
  campaign_name,
  channel,
  model,
  SUM(order_value * weight) AS attributed_revenue,
  SUM(weight)               AS attributed_orders
FROM unioned
GROUP BY 1,2,3,4,5;
