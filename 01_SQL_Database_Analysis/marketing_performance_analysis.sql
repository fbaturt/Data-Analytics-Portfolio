/*******************************************************************************
PROJECT: Omnichannel Marketing Performance Deep-Dive
DATABASE: PostgreSQL (DBeaver)
OBJECTIVE: Analyze cross-platform (Google & Facebook) ad performance to identify spend efficiency, ROMI records, and audience reach growth.
*******************************************************************************/

-- 1. CROSS-PLATFORM SPEND ANALYSIS
-- Goal: Calculate daily spend volatility (Avg, Max, Min) across platforms.
with Daily_Totals as (
	select
		'Facebook' as media_source,
		ad_date,
		sum(spend) as daily_spend
	from facebook_ads_basic_daily
	group by ad_date
	
	union all
	
	select
		'Google' as media_source,
		ad_date,
		sum(spend) as daily_spend
	from google_ads_basic_daily
	group by ad_date
)
select
	media_source,
	round(avg(daily_spend), 2) as Average,
	max(daily_spend) as Maximum,
	min(daily_spend) as Minimum
from Daily_Totals
group by media_source;

-- 2. TOP PERFORMING DAYS BY ROMI
-- Goal: Identify the top 5 days with the highest Return on Marketing Investment.
with Combined_Data as (
	select
		'Facebook' as media_source,	
		ad_date,
		spend,
		value
	from facebook_ads_basic_daily
	
	union all
	
	select
		'Google' as media_source,
		ad_date,
		spend,
		value
	from google_ads_basic_daily
)

select
	media_source,
	ad_date,
	round(1.0 * sum(value) / nullif(sum(spend), 0), 3) as Total_ROMI
from Combined_Data
group by media_source, ad_date having sum(spend) > 0
order by Total_ROMI desc
limit 5;

-- 3. WEEKLY REVENUE RECORDS
-- Goal: Find the single highest revenue-generating campaign in a single week.
with Combined_Data as (
	select
		'Facebook' as media_source,
		cast(campaign_id as varchar) as campaign_identifier,
		ad_date,
		value
	from facebook_ads_basic_daily
	
	union all
	
	select
		'Google' as media_source,
		campaign_name as campaign_identifier,
		ad_date,
		value
	from google_ads_basic_daily
)

select 
	media_source,
	cast(date_trunc('week', ad_date) as date) as ad_week,
	campaign_identifier,
	sum(value) as Total_Revenue
from Combined_Data
group by media_source, campaign_identifier, cast(date_trunc('week', ad_date) as date) having sum(value) > 0
order by Total_Revenue desc
limit 1;

-- 4. MONTHLY AUDIENCE REACH GROWTH
-- Goal: Calculate Month-over-Month (MoM) growth in unique reach per campaign.
with Combined_Data as (
	select
		'Facebook' as media_source,
		cast(campaign_id as varchar) as campaign_identifier,
		ad_date,
		value,
		reach
	from facebook_ads_basic_daily
	
	union all
	
	select
		'Google' as media_source,
		campaign_name as campaign_identifier,
		ad_date,
		value,
		reach
	from google_ads_basic_daily
),

Monthly_Totals as (
	select
		media_source,
		campaign_identifier,
		cast(date_trunc('month', ad_date) as date) as ad_month,
		sum(reach) as total_reach
	from Combined_Data
	group by media_source, campaign_identifier, cast(date_trunc('month', ad_date) as date) having sum(reach) > 0
)

select
	media_source,
	campaign_identifier,
	total_reach,
	ad_month,
	case
		when lag(total_reach) over (partition by campaign_identifier order by ad_month) > 0
		then (total_reach - lag(total_reach) over (partition by campaign_identifier order by ad_month) * 1.0) / lag(total_reach) over (partition by campaign_identifier order by ad_month)
		else 0
	end as Monthly_Reach_Growth
from Monthly_Totals
order by Monthly_Reach_Growth desc nulls last
limit 1;

-- 5. DELIVERY STREAK ANALYSIS (Gaps and Islands)
-- Goal: Identify the longest uninterrupted streak of active ad delivery.
with Combined_Table as (
	select
		t1.ad_date,
		'Facebook Ads' as media_source,
		t2.adset_name
	from facebook_ads_basic_daily as t1
	left join facebook_adset as t2
		on t1.adset_id = t2.adset_id

	union all
	
	select
		ad_date,
		'Google Ads' as media_source,
		adset_name
	from google_ads_basic_daily
),

Streak_Calculation as (
	select
		adset_name,
		ad_date,
		media_source,
		ad_date - cast(row_number() over (partition by adset_name order by ad_date) as int) as streak_group_id
	from Combined_Table
)

select
	adset_name,
	media_source,
	count(*) as duration_days,
	min(ad_date) as start_date,
	max(ad_date) as end_date
from Streak_Calculation
group by media_source, adset_name, streak_group_id
order by duration_days desc
limit 1;
