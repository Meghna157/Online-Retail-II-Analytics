use OnlineRetailDB

-- top 10 products by revenue

select top 10
	StockCode , 
	[Description], 
	sum(Quantity * Price) as total_revenue 
from retail_sales 
group by StockCode, [Description]
order by total_revenue desc 

-- top 10 product by quantity

select top 10
	StockCode ,
	[Description] ,
	sum(Quantity) as total_quantity
from retail_sales
group by StockCode, [Description]
order by total_quantity desc 

-- product ranking

;with Product_Sales as
(
	select
		StockCode,
		[Description],
		sum(Quantity * Price) as total_revenue
	from retail_sales
	group by StockCode, [Description]
)
select top 10 *,
	rank() over(order by total_revenue desc) as revenue_rank
from Product_Sales
order by revenue_rank;

