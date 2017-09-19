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
