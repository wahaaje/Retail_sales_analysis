/* SQL Retail Sales Analysis - P2*/

CREATE DATABASE if not exists sql_project_p3;

CREATE TABLE if not exists retail_sales(
	transactions_id  INT primary KEY,
	sale_date	DATE,
	sale_time	TIME,
	customer_id	INT,
	gender	VARCHAR(10),
	age int,
    category VARCHAR(15),
	quantiy	INT,
	price_per_unit	FLOAT,
	cogs FLOAT,	
	total_sale FLOAT
);

select *  
from retail_sales;

SELECT 
	COUNT(*)
FROM retail_sales;

/*Data Cleaning*/


/* Checking for NULL values */

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


/* Deleting NULL values if exist */

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
        
        
        
/* Data Expolration*/

/*How many Sales we have? */

Select count(total_sale) as Total_no_of_sales, SUM(total_sale) as Total_sales_amount
FROM retail_sales;

/*How many unique customers we have? */

Select count(DISTINCT(customer_id)) as Total_customers
FROM retail_sales;


/*How many unique category we have? */

SELECT COUNT(DISTINCT(category)) as total_categories
FROM retail_sales;



 /* Data Analysis and Business Key Problem and Answers */
 
 
 /* Q.1 Write a query to retrive all columns for sales made on '2022-11-05' */
 
 SELECT  *
 FROM retail_sales
 WHERE sale_date = '2022-11-05';
 
 
 /* Write a SQL query  to retrieve all transactions where the category is 'clothing' and the quantity sold is mre than 10 in the month of Nov-2022?*/
 
 
 SELECT *
 FROM retail_sales
 WHERE category = 'clothing' 
 and
 quantiy >= 4 
 and
 DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
;


/* Write a SQL query to calculate the total sales for each category*/

Select category, SUM(total_sale) AS total_sales
FROM retail_sales
group by category;


/* Write a SQL query to find the average age of customers who purchase items from beauty category */

SELECT category, round(avg(age), 2) as avg_age_of_customers
from retail_sales
WHERE category = 'beauty';


/* Write an SQL query to find all the transactions where the total_sale is greater than 1000. */

SELECT *
FROM retail_sales
WHERE total_sale > 1000;

/* write a SQL query to find total number transactions made by ach gender in each category */

SELECT category, gender, count(transactions_id) as total_transactions
FROM retail_sales
group by gender, category
order by category;


/* Write a SQL query to calculate the average sale for each month? */

SELECT
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	round(avg(total_sale), 2) as average_sale,
    RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY avg(total_sale) DESC) AS rank_by_highest_sale
FROM retail_sales
GROUP BY year, month
order by year, month ;


/* Write a SQL query to find the top 5 customers based on the highest total sales */


SELECT customer_id, SUM(total_sale) as total_sales
FROM retail_sales 
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


/* Write a SQL query to find the number of unique customers who purchased items from each category */

SELECT category, COUNT(DISTINCT(customer_id)) AS no_of_unique_customers
FROM retail_sales
GROUP BY category;


/*Write a SQL query to create each shift and number of orders (Exampl Morning <= 12, Afternoon bewen 12 and 17, Evening > 17 */

SELECT COUNT(quantiy) as no_of_orders,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning Shift'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon Shift'
        WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'Evening Shift'
        END AS SHIFT
FROM retail_sales
group by shift;


/* End of Project*/
