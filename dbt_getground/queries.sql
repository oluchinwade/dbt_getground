create database dbt_pearl;
create database dbt_prod;

create schema dbt_pearl.core;
create schema dbt_prod.core;

-- testing different timestamp conversions to get the right conversion for Unix Nano

SELECT TO_TIMESTAMP_NTZ(1598856466322480000 / 1000) AS utc_timestamp;

SELECT TO_TIMESTAMP_NTZ(1598856466322480000 / 1000000) AS utc_timestamp;

SELECT TO_TIMESTAMP_NTZ(1598856466322480000 / 1000000000) AS utc_timestamp;

select *, to_timestamp_ntz(created_at/1000000000) as created_at from partners;

-- testing connectivity
select * from stg_partners;

select * from fct_referrals;

-- What is the distribution of referral statuses?
SELECT status, COUNT(*) AS count
FROM fct_referrals
GROUP BY status;

-- How many referrals are inbound vs. outbound?
SELECT is_outbound, COUNT(*) AS count
FROM fct_referrals
GROUP BY is_outbound;

-- What is the average time taken for a referral to move from 'pending' to 'successful' or 'disinterested'?
SELECT 
    AVG(CASE WHEN status = 'successful' THEN DATEDIFF(SECOND, created_at, updated_at) END) / 3600 AS avg_time_to_conversion_successful_hours,
    AVG(CASE WHEN status = 'disinterested' THEN DATEDIFF(SECOND, created_at, updated_at) END) / 3600 AS avg_time_to_conversion_disinterested_hours
FROM fct_referrals
WHERE status IN ('successful', 'disinterested')
  AND created_at <> updated_at; 

-- What are the different types of partners, and how many referrals does each type generate?
SELECT partner_type, COUNT(*) AS count
FROM fct_referrals
GROUP BY partner_type;

-- Which partner has the highest number of successful referrals?
SELECT partner_id, COUNT(*) AS successful_referrals
FROM fct_referrals
WHERE status = 'successful'
GROUP BY partner_id
ORDER BY successful_referrals DESC
LIMIT 1;

-- Who are the lead sales contacts for each partner?
SELECT partner_id, lead_sales_contact
FROM fct_referrals;

-- How many salespeople do we have in each country?
SELECT country, COUNT(*) AS count
FROM fct_referrals
GROUP BY country;

-- Which salesperson manages the most partner accounts?
SELECT lead_sales_contact, COUNT(DISTINCT partner_id) AS partner_count
FROM fct_referrals
GROUP BY lead_sales_contact
ORDER BY partner_count DESC
LIMIT 1;

-- Is there a correlation between partner type and referral success rate?
SELECT partner_type,
    AVG(CASE WHEN status = 'successful' THEN 1 ELSE 0 END) AS success_rate
FROM fct_referrals
GROUP BY partner_type;
