create database retail_shopping;
use retail_shopping;
drop table shopping;
create table shopping (
transactions_id int,
sale_date	date,
sale_time	time,
customer_id	int,
gender	varchar(10),
age	int,
category varchar(20),	
quantiy	int,
price_per_unit	float,
cogs float,
total_sale int);

-- data cleaning
select * from shopping order by customer_id limit 10;
select count(*) from shopping;
select distinct customer_id from shopping;

select distinct category from shopping;
select customer_id, sum(total_sale) from shopping group by customer_id order by sum(total_sale );
select category, count(customer_id) from shopping group by category;

select * from shopping where 
transactions_id is null or age is null;

delete from shopping where age is null or category is null or quantiy is null or price_per_unit is null or cogs is null or total_sale is null;
select count(*) from shopping;

-- data exploration
select sum(total_sale) from shopping;
select distinct category from shopping;
select customer_id, sum(total_sale) from shopping group by customer_id order by sum(total_sale );
select category, count(customer_id) from shopping group by category;

-- data analysis
describe shopping;
select * from shopping where sale_date="2022-05-05";
select * from shopping where category="Clothing" 
and month(sale_date)= 01 and 
year(sale_date)=2022 and 
quantiy >= 3;

-- category wise total sales calculate
select category, sum(total_sale), count(*) as total_transaction from shopping group by category;

select round(avg(age),2) 
from shopping 
where category="beauty"; 

select * 
from shopping 
where total_sale > 1000;

select category, 
gender, 
count(transactions_id)  from shopping
group by category , gender ;

select * from 
(	
    select year(sale_date) , month(sale_date), 
	avg(total_sale) as avg_sales,
	rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranks
	from shopping 
	group by 1,2 
) as t1 where ranks = 1 ;


select customer_id ,
sum(total_sale) 
from shopping
group by customer_id
order by 2 desc
limit 10;

select category, 
count(distinct customer_id)
from shopping 
group by category;


with hourly_sale 
as
(select * , 
	CASE
		when hour(sale_time) < 12 then "morning"
        when hour(sale_time) between 12 and 17 then "afternoon"
        else "evening"
	end as shift
from shopping) 

select shift , 
count(transactions_id)
from hourly_sale
group by shift;
        
