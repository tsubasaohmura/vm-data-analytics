SELECT 
    ST_GEOGPOINTFROMGEOHASH(t11.gh6) AS geopoint,
    t08.count AS count_t08,
    t11.count AS count_t11,
    t11.count - t08.count AS diff_vs_08,
    t11.count / t08.count AS diff_per_ve_08
FROM (
    SELECT  
        gh6,
        SUM(count) AS count
    FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.4sq_t_geohash_202111`
    GROUP BY gh6
    ) AS t11
FULL OUTER JOIN (
        SELECT  
        gh6,
        SUM(count) AS count
    FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.4sq_t_geohash_202108`
    GROUP BY gh6
    ) AS t08 ON t11.gh6 = t08.gh6
WHERE ST_GEOGPOINTFROMGEOHASH(t11.gh6) IS NOT NULL;
