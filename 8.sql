WITH count_orders AS (SELECT DISTINCT(courier_id),
                            count(order_id) OVER(PARTITION BY courier_id) as orders_count
            FROM   courier_actions
            WHERE  action = 'deliver_order'
            ORDER BY orders_count desc, courier_id), 
	 rank_orders AS (SELECT courier_id,
                  orders_count,
                  rank() OVER(ORDER BY orders_count desc, courier_id) as courier_rank
            FROM   count_orders)
SELECT *
FROM   rank_orders
WHERE  courier_rank <= ((SELECT (max(courier_rank) * 0.1 + 1)::int
                         FROM   rank_orders))