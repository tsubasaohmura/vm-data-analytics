SELECT
    *
FROM (
    SELECT
        vm_id,
        ST_GEOHASH(ST_GEOGPOINT(longitude, latitude), 6) AS geohash6,
        longitude,
        latitude,
        machine_rank,
        subchannel_3 AS subchannel
    FROM `ccbji-analytics-291203.master_data.1901_1912_vm_hearing_sheet`
    ) AS m_vm
LEFT JOIN (
    SELECT
        m_ccaa_poi_location_txt_name AS location_name,
        m_ccaa_poi_location_txt_category_ids AS segment,
        m_ccaa_poi_location_txt_region AS prefecture,
        m_ccaa_poi_location_txt_locality AS district,
        ST_GEOHASH(ST_GEOGPOINT(m_ccaa_poi_location_txt_longitude, m_ccaa_poi_location_txt_latitude), 6) AS geohash6,
        m_ccaa_poi_location_txt_longitude AS longitude,
        m_ccaa_poi_location_txt_latitude AS latitude
    FROM `ccbji-analytics-291203.master_data.ccaa_poi_location`
) AS m_poi ON m_vm.geohash6 = m_poi.geohash6
WHERE prefecture = '東京都'
#LEFT JOIN (
#    SELECT 
#        *
#    FROM `ccbji-analytics-291203.master_data.weather_master_tokyo_202112`
#) AS m_wea ON m_wea.date = m_vm.calday
