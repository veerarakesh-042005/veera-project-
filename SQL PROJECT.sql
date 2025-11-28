create database project;
use project;

-- Retrive the tool number of orders placed.
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(oi.quantity * p.price), 2)AS total_revenue
FROM 
    order_details oi
JOIN  pizzas p
    ON oi.pizza_id = p.pizza_id;
    
-- Identify the highest-priced pizza  
SELECT 
   pizza_id, price
FROM 
    pizzas
ORDER BY 
    price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    p.size, SUM(oi.quantity) AS total_ordered
FROM 
    order_details oi
JOIN
    pizzas p ON oi.pizza_id = p.pizza_id    
GROUP BY 
	p. size
ORDER BY 
    total_ordered DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
     vr.name AS pizza_type,
	SUM(oi.quantity) AS total_quantity
FROM 
    order_details oi
JOIN
    pizzas p ON oi.pizza_id = p.pizza_id
join
    pizza_types vr ON p.pizza_type_id = vr.pizza_type_id    
GROUP BY 
    vr.name
ORDER BY 
      total_quantity DESC
LIMIT 5;

-- join the necessary tables to find the total quentity of each pizza category ordered
SELECT vr.category,
       SUM(oi.quantity) AS total_quantity
FROM 
    order_details oi
JOIN 
	pizzas p ON oi.pizza_id = p.pizza_id
JOIN 
    pizza_types vr ON p.pizza_type_id = vr.pizza_type_id
GROUP BY 
    vr.category
ORDER BY 
    total_quantity DESC;


-- Detarmine the distribution of orders by hour of the day.
SELECT 
       HOUR(time) AS order_hour, 
       COUNT(*) AS total_orders
FROM 
    Orders
GROUP BY 
	HOUR(time)
ORDER BY 
     order_hour;

-- join relevent tables to find the category wise distribution of pizzas.
SELECT vr.category,
       COUNT(p.pizza_id) AS total_pizzas
FROM 
      pizzas p
JOIN 
      pizza_types vr ON p.pizza_type_id = vr.pizza_type_id
GROUP BY 
      vr.category
ORDER BY 
      total_pizzas DESC;


-- group the orders by date and calculate the average number of pizzas ordered per day.
SELECT p.date,
       SUM(oi.quantity) AS total_pizzas,
       ROUND(avg(sum(oi.quantity)) over(), 2) as avg_pizzas_per_day
FROM 
	orders p
JOIN 
    order_details oi ON p.order_id = oi.order_id
GROUP BY 
    p.date
ORDER BY 
	p.date;

-- Determine the top most ordered pizza types based on revenue.
SELECT 
       vr.name AS pizza_type,
       ROUND(SUM(oi.quantity * p.price), 2) AS total_revenue
FROM 
    order_details oi
JOIN 
    pizzas p ON oi.pizza_id = p.pizza_id
JOIN 
    pizza_types vr ON p.pizza_type_id = vr.pizza_type_id
GROUP BY vr.name
ORDER BY total_revenue DESC
LIMIT 3;




