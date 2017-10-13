-- Author: Johnathan Clementi --
-- Prof: Alan Labouseur --
-- Date: 10/10/2017 --
-- Assignment: DBS Lab 6 --
-- File name: lab6Queries --

-- 1. Display name and city of customers who live in the city with the most unique products (see hint**)

select c.name, c.city
from customers c
where c.city IN (select p.city
                 from products p
                 group by p.city
                 order by COUNT(p.city) DESC
                 limit 1); 
 
-- 2. Display names of products (in reverse alphabetical order) where the price of the product is greater than or
-- equal to the average price for all of the products

select name 
from products 
where priceUSD >=  (select AVG(p.priceUSD)
                    from products p)
order by name desc;


-- 3. Display customer name, pid ordered, and total for all orders sorted by total low -> high

select c.name, o.pid, o.totalUSD
from orders o INNER JOIN customers c ON c.cid = o.cid
order by o.totalUSD ASC;


-- 4. Display all customers names (DESC) and their total ordered, use coalesce to avoid nulls

select c.name, coalesce(o.totalUSD, 0.00)
from orders o RIGHT OUTER JOIN customers c ON c.cid = o.cid
order by c.name DESC;

-- 5. Display customer names (and product names ordered, and agents who sold them) for those who bought products 
-- from agents based in Newark 

select c.name, p.name, a.name
from orders o INNER JOIN customers c ON c.cid = o.cid
			  INNER JOIN agents a ON a.aid = o.aid
              INNER JOIN products p ON p.pid = o.pid
where a.city = 'Newark';

-- 6. Write a query to check the accuracy of Order.totalUSD. Do this by calculating this column using 
-- data in other tables and comparing those values to the values in Orders.totalUSD. Then display all rows
-- where there is a discrepancy (if any)

select o.ordno, o.totalUSD
from orders o
where o.totalUSD IN (select (o.quantity * p.priceUSD) - ((o.quantity * p.priceUSD) * c.discountPct) AS "adjTotal"
                     from orders o INNER JOIN customers c ON c.cid = o.cid
			  					   INNER JOIN agents a ON a.aid = o.aid
                                   INNER JOIN products p ON p.pid = o.pid);
                                   
-- 7. What's the difference between a Right and Left Outer Join, show examples (use CAP)

-- A primary purpose of outer joins is the deal with rows which are missing data in other tables. In other words
-- if a customer has not made an order and we are looking to join the customers and orders tables, an outer join 
-- will help show where there are non-matching data. Right and Left outer joins display all data from columns in 
-- the right or left table within the join statement. For example:

select * 
from orders o RIGHT OUTER JOIN customers c ON c.cid = o.cid;

-- In the CAP table, customer number 005 has not made any orders.  Therefore, the query above will display all 
-- columns in the orders table with the NULL value, in the row that displays c005. 
-- For a Left Outer Join:

select * 
from orders o LEFT OUTER JOIN customers c ON c.cid = o.cid;

-- In the CAP table, there are no orders that do not have a customer.  Therefore, the left outer join above
-- displays like an inner join on the tables.  However if there were a case where an order that did not have a 
-- cid, Null would show in the customers columns. 







