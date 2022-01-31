SELECT 
    AVG(avg_facing_intermid),
    manufacturer
FROM (
    SELECT 
        AVG(Facings) AS avg_facing_intermid,
        identifier,
        manufacturer
    FROM (
        SELECT 
            Facings,
            CONCAT(street, manufacturer) AS identifier,
            manufacturer
        FROM `ccbji-analytics-291203.master_data_US.TRAX_pos_facing_price_0801_0930_2021`
        )
    GROUP BY identifier, manufacturer
    )
GROUP BY manufacturer