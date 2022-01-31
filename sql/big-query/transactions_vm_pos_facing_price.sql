#standardSQL
SELECT
    visit_date,
    session_uid,
    json_output_version,
    f.start_time AS start_time,
    end_time,
    division_code,
    division_name,
    branch_name,
    office_name,
    area_code,
    area_name,
    route_code,
    account_code,
    account_name,
    store_code,
    store_name,
    f.street AS street,
    channel,
    user_name,
    f.scene_type_name AS scene_type_name,
    f.product_ean_code AS product_ean_code,
    product_name,
    manufacturer,
    brand,
    categoryLocalName,
    sub_category,
    package_type,
    package,
    attribute1,
    Facings,
    latitude,
    longitude,
    p.Recognized_price AS Recognized_price,
    p.rec2 AS Recognized_price_rounded,
    d.Has_Digital_Payment_ AS Has_Digital_Payment_
FROM `ccbji-analytics-291203.master_data_US.TRAX_sku_facings_0801_0930_2021` AS f
    LEFT JOIN (
        SELECT 
            street,
            start_time,
            scene_type_name,
            product_ean_code,
            Recognized_price,
            rec2
        FROM
            (
            SELECT 
                street,
                start_time,
                scene_type_name,
                CAST(product_ean_code AS string) AS product_ean_code,
                Recognized_price,
                CAST(Recognized_price AS string) rec2
            FROM `ccbji-analytics-291203.master_data_US.TRAX_sku_price_0801_0930_2021`
            WHERE Recognized_price BETWEEN 1 AND 1000 
            ) 
        WHERE RIGHT(rec2, 1) = '0'
    ) AS p ON f.product_ean_code = p.product_ean_code AND f.street = p.street AND f.start_time = p.start_time AND f.scene_type_name = p.scene_type_name
    LEFT JOIN (
        SELECT
            street,
            start_time,
            scene_type_name,
            Has_Digital_Payment_
        FROM `ccbji-analytics-291203.master_data_US.TRAX_pos_digital_payment_0801_0930`
    ) AS d ON f.street = d.street AND f.start_time = d.start_time AND f.scene_type_name = d.scene_type_name