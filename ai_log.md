# AI Assistance Log

## Prompt 1 — Monthly Category Revenue Query

### Role
You are an experienced SQLite data analyst and SQL tutor.

### Context
I am working on a deterministic BigBasket-style SQLite database with orders and products. The orders table contains order_date, amount_inr, status, and product_id. The products table contains product_id and category.

### Task
Help me write a monthly-by-category Delivered revenue query with the following columns:
category, month, order_count, total_revenue, avg_revenue.

### Constraints
Use SQLite strftime('%Y-%m', order_date) for the month.
Join orders and products using product_id.
Filter only status = 'Delivered'.
Group by category and month.
Order by category and month.
Do not modify the underlying data.

### Format
Return one runnable SQLite query and a short explanation of each clause.

## Verification Performed

I ran the generated query against the SQLite database and verified that it returned:

- 36 rows
- Columns: category, month, order_count, total_revenue, avg_revenue
- Grand total Delivered revenue: ₹88,282

The monthly results were then exported to monthly_category_revenue.csv and the exported data was verified using Python.

## Prompt 2 — Pandas IQR Outlier Capping

### Role
You are an experienced Python and Pandas data analyst who helps beginners debug and understand data-cleaning code.

### Context
I am analyzing a BigBasket-style `orders` DataFrame. The `amount_inr` column contains some unusually large values. I need to identify outliers only among Delivered orders with non-null `amount_inr` and reduce the effect of extreme values without deleting the orders.

### Task
Explain and help me verify the following Pandas approach for IQR-based outlier detection and capping:

```python
delivered_amounts = orders.loc[
    (orders["status"] == "Delivered") &
    (orders["amount_inr"].notna()),
    "amount_inr"
]

Q1 = delivered_amounts.quantile(0.25)
Q3 = delivered_amounts.quantile(0.75)

IQR = Q3 - Q1
upper_fence = Q3 + 1.5 * IQR

orders.loc[
    (orders["status"] == "Delivered") &
    (orders["amount_inr"].notna()),
    "amount_inr"
] = orders.loc[
    (orders["status"] == "Delivered") &
    (orders["amount_inr"].notna()),
    "amount_inr"
].clip(upper=upper_fence)

### Constraints
Use only Pandas operations.
Calculate Q1 and Q3 using `.quantile()`.
Calculate the upper fence as `Q3 + 1.5 * IQR`.
Apply `.clip(upper=upper_fence)` rather than deleting outlier rows.
Use only Delivered orders with non-null `amount_inr` when calculating the IQR.
Do not fill missing `amount_inr` values.

### Format
Explain what each step does, identify any potential problems in the code, and provide a corrected runnable version if necessary.

## Verification Performed

I ran the Pandas code in `analysis.ipynb` and verified the IQR calculation, counted the values above the upper fence, and applied the `.clip(upper=upper_fence)` operation to the Delivered non-null `amount_inr` values. I then continued the analysis using the capped values and verified that the top category was Household Essentials and the top supplier was HomeEssentials Traders, matching the Part 1 SQL findings.