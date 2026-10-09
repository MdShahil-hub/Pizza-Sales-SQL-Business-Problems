-- 1. Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;

-- 2. Calculate the total revenue generated from pizza sales.
select 
round (
	sum(order_details.quantity*pizzas.price),
	2 )as total_revenue
from
order_details join
pizzas on 
	order_details.pizza_id = pizzas.pizza_id;

-- 3. Identify the highest-priced pizza.
SELECT pizza_id, pizza_type_id, price AS highest_priced_pizza
FROM pizzas
ORDER BY price DESC
LIMIT 1;

-- 4. Identify the most common pizza size ordered.
SELECT 
    p.size,
    SUM(od.quantity) AS total_pizzas_sold
FROM pizzas p
JOIN order_details od
    ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY total_pizzas_sold DESC;

-- 5. List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_type_id, SUM(quantity) AS quantity
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.pizza_type_id
limit 5;

