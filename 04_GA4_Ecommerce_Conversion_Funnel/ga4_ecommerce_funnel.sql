WITH session_data AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS session_id,
    MIN(DATETIME(TIMESTAMP_MICROS(event_timestamp))) AS session_start_time,
    MAX(CASE WHEN event_name = 'session_start' THEN (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') END) AS landing_page,
    MAX(traffic_source.source) AS source,
    MAX(traffic_source.medium) AS medium,
    MAX(traffic_source.name) AS campaign,
    MAX(device.category) AS device_category,
    MAX(device.language) AS device_language,
    MAX(device.operating_system) AS device_os,
    
    -- Huni (Funnel) Adımları
    COUNTIF(event_name = 'session_start') AS session_start_events,
    COUNTIF(event_name = 'view_item') AS view_item_events,
    COUNTIF(event_name = 'add_to_cart') AS add_to_cart_events,
    COUNTIF(event_name = 'begin_checkout') AS begin_checkout_events,
    COUNTIF(event_name = 'add_shipping_info') AS add_shipping_info_events,
    COUNTIF(event_name = 'add_payment_info') AS add_payment_info_events,
    COUNTIF(event_name = 'purchase') AS purchase_events,
    
    -- Satış ve Siparişler
    SUM(ecommerce.purchase_revenue) AS sales_revenue,
    COUNT(DISTINCT ecommerce.transaction_id) AS orders
    
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  GROUP BY
    user_pseudo_id,
    session_id
)
SELECT
  DATE(session_start_time) AS session_date,
  landing_page,
  source,
  medium,
  campaign,
  device_category,
  device_language,
  device_os,
  
  -- Temel Metrikler
  COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(session_id AS STRING))) AS total_visits,
  SUM(orders) AS total_orders,
  SUM(sales_revenue) AS total_sales,
  
  -- Funnel (Huni) Metrikleri
  SUM(session_start_events) AS step_1_session_start,
  SUM(view_item_events) AS step_2_view_item,
  SUM(add_to_cart_events) AS step_3_add_to_cart,
  SUM(begin_checkout_events) AS step_4_begin_checkout,
  SUM(add_shipping_info_events) AS step_5_add_shipping_info,
  SUM(add_payment_info_events) AS step_6_add_payment_info,
  SUM(purchase_events) AS step_7_purchase

FROM
  session_data
GROUP BY
  1, 2, 3, 4, 5, 6, 7, 8
ORDER BY 
  session_date DESC