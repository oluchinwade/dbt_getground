{{
  config(
    materialized = 'table'
    , tag = ['do_not_run']
  )
}}


with sales_people as(
  select
    name
    , country
  from {{ ref('sales_people')}}
)

, final as (
  select
    name
    , country
  from sales_people
)

select * from final
