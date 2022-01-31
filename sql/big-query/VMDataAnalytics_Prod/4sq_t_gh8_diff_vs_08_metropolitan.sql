SELECT
    *
FROM (
    SELECT 
        geopoint,
        ST_CONTAINS(ST_GEOGFROMTEXT('POLYGON((139.202787 35.129449, 140.081577 35.129449, 140.081577 36.049924, 139.202787 36.049924, 139.202787 35.129449))'), geopoint) AS geopoint_contains,
        count_t08,
        count_t11,
        diff_vs_08,
        diff_per_vs_08
    FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.4sq_t_gh8_diff_vs_08`
      )
WHERE geopoint_contains IS TRUE