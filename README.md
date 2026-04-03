# 🛒 Superstore Sales & Profitability Analysis

**End-to-End Data Analytics Project**  
**Tools:** Excel | SQL Server | Power BI  
**Author:** Shailesh Kumar  

---

## 📌 Project Overview

This project analyzes a US-based retail superstore dataset (2023–2026) to uncover **profit leakage, discount inefficiencies, and regional performance gaps**.

The goal is not just reporting — but solving **real business problems** using data.

---

## 🚨 Real Business Problem

The company is generating strong revenue ($2.3M), but:

- ❌ **18.71% orders are loss-making**
- ❌ High discounts are destroying profitability
- ❌ Some high-revenue customers are actually **unprofitable**
- ❌ Certain regions (Central) underperform significantly
- ❌ Products like **Tables** generate revenue but cause losses

👉 **Core Problem:**  
> "The business is focusing on sales growth instead of profitable growth."

---

## 🎯 Objectives

- Identify **loss-making areas**
- Analyze **discount impact on profit**
- Evaluate **customer, product, and regional performance**
- Provide **actionable business recommendations**

---

## 🧠 Key Insights

### 🔴 Critical Issues

- Tables sub-category → **-$17.7K loss** despite $207K sales  
- 856 orders with **>50% discount → negative profit**  
- Central region → **lowest margin (7.92%)**  
- High-revenue customers like **Sean Miller** → still loss-making  

---

### 🟢 Opportunities

- West region → **best performer (14.94% margin)**  
- Technology category → **highest margin (17.4%)**  
- Copiers → **37.2% profit margin (top sub-category)**  
- Q4 → consistent **peak season**

---

## 💡 Business Solution (Industry Approach)

### 1. Discount Optimization Strategy
- Cap discounts at **≤ 20%**
- Remove discounts on:
  - Tables
  - Bookcases  
- Expected recovery: **~$41,796**

---

### 2. Product Portfolio Optimization
- Promote high-margin products:
  - Copiers
  - Technology category  
- Reduce focus on low-margin inventory

---

### 3. Regional Strategy Fix
- Central region:
  - Review pricing strategy
  - Reduce discount dependency
  - Optimize logistics/cost structure

---

### 4. Customer Profitability Targeting
- Identify **high-revenue but loss-making customers**
- Apply:
  - Personalized pricing
  - Discount restrictions

---

### 5. Seasonal Strategy
- Q4 = peak season  
👉 Focus on **high-margin products instead of high-discount sales**

---

## 🛠️ Project Workflow

### 🔹 Phase 1 — Data Cleaning (Excel / Power Query)
- Removed irrelevant data (Canada)
- Created new features:
  - Profit Margin %
  - Discount Band
  - Days to Ship
  - Profit Flag
- Clean dataset: **9,994 rows, 29 columns**

---

### 🔹 Phase 2 — SQL Analysis (15 Queries)

Key techniques:
- CTEs
- Window Functions (`LAG`, `RANK`, `NTILE`)
- RFM Analysis
- YoY Growth Analysis

Examples:
- Top/Bottom products
- Discount impact
- Customer segmentation
- Regional performance

---

### 🔹 Phase 3 — Power BI Dashboard

#### 📊 5 Interactive Pages

1. Executive Overview  
2. Product & Profitability  
3. Regional Analysis  
4. Customer Intelligence  
5. Insights & Recommendations  

---

## 📈 Key KPIs

| Metric | Value |
|------|------|
| Total Sales | $2.30M |
| Total Profit | $286.41K |
| Profit Margin | 12.47% |
| Total Orders | 5,009 |
| Customers | 793 |
| Loss Orders | 18.71% |

---

## 📊 Dashboard Highlights

- Sales vs Profit Analysis  
- Discount vs Profit correlation (negative relationship)  
- Region-wise performance  
- Customer-level profitability  
- Sub-category deep dive  

---

## 🔍 Business Impact

✔ Identified **profit leakage due to discounting**  
✔ Highlighted **loss-making products & customers**  
✔ Proposed **data-driven pricing strategy**  
✔ Improved focus on **profit, not just revenue**

---

## 🚀 How to Use This Project

1. Clone the repository  
2. Open:
   - Power BI file (`.pbix`)
   - SQL scripts
   - Clean dataset (`.csv`)
3. Interact with dashboards using slicers:
   - Year
   - Region
   - Category  

---

## 📌 Future Improvements

- Add forecasting (Sales & Profit)
- Build ML model for profit prediction
- Automate ETL pipeline
- Deploy dashboard to Power BI Service

---

## 📬 Contact

**Shailesh Kumar**  
Aspiring Data Analyst  

---

⭐ If you found this project useful, consider giving it a star!
