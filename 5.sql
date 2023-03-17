/* отменённые заказы */
with cancels as (SELECT order_id
                                        FROM   user_actions
                                        WHERE  action = 'cancel_order'),
/* заказы с разницей во времени */      
      diff as (
SELECT user_id,
       order_id,
       time,
       time - lag(time, 1) OVER (PARTITION BY user_id
                                 ORDER BY time) as time_diff
FROM   user_actions
WHERE  order_id not in (SELECT *
                        FROM   cancels))
SELECT user_id,
       round(extract(epoch
FROM   avg(time_diff))/3600) as hours_between_orders
FROM   diff
WHERE  time_diff is not null
GROUP BY user_id
ORDER BY user_id limit 1000
