CREATE OR REPLACE TABLE `suvimarketingdataanalysis.marketing_data_stg.ad_events_clicks_clean` AS
WITH base AS (
  SELECT
    user_id,
    event_ts AS click_ts,
    SAFE.TRIM(campaign_id)   AS campaign_id,
    SAFE.TRIM(campaign_name) AS campaign_name,
    UPPER(SAFE.TRIM(channel)) AS channel
  FROM `suvimarketingdataanalysis.marketing_data.ad_events`
  WHERE LOWER(event_type) = 'click'
),
-- remove exact duplicate clicks (same user, timestamp, campaign, channel)
dedup AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY user_id, click_ts, campaign_id, campaign_name, channel
      ORDER BY click_ts
    ) AS rn
  FROM base
)
SELECT * EXCEPT(rn)
FROM dedup
WHERE rn = 1;
