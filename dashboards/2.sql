 WITH  canceled_orders as (SELECT order_id
                                        FROM   user_actions
                                        WHERE  action = 'cancel_order'),
    unnested_products as (SELECT creation_time, unnest(product_ids) as product_id 
                                        FROM orders 
                                        WHERE order_id not in (SELECT * FROM canceled_orders)),
              revenue as (SELECT creation_time::date as date, sum(price) as revenue
                                        FROM   unnested_products LEFT JOIN products using (product_id)
                                        GROUP BY date)                                    

SELECT date,
       revenue,
       sum(revenue) OVER (ORDER BY date) as total_revenue,
       round(100 * (revenue - lag(revenue, 1) OVER (ORDER BY date))::decimal / lag(revenue, 1) OVER (ORDER BY date),
             2) as revenue_change
FROM   revenue
