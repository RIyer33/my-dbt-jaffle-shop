with 
orders as ( 

    select * from {{ ref('stg_jaffle_shop__orders') }}

),
payments as
(
    select * from {{ref('stg_stripe__payments')}}
),

customer_payments as (
select 
o.order_id,
o.customer_id,
sum(p.amount) as amount
from orders as o
inner join payments as p using (order_id)
where p.status = 'success'
group by o.order_id, o.customer_id

)
select * from customer_payments
