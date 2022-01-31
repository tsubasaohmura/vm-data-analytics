SELECT
    visit_date,
    session_uid,
    json_output_version,
    start_time,
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
    street,
    channel,
    user_name,
    scene_type_name,
    product_ean_code,
    product_name,
    CASE 
        WHEN product_ean_code = '4902102074902' THEN REPLACE(manufacturer, '日本コカ・コーラ', '日本コカ・コーラ_170can')
        WHEN manufacturer = '日本コカ・コーラ' THEN REPLACE(manufacturer, '日本コカ・コーラ', '日本コカ・コーラ_185can')
        ELSE manufacturer
    END AS manufacturer,
    brand,
    categoryLocalName,
    sub_category,
    package_type,
    package,
    attribute1,
    Facings,
    latitude,
    longitude,
    Recognized_price,
    Has_Digital_Payment_,
    delivery_code,
    sub_channel_name,
    sub_channel_code	
FROM `ccbji-analytics-291203.master_data_US.TRAX_pos_facing_price_0801_0930_2021` AS f
    LEFT JOIN (
        SELECT 
            delivery_code,
            sub_channel_name,
            sub_channel_code,
        FROM `ccbji-analytics-291203.tsubasa_work.master_vm_subchannel_identifier`
    ) AS m ON f.street = m.delivery_code
WHERE product_ean_code in ('4902102107341', '4514603284317', '4901777235298', '4909411083267',
                           '4904910239801', '4902102074902')
AND sub_channel_code = 441
AND manufacturer in ('日本コカ・コーラ', 'サントリー', 'アサヒ飲料', 'キリンビバレッジ',
                    　 'ダイドードリンコ', '伊藤園', 'ポッカサッポロＦ＆Ｂ')
AND manufacturer IS NOT NULL;