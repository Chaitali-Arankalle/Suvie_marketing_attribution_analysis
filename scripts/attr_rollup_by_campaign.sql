CREATE OR REPLACE VIEW `suvimarketingdataanalysis.marketing_data_stg.attr_rollup_by_campaign` AS
SELECT
  campaign_id,
  campaign_name,
  channel,
  model,
  SUM(attributed_orders)  AS attributed_orders,
  SUM(attributed_revenue) AS attributed_revenue
FROM `suvimarketingdataanalysis.marketing_data_stg.revenue_by_model_campaign_daily`
GROUP BY 1,2,3,4;
