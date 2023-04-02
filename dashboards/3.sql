WITH canceled_orders AS (SELECT order_id
                                        FROM   user_actions
                                        WHERE  action = 'cancel_order'),
     unnest_products AS (SELECT order_id,
                       creation_time,
                       unnest(product_ids) as product_id
                                     FROM   orders
                                     WHERE  order_id not in (SELECT * FROM canceled_orders)),
            revenue  AS (SELECT creation_time::date as date, count(distinct order_id) as orders,
                                                             sum(price) as revenue
                                     FROM   unnest_products  LEFT JOIN products using(product_id)
                                     GROUP BY date),
          all_users  AS (SELECT time::date as date, count(distinct user_id) as all_users
                                     FROM   user_actions
                                     GROUP BY date),    
        paying_users AS (SELECT time::date as date, count(distinct user_id) as paying_users
                                     FROM   user_actions
                                     WHERE  order_id not in (SELECT * FROM canceled_orders)
                                    GROUP BY date)                              
                            
SELECT date,
       round(revenue::decimal / all_users, 2) as arpu,
       round(revenue::decimal / paying_users, 2) as arppu,
       round(revenue::decimal / orders, 2) as aov
FROM   revenue
    LEFT JOIN all_users USING (date)
    LEFT JOIN paying_users USING (date)
ORDER BY dateSELECT * FROM new_schema.table_2;