-- 1. Calculate the percentage contribution of each pizza type to total revenue.
WITH avg_rvn AS (
    SELECT
        pizzas.pizza_type_id,
        SUM(order_details.quantity * pizzas.price) AS revenue
    FROM pizzas
    JOIN order_details
        ON pizzas.pizza_id = order_details.pizza_id
    GROUP BY pizzas.pizza_type_id
)
SELECT
    pizza_type_id,
    ROUND(revenue * 100 / SUM(revenue) OVER (), 2)
        AS percentage_revenue
FROM avg_rvn;

-- 2. Analyze the cumulative revenue generated over time.
select order_date,
sum(revenue) over(order by order_date) as cum_revenue
from
(select orders.order_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.order_date) as sales;

-- 3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name, category, revenue from
(select category, name, revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select pizza_types.category, pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as a) as b
where rn <= 3;

