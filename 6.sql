with sep_couriers as (
  select
    courier_id,
    count(*) as delivered_orders
  from
    courier_actions
  where
    DATE_PART('month', time) = 09
    and action = 'deliver_order'
  group by
    1
)
select
  courier_id,
  delivered_orders,
  ROUND(avg(delivered_orders) over(), 2) as avg_delivered_orders,
  case
    when delivered_orders > ROUND(avg(delivered_orders) over(), 2) then 1
    else 0
  end as is_above_avg
from
  sep_couriers
order by
  1