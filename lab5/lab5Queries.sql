-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 10/02/2017 --
-- Assignment: DBS Lab 4 --
-- File name: lab5Queries --
-- P.S. POSTGRESQL ROCKS MY SOCKS --

-- 1. Cities of Agents booking for customer 006 --  

select a.city
from orders o INNER JOIN agents a ON o.aid = a.aid
			  INNER JOIN customers c ON o.cid = c.cid
where c.cid = 'c006';


-- 2. Get product ids of products ordered through any agents who make at least one order for a customer in 
-- Beijing , sorted by pid highest to lowest. --

select distinct o2.pid
from orders o INNER JOIN customers c ON c.cid = o.cid
               INNER JOIN agents a ON c.city ='Beijing'
               INNER JOIN orders o2 ON o2.aid = o.aid
order by o2.pid DESC;


-- 3. Get the customers who have never placed an order using subquery --

select name
from customers
where cid not in (select cid
               from orders
			   where ordno = ordno);
 
 
 -- 4. Get customer names who have never placed an order using outer join --
 
select distinct name
from customers c LEFT OUTER JOIN orders o ON c.cid = o.cid
where o.cid IS NULL;


-- 5. Show customers names for those in the same city as their agent and the agent's name --

select distinct c.name, a.name
from customers c INNER JOIN orders o ON c.cid = o.cid
				  INNER JOIN agents a ON a.aid = o.aid
where c.city = a.city;


-- 6. Get customer, agents, and city name where cust and agents are in the same city --

select distinct c.name, a.name, c.city
from customers c INNER JOIN orders o ON c.cid = o.cid
				  INNER JOIN agents a ON c.city = a.city;


-- 7. Get name and city of customers who live in city that makes the fewest distinct products --

select c.name, c.city
from customers c INNER JOIN products p ON c.city = p.city
GROUP BY c.name, c.city
ORDER BY COUNT(p.city) ASC LIMIT 1;

