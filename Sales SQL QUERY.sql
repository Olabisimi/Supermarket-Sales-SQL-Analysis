/*Table Definition: Creating the 'supermarket_sales' table to store structured sales transaction data.
This includes customer details, transaction amounts, product categories, timing, and satisfaction ratings.
The table will serve as the foundation for all sales, customer behavior, and performance analysis.*/
CREATE TABLE supermarket_sales (
	invoice_id TEXT PRIMARY KEY,       
	branch TEXT,       
	city TEXT,       
	customer_type TEXT,       
	gender TEXT,       
	product_line TEXT,       
	unit_price NUMERIC,       
	quantity INTEGER,       
	tax_5_percent NUMERIC,       
	total NUMERIC,       
	date DATE,       
	time TIME,       
	payment TEXT,       
	cogs NUMERIC,       
	gross_margin_pct NUMERIC,       
	gross_income NUMERIC,       
	rating NUMERIC );

	
/* The data was imported into the above using 
	\COPY supermarket_sales FROM 'C:\Users\HP\Downloads\Sample Supermarket Dataset.csv' DELIMITER ',' CSV HEADER */

--TO CONFIRM OUR IMPORTED DATA
SELECT * FROM supermarket_sales;

--A: SALES PERFORMANCE ANALYSIS
-- Insight 1: Product Line with Highest Total Sales and Gross Income 
-- Purpose: Identify which product category generated the most revenue and profit 
SELECT 
	product_line, -- Product category 
	SUM(total) AS total_sales, -- Total sales amount per category 
	SUM(gross_income) AS total_gross_income -- Total profit per category 
FROM supermarket_sales 
GROUP BY product_line -- Group by each product line 
ORDER BY total_sales DESC -- Sort by highest sales 
LIMIT 1; -- Return the top product line only 

-- Insight 2: Average Sales and Profit Per Transaction 
-- Purpose: Understand average revenue and profit generated per transaction 
SELECT 
	ROUND(AVG(total), 2) AS avg_sales, -- Average transaction total 
	ROUND(AVG(gross_income), 2) AS avg_profit -- Average transaction profit 
FROM supermarket_sales; 

--B: CUSTOMER BEHAVIOR
-- Insight 3: Average Spend by Customer Type 
-- Purpose: Compare average transaction amounts between Members and Normal customers 
SELECT 
	customer_type, -- Member or Normal 
	ROUND(AVG(total), 2) AS avg_transaction -- Average spending per transaction
FROM supermarket_sales
GROUP BY customer_type; 
	
-- Insight 4: Gender-Based Analysis
-- Purpose: Determine which gender spends more and buys more items on average 
SELECT 
	gender, -- Male or Female 
	ROUND(AVG(total), 2) AS avg_transaction, -- Average total per transaction 
	ROUND(AVG(quantity), 2) AS avg_quantity -- Average quantity purchased 
FROM supermarket_sales 
GROUP BY gender
ORDER BY avg_transaction DESC, avg_quantity DESC
LIMIT 1; 

--C: BRANCH AND LOCATION ANALYSIS
-- Insight 5: Highest Revenue and Profit by Branch 
-- Purpose: Find the best-performing branch in terms of total revenue and gross income 
SELECT 
	branch, -- Branch A, B, or C 
	SUM(total) AS total_revenue, -- Total revenue per branch 
	SUM(gross_income) AS total_profit -- Total profit per branch 
FROM supermarket_sales 
GROUP BY branch 
ORDER BY total_revenue DESC
LIMIT 1; 

-- Insight 6: Customer Satisfaction by Branch and City 
-- Purpose: Evaluate average customer rating per branch and city 
SELECT 
	branch, 
	city, -- City where the branch is located 
	ROUND(AVG(rating), 2) AS avg_rating -- Average customer satisfaction score 
FROM supermarket_sales 
GROUP BY branch, city 
ORDER BY avg_rating DESC;


--D: Product Analysis
-- Insight 7: Top 3 Product Lines by Quantity and Revenue 
-- Purpose: Identify the most popular and high-earning product categories 
SELECT 
	product_line, 
	SUM(quantity) AS total_quantity, -- Total units sold 
	SUM(total) AS total_revenue -- Total revenue generated 
FROM supermarket_sales 
GROUP BY product_line 
ORDER BY total_quantity DESC, total_revenue DESC 
LIMIT 3; 

-- Insight 8: Product Lines with Highest Avg Profit and Rating 
-- Purpose: See which product categories perform best in profit margin and customer satisfaction 
SELECT 
	product_line, 
	ROUND(AVG(gross_income), 2) AS avg_profit, -- Average profit per transaction 
	ROUND(AVG(rating), 2) AS avg_rating -- Average customer satisfaction
FROM supermarket_sales 
GROUP BY product_line 
ORDER BY avg_profit DESC
LIMIT 1; 

--E: TIME BASED TRENDS	
-- Insight 9: Peak Sales Days and Times 
-- Purpose: Discover the busiest days and times for sales volume 
SELECT 
	TO_CHAR(date, 'Day') AS day_of_week, -- Extract weekday name from date 
	COUNT(*) AS transaction_count -- Count number of transactions per day 
FROM supermarket_sales 
GROUP BY day_of_week 
ORDER BY transaction_count DESC; 
-- Hourly trend    
SELECT 
	EXTRACT(HOUR FROM time::time) AS hour_of_day,          
	COUNT(*) AS transaction_count,          
	SUM(total) AS total_sales   
FROM supermarket_sales   
GROUP BY hour_of_day   
ORDER BY total_sales DESC;

SELECT 
TO_CHAR(date,'Day') AS day_of_week,
COUNT(*) AS transaction,
SUM(total) AS total_sales
FROM supermarket_sales
GROUP BY day_of_week
ORDER BY total_sales DESC;
-- Insight 10: Peak Hours by Branch 
-- Purpose: Determine when each branch experiences the highest sales 
SELECT 
	branch, 
	DATE_PART('hour', time) AS hour_of_day, -- Extract hour from time 
	SUM(total) AS total_sales -- Sum of sales during that hour 
	FROM supermarket_sales 
GROUP BY branch, hour_of_day 
ORDER BY total_sales DESC; 

--F: PAYMENT AND TRANSACTION INSIGHTS
-- Insight 11: Most Used Payment Method and Its Correlation 
-- Purpose: Identify preferred payment method and analyze sales distribution 
SELECT 
	customer_type,
	payment, 
	COUNT(*) AS usage_count, -- Count of transactions using this payment method 
	ROUND(AVG(total), 2) AS avg_transaction, -- Average transaction value 
	COUNT(DISTINCT customer_type) AS customer_type_count -- Customer diversity 
FROM supermarket_sales 
GROUP BY payment, customer_type
ORDER BY usage_count DESC
LIMIT 1; 
	
-- Insight 12: Average Transaction by Payment Method per Branch 
-- Purpose: Analyze how payment methods perform across different branches 
SELECT 
	branch, 
	payment, 
	ROUND(AVG(total), 2) AS avg_transaction -- Average sale amount 
FROM supermarket_sales 
GROUP BY branch, payment 
ORDER BY branch; 

--G: OPERATIONAL INSIGHTS
-- Insight 13: Average Quantity per Product Line 
-- Purpose: Understand purchase volume by product category 
SELECT 
	product_line, 
	ROUND(AVG(quantity), 2) AS avg_quantity -- Average items bought per transaction 
FROM supermarket_sales 
GROUP BY product_line
ORDER BY avg_quantity; 

-- Insight 14: Profit Variation by Day of Week 
-- Purpose: See which days generate the highest profit 
SELECT 
	TO_CHAR(date, 'Day') AS day_of_week, 
	ROUND(AVG(gross_income), 2) AS avg_profit -- Average profit per day 
FROM supermarket_sales 
GROUP BY day_of_week 
ORDER BY avg_profit DESC; 

--H: CUSTOMER EXPERIENCE
-- Insight 15: Customer Rating vs Spending 
-- Purpose: Check for correlation between customer rating and how much they spend 
SELECT
  CORR(rating, total) AS rating_total_corr, -- Checking relationship between customer rating and total spending
  CORR(rating, gross_income) AS rating_income_corr-- Checking relationship between customer rating and profit
FROM supermarket_sales; 

--What is the average total amount spent per transaction by Member and Normal customers in Branch B?  
SELECT 
	Customer_type, 
	AVG(Total) AS avg_total_spent
FROM supermarket_sales
WHERE Branch = 'B'
GROUP BY Customer_type;

--What is the total gross income generated by each product line in Branch B?  
SELECT 
	Product_line, 
	SUM(Gross_income) AS total_gross_income
FROM supermarket_sales
WHERE Branch = 'B'
GROUP BY Product_line;

--Which gender has a higher average quantity purchased in Branch B?
SELECT 
	Gender, 
	AVG(Quantity) AS avg_quantity
FROM supermarket_sales
WHERE Branch = 'B'
GROUP BY Gender
ORDER BY avg_quantity DESC
LIMIT 1;