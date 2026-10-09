-- 1. Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category, SUM(od.quantity) AS total_quantity
FROM
    order_details AS od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- 2. Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(order_id) AS total_order
FROM
    orders
GROUP BY HOUR(order_time);

-- 3. Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- 4. Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    round(AVG(order_by_date.quantity),0) as average_no_of_pizzas_opd
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_by_date;

-- 5. Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizzas.pizza_type_id,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS revenue
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_type_id
ORDER BY revenue DESC
LIMIT 3;
