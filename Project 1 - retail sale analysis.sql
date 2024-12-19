Create Database project1;
use project1;
Drop table if exists retail_sale;
Create table retail_sale (
transactions_id	INT Primary key,
sale_date	Date,
sale_time time,
customer_id INT,
gender Varchar(15),
age	INT,
category Varchar(15),
quantiy INT,
price_per_unit Float,
cogs Float,
total_sale float
);

Select * from retail_sale;
select count(*) from retail_sale;
Select * from retail_sale where transactions_id is Null;
Select * from retail_sale
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or 
quantiy is null
or 
cogs is null
or 
total_sale is null;

Delete from retail_sale
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or 
quantiy is null
or 
cogs is null
or 
total_sale is null;

select count(*) from retail_sale;

-- total sale
select count(*) as total_sale from retail_sale;
select count(*) as customer from retail_sale;
select count(distinct customer_id) as total_sale from retail_sale;
select count(distinct category) as total_sale from retail_sale;
select distinct category from retail_sale;
-- write a SQL query to retrive all columns for sales made on 2022-05-11?
select * from retail_sale
where sale_date = '2022-11-05';
-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select  * from retail_sale
where category = 'Clothing' AND quantiy >= 4 AND 
Sale_date = '2022-11-02';

-- Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, sum(total_sale) as net_sale, count(*) as total_order
from retail_sale 
group by category,total_sale;

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sale
GROUP BY category, total_sale;
-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
Select category='Beauty', Round( Avg(age), 2) as avg_age
from retail_sale
Group By Category,Age;

Select * from retail_sale
where category = 'beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.
Select * from retail_sale
where total_sale > 1000;
-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
Select Category, Gender,
Count(*) as total_trans
from retail_sale
group By Category,Gender;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select 
year,Month,Avg_sale 
from
(
Select extract(Year from sale_date) Year,
extract(Month from sale_date)Month,
 Avg(total_sale) as Avg_sale,
 Rank()OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) 
from retail_sale
Group By Sale_date, Total_sale
-- Order BY sale_date,Total_sale Desc;

) as t1 

-- **Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id, Sum(total_sale) from retail_sale
group by customer_id,total_sale
order by customer_id, total_sale desc
Limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:

Select category, 
count(distinct customer_id) as Unique_id
from retail_sale
group by category,customer_id;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_sale
as
(
select *,
Case
WHEN EXTRACT(HOUR FROM sale_time) < 12 then 'Morning'
When EXTRACT(HOUR FROM sale_time) Between 12 AND 17 then 'Afternoon'
else 'Evening'
end as shift
 from retail_sale
 )
 select shift,
 count(*) as total_orders
 from hourly_sale
 group by shift
 
