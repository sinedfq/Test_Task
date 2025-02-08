SELECT 
    c.name AS category_name,
     SUM(p.price * oi.quantity) as total
FROM 
    categories c
INNER JOIN products p ON c.cat_id = p.cat_id
INNER JOIN order_items oi ON p.prod_id = oi.product_id
INNER JOIN orders o ON oi.ord_id = o.ord_id
WHERE 
    o.status = 'Доставлен' AND o.ordered_at >= DATE_SUB(CURRENT_DATE, INTERVAL 3 YEAR) 
GROUP BY
  c.name
HAVING total > 1500
ORDER BY total DESC;