CREATE OR REPLACE TABLE `suvimarketingdataanalysis.marketing_data_stg.ad_events_purchases_clean` AS
WITH base AS (
  SELECT
    user_id,
    event_ts AS purchase_ts,
    DATE(event_ts) AS purchase_date,
    order_id,
    order_value,
    SAFE.TRIM(campaign_id)   AS campaign_id,
    SAFE.TRIM(campaign_name) AS campaign_name,
    UPPER(SAFE.TRIM(channel)) AS channel
  FROM `suvimarketingdataanalysis.marketing_data.ad_events`
  WHERE LOWER(event_type) = 'purchase'
    AND order_id IS NOT NULL
    AND order_value IS NOT NULL
    AND order_value > 0
),
-- if the same order_id appears multiple times, keep the most recent,
-- breaking ties by higher order_value
dedup AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY order_id
      ORDER BY purchase_ts DESC, order_value DESC
    ) AS rn
  FROM base
)
SELECT * EXCEPT(rn)
FROM dedup
WHERE rn = 1;
