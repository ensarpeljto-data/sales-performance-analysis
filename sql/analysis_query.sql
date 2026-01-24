

create table sales_1 (
order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    region VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(200),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2)
);

SELECT TOP 5 * FROM [Sample - Superstore]

SELECT * 
FROM superstore


SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percentage,
    COUNT(DISTINCT [Order_ID]) AS total_orders,
    ROUND(SUM(Sales) / COUNT(DISTINCT [Order_ID]), 2) AS average_order_value
FROM superstore;


SELECT TOP 10
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC;


WITH monthly_sales AS (
    SELECT
        FORMAT(order_date, 'yyyy-MM') AS order_month,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY FORMAT(order_date, 'yyyy-MM')
)
SELECT
    order_month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY order_month)) 
        / LAG(total_sales) OVER (ORDER BY order_month) * 100,
    2) AS month_over_month_growth_percentage
FROM monthly_sales
ORDER BY order_month


SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / NULLIF(SUM(sales),0) * 100, 2) AS profit_margin_percentage
FROM superstore
GROUP BY sub_category
ORDER BY profit_margin_percentage DESC;


SELECT
    discount,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY discount
ORDER BY discount;


-- The total sales of the products amount 113.1591.720 $ with an overall margin profit 159,06 %

-- Sales show a strong seasonal peak in Q4, suggesting holiday-driven demand.

-- Technology is a fore-runner in terms of the revenue, while Office Supplies has the highest profit margin.

-- A small group of top 10 customers contributes a significant share of total revenue, indicating customer concentration.

-- Higher discount levels correlate with declining profit margins, suggesting that aggressive discounting reduces profitability.












