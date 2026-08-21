
-- cohort analysis
;with customer_first_purchase as
(
    select
        [Customer ID],
        min(InvoiceDate) as first_purchase_date
    from retail_sales
    group by [Customer ID]
),
customer_cohort as
(
    select
        [Customer ID],
        dateadd(month, datediff(month, 0, first_purchase_date), 0) as cohort_month
    from customer_first_purchase
),
sales_with_cohort as
(
    select
        r.[Customer ID],
        c.cohort_month,
        dateadd(month, datediff(month, 0, r.invoicedate), 0) as invoice_month,
        r.Quantity,
        r.Price
    from retail_sales r
    join customer_cohort c
        on r.[Customer ID] = c.[Customer ID]
),
cohort_activity as
(
    select
        cohort_month,
        datediff(month, cohort_month, invoice_month) as cohort_index,
        count(distinct [customer id]) as active_customers,
        sum(quantity * price) as cohort_revenue
    from sales_with_cohort
    group by cohort_month, datediff(month, cohort_month, invoice_month)
),
cohort_size as
(
    select
        cohort_month,
        active_customers as customers_at_month_0
    from cohort_activity
    where cohort_index = 0
)
select
    a.cohort_month,
    a.cohort_index,
    a.active_customers,
    a.cohort_revenue,
    s.customers_at_month_0,
    cast(a.active_customers * 100.0 / s.customers_at_month_0 as decimal(5,2)) as retention_pct
from cohort_activity a
join cohort_size s
    on a.cohort_month = s.cohort_month
order by a.cohort_month, a.cohort_index;