with cancel_orders as (SELECT order_id
                         FROM   user_actions
                         WHERE  action = 'cancel_order'
                         GROUP BY order_id)
SELECT user_id,
       order_id,
       time,
       row_number() OVER(PARTITION BY user_id
                         ORDER BY time) as order_number,
       lag(time, 1) OVER(PARTITION BY user_id) as time_lag,
       time - lag(time, 1) OVER(PARTITION BY user_id) as time_diff
FROM   user_actions
WHERE  order_id not in (SELECT *
                        FROM   cancel_orders) limit 1000
