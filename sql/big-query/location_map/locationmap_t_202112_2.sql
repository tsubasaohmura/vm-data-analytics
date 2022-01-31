SELECT
    machine_cd,
    calday,
    sales_amount,
    t_vm.geohash8 AS geohash8,
    longitude,
    latitude,
    machine_rank,
    subchannel,
    prefecture,
    categories,
    IFNULL(poi_count, 0) AS poi_count,
    IFNULL(count, 0) AS peaple_flow,
    weekday,
    ave,
    max,
    min,
    rain,
    sunshine,
    windspeed,
    humidity,
    cloud
FROM (
    SELECT 
        *
    FROM (
        SELECT
            VENDINGMACHINE_CD AS machine_cd,
            calday,
            SUM(sales_amount) AS sales_amount
        FROM `ccbji-analytics-291203.location_map.cmos_t_all_intermidiate`
        GROUP BY VENDINGMACHINE_CD, calday
    ) AS t
    INNER JOIN (
        SELECT 
            CAST(machine_code AS string) AS machine_code,
            ST_GEOHASH(ST_GEOGPOINT(longitude, latitude), 8) AS geohash8,
            longitude,
            latitude,
            machine_rank,
            subchannel,
            prefecture
        FROM `ccbji-analytics-291203.master_data_US.hearing_sheet_2022_spring`
        WHERE prefecture = '東京都'
    ) AS m ON m.machine_code = t.machine_cd
    ) AS t_vm
LEFT JOIN (
    SELECT 
        REPLACE(STRING_AGG(category),',','') AS categories, # Remove ',' and concat each string.
        geohash8,
        SUM(poi_count_intermidiate) AS poi_count
    FROM (
        SELECT DISTINCT 
            category,
            geohash8,
            prefecture,
            COUNT(*) AS poi_count_intermidiate
        FROM (
            SELECT
                category_name_level_1 AS category,
                state AS prefecture,
                ST_GEOHASH(ST_GEOGPOINT(geo_long, geo_lat), 8) AS geohash8,
            FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.foursquare_venues`
            WHERE state IN ('Tokyo', 'Tōkyō-to', 'Tōkyō')
            ORDER BY category_name_level_1, geohash8
            )
        GROUP BY category, geohash8, prefecture
        )
    GROUP BY geohash8
) AS m_poi ON t_vm.geohash8 = m_poi.geohash8
LEFT JOIN (
    SELECT
        SUBSTRING(gh9, 0, 8) AS geohash8,
        CAST(FORMAT_TIMESTAMP('%Y-%m-%d', TIMESTAMP_SECONDS(epoch_hr), 'Asia/Tokyo') AS DATE) AS date,
        SUM(count) AS count
    FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.foursquare_geohashes` 
    WHERE epoch_hr BETWEEN 1638284400 AND 1640962799
    GROUP BY geohash8, date
) AS t_pf ON t_vm.geohash8 = t_pf.geohash8 AND t_vm.calday = t_pf.date
LEFT JOIN (
    SELECT 
        *
    FROM `ccbji-analytics-291203.master_data_US.weather_master_tokyo_202112`
) AS m_wea ON m_wea.date = t_vm.calday

