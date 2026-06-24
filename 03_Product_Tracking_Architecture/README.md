# 03 — Product Tracking Architecture

![Amplitude](https://img.shields.io/badge/Amplitude-5B36A6?style=flat-square&logo=amplitude&logoColor=white)
![Braze](https://img.shields.io/badge/Braze-FF4500?style=flat-square)
![Excel](https://img.shields.io/badge/Excel-217346?style=flat-square&logo=microsoft-excel&logoColor=white)

> A full product instrumentation plan reverse-engineered for **Flightradar24** — defining event taxonomy, user properties, and business metrics from scratch using a "sensor-first" approach rooted in aeronautical engineering thinking.

---

## 📂 Files

| File | Description |
|---|---|
| [`Flightradar24_Tracking_Plan.xlsx`](./Flightradar24_Tracking_Plan.xlsx) | Full tracking plan — events, user properties, metrics, and discussion sheets |

---

## 🎯 Objective

Design a complete product analytics instrumentation plan for Flightradar24 — a live flight tracking app with millions of users across free and paid tiers. The goal was to define every measurable user interaction from first app open to paid subscription, structured so that both Amplitude (product analytics) and Braze (CRM/push notifications) receive exactly the data they need.

This is the foundation of any serious product analytics operation: without a well-designed tracking plan, dashboards are built on unreliable data.

---

## 📋 Tracking Plan Structure

The deliverable is a 4-sheet Excel workbook:

| Sheet | Contents |
|---|---|
| **Glossary** | Column definitions, naming conventions (`Proper Case` for events, `snake_case` for properties), and instrumentation guidelines |
| **Events & Event Properties** | Full event taxonomy organised by user lifecycle stage, with properties, data types, expected values, and destinations |
| **User Properties** | Persistent user-level attributes tracked across sessions — subscription tier, location permissions, alert habits |
| **Metrics** | 7 North Star and supporting metrics with exact definitions, input events, and data types |

---

## 🗺️ Event Taxonomy

Events are organised across four lifecycle stages:

### Activation — *Improve Onboarding & Activation Rate*

| Event | Trigger | Key Properties |
|---|---|---|
| `Signed Up` | New user registers | `registration_method`, `subscription_tier`, `country` |
| `Permission Prompt Answer` | Location/push prompt shown | `permission_type`, `status` |
| `Aircraft Selected` | User taps a plane icon on the map | `aircraft_type`, `airline_name`, `flight_status` |

### Adoption — *Accelerate Feature Adoption & UX*

| Event | Trigger | Key Properties |
|---|---|---|
| `Search Performed` | User uses the search bar | `search_type`, `search_term`, `result_clicked` |
| `Filter Applied` | User narrows map view | `filter_category`, `filter_value` |
| `Alert Created` | User sets a push notification | `alert_category`, `is_push_enabled` |

### Revenue — *Understand Monetisation*

| Event | Trigger | Key Properties |
|---|---|---|
| `Trial Started` | Free trial initiated | `trial_plan_name`, `trigger_source` |
| `Trial Ended` | Trial period concludes | `trial_plan_name`, `did_convert` |
| `Subscription Cancelled` | Plan change or cancellation | `new_plan`, `action_of_change`, `cancelled_plan` |

### Page Views — *Track Navigation Patterns*

| Event | Trigger | Key Properties |
|---|---|---|
| `Screen Viewed` | Any screen or modal opened | `screen_name`, `previous_screen` |

---

## 👤 User Properties

15 persistent user attributes tracked across sessions, including:

- `subscription_tier` — updates dynamically on upgrade/downgrade
- `is_location_enabled` / `is_push_enabled` — critical for map centering and alert delivery
- `total_alerts_saved` — running tally used as a "habit formation" proxy
- `favorite_aircraft_types` — array property for UI personalisation

Destinations split between **Amplitude** (behavioural analysis) and **Braze** (CRM targeting and push campaigns) based on which tool needs each property.

---

## 📊 Metrics Framework

| Metric | Definition | Input Events |
|---|---|---|
| **Onboarding Completion Rate** | % of users granting location permissions after signup | `Signed Up`, `Permission Prompt Answer` |
| **Time to First Value (TTFV)** | Avg. time from account creation to first aircraft tap | `Signed Up`, `Aircraft Selected` |
| **Exploration Depth** | Avg. unique aircraft selected per user in first session | `Aircraft Selected` |
| **Search-to-Tap Conversion** | % of searches resulting in an aircraft click | `Search Performed`, `result_clicked` |
| **Habit Formation Rate** | % of new users creating ≥1 alert within 7 days | `Signed Up`, `Alert Created` |
| **Premium Tease Rate** | Frequency of free users encountering locked features | `Trial Started`, `trigger_source` |
| **Free-to-Paid Conversion** | % of trial users who convert to paid | `Trial Ended`, `did_convert` |

---

## 💡 Key Takeaways

- **Naming convention discipline matters** — `Proper Case` for event names and `snake_case` for properties keeps the taxonomy consistent across Amplitude and Braze without ambiguity
- **Destination mapping at the property level** — not every property needs to go to every tool; routing selectively reduces noise in CRM systems
- **`trigger_source` on `Trial Started`** is a high-value property — it reveals which premium features drive the most upgrade intent, directly informing feature development prioritisation
- **TTFV as a North Star** — for Flightradar24, the "Aha! Moment" is tapping a live aircraft for the first time; minimising the time to reach that moment is the single most impactful activation lever
- The aviation domain knowledge applied here is genuine — understanding what `squawk_7700`, `flight_status`, and `aircraft_type` mean allowed for a more precise and realistic taxonomy than a generic analyst could produce
