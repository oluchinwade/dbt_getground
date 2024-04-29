{{
  config(
    materialized = 'table'
    , unique_key = ['referral_id']
  )
}}

with referrals as (
    select * from {{ref('stg_referrals')}}
),

partners as(
    select * from {{ref('stg_partners')}}
),

sales_people as (
    select * from {{ref('stg_sales_people')}}
),

mart as (
    select 
        referral_id
        , referrals.created_at
        , referrals.updated_at
        , company_id
        , referrals.partner_id
        , consultant_id
        , status
        , is_outbound
        , partner_type
        , lead_sales_contact
        , country
    from referrals 
    left join partners on referrals.partner_id = partners.partner_id
    left join sales_people on sales_people.name = partners.lead_sales_contact
)

select * from mart