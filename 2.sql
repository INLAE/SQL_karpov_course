SELECT product_id,
       name,
       price,
       max(price) OVER () as max_price,
       round(price / max(price) OVER (), 2) as share_of_max
FROM   products
ORDER BY price desc, product_id