#standardSQL
SELECT
    SUBSTRING(gh9, 0, 8) AS gh8,
    FORMAT_TIMESTAMP('%Y-%m-%d', TIMESTAMP_SECONDS(epoch_hr), 'Asia/Tokyo') AS date,
    SUM(count) AS count
FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.foursquare_geohashes`
WHERE epoch_hr BETWEEN 1635692400 AND 1638198000
GROUP BY gh8, date