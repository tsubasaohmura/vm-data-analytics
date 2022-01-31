SELECT 
    ST_GEOGPOINTFROMGEOHASH(t11.gh6) AS geopoint,
    t01.count AS count_t01,
    t11.count AS count_t11,
    t11.count - t01.count AS diff_vs_01,
    t11.count / t01.count AS diff_per_vs_01
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
    FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.4sq_t_geohash_202101`
    GROUP BY gh6
    ) AS t01 ON t11.gh6 = t01.gh6
WHERE ST_GEOGPOINTFROMGEOHASH(t11.gh6) IS NOT NULL;
