SELECT 
    AVG(Facings),
    manufacturer
FROM `ccbji-analytics-291203.master_data_US.TRAX_pos_facing_price_0801_0930_2021`
GROUP BY manufacturer
