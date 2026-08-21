create view vw_customer_rfm as
with customer_rfm as
(
    select
        [Customer ID],
        count(distinct Invoice) as frequency,
        max(InvoiceDate) as last_purchase_date,
        sum(Quantity * Price) as monetary
    from retail_sales
    group by [Customer ID]
),
rfm_values as
(
    select
        [Customer ID],
        datediff(
            day,
            last_purchase_date,
            (select max(InvoiceDate) from retail_sales)
        ) as recency,
        frequency,
        monetary
    from customer_rfm
),
rfm_scores as
(
    select
        [Customer ID],
        recency,
        frequency,
        monetary,
        6 - ntile(5) over (order by recency)   as recency_score,
        ntile(5) over (order by frequency)     as frequency_score,
        ntile(5) over (order by monetary)      as monetary_score
    from rfm_values
)
select
    [Customer ID],
    recency,
    frequency,
    monetary,
    recency_score,
    frequency_score,
    monetary_score,
    cast(recency_score as varchar(1)) +
    cast(frequency_score as varchar(1)) +
    cast(monetary_score as varchar(1)) as rfm_score,
    case
        when recency_score >= 4 and frequency_score >= 4 and monetary_score >= 4
            then 'Champions'
        when recency_score >= 3 and frequency_score >= 3 and monetary_score >= 3
            then 'Loyal Customers'
        when recency_score >= 4 and frequency_score <= 2
            then 'New / Potential Loyalists'
        when recency_score <= 2 and frequency_score >= 4 and monetary_score >= 4
            then 'At Risk'
        when recency_score <= 2 and frequency_score <= 2 and monetary_score <= 2
            then 'Lost'
        else 'Others'
    end as customer_segment
from rfm_scores;

