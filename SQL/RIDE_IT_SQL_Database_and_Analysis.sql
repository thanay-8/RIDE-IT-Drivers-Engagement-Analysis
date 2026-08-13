-- ============================================================
-- RIDE IT - Drivers Engagement Analysis
-- MySQL Database Setup + Analysis Queries
-- ============================================================

DROP DATABASE IF EXISTS ride_it_analysis;
CREATE DATABASE ride_it_analysis;
USE ride_it_analysis;

-- 1. DRIVER MASTER TABLE
CREATE TABLE drivers (
    id_driver BIGINT PRIMARY KEY,
    date_registration DATE,
    driver_rating DECIMAL(4,2) NULL,
    gold_level_count INT NULL,
    receive_marketing BOOLEAN,
    country_code VARCHAR(20),
    service_type VARCHAR(50)
);

-- 2. DRIVER ACTIVITY TABLE
CREATE TABLE driver_activity (
    id_driver BIGINT NOT NULL,
    active_date DATE NOT NULL,
    offers INT NOT NULL DEFAULT 0,
    bookings INT NOT NULL DEFAULT 0,
    bookings_cancelled_by_passenger INT NOT NULL DEFAULT 0,
    bookings_cancelled_by_driver INT NOT NULL DEFAULT 0,
    rides INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_driver, active_date),
    CONSTRAINT fk_activity_driver
        FOREIGN KEY (id_driver) REFERENCES drivers(id_driver)
);

CREATE INDEX idx_activity_date ON driver_activity(active_date);
CREATE INDEX idx_driver_country ON drivers(country_code);
CREATE INDEX idx_driver_service ON drivers(service_type);

-- ============================================================
-- DATA IMPORT
-- ============================================================
-- Recommended: MySQL Workbench > Table Data Import Wizard.
-- Import rideit_drivers_cleaned.csv into drivers.
-- Import rideit_drivers_activity_cleaned.csv into driver_activity.
--
-- IMPORTANT:
-- Import drivers FIRST, then driver_activity because of the foreign key.
--
-- Alternative LOAD DATA LOCAL INFILE examples:
-- 
SET GLOBAL local_infile = ON;
-- =================================================================================================================
-- LOADING drivers_cleaned TABLE
-- =================================================================================================================
LOAD DATA LOCAL INFILE
'YOUR_PATH/rideit_drivers_cleaned.csv'
INTO TABLE drivers
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_driver, date_registration, @driver_rating, @gold_level_count,
 receive_marketing, country_code, service_type)
SET driver_rating = NULLIF(@driver_rating, ''),
    gold_level_count = NULLIF(@gold_level_count, '');

SELECT COUNT(*) AS DRIVERS_RECORD FROM DRIVERS

-- ==============================================================================================================================
-- LOADING drivers_activity_cleaned TABLE
-- ==============================================================================================================================
LOAD DATA LOCAL INFILE
'YOUR_PATH/rideit_drivers_activity_cleaned.csv'
INTO TABLE driver_activity
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_driver, active_date, offers, bookings,
 bookings_cancelled_by_passenger,
 bookings_cancelled_by_driver, rides);
 
 SELECT COUNT(*) FROM driver_activity;

-- ============================================================
-- VALIDATION QUERIES
-- ============================================================

SELECT COUNT(*) AS driver_rows,
       COUNT(DISTINCT id_driver) AS unique_drivers
FROM drivers;

SELECT COUNT(*) AS activity_rows,
       COUNT(DISTINCT id_driver) AS active_drivers,
       MIN(active_date) AS first_activity_date,
       MAX(active_date) AS last_activity_date
FROM driver_activity;

SELECT
    SUM(driver_rating IS NULL) AS missing_ratings,
    SUM(gold_level_count IS NULL) AS missing_gold_counts
FROM drivers;

-- ============================================================
-- 1. OVERALL ENGAGEMENT KPIs
-- ============================================================

SELECT
    COUNT(DISTINCT id_driver) AS active_drivers,
    COUNT(*) AS active_driver_days,
    SUM(offers) AS total_offers,
    SUM(bookings) AS total_bookings,
    SUM(rides) AS total_completed_rides,
    ROUND(SUM(rides) / NULLIF(COUNT(*), 0), 2) AS rides_per_active_day,
    ROUND(
        100.0 * SUM(bookings_cancelled_by_driver)
        / NULLIF(SUM(bookings), 0), 2
    ) AS driver_cancellation_rate_pct,
    ROUND(
        100.0 * SUM(rides)
        / NULLIF(SUM(bookings), 0), 2
    ) AS ride_completion_rate_pct
FROM driver_activity;

-- ============================================================
-- 2. MONTHLY ENGAGEMENT TREND
-- ============================================================

SELECT
    DATE_FORMAT(active_date, '%Y-%m') AS activity_month,
    COUNT(DISTINCT id_driver) AS monthly_active_drivers,
    COUNT(*) AS active_driver_days,
    SUM(rides) AS total_rides,
    ROUND(SUM(rides) / NULLIF(COUNT(*), 0), 2)
        AS rides_per_active_day,
    ROUND(
        SUM(rides) / NULLIF(COUNT(DISTINCT id_driver), 0), 2
    ) AS rides_per_active_driver,
    ROUND(
        100.0 * SUM(bookings_cancelled_by_driver)
        / NULLIF(SUM(bookings), 0), 2
    ) AS driver_cancellation_rate_pct
FROM driver_activity
GROUP BY DATE_FORMAT(active_date, '%Y-%m')
ORDER BY activity_month;

-- ============================================================
-- 3. DRIVER-LEVEL ENGAGEMENT VIEW
-- ============================================================

CREATE OR REPLACE VIEW driver_engagement AS
SELECT
    d.id_driver,
    d.date_registration,
    d.driver_rating,
    d.gold_level_count,
    d.receive_marketing,
    d.country_code,
    d.service_type,
    COUNT(DISTINCT a.active_date) AS active_days,
    MIN(a.active_date) AS first_active_date,
    MAX(a.active_date) AS last_active_date,
    SUM(a.offers) AS total_offers,
    SUM(a.bookings) AS total_bookings,
    SUM(a.bookings_cancelled_by_passenger)
        AS passenger_cancellations,
    SUM(a.bookings_cancelled_by_driver)
        AS driver_cancellations,
    SUM(a.rides) AS total_rides,
    ROUND(
        SUM(a.rides) / NULLIF(COUNT(DISTINCT a.active_date), 0), 2
    ) AS rides_per_active_day,
    ROUND(
        100.0 * SUM(a.bookings_cancelled_by_driver)
        / NULLIF(SUM(a.bookings), 0), 2
    ) AS driver_cancellation_rate_pct,
    ROUND(
        100.0 * SUM(a.rides)
        / NULLIF(SUM(a.bookings), 0), 2
    ) AS ride_completion_rate_pct
FROM drivers d
LEFT JOIN driver_activity a
    ON d.id_driver = a.id_driver
GROUP BY
    d.id_driver,
    d.date_registration,
    d.driver_rating,
    d.gold_level_count,
    d.receive_marketing,
    d.country_code,
    d.service_type;

-- ============================================================
-- 4. COUNTRY SEGMENT ANALYSIS
-- ============================================================

SELECT
    country_code,
    COUNT(*) AS drivers,
    ROUND(AVG(active_days), 2) AS avg_active_days,
    SUM(total_rides) AS total_rides,
    ROUND(AVG(rides_per_active_day), 2)
        AS avg_rides_per_active_day,
    ROUND(AVG(driver_cancellation_rate_pct), 2)
        AS avg_driver_cancellation_rate_pct
FROM driver_engagement
GROUP BY country_code
ORDER BY total_rides DESC;

-- ============================================================
-- 5. SERVICE TYPE ANALYSIS
-- ============================================================

SELECT
    service_type,
    COUNT(*) AS drivers,
    ROUND(AVG(active_days), 2) AS avg_active_days,
    SUM(total_rides) AS total_rides,
    ROUND(AVG(rides_per_active_day), 2)
        AS avg_rides_per_active_day,
    ROUND(AVG(driver_cancellation_rate_pct), 2)
        AS avg_driver_cancellation_rate_pct
FROM driver_engagement
GROUP BY service_type
ORDER BY avg_rides_per_active_day DESC;

-- ============================================================
-- 6. MARKETING OPT-IN ANALYSIS
-- ============================================================

SELECT
    receive_marketing,
    COUNT(*) AS drivers,
    ROUND(AVG(active_days), 2) AS avg_active_days,
    SUM(total_rides) AS total_rides,
    ROUND(AVG(rides_per_active_day), 2)
        AS avg_rides_per_active_day,
    ROUND(AVG(driver_cancellation_rate_pct), 2)
        AS avg_driver_cancellation_rate_pct
FROM driver_engagement
GROUP BY receive_marketing;

-- ============================================================
-- 7. GOLD STATUS SEGMENT ANALYSIS
-- ============================================================

SELECT
    CASE
        WHEN gold_level_count IS NULL THEN 'Unknown'
        WHEN gold_level_count = 0 THEN 'No Gold'
        WHEN gold_level_count BETWEEN 1 AND 5 THEN '1-5'
        WHEN gold_level_count BETWEEN 6 AND 20 THEN '6-20'
        ELSE '21+'
    END AS gold_segment,
    COUNT(*) AS drivers,
    ROUND(AVG(active_days), 2) AS avg_active_days,
    SUM(total_rides) AS total_rides,
    ROUND(AVG(rides_per_active_day), 2)
        AS avg_rides_per_active_day
FROM driver_engagement
GROUP BY gold_segment
ORDER BY avg_rides_per_active_day DESC;

-- ============================================================
-- 8. DRIVER RATING SEGMENT ANALYSIS
-- ============================================================

SELECT
    CASE
        WHEN driver_rating IS NULL THEN 'Unknown'
        WHEN driver_rating <= 4.0 THEN '<=4.0'
        WHEN driver_rating <= 4.5 THEN '4.01-4.5'
        WHEN driver_rating <= 4.8 THEN '4.51-4.8'
        ELSE '4.81-5.0'
    END AS rating_segment,
    COUNT(*) AS drivers,
    ROUND(AVG(active_days), 2) AS avg_active_days,
    SUM(total_rides) AS total_rides,
    ROUND(AVG(rides_per_active_day), 2)
        AS avg_rides_per_active_day,
    ROUND(AVG(driver_cancellation_rate_pct), 2)
        AS avg_driver_cancellation_rate_pct
FROM driver_engagement
GROUP BY rating_segment
ORDER BY avg_rides_per_active_day DESC;

-- ============================================================
-- 9. TOP ENGAGED DRIVERS
-- ============================================================

SELECT
    id_driver,
    country_code,
    service_type,
    active_days,
    total_rides,
    rides_per_active_day,
    driver_cancellation_rate_pct
FROM driver_engagement
WHERE active_days IS NOT NULL
ORDER BY active_days DESC, total_rides DESC
LIMIT 20;

-- ============================================================
-- 10. DRIVERS WITH HIGH CANCELLATION RATES
-- Minimum 20 bookings to reduce noise from very low activity.
-- ============================================================

SELECT
    id_driver,
    country_code,
    service_type,
    total_bookings,
    driver_cancellations,
    driver_cancellation_rate_pct,
    total_rides
FROM driver_engagement
WHERE total_bookings >= 20
ORDER BY driver_cancellation_rate_pct DESC
LIMIT 20;
