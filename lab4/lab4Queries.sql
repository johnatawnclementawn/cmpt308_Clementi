-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 09/22/2017 --
-- Assignment: DBS Lab 4 --
-- File name: lab4Queries --

-- 1. Cities of Agents booking for customer 006 --

-- This query --
-- select * 
-- from orders
-- where cid = 'c006';
-- plus this query --
-- select aid, city
-- from agents;
-- results in: --

select city
from agents 
where aid in (select aid
             from orders
             where cid = 'c006');
             
-- 2. Get the distinct Product ID's (sorted in desc order) of products ordered through an Agent 
--		who recieves an order from at least one customer in Beijing --
select distinct pid
from orders
where aid in (select aid
              from orders
              where cid in (select cid
                            from customers
                            where city = 'Beijing')
             )			
order by pid desc;

-- 3. Obtain the ID and name of customers who did not order thru agent 03. --

select cid, name
from customers
where cid in (select cid
              from orders
              where aid in (select distinct aid
                           from orders
                           where aid != 'a03')
             );
             
-- 4. Get customer id's for customers who ordered products 1 and 7 --

select distinct cid
from orders
where pid in ('p01','p07');


-- 5. Get product id's (ordered high-low) not ordered by any customers ordering through agents a02 or a03 --

select pid
from orders
where cid in (select cid
              from orders
              where aid in (select aid
                            from orders
                            where not aid in ('a02', 'a03')
                           )
             )
order by pid desc;


-- 6. Get name, discount, and city of customers ordering through agents in Tokyo or New York --

select name, discountpct, city
from customers
where cid in (select cid
              from orders
              where aid in (select aid
                            from agents
                            where city in ('Tokyo', 'New York')
                           )
             );

-- 7. Select customers who have the same discount as any customers in Duluth or London --

select name
from customers
where discountpct in (select discountpct
              from customers
              where city in ('Duluth', 'London')
             );


-- End Script.  Completed 16:30, 2017/09/22 by Johnathan Clementi --