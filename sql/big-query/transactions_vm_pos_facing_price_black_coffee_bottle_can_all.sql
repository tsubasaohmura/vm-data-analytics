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
WHERE product_ean_code in ('4902102139311', '4904910024995', '4514603377811', '4909411078874', 
                           '4902102118644', '4901085188934', '4901085617694', '4901777301641',
                           '4901777277090' ,'4901777310148', '4902102132787', '4901777258488'
                            )
AND sub_channel_code = 441
