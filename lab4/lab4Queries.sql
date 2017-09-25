-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 09/22/2017 --
-- Assignment: DBS Lab 4 --
-- File name: lab4Queries --
-- P.S. POSTGRESQL IS FREAKIN' AWESOME! --

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

-- Answer to Question 8: 
-- 
-- Check constraints are restrictions within a database that are used to ensure data integrity. They dictate values that can be entered 
-- into a column or table other than values of 'NOT NULL', 'PRIMARY KEY', and the datatypes.  In other words, check constraints
-- enforce rules so that data within the table is useful, consistent, and is unlikely to change - for instance names of days or months. 
-- Check constraints are useful because they limit user input to data that is unique, meaningful, and unlikely to change.  
-- For example here is an example of a good check constraint.
--
--    fishLog_Species TEXT CHECK(fishLog_Species = 'bluegill'
--                        OR fishLog_Species = 'pumpkinseed'
--                        OR fishLog_Species = 'northernPike'
--                        OR fishLog_Species = 'walleye'
--                        OR fishLog_Species = 'rockBass'
--                        OR fishLog_Species = 'smallMouthBass'
--                        OR fishLog_Species = 'largeMouthBass')
--
-- This constraint is useful for my fisheries research over the summer, especially when entering fish data, because it limits my entries to 
-- a certain format of the common names of fish.  This check constraint would not be considered not good if I added the following statements:
--
--    fishLog_Species TEXT CHECK(fishLog_Species = 'bluegill' OR fishLog_Species = 'BLG'
--                        OR fishLog_Species = 'pumpkinseed' OR fishLog_Species = 'PKS'
--                        OR fishLog_Species = 'northernPike' OR fishLog_Species = 'NPK'
--                        OR fishLog_Species = 'walleye' OR fishLog_Species = 'WLY'
--                        OR fishLog_Species = 'rockBass' OR fishLog_Species = 'RKB'
--                        OR fishLog_Species = 'smallMouthBass' OR OR fishLog_Species = 'SMB'
--                        OR fishLog_Species = 'largeMouthBass' OR fishLog_Species = 'LMB')
--
-- This is not a good check constraint because it allows different values for data that means the same thing.  In this case, the three letter 
-- abbreviation is the code we use in the field datasheets when collecting fish.  However, when entered into the database, we prefer that the 
-- full species name is included, not the field abbreviation, as it is more meaningful to people outside our lab.  
--