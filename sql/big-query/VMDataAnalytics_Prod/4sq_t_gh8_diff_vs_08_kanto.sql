SELECT
    *
FROM (
    SELECT 
        geopoint,
        ST_CONTAINS(ST_GEOGFROMTEXT('POLYGON((137.405845 34.170223, 137.405845 34.228282, 141.448281 34.228282, 141.448281 34.170223, 137.405845 34.170223))'), geopoint) AS geopoint_contains,
        count_t08,
        count_t11,
        diff_vs_08,
        diff_per_vs_08
    FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.4sq_t_gh8_diff_vs_08`
      )
WHERE geopoint_contains IS TRUE