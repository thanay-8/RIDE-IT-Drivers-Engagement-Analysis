# RIDE IT Driver Engagement Analysis

An end-to-end **Data Analytics project** focused on understanding driver
engagement, operational performance, and activity patterns using
**Python, MySQL, and Power BI**.

**Tech Stack:** Python • Pandas • MySQL • Power BI • DAX • GitHub

------------------------------------------------------------------------

## 📌 Project Overview

The objective of this project is to analyze driver activity and
engagement patterns and generate insights that can support data-driven
business decisions.

The project follows a complete analytics workflow:

**Data Cleaning → Exploratory Analysis → SQL Database & Analysis → Power
BI Data Modeling → DAX → Interactive Dashboard → Business Insights**

## 🎯 Objectives

-   Analyze driver engagement and activity patterns.
-   Measure key operational KPIs.
-   Identify differences across countries and service types.
-   Analyze driver ratings, Gold-level achievement, and marketing
    preferences.
-   Examine ride completion and driver cancellation rates.
-   Build an interactive Power BI dashboard for stakeholder analysis.

## 🛠️ Tools & Technologies

  Tool       Purpose
  ---------- -----------------------------------------------
  Python     Data cleaning, preparation, analysis, and EDA
  Pandas     Data manipulation and aggregation
  MySQL      Database creation and SQL analysis
  Power BI   Data modeling, DAX, and dashboard development
  GitHub     Project version control and portfolio

## 📂 Project Structure

``` text
RIDE-IT-Drivers-Engagement-Analysis/
│
├── Data/
│   ├── Raw Data/
│   └── Cleaned Data/
│
├── Python/
│   └── RIDE_IT_Drivers_Engagement_Analysis.ipynb
│
├── SQL/
│   └── RIDE_IT_SQL_Database_and_Analysis.sql
│
├── Power BI/
│   └── RideIt_Dashboard.pbix
│
├── Dashboard Screenshots/
│   ├── Page1_Driver_Engagement_Overview.png
│   ├── Page2_Driver_Engagement_Analysis.png
│   └── Page3_Driver_Performance_Dashboard.png
│
├── Documentation/
│   └── RideIT_Driver_Engagement_Analysis_Documentation.docx
│
└── README.md
```

## 📊 Dataset

The project uses two datasets.

### Driver Dataset

Contains driver-level information such as:

-   Driver ID
-   Registration date
-   Driver rating
-   Gold-level count
-   Marketing preference
-   Country code
-   Service type

### Driver Activity Dataset

Contains driver activity records such as:

-   Driver ID
-   Active date
-   Offers
-   Bookings
-   Passenger cancellations
-   Driver cancellations
-   Completed rides

## 🐍 Python Analysis

The Jupyter Notebook covers:

1.  Loading the datasets
2.  Data understanding and quality checks
3.  Missing-value and duplicate checks
4.  Data cleaning
5.  Data validation
6.  Driver-level data preparation
7.  Activity aggregation
8.  Feature engineering
9.  KPI calculation
10. Monthly engagement analysis
11. Country and service-type analysis
12. Marketing preference analysis
13. Gold-level segmentation
14. Driver-rating segmentation
15. Export of prepared datasets

## 🗄️ SQL Database

A MySQL database named `ride_it_analysis` is created as part of the
project.

### Main Tables

-   `drivers`
-   `driver_activity`

### Analytical View

-   `driver_engagement`

The SQL script includes:

-   Database creation
-   Table creation
-   Primary and foreign keys
-   Indexes
-   CSV data-import instructions
-   Data validation queries
-   KPI queries
-   Monthly trend analysis
-   Country analysis
-   Service-type analysis
-   Marketing analysis
-   Gold-segment analysis
-   Rating-segment analysis
-   Top-driver analysis
-   Cancellation-rate analysis

## 📈 Key KPIs

-   Total Drivers
-   Total Offers
-   Total Bookings
-   Total Completed Rides
-   Active Driver Days
-   Rides per Active Day
-   Driver Cancellation Rate
-   Ride Completion Rate

## 📌 Key Results

Based on the completed analysis:

-   **36,771 unique drivers** were analyzed.
-   **1.82M+ driver activity records** were analyzed.
-   The dataset contains **6M+ completed rides**.
-   Overall **ride completion rate: 81.83%**.
-   Overall **driver cancellation rate: 7.75%**.

These metrics provide a high-level view of driver activity and
operational performance across the platform.

## 📊 Power BI Dashboard

The Power BI dashboard contains three pages.

### Page 1 --- Driver Engagement Overview

Focuses on overall driver activity and engagement.

Includes:

-   KPI cards
-   Monthly active-driver trend
-   Monthly ride trend
-   Rides by country
-   Rides by service type
-   Country, service-type, and marketing slicers

### Page 2 --- Driver Engagement Analysis

Focuses on engagement differences between driver segments.

Includes:

-   Gold-level segmentation
-   Driver-rating segmentation
-   Driver rating vs. engagement scatter plot
-   Marketing preference vs. engagement
-   Driver cancellation rate by service type
-   Country and service-type filters

### Page 3 --- Driver Performance Dashboard

Focuses on operational driver performance.

Includes:

-   KPI cards
-   Top 10 drivers by total rides
-   Average active days by service type
-   Driver cancellation rate by country
-   Ride completion rate by service type
-   Marketing preference distribution
-   Country, service-type, and Gold-segment slicers

## 🔍 Business Analysis Areas

The project examines:

-   Driver activity trends over time
-   Country-wise ride activity
-   Service-type engagement
-   Driver rating and engagement
-   Gold-level achievement and activity
-   Marketing preference and engagement
-   Driver cancellation rates
-   Ride completion across service types

## 💡 Business Value

The analysis helps stakeholders:

-   Identify stronger and weaker engagement segments.
-   Monitor driver activity trends.
-   Compare operational performance across countries and services.
-   Identify areas with higher cancellation rates.
-   Design targeted driver engagement and incentive strategies.
-   Support data-driven supply-side decisions.

## 🧠 Skills Demonstrated

-   Data Cleaning & Preparation
-   Exploratory Data Analysis
-   SQL Database Design
-   SQL Aggregation & Analysis
-   Data Modeling
-   DAX
-   KPI Development
-   Dashboard Design
-   Business Analysis
-   Data Visualization

## 📷 Dashboard Preview

Place the three Power BI screenshots in the `Dashboard Screenshots`
folder.

### Driver Engagement Overview

![Driver Engagement
Overview](Dashboard%20Screenshots/Page1_Driver_Engagement_Overview.png)

### Driver Engagement Analysis

![Driver Engagement
Analysis](Dashboard%20Screenshots/Page2_Driver_Engagement_Analysis.png)

### Driver Performance Dashboard

![Driver Performance
Dashboard](Dashboard%20Screenshots/Page3_Driver_Performance_Dashboard.png)

## 🚀 Future Enhancements

-   Automated Power BI data refresh
-   Real-time driver activity monitoring
-   Predictive driver engagement analysis
-   Driver churn/retention modeling
-   Advanced segmentation and scoring
-   Automated KPI alerts

## 📚 Project Documentation

Detailed project documentation is available in:

`Documentation/RideIT_Driver_Engagement_Analysis_Documentation.docx`

## 👤 Author

**Thanay Gannu**

B.Tech -- Artificial Intelligence & Machine Learning

Aspiring Data Analyst

------------------------------------------------------------------------

⭐ If you find this project useful, feel free to explore the notebook,
SQL analysis, and Power BI dashboard.
