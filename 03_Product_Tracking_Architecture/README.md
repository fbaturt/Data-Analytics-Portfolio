![Product Management](https://img.shields.io/badge/Focus-Product_Management-orange)
![Amplitude](https://img.shields.io/badge/Analytics-Amplitude-purple)
![Google Sheets](https://img.shields.io/badge/Documentation-Google_Sheets-34A853?logo=google-sheets&logoColor=white)
![Aviation Tech](https://img.shields.io/badge/Industry-Aviation_Analytics-blue)

# 🗺️ Product Tracking Architecture

> **Designing the "Source of Truth."** This folder focuses on product analytics instrumentation and event taxonomy. It demonstrates my ability to define tracking requirements that align with core business KPIs and user journey optimization.

---

## 🎯 Measurement Strategy & Taxonomy
A robust tracking plan is the bridge between raw user interaction and executive decision-making. Below is a highlight of the strategic mapping used in this folder:

| Event Name | Trigger Condition | Business KPI / Goal |
| :--- | :--- | :--- |
| `plane_selected` | User clicks a specific aircraft icon on the live map. | **Core Feature Engagement** |
| `filter_applied` | User restricts view by airline, altitude, or aircraft type. | **User Intent & Search Depth** |
| `ar_view_triggered` | User activates the Augmented Reality (AR) camera view. | **Feature Adoption & Stickiness** |
| `paywall_viewed` | User reaches the premium feature limitation screen. | **Monetization Intent** |
| `subscription_started` | User successfully completes the checkout process. | **Conversion Rate (CR)** |

---

## 🚀 Featured Project: Flightradar24 Analytics Reverse-Engineering
**Project Type:** Product Instrumentation & Tracking Plan  
**Deliverable:** [📄 Download Full Tracking Plan (.xlsx)](./Flightradar24_Tracking_Plan.xlsx)

In this project, I reverse-engineered the tracking architecture for **Flightradar24**. As an **Aeronautical Engineer**, I applied a "sensor-first" mindset to ensure that every user interaction provides high-fidelity data for product growth.

### Key Highlights:
* **Event Taxonomy Design:** Defined a hierarchical list of events and properties (e.g., `aircraft_model`, `flight_origin`) to enable granular cohort analysis.
* **Conversion Funnel Mapping:** Established the tracking logic for the "Free-to-Premium" journey, focusing on identifying friction points in the subscription flow.
* **TTFV Optimization:** Defined milestones to measure **Time-to-First-Value (TTFV)**, ensuring users reach the "Aha! Moment" (first flight tracked) as quickly as possible.

---

## 🧠 Core Competencies
* **Event-Driven Architecture:** Mapping complex user flows into clean, scalable event schemas.
* **Metric Definition:** Defining North Star metrics and retention triggers for B2C SaaS platforms.
* **Instrumentation Strategy:** Coordinating between business goals and engineering implementation.
