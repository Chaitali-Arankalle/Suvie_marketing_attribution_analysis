# Suvie Marketing Attribution Analysis

This project implements a **First vs Last Click Attribution Model** using raw ad event and spend data, processed in **BigQuery SQL**, and visualized in a **Looker Studio dashboard**.  
The objective is to show how attribution models change campaign/channel credit allocation and inform smarter marketing budget decisions.


## 📂 Project Structure

Suvie_marketing_attribution_analysis/
│
├── data/ # Data sources
│ ├── raw/ # Original CSVs provided
│ │ ├── ad_events.csv
│ │ └── ad_spend_daily.csv
│ └── processed/ # Cleaned & modeled outputs
│ ├── attr_rollup_by_campaign.csv
│ ├── attr_rollup_by_channel.csv
│ └── revenue_by_model_campaign_daily.csv
│
├── scripts/ # BigQuery SQL scripts
│ ├── ad_events_clicks_clean.sql
│ ├── ad_events_purchases_clean.sql
│ ├── ad_spend_daily_clean.sql
│ ├── revenue_by_model_campaign_daily.sql
│ ├── attr_rollup_by_campaign.sql
│ ├── attr_rollup_by_channel.sql
│ └── data_quality_check_post_preprocessing.sql
│
├── documents/ # Case study documentation
│ ├── Marketing Attribution Analysis Case Study.pdf
│ └── Suvie Marketing Analyst Test Task.pdf
│
├── reports/ # Final outputs
│ └── Looker Dashboard Link.pdf
│
└── README.md # Project navigation & summary


## 🚀 Workflow

1. **Raw data** → `data/raw`  
   Provided event-level and spend-level CSVs.

2. **Cleaning (staging)** → `scripts/*clean.sql`  
   - Deduplicate clicks & purchases  
   - Standardize campaign/channel fields  
   - Remove invalid/null purchase values  
   - Replace/coerce missing spend metrics

3. **Attribution modeling** → `revenue_by_model_campaign_daily.sql`  
   - 7-day lookback window (pre-purchase)  
   - Exclude unattributed purchases  
   - Allocate revenue/orders to First vs Last click

4. **Rollups for dashboarding** → `attr_rollup_by_campaign.sql`, `attr_rollup_by_channel.sql`  
   Aggregations for campaign-level and channel-level views.

5. **Data Quality Checks** → `data_quality_check_post_preprocessing.sql`  
   Ensures no duplicate orders, no negative spend, logical constraints.

6. **Outputs** → `data/processed/`  
   Final CSV exports for quick reference.

7. **Visualization** → `reports/Looker Dashboard Link.pdf`  
   Contains dashboard link with 3 pages:  
   - Landing Page (methodology)  
   - Revenue Trends & Campaigns  
   - Channel Mix & Model Disagreement


## 📝 Deliverables
- **Clean SQL pipelines** for data prep and attribution logic.  
- **Processed datasets** in CSV form.  
- **Looker Studio Dashboard** with insights (MTD revenue, trends, top campaigns, channel mix, model disagreement, AOV).  
- **Case Study Document** summarizing methodology and marketing insights.


