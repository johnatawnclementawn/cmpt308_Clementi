-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 09/18/2017 --
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
              from agents
              where aid in (select aid
                            from orders
                            where cid in (select cid
                                          from customers
                                          where city = 'Beijing')
              				)
 			)
order by pid desc;

-- 3. Obtain the ID and name of customers who did not order thru agent 03. --

select cid, name
from customers
where cid in (select cid
              from orders
              where aid in (select aid
                           from orders
                           where aid != 'a03')
             );







