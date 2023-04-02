{\rtf1\ansi\ansicpg1252\cocoartf2708
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 WITH  canceled_orders as (SELECT order_id\
                                        FROM   user_actions\
                                        WHERE  action = 'cancel_order'),\
    unnested_products as (SELECT creation_time, unnest(product_ids) as product_id \
                                        FROM orders \
                                        WHERE order_id not in (SELECT * FROM canceled_orders)),\
              revenue as (SELECT creation_time::date as date, sum(price) as revenue\
                                        FROM   unnested_products LEFT JOIN products using (product_id)\
                                        GROUP BY date)                                    \
\
SELECT date,\
       revenue,\
       sum(revenue) OVER (ORDER BY date) as total_revenue,\
       round(100 * (revenue - lag(revenue, 1) OVER (ORDER BY date))::decimal / lag(revenue, 1) OVER (ORDER BY date),\
             2) as revenue_change\
FROM   revenue}
