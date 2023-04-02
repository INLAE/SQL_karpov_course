WITH canceled_orders AS (SELECT order_id
                        FROM   user_actions
                        WHERE  action = 'cancel_order'),
                        
      unnest_orders  AS (SELECT order_id,
                               unnest(product_ids) as product_id
                        FROM   orders
                        WHERE  order_id not in (SELECT *
                                                FROM   canceled_orders)),
                                                
             revenue AS (SELECT name, sum(price) as revenue
                       FROM   unnest_orders  LEFT JOIN products using(product_id)
                       GROUP BY name),
                       
          categories AS (SELECT 
                                   CASE WHEN round(100 * revenue / sum(revenue) OVER (), 2) >= 0.5 
                                        THEN name ELSE 'ДРУГОЕ' 
                                        END AS product_name,
                            revenue, round(100 * revenue / sum(revenue) OVER (), 2) as share_in_revenue
                        FROM   revenue)           

SELECT product_name,
       sum(revenue) as revenue,
       sum(share_in_revenue) as share_in_revenue
FROM   categories
GROUP BY product_name
ORDER BY revenue desc