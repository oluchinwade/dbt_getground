{{
  config(
    materialized = 'table'
    , tag = ['do_not_run']
  )
}}

with referrals as(
  select
    id as  referral_id
    , to_timestamp_ntz(created_at/1000000000) as created_at
    , to_timestamp_ntz(updated_at/1000000000) as updated_at
    , company_id
    , partner_id
    , consultant_id
    , status
    , case 
        when is_outbound = 1 then 'TRUE'
      else 'FALSE'
      end as is_outbound
  from {{ ref('referrals')}}
)

, final as (
  select
    referral_id
    , created_at
    , updated_at
    , company_id
    , partner_id
    , consultant_id
    , status
    , is_outbound
  from referrals
)


select * from final