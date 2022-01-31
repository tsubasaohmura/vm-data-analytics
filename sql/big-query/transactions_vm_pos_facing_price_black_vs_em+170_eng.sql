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
        WHEN product_ean_code = '4902102107341' THEN REPLACE(product_name, 'ジョージア エメラルドマウンテンブレンド 185g缶', '185 GEORGIA EMERALD MOUNTAIN BLEND')
        WHEN product_ean_code = '4902102074902' THEN REPLACE(product_name, 'ジョージア エメラルドマウンテンブレンド 170g缶', '170 GEORGIA EMERALD MOUNTAIN BLEND')
        WHEN product_ean_code = '4901777235298' THEN REPLACE(product_name, 'ボス レインボーマウンテンブレンド 185g缶', 'BOSS RAINBOW MOUNTAIN')
        WHEN product_ean_code = '4514603284317' THEN REPLACE(product_name, 'ワンダ モーニングショット 185g缶', 'WONDA MORNING SHOT')
        WHEN product_ean_code = '4904910239801' THEN REPLACE(product_name, 'ダイドーブレンド ブレンドコーヒー 185g缶', 'DyDo-BLEND BLEND COFFEE')
        WHEN product_ean_code = '4909411083267' THEN REPLACE(product_name, 'ファイア 直火ブレンド 185g缶', 'FIRE OPEN FIRE BLEND')
        ELSE product_name
    END AS product_name_eng,
    CASE 
        WHEN product_ean_code = '4902102074902' THEN REPLACE(manufacturer, '日本コカ・コーラ', '日本コカ・コーラ_170can')
        WHEN manufacturer = '日本コカ・コーラ' THEN REPLACE(manufacturer, '日本コカ・コーラ', '日本コカ・コーラ_185can')
        ELSE manufacturer
    END AS manufacturer,
    CASE 
        WHEN product_ean_code = '4902102074902' THEN REPLACE(manufacturer, '日本コカ・コーラ', 'Coca-Cola_170can')
        WHEN manufacturer = '日本コカ・コーラ' THEN REPLACE(manufacturer, '日本コカ・コーラ', 'Coca-Cola_185can')
        WHEN manufacturer = 'サントリー' THEN REPLACE(manufacturer, 'サントリー', 'Suntory')
        WHEN manufacturer = 'アサヒ飲料' THEN REPLACE(manufacturer, 'アサヒ飲料', 'Asahi')
        WHEN manufacturer = 'キリンビバレッジ' THEN REPLACE(manufacturer, 'キリンビバレッジ', 'Kirin')
        WHEN manufacturer = 'ダイドードリンコ' THEN REPLACE(manufacturer, 'ダイドードリンコ', 'DyDo')
        WHEN manufacturer = 'ポッカサッポロＦ＆Ｂ' THEN REPLACE(manufacturer, 'ポッカサッポロＦ＆Ｂ', 'Pokka Sapporo')
        WHEN manufacturer = '伊藤園' THEN REPLACE(manufacturer, '伊藤園', 'Itoen')

        ELSE manufacturer
    END AS manufacturer_eng,
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