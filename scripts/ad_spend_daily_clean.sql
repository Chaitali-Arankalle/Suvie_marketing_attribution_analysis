CREATE OR REPLACE TABLE `suvimarketingdataanalysis.marketing_data_stg.ad_spend_daily_clean` AS
WITH base AS (
  SELECT
    DATE(date)                           AS date,
    SAFE.TRIM(campaign_id)               AS campaign_id,
    SAFE.TRIM(campaign_name)             AS campaign_name,
    UPPER(SAFE.TRIM(channel))            AS channel,
    IFNULL(spend, 0.0)                   AS spend,
    IFNULL(impressions, 0)               AS impressions,
    IFNULL(clicks, 0)                    AS clicks
  FROM `suvimarketingdataanalysis.marketing_data.ad_spend_daily`
),
rolled AS (
  SELECT
    date, campaign_id, campaign_name, channel,
    SUM(GREATEST(spend, 0))        AS spend,
    SUM(GREATEST(impressions, 0))  AS impressions,
    SUM(GREATEST(clicks, 0))       AS clicks
  FROM base
  GROUP BY 1,2,3,4
)
SELECT * FROM rolled;
