with t1 as (SELECT user_id ,
                   order_id ,
                   action ,
                   time ,
                   count(order_id) filter (WHERE action = 'create_order') OVER (PARTITION BY user_id
                                                                                ORDER BY time) created_orders ,
                   count(order_id) filter (WHERE action = 'cancel_order') OVER (PARTITION BY user_id
                                                                                ORDER BY time) canceled_orders
            FROM   user_actions)
SELECT *,
       round(canceled_orders::decimal/ created_orders, 2) cancel_rate
FROM   t1
ORDER BY user_id, order_id, time limit 1000