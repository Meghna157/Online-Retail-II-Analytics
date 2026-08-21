use OnlineRetailDB
-- select count(*) as total_rows from retail_sales;
-- KPIs 

-- Total Revenue

select sum(Quantity * Price) as total_revenue from retail_sales

-- Total Quantity

select sum(Quantity) as total_quantity from retail_sales

-- Total Orders

select count(distinct Invoice) as total_orders from retail_sales

-- Total Customers

select count(distinct [Customer ID]) as total_customers from retail_sales

-- Average Order Value

select sum(Quantity * Price) / count(distinct Invoice) as average_order_value from retail_sales

-- Revenue by year

select 
	year(InvoiceDate) as sales_year,
	sum(Quantity * Price) as total_revenue,
	count(distinct Invoice) as total_orders,
	count(distinct [Customer ID]) as total_customers
from retail_sales
group by year(InvoiceDate) 
order by sales_year

-- monthly sales trend

select
	year(InvoiceDate) as sales_year,
	month(InvoiceDate) as sales_month,
	sum(Quantity * Price) as total_revenue,
	count(distinct Invoice) as total_orders,
	count(distinct [Customer ID]) as total_customers
from retail_sales
group by year(InvoiceDate), month(InvoiceDate)
order by sales_year, sales_month

-- revenue by country

select
	Country,
	sum(Quantity * Price) as total_revenue,
	count(distinct Invoice) as total_orders,
	count(distinct [Customer ID]) as total_customers
from retail_sales
group by Country
order by total_revenue desc 

/* SELECT
    [Customer ID],
    COUNT(DISTINCT Invoice) AS total_orders,
    SUM(Quantity * Price) AS total_revenue
FROM retail_sales
WHERE Country = 'EIRE'
GROUP BY [Customer ID]
ORDER BY total_revenue DESC; */