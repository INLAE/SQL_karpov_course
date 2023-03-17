SELECT product_id, name, price, ROW_NUMBER() OVER w as product_number, 
                                RANK() OVER w as product_rank, 
                                DENSE_RANK() OVER w as product_dense_rank
FROM products
WINDOW w AS (ORDER BY price DESC)
