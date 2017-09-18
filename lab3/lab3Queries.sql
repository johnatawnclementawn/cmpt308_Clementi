-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 09/18/2017 --
-- Assignment: DBS Lab 3 --
-- File name: lab3Queries --

-- 1. Obtain the cost of each order --
select ordno, totalusd
from orders;

-- 2. Select data for agent Smith --
select name, city
from agents
where name = 'Smith';

-- 3. Select product information where quantity is larger than 200,010 --
select pid, name, priceusd
from products
where qty > 200010;

-- 4. Select Customers in Duluth --
select name, city
from customers
where city = 'Duluth';

-- 5. Select agents not in New York or Duluth --
select name
from agents
where city != 'New York'
	and city != 'Duluth';
    
-- 6. Select products that cost $1 or more and aren't in Dallas or Duluth --
select *
from products
where priceusd >= 1.00 
	and city != 'Dallas'
	and city != 'Duluth';
    
-- 7. Select Orders in March and May --
select *
from orders
where month in ('Mar', 'May');

-- 8. Select orders of $500 or more in February --
select *
from orders 
where month = 'Feb'
	and totalusd >= 500.00;
    
-- 9. Select orders from customer 005 --
select *
from orders
where cid = 'c005';