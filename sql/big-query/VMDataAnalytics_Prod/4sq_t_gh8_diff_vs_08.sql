SELECT 
    ST_GEOGPOINTFROMGEOHASH(t11.gh8) AS geopoint,
    t08.count AS count_t08,
    t11.count AS count_t11,
    t11.count - t08.count AS diff_vs_08,
    t11.count / t08.count AS diff_per_vs_08
FROM (
    SELECT  
        gh8,
        SUM(count) AS count
    FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.4sq_t_geohash8_202111`
    GROUP BY gh8
    ) AS t11
FULL OUTER JOIN (
        SELECT  
        gh8,
        SUM(count) AS count
    FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.4sq_t_geohash8_202108`
    GROUP BY gh8
    ) AS t08 ON t11.gh8 = t08.gh8
WHERE ST_GEOGPOINTFROMGEOHASH(t11.gh8) IS NOT NULL;
