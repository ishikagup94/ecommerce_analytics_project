# ecommerce_analytics_project

The project demonstrates a complete analytics workflow including:
- Data cleaning
- Data preparation
- SQL business analysis
- Customer segmentation (RFM)
- Conversion funnel analysis
- Interactive dashboards

Project Objectives-

This project answers the following key business questions:

- How is revenue and profit trending over time?
- Which product categories generate the most revenue and profit?
- Which customers are the most valuable?
- Where do users drop off in the purchase funnel?
- Which customer segments drive the highest revenue?

**Dataset Overview**

The dataset simulates a real e-commerce platform with four relational tables.

customers	- contains customer demographics and acquisition channel
orders	- contains order transactions data including revenue, discount, and returns
products - includes product information including category and cost
website_events - User interaction events (visit, add_to_cart, checkout, payment)


**Data Cleaning (SQL)**

The data cleaning process included:

- Removing duplicate records
- Handling missing values
- Standardizing text fields
- Fixing data types
- Validating numerical values
- Ensuring referential integrity
- Creating primary and foreign keys

Cleaned datasets are stored in the data/ directory.

**Data Preparation**

A master analytics table was created to calculate:
- Net Revenue
- Profit
- Discount Amount
- Order Month
- Customer-level metrics

This table enabled downstream analysis including revenue trends, product performance, and customer segmentation.

Key Analyses

The project covers four major analytical areas.

1️⃣ Business Performance Analysis

Metrics analyzed:

- Total Revenue
- Total Profit
- Total Orders
- Average Order Value (AOV)
- Monthly revenue trends

Key Insights:

- Total Revenue: ₹207M
- Total Profit: ₹78M
- Average Order Value: ₹4.63K

Revenue shows stable growth across months with consistent profitability.

2️⃣ Product Performance Analysis

This analysis evaluates product categories based on:
- Revenue contribution
- Profit margin
- Return rate



Key Insights:

- Home category generates the highest revenue
- Beauty category has the highest profit margin
- Home category also shows the highest return rate

3️⃣ Customer Segmentation (RFM Analysis)

Customers were segmented using Recency, Frequency, and Monetary value.

Segments created:
- Champions
- Loyal Customers
- New Customers
- At Risk Customers
- Others


Key Insights:

- At-risk customers represent the largest segment
- Champions generate the highest average spending
- Retention strategies could significantly improve revenue.

4️⃣ Conversion Funnel Analysis

Website events were analyzed to identify where users drop off during the purchase journey.

Conversion Rates:

- Visit → Cart: 99.6%
- Cart → Checkout: 98.1%
- Checkout → Payment: 86.0%

Key Insight:

- The largest drop-off occurs during the checkout → payment stage, indicating potential friction in the payment process.

**Tools Used**

- PostgreSQL Data cleaning and analysis
- SQL	Data transformation and analytics
- Tableau	Dashboard visualization

Author
Ishika Gupta
