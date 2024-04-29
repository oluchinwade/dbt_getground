{{
  config(
    materialized = 'table'
    , unique_key = ['partner_id']
  )
}}

with partners as(
  select
    id as partner_id
    , to_timestamp_ntz(created_at/1000000000) as created_at
    , to_timestamp_ntz(updated_at/1000000000) as updated_at
    , partner_type
    , lead_sales_contact
  from {{ ref('partners')}}
)
, final as (
  select
    partner_id
    , created_at
    , updated_at
    , partner_type
    , lead_sales_contact
  from partners
)

select * from final
