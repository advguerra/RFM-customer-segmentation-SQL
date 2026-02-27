# 📊 Customer Segmentation & Revenue Risk Analysis (RFM Model)

## 📌 Project Overview

This project applies the **RFM (Recency, Frequency, Monetary)** model to segment customers and analyze revenue distribution and churn exposure.

The objective of this analysis was to:

- Classify customers based on purchasing behavior
- Measure revenue concentration per segment
- Identify churn risk exposure
- Generate actionable business recommendations

This is a **SQL-only portfolio project**, focused on analytical reasoning and business impact — without the use of BI tools.

---

# 🗄️ Dataset & Methodology

The analysis was conducted using transactional data containing:

- Customer purchase history
- Transaction dates
- Monetary value

### Analytical Steps

1. Calculated Recency, Frequency, and Monetary metrics
2. Assigned RFM scores
3. Created behavioral customer segments
4. Aggregated total revenue by segment
5. Calculated ARPU (Average Revenue per Customer)
6. Performed revenue risk analysis

---

# 📊 Customer Segmentation Distribution

| Segment Name        | Total Customers | % of Customer Base |
|---------------------|-----------------|--------------------|
| Emerging Customers  | 7,188           | 38.89%             |
| Lost Customers      | 5,408           | 29.26%             |
| Loyal Customers     | 2,252           | 12.18%             |
| At Risk             | 1,986           | 10.74%             |
| Core Customers      | 1,321           | 7.15%              |
| Champions           | 329             | 1.78%              |

### Key Insight

- The majority of customers are in early or unstable lifecycle stages.
- Only 1.78% qualify as high-value Champions.
- Over 40% of customers are in Lost or At Risk segments.

---

# 💰 Revenue Distribution by Segment

| Segment Name        | Total Revenue |
|---------------------|--------------|
| Emerging Customers  | 646,804.21   |
| Lost Customers      | 603,534.05   |
| At Risk             | 555,672.24   |
| Loyal Customers     | 519,082.57   |
| Core Customers      | 398,506.70   |
| Champions           | 212,208.46   |

### Revenue Risk Exposure

Lost + At Risk revenue:

603,534 + 555,672 = **1,159,206**

Over **1.15M in revenue** is associated with churn-prone segments, representing significant financial exposure.

---

# 🎯 Average Revenue per Customer (ARPU)

| Segment Name        | Customers | Avg Revenue per Customer |
|---------------------|-----------|--------------------------|
| Champions           | 329       | 6,450.09                 |
| Core Customers      | 1,321     | 3,017.26                 |
| At Risk             | 1,986     | 2,797.87                 |
| Loyal Customers     | 2,252     | 2,304.99                 |
| Lost Customers      | 5,408     | 1,116.00                 |
| Emerging Customers  | 7,188     | 899.84                   |

### Strategic Interpretation

- Champions generate the highest individual revenue but represent a very small portion of the base.
- Emerging Customers drive revenue through volume rather than value.
- At Risk customers have high ARPU, meaning churn directly impacts profitability.
- Revenue concentration is vulnerable due to exposure in unstable segments.

---

# 🚀 Business Recommendations

## 1️⃣ Retention Strategy for At Risk Customers

- Personalized retention campaigns  
- Targeted discount offers  
- Engagement automation  

**Goal:** Protect high-value revenue before migration to Lost segment.

---

## 2️⃣ Reactivation Campaign for Lost Customers

- Win-back promotions  
- Time-limited incentives  
- Behavioral email campaigns  

**Goal:** Recover part of the 1.15M+ revenue currently exposed to churn.

---

## 3️⃣ Upsell Strategy (Core → Champions)

- Loyalty tier program  
- Premium bundles  
- Exclusive offers  

**Goal:** Expand high-value segment and increase ARPU.

---

## 4️⃣ Monetization Optimization for Emerging Customers

- Second-purchase incentives  
- Cross-selling strategy  
- Subscription model testing  

**Goal:** Increase revenue per customer without relying solely on acquisition.

---

# 📌 Executive Conclusion

This RFM analysis reveals:

- Strong acquisition performance
- Significant revenue exposure due to churn
- Underdeveloped high-value segment
- Clear opportunity to increase ARPU through segmentation strategy

### Strategic Priority:

> Revenue Protection before Revenue Expansion.

---

# 🛠️ Technical Highlights

- Advanced SQL aggregations
- RFM scoring logic
- Customer segmentation modeling
- Revenue concentration analysis
- ARPU calculation
- Business-driven data interpretation

---

# 🎯 Skills Demonstrated

- SQL (Intermediate / Advanced)
- Customer Segmentation
- Revenue Analytics
- Churn Risk Assessment
- Business Strategy Translation
- Data-Driven Decision Making

# 📎 Key SQL Queries

Below are the core queries used to generate the main business metrics.

---

## 1️⃣ Customer Segmentation Distribution

```sql
SELECT
    Segment_Name,
    COUNT(*) AS Total_Customers,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Percent_of_Base
FROM Final_Score
GROUP BY Segment_Name
ORDER BY Total_Customers DESC;
```

**Purpose:**  
Calculates customer distribution and percentage representation per segment.

---

## 2️⃣ Revenue Distribution by Segment

```sql
SELECT
    Segment_Name,
    SUM(Monetary) AS Total_Revenue
FROM Final_Score
GROUP BY Segment_Name
ORDER BY Total_Revenue DESC;
```

**Purpose:**  
Measures revenue concentration and identifies financially critical segments.

---

## 3️⃣ Average Revenue per Customer (ARPU)

```sql
SELECT
    Segment_Name,
    COUNT(*) AS Customers,
    SUM(Monetary) / COUNT(*) AS Avg_Revenue_Per_Customer
FROM Final_Score
GROUP BY Segment_Name
ORDER BY Avg_Revenue_Per_Customer DESC;
```

**Purpose:**  
Calculates customer-level revenue efficiency and identifies high-value segments.

---

# 📂 Full SQL Script

The complete SQL logic used to build the RFM model, generate segmentation, and calculate all business metrics is available here:

📎 [`SQL/rfm_customer_segmentation.sql`](SQL/rfm_customer_segmentation.sql)

This file contains:

- RFM metric calculations
- Score assignment logic
- Segment classification CASE statements
- Revenue aggregation queries

Feel free to explore the full query structure and scoring methodology.
