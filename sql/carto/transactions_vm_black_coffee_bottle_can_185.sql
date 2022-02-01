SELECT
    *
FROM `ccbji-analytics-291203.tsubasa_work.transactions_vm_pos_facing_price_black_coffee_bottle_can_185`
WHERE manufacturer in ('日本コカ・コーラ', 'サントリー', 'アサヒ飲料', 'キリンビバレッジ',
                    　 'ダイドードリンコ', '伊藤園', 'ポッカサッポロＦ＆Ｂ')
AND manufacturer IS NOT NULL;