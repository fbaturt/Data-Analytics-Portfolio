/*******************************************************************************
PROJECT: GA4 E-commerce User Journey & Conversion Analysis
PLATFORM: Google BigQuery (GA4 Public Dataset)
OBJECTIVE: Rebuild the e-commerce funnel, evaluate landing page performance, and calculate the correlation between user engagement and revenue.
*******************************************************************************/

-- 1. DATA PREPARATION: CLEAN EVENT EXTRACTION
-- Goal: Extract core e-commerce events from nested GA4 schema for the 2021 period.
select
  timestamp_micros(event_timestamp) as event_timestamp,
  user_pseudo_id,
  (select value.int_value from unnest(event_params) where key = 'ga_session_id') as session_id,
  event_name,
  geo.country as country,
  device.category as device_category,
  traffic_source.name as campaign,
  traffic_source.medium as medium,
  traffic_source.source as source
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
where _table_suffix between '20210101' and '20211231' and event_name in ('session_start', 'view_item', 'add_to_cart', 'begin_checkout', 'add_shipping_info', 'add_payment_info', 'purchase')

-- 2. CONVERSION FUNNEL BY TRAFFIC CHANNEL
-- Goal: Analyze the drop-off rates from session start to purchase by source/medium.
with Raw_Data as (
  select
    parse_date('%Y%m%d', event_date) as event_date,
    user_pseudo_id,
    (select value.int_value from unnest(event_params) where key = 'ga_session_id') as session_id,
    event_name,
    traffic_source.name as campaign,
    traffic_source.medium as medium,
    traffic_source.source as source
  from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  where _table_suffix between '20210101' and '20211231'  
  ),

Session_Prep as (
  select
    *,
    concat(user_pseudo_id, '-', cast(session_id as string)) as unique_session_id
  from Raw_Data
  where session_id is not null
),

Valid_Sessions as(
  select distinct unique_session_id
  from Session_Prep
  where event_name = 'session_start'
)

select
  s.event_date,
  s.source,
  s.medium,
  s.campaign,
  count(distinct s.unique_session_id) as user_sessions_count,
  round(safe_divide(count(distinct case when event_name = 'add_to_cart' then s.unique_session_id end), count(distinct s.unique_session_id)), 4) as visit_to_cart,
  round(safe_divide(count(distinct case when event_name = 'begin_checkout' then s.unique_session_id end), count(distinct s.unique_session_id)), 4) as visit_to_checkout,
  round(safe_divide(count(distinct case when event_name = 'purchase' then s.unique_session_id end), count(distinct s.unique_session_id)), 4) as visit_to_purchase
from Session_Prep s
inner join Valid_Sessions v
  on s.unique_session_id = v.unique_session_id
group by 1, 2, 3, 4
order by event_date desc;

-- 3. LANDING PAGE PERFORMANCE (CRO ANALYSIS)
-- Goal: Use Regex to extract page paths and compare conversion rates across landing pages.
with Events_Prep as (
  select
    user_pseudo_id,
    (select value.int_value from unnest(event_params) where key = 'ga_session_id') as session_id,
    event_name,
    (select value.string_value from unnest(event_params) where key = 'page_location') as page_location
  from`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  where _table_suffix between '20200101' and '20201231'
),

Landing_Pages as (
  select distinct
    concat(user_pseudo_id, '-', cast(session_id as string)) as unique_session_id,
    regexp_extract(page_location, r'^https?://[^/]+([^?#]*)') as page_path
  from Events_Prep
  where event_name = 'session_start'
),

Purchases as(
  select distinct
    concat(user_pseudo_id, '-', cast(session_id as string)) as unique_session_id
  from Events_Prep
  where event_name = 'purchase'
)

select
  lp.page_path,
  count(distinct lp.unique_session_id) as total_sessions,
  count(distinct p.unique_session_id) as total_purchase,
  round(safe_divide(count(distinct p.unique_session_id), count(distinct lp.unique_session_id)) * 100, 2) as conversion_rate_percentage
from Landing_Pages lp
left join Purchases p
  on lp.unique_session_id = p.unique_session_id
where lp.page_path is not null
group by lp.page_path
order by total_sessions desc;

-- 4. USER ENGAGEMENT VS. PURCHASE CORRELATION
-- Goal: Statistically determine if active engagement time correlates with final purchases.
with Session_Stats as (
  select
    user_pseudo_id,
    (select value.int_value from unnest(event_params) where key = 'ga_session_id') as session_id,
    max(cast((select value.string_value from unnest(event_params) where key = 'session_engaged') as int64)) as is_engaged,
    coalesce(sum((select value.int_value from unnest (event_params) where key = 'engagement_time_msec')), 0) as total_engagement_time,
    max(case when event_name = 'purchase' then 1 else 0 end) as made_purchase
  from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  where _table_suffix between '20210101' and '20211231'
  group by user_pseudo_id, session_id
)

select
  corr(is_engaged, made_purchase) as engagement_purchase_correlation,
  corr(total_engagement_time, made_purchase) as time_purchase_correlation
from Session_Stats
where session_id is not null;
