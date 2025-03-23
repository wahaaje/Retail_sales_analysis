# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Database Setup**:
Establish a retail sales database.
Populate the database with the provided sales data.
2. **Data Cleaning**:
Identify records containing missing or null values.
Remove or handle those incomplete records.
3. **Exploratory Data Analysis (EDA)**:
Perform initial data exploration to understand the dataset's characteristics.
4. **Business Analysis**:
Utilize SQL to answer business-related questions.
Derive actionable insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT *
FROM
    retail_sales
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;

DELETE
FROM
    retail_sales
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **How many Sales we have?**:
```sql
Select count(total_sale) as Total_no_of_sales, SUM(total_sale) as Total_sales_amount
FROM retail_sales;
```

2. ***How many unique customers we have?**:
```sql
Select count(DISTINCT(customer_id)) as Total_customers
FROM retail_sales;
```

3. **How many unique category we have?**:
```sql
SELECT COUNT(DISTINCT(category)) as total_categories
FROM retail_sales;
```

4. ** Write a query to retrive all columns for sales made on '2022-11-05'**:
```sql
 SELECT  *
 FROM retail_sales
 WHERE sale_date = '2022-11-05';
```

5. ** Write a SQL query  to retrieve all transactions where the category is 'clothing' and the quantity sold is mre than 10 in the month of Nov-2022?**:
```sql
SELECT *
 FROM retail_sales
 WHERE category = 'clothing' 
 and
 quantiy >= 4 
 and
 DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
```

6. **Write a SQL query to calculate the total sales for each category**:
```sql
Select category, SUM(total_sale) AS total_sales
FROM retail_sales
group by category;
```

7. ** Write a SQL query to find the average age of customers who purchase items from beauty category**:
```sql
SELECT category, round(avg(age), 2) as avg_age_of_customers
from retail_sales
WHERE category = 'beauty';
```

8. **Write an SQL query to find all the transactions where the total_sale is greater than 1000. **:
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

9. **Write a SQL query to find total number transactions made by ach gender in each category**:
```sql
SELECT category, gender, count(transactions_id) as total_transactions
FROM retail_sales
group by gender, category
order by category;
```

10. **Write a SQL query to calculate the average sale for each month?**:
```sql
SELECT
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	round(avg(total_sale), 2) as average_sale,
    RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY avg(total_sale) DESC) AS rank_by_highest_sale
FROM retail_sales
GROUP BY year, month
order by year, month ;
```
11. **Write a SQL query to find the top 5 customers based on the highest total sales  **

```sql
SELECT customer_id, SUM(total_sale) as total_sales
FROM retail_sales 
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

```

12. **Write a SQL query to find the number of unique customers who purchased items from each category  **
```sql
SELECT category, COUNT(DISTINCT(customer_id)) AS no_of_unique_customers
FROM retail_sales
GROUP BY category;
```
13. **Write a SQL query to create each shift and number of orders (Exampl Morning <= 12, Afternoon bewen 12 and 17, Evening > 17  **

```sql
SELECT COUNT(quantiy) as no_of_orders,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning Shift'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon Shift'
        WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'Evening Shift'
        END AS SHIFT
FROM retail_sales
group by shift;
```



## Findings

- **Sales and Customer Overview**:

Total number of sales transactions and the total sales amount were calculated.
The number of unique customers was determined, providing insight into customer base size.
The number of unique product categories offered was identified.

- **Sales Analysis**:

Specific sales transactions made on '2022-11-05' were retrieved.
Transactions involving 'clothing' category with quantity greater than or equal to 4 in November 2022 were identified. (You had quantiy >= 4, I assume that was intended)
Total sales for each product category were calculated.
Average age of customers purchasing 'beauty' category items was determined.
Transactions with total sales exceeding 1000 were listed.
The number of transactions made by each gender within each category was analyzed.
Average sales per month, per year were determined and ranked.

- **Customer Behavior**:

The top 5 customers with the highest total sales were identified.
The number of unique customers who purchased items from each category was calculated.

- **Time-Based Analysis**:

Sales were categorized into shifts (Morning, Afternoon, Evening) based on the sale_time, and the number of orders per shift was determined.


## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.



