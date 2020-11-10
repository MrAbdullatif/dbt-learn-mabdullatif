{{
  config(
    materialized='view'
  )
}}

select 
    customer_id, 
    order_id, 
    sum(to_decimal(ZEROIFNULL(amount),10,2)) as amount
from {{ ref('stg_orders') }}
left join {{ ref('stg_payments') }} using (order_id)
where stg_payments.status = 'success'
group by 
    customer_id, 
    order_id