# Retail Sales Analytics

An end-to-end retail sales analytics project using **MySQL, Excel, and Power BI** to analyze sales, profit, customers, products, regions, segments, and business performance.

---

## 🎯 Business Question

Which regions, segments, and product categories should this retailer prioritize for growth — and where is profitability being quietly eroded by discounting? This project uses SQL, Excel, and Power BI to turn ~10,194 raw transaction records into a clear answer.

---

## 📌 Project Overview

This project analyzes a Superstore-style retail dataset containing approximately **10,194 orders**.

The objective is to transform raw retail transaction data into meaningful business insights using SQL, Excel, and Power BI.

The analysis focuses on:

- Sales and profit performance
- Category and sub-category performance
- Regional performance
- Customer segmentation
- Monthly sales and profit trends
- Product performance
- Discount impact
- Business recommendations

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| MySQL | Data loading, cleaning, querying and analysis |
| Excel | Business analysis and supporting calculations |
| Power BI | Interactive dashboard and visualization |
| GitHub | Project documentation and version control |

---

## 📂 Project Structure

```text
Retail-Sales-Analytics/
│
├── Dataset/
│   └── samplesuperstore.csv
│
├── Excel/
│   └── Retail_Sales_Business_Analysis.xlsx
│
├── PowerBI/
│   └── Retail_Sales_Analytics_Dashboard.pbix
│
├── SQL/
│   └── retail_sales_analysis.sql
│
├── Screenshots/
│   ├── SQL1.png
│   ├── SQL2.png
│   ├── SQL3.png
│   ├── SQL4.png
│   ├── business-insights.png
│   ├── dashboard.png
│   ├── excel-business-analysis1.png
│   └── excel-business-analysis2.png
│
└── README.md
```
---

## 🗄️ SQL Analysis

The MySQL analysis covers Beginner, Intermediate, and Advanced SQL concepts.

### SQL Skills Demonstrated

- SELECT, WHERE, ORDER BY
- GROUP BY and aggregate functions
- Subqueries
- CASE statements
- Common Table Expressions (CTEs)
- Window functions
- Running totals
- Month-over-month growth
- Product profitability ranking
- Customer segmentation
- SQL Views

The complete SQL analysis is available here:

`SQL/retail_sales_analysis.sql`

---

## 📊 Excel Analysis

Excel was used to perform business analysis and prepare supporting calculations.

### Analysis Includes

- KPI analysis
- Category performance
- Regional performance
- Segment performance
- Profitability analysis
- Monthly sales and profit trends
- Product performance
- Discount impact
- Business recommendations

---

## 📈 Power BI Dashboard

The Power BI dashboard provides an interactive view of retail sales performance.

### Dashboard Includes

- Total Sales
- Total Profit
- Order Count
- Profit Margin
- YTD Sales
- Sales by Category
- Sales by Region
- Monthly Sales Trend
- Sales by Segment
- Top 5 Sub-Categories by Sales
- Interactive filters

Power BI file:

`PowerBI/Retail_Sales_Analytics_Dashboard.pbix`

---

## 💡 Key Business Insights

- **Technology** generated the highest sales and strong profitability.
- **Furniture** generated substantial sales but had a significantly lower profit margin.
- **West** generated the highest regional sales and profit.
- **Central** showed the weakest regional profit margin.
- **Consumer** generated the highest sales and total profit.
- **Home Office** had the highest profit margin among the segments.
- **Furniture** had approximately a **3% profit margin**, compared with around **17%** for Technology and Office Supplies.
- Orders discounted at **50% or above** generated a combined loss of approximately **$77K across 874 orders** — a negative contribution of about **26%** relative to total profit.
- Binders, Chairs, Phones, Storage, and Tables were among the leading sub-categories by sales.

---

## 🎯 Business Recommendations

- Review Furniture pricing and product costs to improve profitability.
- Reduce excessive discounting and establish appropriate discount limits.
- Maintain focus on the high-performing Consumer segment.
- Explore opportunities to grow the higher-margin Home Office segment.
- Improve profitability in the Central region.
- Prioritize inventory for high-performing sub-categories.
- Use historical sales trends for inventory and promotional planning.

---

## 📷 Screenshots

### Power BI Dashboard

![Power BI Dashboard](Screenshots/dashboard.png)

### Excel Business Analysis

![Excel Business Analysis](Screenshots/excel-business-analysis1.png)

### Business Insights

![Business Insights](Screenshots/business-insights.png)

---

## 🚀 How to Use

### MySQL

Open:

`SQL/retail_sales_analysis.sql`

Load the dataset from:

`Dataset/samplesuperstore.csv`

Then execute the SQL queries in MySQL Workbench.

### Excel

Open:

`Excel/Retail_Sales_Business_Analysis.xlsx`

### Power BI

Open:

`PowerBI/Retail_Sales_Analytics_Dashboard.pbix`

---

## 📌 Dataset

The project uses a Superstore-style retail dataset containing approximately 10,194 orders.

The dataset includes information about:

- Orders
- Customers
- Products
- Categories
- Regions
- Sales
- Quantity
- Discounts
- Profit

The raw dataset is included in the `Dataset/` folder for reproducibility.

---

## 👨‍💻 Author

**Orlotu Sirisha**

Retail Sales Analytics Project
