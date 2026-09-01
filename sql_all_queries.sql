-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_2;

CREATE TABLE RETAIL(
TRANSACTION_ID INT PRIMARY KEY,
SALE_DATE DATE,
SALE_TIME TIME,
CUSTOMER_ID INT,
GENDER VARCHAR(10),
AGE INT,
CATEGORY VARCHAR(20),
QUANTITY INT,
PRICE_PER_UNIT FLOAT,
COGS FLOAT,
TOTAL_SALES FLOAT
);

ALTER TABLE RETAIL ALTER COLUMN PRICE_PER_UNIT TYPE FLOAT;

ALTER TABLE RETAIL ALTER COLUMN COGS TYPE FLOAT;

DROP TABLE RETAIL;

SELECT * FROM RETAIL;

--SELECT DISTINCT CATEGORY FROM RETAIL;

--DATA CLEANING
SELECT * FROM RETAIL 
WHERE 
SALE_DATE IS NULL
OR SALE_TIME IS NULL
OR CUSTOMER_ID IS NULL
OR GENDER IS NULL
OR AGE IS NULL
OR CATEGORY IS NULL
OR QUANTITY IS NULL
OR PRICE_PER_UNIT IS NULL
OR COGS IS NULL
OR TOTAL_SALES IS NULL;

DELETE FROM RETAIL
WHERE SALE_DATE IS NULL
OR SALE_TIME IS NULL
OR CUSTOMER_ID IS NULL
OR GENDER IS NULL
OR AGE IS NULL
OR CATEGORY IS NULL
OR QUANTITY IS NULL
OR PRICE_PER_UNIT IS NULL
OR COGS IS NULL
OR TOTAL_SALES IS NULL;

-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE?

SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL;

-- HOW MANY UNIQUE CUSTOMERS WE HAVE

SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_UNIQUE_CUSTOMER_ID FROM RETAIL;

-- HOW MANY UNIQUE CATEGORY WE HAVE

SELECT DISTINCT CATEGORY AS TOTAL_UNIQUE_CATEGORY FROM RETAIL;

--Main Data Analysis
--Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * FROM RETAIL
WHERE sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT *
FROM RETAIL
WHERE category = 'Clothing' AND quantity>=4 AND TO_CHAR(sale_date, 'YYYY-MM') ='2022-11';

-- Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT SUM(total_sales) total_sales_per_category,category
FROM RETAIL
GROUP BY category

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT ROUND(AVG(age),2) as avg_age
FROM RETAIL
WHERE category='Beauty';

--http://localhost:3001
--Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * 
FROM RETAIL
WHERE total_sales>1000;

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
COUNT(*) as total_no_of_transaction,
gender,
category
FROM RETAIL
GROUP BY gender,category

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT average_sales,month,year
FROM(
SELECT AVG(total_sales) as average_sales,
TO_CHAR(sale_date,'MM') as month,
TO_CHAR(sale_date,'YYYY') as year,
RANK() OVER(PARTITION BY TO_CHAR(sale_date,'YYYY') ORDER BY AVG(total_sales) DESC) as rank_
FROM RETAIL
GROUP BY TO_CHAR(sale_date,'MM'),TO_CHAR(sale_date,'YYYY'))t
WHERE rank_=1;

--Write a SQL query to find the top 5 customers based on the highest total sales 