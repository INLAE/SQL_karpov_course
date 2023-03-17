with cancel_orders as (SELECT order_id
                       FROM   user_actions
                       WHERE  action = 'cancel_order'
                       GROUP BY order_id), orders_per_day as (SELECT creation_time :: date as date,
                                              count(order_id) as orders_count
                                       FROM   orders
                                       WHERE  order_id not in (SELECT *
                                                               FROM   cancel_orders)
                                       GROUP BY date)
SELECT date,
       orders_count,
       sum(orders_count) OVER(ORDER BY date) as orders_cum_count
FROM   orders_per_day