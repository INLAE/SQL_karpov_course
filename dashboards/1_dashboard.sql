with min_time as (SELECT user_id,
                         min(time::date) as date
                  FROM   user_actions
                  GROUP BY user_id), first_courier_activity as (SELECT courier_id,
                                                     min(time::date) as date
                                              FROM   courier_actions
                                              GROUP BY courier_id)
SELECT date,
       count(distinct user_id) as new_users,
       count(distinct courier_id) as new_couriers,
       sum(count(distinct user_id)::int) OVER(ORDER BY date) as total_users,
       sum(count(distinct courier_id)::int) OVER(ORDER BY date) as total_couriers
FROM   min_time
    INNER JOIN first_courier_activity using(date)
GROUP BY date
ORDER BY date
