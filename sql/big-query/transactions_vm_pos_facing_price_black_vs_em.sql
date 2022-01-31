SELECT
*
FROM `ccbji-analytics-291203.master_data_US.TRAX_pos_facing_price_0801_0930_2021` AS f
    LEFT JOIN (
        SELECT 
            delivery_code,
            sub_channel_name,
            sub_channel_code,
        FROM `ccbji-analytics-291203.tsubasa_work.master_vm_subchannel_identifier`
    ) AS m ON f.street = m.delivery_code
WHERE product_ean_code in ('4902102107341', '4514603284317', '4901777235298', '4909411083267',
                           '4904910239801')
AND sub_channel_code = 441
AND manufacturer in ('日本コカ・コーラ', 'サントリー', 'アサヒ飲料', 'キリンビバレッジ',
                    　 'ダイドードリンコ', '伊藤園', 'ポッカサッポロＦ＆Ｂ')
AND manufacturer IS NOT NULL;