# 🧹 Data Cleaning Steps — Airbnb Dataset

## Raw Data Issues Found

| Issue | Column(s) Affected | Action Taken |
|-------|--------------------|--------------|
| Missing values | `review_score`, `price_per_night` | Filled with column median |
| Inconsistent property type names | `property_type` | Standardized to 3 categories |
| Date format inconsistency | `checkin_date`, `checkout_date` | Converted to YYYY-MM-DD |
| Duplicate listing IDs | `listing_id` | Identified and removed |
| Extra whitespace in text fields | `neighbourhood`, `borough` | Applied TRIM() |
| Negative revenue values | `total_revenue` | Flagged and excluded |

## Steps Performed in Excel

1. **Backup raw file** — Saved original as `airbnb_raw_backup.csv` before any changes
2. **Remove duplicates** — Data tab → Remove Duplicates → checked `listing_id`
3. **Fix blanks** — CTRL+G → Special → Blanks → filled with median values
4. **Standardize categories** — Used Find & Replace to normalize property type names
5. **Date formatting** — Selected date columns → Format Cells → Date → YYYY-MM-DD
6. **Add calculated column** — `is_weekend_booking`: `=IF(WEEKDAY(checkin_date,2)>=6,"Yes","No")`
7. **Data type check** — Verified price, revenue, occupancy as Number; dates as Date

## SQL Data Quality Checks

```sql
-- Check for NULLs
SELECT
  SUM(CASE WHEN price_per_night IS NULL THEN 1 ELSE 0 END) AS null_price,
  SUM(CASE WHEN total_revenue   IS NULL THEN 1 ELSE 0 END) AS null_revenue,
  SUM(CASE WHEN review_score    IS NULL THEN 1 ELSE 0 END) AS null_reviews
FROM airbnb_dataset;

-- Check for duplicates
SELECT listing_id, COUNT(*) AS count
FROM airbnb_dataset
GROUP BY listing_id
HAVING COUNT(*) > 1;

-- Check for invalid values
SELECT * FROM airbnb_dataset
WHERE total_revenue < 0 OR occupancy_rate > 1 OR review_score > 5;
```

## Result

- ✅ Zero duplicate listing IDs after cleaning
- ✅ Zero NULL values in key columns
- ✅ All dates in consistent YYYY-MM-DD format
- ✅ All numeric columns verified for correct data types
- ✅ Dataset ready for SQL analysis and Power BI import
