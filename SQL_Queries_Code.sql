select date from `walmartsalesdata.csv`;

-- ----------------------------------------------------Feature Engineering ---------------------------------------------
-- time_of_day ---------------------------------------------------------------------------------------------------------
select 
	time,
	(case 
		when `time` between "00:00:00" and "12:00:00" then 'Morning'
        when `time` between "12:01:00" and "16:00:00" then 'Afternoon'
        else 'Evening'
	end
    ) as time_of_day
 from `walmartsalesdata.csv`;
 
 alter table `walmartsalesdata.csv` add column time_of_day varchar(20);
 
 update `walmartsalesdata.csv` 
	set time_of_day= (
    case 
		when `time` between "00:00:00" and "12:00:00" then 'Morning'
        when `time` between "12:01:00" and "16:00:00" then 'Afternoon'
        else 'Evening'
	end
    );
    
-- day_name ---------------------------------
select 
	date,
    dayname(date) as day_name
from `walmartsalesdata.csv`;

alter table `walmartsalesdata.csv` add column day_name varchar(10);

update `walmartsalesdata.csv`
set day_name= dayname(date);

-- month_name-------------------------------------------------------------------------
select 
	date,
	monthname(date)
 from `walmartsalesdata.csv`;
 
 alter table `walmartsalesdata.csv` add column month_name varchar(10);
 
update `walmartsalesdata.csv`
set month_name= monthname(date); 
-- --------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------Generic----------------------------------------------------------------------------------------------
-- How many unique cities does the data have?-------------------------------------------------------------------------------------
select 
	distinct city
from `walmartsalesdata.csv`;

-- In which city is each branch?
select 
	distinct branch
from `walmartsalesdata.csv`;

select 
	distinct city, branch
from `walmartsalesdata.csv`;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------- Product ------------------------------------------------------------------------------------
-- How many unique product lines does the data have? -------------------
select 
	distinct `product line`
from `walmartsalesdata.csv`;

-- What is the most common payment method
select 
	`payment`,
    count(`payment`) as cnt
from `walmartsalesdata.csv`
group by `payment`
order by cnt desc;

-- What is the most selling product?
select 
	`product line`,
    count(`product line`) as cnt
from `walmartsalesdata.csv`
group by `product line`
order by cnt desc;

-- What is the total revenue by month
select 
	month_name as month,
    sum(total) as total_revenue
from `walmartsalesdata.csv`
group by month
order by total_revenue desc;

-- What month had the largest COGS(Cost Of Goods)
select 
	month_name as month,
    sum(cogs) as total_cogs
from `walmartsalesdata.csv`
group by month_name 
order by total_cogs desc;

-- What product line had the highest VAT
select 
	`product line`,
	avg(`tax 5%`) as VAT
from `walmartsalesdata.csv`
group by `product line`
order by VAT desc;

-- WHich branch sold more products than average products sold?
select 
	branch,
    sum(quantity) as qty
from `walmartsalesdata.csv`
group by branch
having sum(quantity) > (select avg (quantity) from  `walmartsalesdata.csv`)
order by qty desc;

-- What is the most common product line by Gender
select
	gender,
	`product line`,
    count(gender) as Total_cnt
from `walmartsalesdata.csv`
group by `product line`,gender
order by total_cnt desc;
-- What is the average rating of each product? I also rounded the average 
select
    `product line`,
    round(avg(rating),2) as avg_rating
from `walmartsalesdata.csv`
group by `product line`
order by avg(rating) desc;
