-- running totals
with monthly_sales as
(
    select
        year(InvoiceDate) as sales_year,
        month(InvoiceDate) as sales_month,
        sum(Quantity * Price) as monthly_revenue,
        count(distinct Invoice) as monthly_orders
    from retail_sales
    group by year(InvoiceDate), month(InvoiceDate)
)
select
    m1.sales_year,
    m1.sales_month,
    m1.monthly_revenue,
    (
        select sum(m2.monthly_revenue) 
        from monthly_sales m2
        where (m2.sales_year < m1.sales_year) 
           or (m2.sales_year = m1.sales_year and m2.sales_month <= m1.sales_month)
    ) as running_revenue,
    
    m1.monthly_orders,
    (
        select sum(m2.monthly_orders) 
        from monthly_sales m2
        where (m2.sales_year < m1.sales_year) 
           or (m2.sales_year = m1.sales_year and m2.sales_month <= m1.sales_month)
    ) as running_orders

from monthly_sales m1
order by m1.sales_year, m1.sales_month;
