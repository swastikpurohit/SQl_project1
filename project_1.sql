SELECT * FROM public.retail_sale
ORDER BY transactions_id ASC 


-- DATA EXPLORATION

-- How many sales we have?
select count(*) from retail_sale -- DONE

--How many unique customers we have?
select count( distinct customer_id) as total_customers from retail_sale

select distinct category from retail_sale


   -- My Analysis --

-- Q1. write an SQL query to retrieve all columns for sales made on 2022-11-05
select * from retail_sale where sale_date = '2022-11-05'

-- Q2. write an SQL to retrieve all transactions where the category is 'clothing' and the quantity is sold more than 10 in the month of Nov-2022
select * from retail_sale where quantiy >= 4 and category = 'Clothing' and TO_CHAR (sale_date, 'yyyy-mm') = '2022-11' ;

-- Q3. write a SQL query to calculate the total sales for each category
select category, sum(total_sale) as net_sale, count(*) as total_orders from retail_sale group by category;

-- Q4. write a sql query to find the average age of customers who purchased items from the beauty category
select round(avg(age),2) from retail_sale where category = 'Beauty';

-- Q5. write a query to find all transaction where total sale is greater than 1000
select * from retail_sale where total_sale > 1000;

-- Q6. write a sql query to find the number of transactions made by each gender in each category
select category, gender, count(*) from retail_sale group by  category, gender order by category;

-- Q7. write a sql query to calculate the average sale for each month and find out best selling month each year,
select year, month, total_sale
from 
(select 
extract(year from sale_date ) as year,
extract(month from sale_date ) as month,
avg(total_sale) as total_sale,
Rank() over(partition by extract(year from sale_date ) order by avg(total_sale) desc)
from retail_sale
group by 1,2 ) 
where rank = 1

-- Q8. write a sql query to find the top 5 customers based on the highest total_sale
select customer_id, sum(total_sale) as total_sale from retail_sale group by customer_id order by 2 desc limit 5;

-- Q9. write an SQL query to find number of unique customers who purchased from each category
select category, count(distinct customer_id) as no_customer from retail_sale group by category;

-- Q10. write a sql query to create each shift and number of orders (example morning <=12, afternoon between 12 & 17, evening >17)
with hourly_sale
as (
select *,
case
     when EXTRACT(HOUR FROM sale_time) < 12 then 'Morning'
	 when EXTRACT(HOUR FROM sale_time) between 12 and 17 then 'Afternoon'
	 else 'evening'
end as shifts
from retail_sale) 
select shifts, count (*) as total_orders from hourly_sale 
group by shifts


