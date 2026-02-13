# Supermarket-Sales-SQL-Analysis
SQL project analyzing supermarket sales performance and customer behavior using PostgreSQL

**Project Overview**

This project performs exploratory and business performance analysis on a supermarket sales dataset using SQL (PostgreSQL).

The goal is to extract insights related to:

Sales performance
Customer behavior
Branch performance
Product analysis
Payment trends
Time-based trends
Customer satisfaction

**Dataset Information**

The dataset contains transactional sales data including: 

Invoice ID
Branch & City
Customer Type
Gender
Product Line
Unit Price
Quantity
Tax
Total
Date & Time
Payment Method
Gross Income
Rating

**Tools Used**
PostgreSQL
SQL
GitHub

**Key Business Insights Extracted**

🔹 Sales Performance

Identified highest revenue generating product line
Calculated average sales and profit per transaction

🔹 Customer Behavior

Compared spending between Member and Normal customers
Analyzed gender-based purchasing patterns

🔹 Branch Analysis

Determined highest performing branch
Evaluated customer satisfaction by branch and city

🔹 Time-Based Trends

Identified peak sales days and hours
Analyzed hourly sales distribution

🔹 Payment Insights

Most used payment method
Payment performance across branches

🔹 Customer Experience

Correlation between customer ratings and spending

**Sample Business Question Answered**

✔ What is the average total amount spent per transaction by Member and Normal customers in Branch B?
✔ Which gender purchases more quantity in Branch B?
✔ What product line generates the highest profit?

**How to Run This Project**

Create the table using the provided SQL script.
Import the dataset using:
Copy code
Sql
\COPY supermarket_sales FROM 'your_file_path.csv' DELIMITER ',' CSV HEADER;
Run the analysis queries.
