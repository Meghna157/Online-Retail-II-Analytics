use OnlineRetailDB;

-- top 10 customers by revenue

select top 10 
	[Customer ID],
	count(distinct Invoice) as total_orders,
	sum(Quantity) as total_quantity,
	sum(Quantity * Price) as total_revenue
from retail_sales
group by [Customer ID]
order by total_revenue desc;

-- average order value per customer (customer order value)

select top 10
	[Customer ID],
	count(distinct Invoice) as total_orders,
	sum(Quantity * Price) as total_revenue,
	sum(Quantity * Price) / count(distinct Invoice) as average_order_value
from retail_sales
group by [Customer ID]
order by average_order_value desc;

-- high value customers with minimum orders

select top 10
	[Customer ID],
	count(distinct Invoice) as total_orders,
	sum(Quantity * Price) as total_revenue,
	sum(Quantity * Price) / count(distinct Invoice) as average_order_value
from retail_sales
group by [Customer ID]
having count(distinct Invoice) >= 5
order by average_order_value desc;

-- Customer Segmentation
--- RFM Analysis


select customer_segment, count(*) as num_customers
from vw_customer_rfm
group by customer_segment
order by num_customers desc;

select customer_segment,
       count(*) as num_customers,
       sum(monetary) as segment_revenue,
       avg(monetary) as avg_customer_value
from vw_customer_rfm
group by customer_segment
order by segment_revenue desc;