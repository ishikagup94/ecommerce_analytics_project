# ecommerce_analytics_project

**Overview:**
This project demonstrates an end-to-end data analytics workflow on a simulated e-commerce dataset, covering data cleaning, business analysis, customer segmentation, and conversion funnel analysis.
The objective is to extract actionable business insights that could improve revenue growth, customer retention, and conversion rates.
The project replicates the type of analysis performed by data analysts in e-commerce, marketplace, and consumer internet companies.

Note: The dataset used in this project is synthetic and generated using AI for educational and portfolio purposes. It does not represent real company or customer data.

**Business Questions:**
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

**Key Analyses**

The project covers four major analytical areas.

1️⃣ Business Performance Analysis

Metrics analyzed:
- Total Revenue
- Total Profit
- Total Orders
- Average Order Value (AOV)
- Monthly revenue trends

Key Insights:
- Revenue: ₹207.64M
- Profit: ₹78.44M
- Orders: 44.88K
- AOV: ₹4.63K

- Profit Margin = 78.44/207.64 = ~37.8%

- Revenue shows stable growth across months with consistent profitability.

Recommendations: Since margins are strong, the company could increase marketing spend to accelerate growth through:
- Customer acquisition campaigns
- Product bundling
- Cross-selling strategies

2️⃣ Product Performance Analysis

Product categories were evaluated based on:
- Revenue contribution
- Profit margin
- Return rate

Key Insights:

- Home category generates the highest revenue
- Beauty category has the highest profit margin
- Home category also shows the highest return rate

The Home category drives the most revenue but also has the highest return rate.
This indicates possible:
- product quality issues
- incorrect product descriptions
- shipping damage

Recommendation : Investigate returns in the Home category, since even a small reduction in return rates could significantly increase profit.

3️⃣ Customer Segmentation (RFM Analysis)

Customers were segmented using Recency, Frequency, and Monetary (RFM) analysis.

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

This indicates a retention problem rather than a customer acquisition problem. The business has already acquired many customers but struggles to keep them engaged.

A small number of customers generate disproportionately high revenue. This is typical in e-commerce where: 20% customers → ~60–70% revenue.

Recommendation:

1. Target At-risk customers with:
- personalized discounts
- remarketing campaigns
- loyalty programs

Retaining existing customers is 5x cheaper than acquiring new ones.

2. The company should introduce:
- VIP loyalty programs
- early product access
- exclusive discounts

to retain these high-value customers.

4️⃣ Conversion Funnel Analysis

Website events were analyzed to identify where users drop off during the purchase journey.

Conversion Rates:

- Visit → Cart: 99.6%
- Cart → Checkout: 98.1%
- Checkout → Payment: 86.0%

Key Insight:

- The largest drop-off occurs during the checkout → payment stage, indicating potential friction in the payment process.
Possible causes:
- payment failures
- limited payment methods
- slow checkout process
- shipping cost shock

Recommendation:

Improve payment conversion by:
- adding more payment options
- simplifying checkout
- showing shipping cost earlier
Even a 5% improvement in payment conversion could significantly increase revenue.

Final Recommendations:

The platform shows strong profitability and stable demand, but growth is constrained by:
- High customer churn
- Product return issues
- Drop-offs during payment

Revenue growth can be achieved by focusing on:
- Customer retention
- Reducing product returns
- Improving checkout conversion

These improvements could increase revenue without increasing customer acquisition costs.


**Tools Used**

- PostgreSQL Data cleaning and analysis
- Tableau	Dashboard visualization

Author
Ishika Gupta
