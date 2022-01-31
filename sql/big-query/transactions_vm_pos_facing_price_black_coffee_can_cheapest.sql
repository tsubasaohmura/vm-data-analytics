SELECT 
*
FROM (
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
    WHERE product_ean_code in ('4901085603154', '4582409186913', '4902179021427', '4902102122498', 
                            '4902102133449', '4902102133425', '4904910046317', '4904910239382', 
                            '4909411083304', '4901201208096', '4901301287618', '4901777204980', '4514603376616')
    AND sub_channel_code = 441
    )
WHERE CONCAT(product_ean_code, Recognized_price) IN (
    SELECT
        CONCAT(
            product_ean_code,
            MIN(Recognized_price)
        )
    FROM `ccbji-analytics-291203.master_data_US.TRAX_pos_facing_price_0801_0930_2021` AS f
        LEFT JOIN (
            SELECT 
                delivery_code,
                sub_channel_name,
                sub_channel_code,
            FROM `ccbji-analytics-291203.tsubasa_work.master_vm_subchannel_identifier`
        ) AS m ON f.street = m.delivery_code
    WHERE product_ean_code in ('4901085603154', '4582409186913', '4902179021427', '4902102122498', 
                            '4902102133449', '4902102133425', '4904910046317', '4904910239382', 
                            '4909411083304', '4901201208096', '4901301287618', '4901777204980', '4514603376616')
    AND sub_channel_code = 441
    GROUP BY product_ean_code
    )