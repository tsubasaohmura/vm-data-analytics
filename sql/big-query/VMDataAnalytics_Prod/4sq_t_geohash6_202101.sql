#standardSQL
SELECT
    SUBSTRING(gh9, 0, 6) AS gh6,
    FORMAT_TIMESTAMP('%Y-%m-%d', TIMESTAMP_SECONDS(epoch_hr), 'Asia/Tokyo') AS date,
    SUM(count) AS count
FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.foursquare_geohashes`
WHERE epoch_hr BETWEEN 1609426800 AND 1612018800
GROUP BY gh6, date