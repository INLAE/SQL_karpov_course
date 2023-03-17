with cancel_orders as (SELECT order_id
                       FROM   user_actions
                       WHERE  action = 'cancel_order'
                       GROUP BY order_id)
SELECT user_id,
       order_id,
       time,
       row_number() OVER(PARTITION BY user_id
                         ORDER BY time) as order_number
FROM   user_actions
WHERE  order_id not in (SELECT *
                        FROM   cancel_orders) limit 1000