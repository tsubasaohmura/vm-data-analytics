#standardSQL
SELECT
    *
FROM    (
    SELECT 
        VENDINGMACHINE_CD,
        calday,
        sales_amount
    FROM (
        SELECT 
            VENDINGMACHINE_CD,
            PARSE_DATE("%Y/%m/%d", CONCAT(CAST(SUBSTRING(VM_MAIN_CONTROLLER_DATETIME, 0, 4) AS string), '/', CAST(SUBSTRING(VM_MAIN_CONTROLLER_DATETIME, 5, 2) AS string), '/', CAST(SUBSTRING(VM_MAIN_CONTROLLER_DATETIME, 7, 2) AS string))) AS calday,
            COUNT(*) AS sales_amount
        FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.t_ml_cmos_all_std_full_4g`
        WHERE LENGTH(VM_MAIN_CONTROLLER_DATETIME) = 14
        AND SUBSTRING(VM_MAIN_CONTROLLER_DATETIME, 5,1) = '1'
        OR SUBSTRING(VM_MAIN_CONTROLLER_DATETIME, 5,1) = '0'
        GROUP BY VENDINGMACHINE_CD, VM_MAIN_CONTROLLER_DATETIME
        )
    WHERE calday BETWEEN '2021-12-01' AND '2021-12-31'
    )
UNION ALL (
    SELECT 
        VENDINGMACHINE_CD,
        PARSE_DATE("%Y%m%d", calday_str) AS calday,
        sales_amount
    FROM (
        SELECT 
            VENDINGMACHINE_CD,
            calday_str,
            sales_amount
        FROM (
            SELECT 
                VENDINGMACHINE_CD,
                CONCAT(CAST(SUBSTRING(VM_MAIN_CONTROLLER_DATETIME, 0, 4) AS string), CAST(SUBSTRING(VM_MAIN_CONTROLLER_DATETIME, 5, 2) AS string), CAST(SUBSTRING(VM_MAIN_CONTROLLER_DATETIME, 7, 2) AS string)) AS calday_str,
                COUNT(*) AS sales_amount
            FROM `ccbji-analytics-291203.VMDataAnalytics_Prod.t_ml_cmos_all_std_full_5g`
            WHERE LENGTH(VM_MAIN_CONTROLLER_DATETIME) = 14
            AND VM_MAIN_CONTROLLER_DATETIME NOT LIKE "20??%"
            AND SUBSTRING(VM_MAIN_CONTROLLER_DATETIME, 5,1) IN ('0', '1')
            GROUP BY VENDINGMACHINE_CD, VM_MAIN_CONTROLLER_DATETIME
            )
        WHERE calday_str NOT LIKE "%00"
        )
    WHERE PARSE_DATE("%Y%m%d", calday_str) BETWEEN '2021-12-01' AND '2021-12-31'
    )