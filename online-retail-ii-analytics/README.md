# Online Retail II — Sales Analytics & BI Dashboard

Analysis of a UK-based online retailer's transactional sales data (Dec 2009 – Dec 2011) to uncover revenue trends, customer behavior, product performance, and growth opportunities — built end-to-end from raw data cleaning through an interactive BI dashboard.

## Business Scenario

Analyze a retail company's sales dataset to identify revenue trends, customer behavior, product performance, and opportunities for business growth.

## Tech Stack

- **Database:** SQL Server (T-SQL)
- **BI Tool:** Power BI Desktop (Power Query, DAX, star schema data model)
- **Techniques used:** CTEs, window functions (`RANK`, `NTILE`, `SUM() OVER`), RFM segmentation, cohort retention analysis, DAX measures and calculated columns

## Data Source

[Online Retail II — UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/502/online+retail+ii). Transactions from a UK-based online retailer selling mostly unique all-occasion gift-ware, Dec 2009–Dec 2011.

## Project Phases

1. **Data Preparation** — combined two source years into one table, corrected data types, removed rows with missing `CustomerID`, `Quantity <= 0`, or `Price = 0`, applied trim/clean to text fields. Result: 805,549 clean transaction rows from ~1,067,371 raw rows.
2. **Database Design** — star schema with `Retail_Sales` as the fact table and `DimCustomer`, `DimProduct`, `DimDate` as dimensions. Built and verified in both Power BI and SQL Server.
3. **SQL Analysis** — sales performance, product ranking, customer analysis, running totals, RFM segmentation, and cohort retention, all in `sql/phase3_analysis.sql`.
4. **BI Dashboard** — 7-page interactive Power BI dashboard (Executive Summary, Revenue Deep Dive, Sales Trends, Top Products, Category Analysis, Regional Analysis, Customer Segmentation) plus a drill-through Product Detail page, report-wide slicers, and consistent theming.

## Key Findings

- **Revenue:** £17.74M total revenue, 36,969 orders, 5,878 customers. Strong seasonality peaking each Sep–Nov.
- **Customer value is highly concentrated:** the "Champions" RFM segment is 23% of customers but generates 69% of revenue (£12.2M of £17.7M).
- **Retention:** cohort analysis shows a steep first-month drop-off, then a stable ~30–35% retention plateau, with a seasonal rebound around the 11–12 month mark (annual holiday repeat buyers).
- **Products:** top revenue and top volume products differ substantially — the business relies on both high-value, low-volume items and high-volume, low-price items.
- **Data caveat:** the source dataset's December 2011 is incomplete; year-over-year comparisons should use the like-for-like Jan–Nov window rather than full calendar years.

