-- ============================================================
-- AIRBNB PERFORMANCE DASHBOARD — SQL ANALYSIS QUERIES
-- Author  : Mounika Vankeshwaram
-- Dataset : airbnb_dataset.csv (500 listings, 2023)
-- Tools   : SQL | Power BI | Excel
-- ============================================================


-- ── 1. TOTAL REVENUE OVERVIEW ──────────────────────────────
SELECT
    ROUND(SUM(total_revenue), 2)          AS total_revenue,
    ROUND(AVG(price_per_night), 2)        AS avg_daily_rate,
    ROUND(AVG(occupancy_rate) * 100, 2)   AS avg_occupancy_pct,
    COUNT(DISTINCT listing_id)            AS total_listings,
    COUNT(DISTINCT host_id)               AS total_hosts,
    ROUND(AVG(review_score), 2)           AS avg_review_score
FROM airbnb_dataset;


-- ── 2. REVENUE PER AVAILABLE ROOM (RevPAR) ─────────────────
-- RevPAR = ADR × Occupancy Rate
SELECT
    ROUND(AVG(price_per_night) * AVG(occupancy_rate), 2) AS revpar
FROM airbnb_dataset;


-- ── 3. REVENUE BY BOROUGH ───────────────────────────────────
SELECT
    borough,
    COUNT(listing_id)                     AS total_listings,
    ROUND(SUM(total_revenue), 2)          AS total_revenue,
    ROUND(AVG(price_per_night), 2)        AS avg_daily_rate,
    ROUND(AVG(occupancy_rate) * 100, 2)   AS avg_occupancy_pct
FROM airbnb_dataset
GROUP BY borough
ORDER BY total_revenue DESC;


-- ── 4. REVENUE BY PROPERTY TYPE ─────────────────────────────
SELECT
    property_type,
    COUNT(listing_id)                     AS total_listings,
    ROUND(SUM(total_revenue), 2)          AS total_revenue,
    ROUND(AVG(price_per_night), 2)        AS avg_daily_rate,
    ROUND(AVG(occupancy_rate) * 100, 2)   AS avg_occupancy_pct,
    ROUND(AVG(review_score), 2)           AS avg_review_score
FROM airbnb_dataset
GROUP BY property_type
ORDER BY avg_daily_rate DESC;


-- ── 5. MONTHLY REVENUE TREND ────────────────────────────────
SELECT
    STRFTIME('%Y-%m', checkin_date)       AS month,
    COUNT(listing_id)                     AS bookings,
    ROUND(SUM(total_revenue), 2)          AS monthly_revenue,
    ROUND(AVG(price_per_night), 2)        AS avg_daily_rate
FROM airbnb_dataset
GROUP BY month
ORDER BY month;


-- ── 6. WEEKEND vs WEEKDAY PERFORMANCE ───────────────────────
SELECT
    is_weekend_booking,
    COUNT(listing_id)                     AS total_bookings,
    ROUND(SUM(total_revenue), 2)          AS total_revenue,
    ROUND(AVG(price_per_night), 2)        AS avg_daily_rate,
    ROUND(AVG(occupancy_rate) * 100, 2)   AS avg_occupancy_pct
FROM airbnb_dataset
GROUP BY is_weekend_booking;


-- ── 7. TOP 10 HOSTS BY REVENUE ──────────────────────────────
SELECT
    host_id,
    COUNT(listing_id)                     AS total_listings,
    ROUND(SUM(total_revenue), 2)          AS total_revenue,
    ROUND(AVG(review_score), 2)           AS avg_review_score
FROM airbnb_dataset
GROUP BY host_id
ORDER BY total_revenue DESC
LIMIT 10;


-- ── 8. TOP 10 NEIGHBOURHOODS BY REVENUE ─────────────────────
SELECT
    neighbourhood,
    borough,
    COUNT(listing_id)                     AS listings,
    ROUND(SUM(total_revenue), 2)          AS total_revenue,
    ROUND(AVG(price_per_night), 2)        AS avg_daily_rate
FROM airbnb_dataset
GROUP BY neighbourhood, borough
ORDER BY total_revenue DESC
LIMIT 10;


-- ── 9. OCCUPANCY RATE DISTRIBUTION ──────────────────────────
SELECT
    CASE
        WHEN occupancy_rate < 0.5  THEN 'Low (< 50%)'
        WHEN occupancy_rate < 0.75 THEN 'Medium (50–75%)'
        ELSE                            'High (> 75%)'
    END                                   AS occupancy_band,
    COUNT(listing_id)                     AS listings,
    ROUND(AVG(price_per_night), 2)        AS avg_daily_rate
FROM airbnb_dataset
GROUP BY occupancy_band
ORDER BY listings DESC;


-- ── 10. REVIEW SCORE vs REVENUE CORRELATION ─────────────────
SELECT
    CASE
        WHEN review_score >= 4.5 THEN 'Excellent (4.5–5.0)'
        WHEN review_score >= 4.0 THEN 'Good (4.0–4.4)'
        WHEN review_score >= 3.5 THEN 'Average (3.5–3.9)'
        ELSE                          'Below Average (< 3.5)'
    END                                   AS review_band,
    COUNT(listing_id)                     AS listings,
    ROUND(AVG(total_revenue), 2)          AS avg_revenue_per_listing,
    ROUND(AVG(occupancy_rate) * 100, 2)   AS avg_occupancy_pct
FROM airbnb_dataset
GROUP BY review_band
ORDER BY avg_revenue_per_listing DESC;


-- ── 11. DATA QUALITY CHECK — NULL / MISSING VALUES ──────────
SELECT
    SUM(CASE WHEN listing_id      IS NULL THEN 1 ELSE 0 END) AS null_listing_id,
    SUM(CASE WHEN host_id         IS NULL THEN 1 ELSE 0 END) AS null_host_id,
    SUM(CASE WHEN total_revenue   IS NULL THEN 1 ELSE 0 END) AS null_revenue,
    SUM(CASE WHEN price_per_night IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN review_score    IS NULL THEN 1 ELSE 0 END) AS null_review_score,
    SUM(CASE WHEN occupancy_rate  IS NULL THEN 1 ELSE 0 END) AS null_occupancy
FROM airbnb_dataset;


-- ── 12. DUPLICATE LISTING CHECK ─────────────────────────────
SELECT
    listing_id,
    COUNT(*) AS occurrences
FROM airbnb_dataset
GROUP BY listing_id
HAVING COUNT(*) > 1;
