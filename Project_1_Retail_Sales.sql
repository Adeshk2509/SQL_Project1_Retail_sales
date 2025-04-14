-- SQL Retail Sales Analysis - P1
Create Database sql_project_p1;

-- Create Table
Drop Table retail_sales;

Create table retail_sales(
transactions_id int Primary Key,	
sale_date	date,
sale_time	time,
customer_id	int,
gender varchar(15),
age	int,
category varchar(12),	
quantity	int,
price_per_unit	int,
cogs	float,
total_sale int
);

SELECT * FROM retail_sales;

Select count(*) from retail_sales;

SELECT * FROM retail_sales
where transactions_id is null;

SELECT * FROM retail_sales
where sale_date is null;

SELECT * FROM retail_sales
where sale_time is null;

SELECT * FROM retail_sales
where transactions_id is null
or
 sale_date is null
or
 sale_time is null
or
 customer_id is null
or
 gender is null
or
 age is null
or
 category is null
or
 quantity is null
or
 price_per_unit is null
or
 cogs is null
or
 total_sale is null;
 
 --- Data Exploration
 
 --- How Many Sales we have ?
 
 select count(*) total_sales from retail_sales;
 
 --- How Many unique customers we have ?
 
 select count(distinct customer_id) as total_sale from retail_sales;
 
 
 ---- Data Analysis & Business Key Problems
 
#------ 1) Write SQL Query to retrieve all the columns for sales made on 2022-11-05.------

select * from retail_sales
where sale_date = "2022-11-05";

#------ 2) Write a SQL Query to retrieve all transactions where the category is 'Clothing' and the qunatity sold is more than 4 in the month of Nov-2022.------

select category, sum(quantity)
from retail_sales
where category = 'Clothing'
and 
char(sale_date, 'YYYY-MM') = '2022-11'
and 
quantity >= 4;

#------ 3) Write SQL Query to calculate the total sales for each category.-------

Select category, sum(total_sale) as Total_Sale, Count(category) as Total_Orders from retail_sales
group by category;

#------ 4) Write SQL Query to find the average age of customers who purchased items from 'Beauty' Category.-------

Select round(avg(age),2) as Avg_age from retail_sales
where category = "Beauty";

#------ 5) Write SQL Query to find all transactions where the total sale is greater than 1000.-------

select * from retail_sales
where total_sale > 1000;

#------ 6) Write SQL Query to find the total number of transactions made by each gender in each category -------

select category, gender,
count(*) as total_trans from retail_sales
group by category, gender
order by category;

#------ 7) Write SQL Query to calculate the average sale for each month. Also find out best selling month in each year. -------

Select 
year, 
month,
avg_sale
from
(
select 
year(sale_date) as Year,
month(sale_date) as Month,
avg(total_sale) as Avg_Sale,
Rank() over(partition by (Year (sale_date)) ORDER BY AVG (total_sale) desc) as rnk
 from 
 retail_sales
 group by year(sale_date), month(sale_date)
 ) as t1
where rnk = 1;

#------- 8) Write SQL Query to find the top 5 customers based on the highest total sales. -------

Select customer_id, sum(total_sale) as Total_Sale from retail_sales
group by customer_id
order by Total_Sale desc
limit 5;

#------- 9) Write SQL Query to find the number of customers who purchased items from each category. -------
 
Select count(distinct customer_id) as unique_customer, category from retail_sales
group by category;

#------- 10) Write SQL Query to create each shift and number of orders (Example Morning <= 12, Afternoon between 12 & 17, Evening > 17)--------

select 
     case 
     when hour(sale_time) <= 12 then 'Morning'
     when hour(sale_time) > 12 and hour(sale_time) <= 17 then 'Afternoon'
     else
     'Evening'
End as Shift,
Count(customer_id) as num_orders
from retail_sales
group by shift;