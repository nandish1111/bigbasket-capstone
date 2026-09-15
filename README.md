# BigBasket Revenue Performance Analysis

## Project Overview

This project analyzes BigBasket-style e-commerce order data to evaluate revenue performance across product categories from January to June 2026.

The project combines SQL, Google Sheets/Excel, Tableau Public, and Python/Pandas to perform data generation, validation, visualization, cleaning, analysis, and cross-validation.

The analysis focuses on:

- Monthly revenue trends
- Revenue performance by category
- Category performance against revenue targets
- Supplier revenue performance
- Data-quality issues and cleaning
- Cross-validation between SQL and Pandas results

## Key Business Findings

- **Total Delivered Revenue (Part 1 SQL):** ₹88,282
- **Total Delivered Orders:** 434
- **Average Order Value:** ₹203.41
- **Categories Meeting Target:** 3
- **Top Category:** Household Essentials
- **Top Supplier:** HomeEssentials Traders
- **Highest Monthly Revenue in Part 4:** May — ₹16,668.50

The Part 4 Pandas analysis independently confirmed that **Household Essentials** was the top category and **HomeEssentials Traders** was the top supplier, matching the key findings from Part 1 SQL.

## Tableau Public Dashboard

The interactive Tableau Public dashboard presents revenue performance across the six product categories from January to June 2026.

**Dashboard:** [BigBasket Revenue Performance Dashboard](https://public.tableau.com/app/profile/nandish.m5797/viz/BigBasketRevenuePerformanceDashboard_17894673318310/Dashboard1)

The dashboard includes:

- Monthly Total Revenue
- Category Revenue by Target Status
- Total Revenue
- Total Delivered Orders
- Average Order Value
- Categories Meeting Target
- Category filtering
- Target-status color coding

## Data Story

The dashboard shows that revenue performance varies significantly across the six categories.

**Household Essentials** is the strongest-performing category, generating ₹21,715 in Part 1 SQL against a target of ₹17,000. **Bakery** and **Personal Care** also exceeded their targets.

Three categories require attention. **Fruits & Vegetables** and **Snacks & Beverages** are classified as Below Target - Critical, while **Dairy & Eggs** is classified as Below Target - Watch.

The main recommendation is to prioritize **Fruits & Vegetables** and **Snacks & Beverages**, as they have the largest percentage gaps below their targets. At the same time, the business should maintain the strong performance of Household Essentials and Bakery and investigate the factors contributing to their higher revenue.

For the independent Part 4 Pandas analysis, the raw data was cleaned by removing duplicate order IDs, standardizing city and category values, excluding missing revenue values from revenue calculations, and capping extreme Delivered-order revenue values using the IQR method.

## Repository Structure

```text
bigbasket-capstone/
│
├── generate_data.py
├── bigbasket_capstone.db
├── orders_raw.csv
├── products.csv
├── monthly_category_revenue.csv
│
├── 01_foundations.sql
├── 02_aggregation_joins.sql
├── 03_reporting.sql
├── verify.sql
│
├── bigbasket_revenue_analysis.xlsx
├── analysis.ipynb
├── Part-1.ipynb
│
├── DATA_STORY.md
├── ai_log.md
└── README.md
```
### File Description

| File | Purpose |
|---|---|
| `generate_data.py` | Generates the deterministic SQLite database and raw CSV files |
| `bigbasket_capstone.db` | SQLite database created in Part 1 |
| `orders_raw.csv` | Raw order data used for Part 4 |
| `products.csv` | Product and supplier reference data |
| `monthly_category_revenue.csv` | Monthly category revenue export from Part 1 SQL |
| `01_foundations.sql` | Basic SQL foundation queries |
| `02_aggregation_joins.sql` | SQL aggregation and join queries |
| `03_reporting.sql` | Reporting queries, monthly revenue, and category target analysis |
| `verify.sql` | Part 1 database and status-count verification |
| `bigbasket_revenue_analysis.xlsx` | Google Sheets/Excel cross-check from Part 2 |
| `analysis.ipynb` | Python/Pandas cleaning, analysis, visualization, and cross-validation |
| `part1.ipynb` | Part 1 supporting notebook |
| `DATA_STORY.md` | Business data story and recommendations |
| `ai_log.md` | AI-assisted prompting log containing the two RCTCF prompts |
| `README.md` | Project documentation and submission guide |

## Methodology

### Part 1 — SQL Foundations

A deterministic BigBasket-style SQLite database was created using `generate_data.py`.

The database contains:

- 31 products
- 50 customers
- 500 orders
- 6 category targets

SQL was used to calculate monthly Delivered revenue by category and perform business diagnostics.

### Part 2 — Google Sheets/Excel Cross-Check

The `monthly_category_revenue.csv` file generated from Part 1 was imported into Google Sheets/Excel.

Pivot tables and category-level calculations were used to independently verify the SQL revenue results and target variances.

### Part 3 — Tableau Public

The validated monthly revenue data was visualized in Tableau Public.

The dashboard provides KPI cards, monthly revenue trends, category performance, and target-status analysis.

### Part 4 — Python/Pandas

The raw `orders_raw.csv` data was independently analyzed using Pandas.

The cleaning process included:

1. Removing duplicate `order_id` records while keeping the first occurrence.
2. Standardizing city and category values using `.str.strip()` and `.str.title()`.
3. Identifying missing `amount_inr` values and excluding them from revenue calculations.
4. Leaving legitimate null ratings for Cancelled and Pending orders unchanged.
5. Detecting extreme Delivered-order revenue values using the IQR method.
6. Capping values above the upper fence using `.clip(upper=...)`.
7. Creating date and analysis columns including `month`, `month_name`, `revenue_per_unit`, and `is_delivered`.
8. Using `groupby()` and `merge()` for category and supplier analysis.
9. Cross-validating the top category and top supplier against Part 1 SQL.
10. Creating three matplotlib visualizations and three business observations.

## Part 4 — Python/Pandas Results

The raw order data initially contained more than 500 rows because of duplicate order records.

After removing duplicate `order_id` values while keeping the first occurrence:

- **Final rows:** 500
- **Distinct cities:** 4
- **Distinct categories:** 6
- **Missing `amount_inr` values:** 10
- **Delivered orders:** 434
- **Missing ratings among Delivered orders:** 0

### IQR Outlier Treatment

The IQR calculation was performed only on Delivered orders with non-null `amount_inr`.

- **Q1:** ₹90.00
- **Q3:** ₹275.00
- **IQR:** ₹185.00
- **Upper fence:** ₹552.50
- **Values capped:** 16

The outliers were capped rather than deleted using Pandas `.clip(upper=upper_fence)`. Missing `amount_inr` values were not filled and were excluded from revenue calculations.

### Cross-Validation

The cleaned Pandas analysis confirmed the same key findings as Part 1 SQL:

- **Top category:** Household Essentials
- **Top supplier:** HomeEssentials Traders

The exact revenue totals can differ between Part 1 and Part 4 because Part 4 independently cleans the raw export, excludes missing revenue values, and caps high-value outliers.

## How to Regenerate the Data

The project uses `generate_data.py` to create the deterministic SQLite database and raw CSV files.

From the project folder, run:

```bash
python generate_data.py

## AI-Assisted Analysis

AI assistance was used during the project to support SQL and Pandas learning and debugging.

The complete record of AI-assisted prompts and verification steps is available in:

`ai_log.md`

The log contains exactly two RCTCF-structured prompts:

1. **Prompt 1:** Monthly Category Revenue SQL Query
2. **Prompt 2:** Pandas IQR Outlier Capping

The verification steps in `ai_log.md` document how the generated guidance was tested against the project data.

## Part 4 Notebook

The complete Python/Pandas cleaning, analysis, visualization, and cross-validation work is available in:

`analysis.ipynb`

The notebook contains the raw-data inspection, duplicate removal, text cleaning, missing-value handling, IQR outlier capping, date parsing, category and supplier analysis, three matplotlib charts, and exactly three structured business observations.

## Conclusion

This project demonstrates an end-to-end data analysis workflow using SQL, Google Sheets/Excel, Tableau Public, and Python/Pandas.

The analysis identifies strong-performing categories, categories that require attention, monthly revenue patterns, and the highest-performing supplier. Independent validation between SQL and Pandas confirms the key business findings despite differences in cleaned revenue totals.

The project also demonstrates practical data-cleaning techniques, including duplicate removal, text standardization, missing-value handling, IQR-based outlier detection, and outlier capping.