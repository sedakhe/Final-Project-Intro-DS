WITH daily AS (
    SELECT
        DATE(transaction_time)            AS txn_date,       
        AVG(transaction_amount)           AS daily_avg
    FROM transactions
    WHERE transaction_time >= '2021-01-01'
      AND transaction_time <  '2021-02-01'
    GROUP BY DATE(transaction_time)
)
SELECT
    txn_date,
    daily_avg,
    AVG(daily_avg) OVER (
        ORDER BY txn_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3day_avg
FROM daily
ORDER BY txn_date;
