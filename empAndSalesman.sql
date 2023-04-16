-- 1). List all the columns of the Salespeople table.**

select * from salespeople;

-- 2). List all customers with a rating of 100.***

select * from customers where rating = 100;

-- 3). Find all records in the Customer table with NULL values in the city column.***
select * from customers where city is null;

-- 4).Find the largest order taken by each salesperson on each date.***
select snum,onum,odate,max(amt) as largest_order from orders group by snum,odate;

-- 5). Arrange the Orders table by descending customer number.
select * from orders order by cnum desc;

-- 6). Find which salespeople currently have orders in the Orders table.***
select snum,sname from salespeople where snum in (select snum from orders);

-- 7).List names of all customers matched with the salespeople serving them.
select cname from customers where snum in (select snum from salespeople);

-- 8). Find the names and numbers of all salespeople who had more than one customer.*** 
select snum,sname from salespeople  where snum in (select snum from customers group by snum having count(snum) > 1);

-- 9). Count the orders of each of the salespeople and output the results in descending order.**
select snum, count(onum) from orders group by snum order by count(onum) desc;

-- 10). List the Customer table if and only if one or more of the customers in the Customer table are
-- located in San Jose.

select * from customer where  (select count(*) from customers where city = 'San Jose')>1;
select * from customer where (select count(*) from customer where city='san jose')>1;

-- 11).Match salespeople to customers according to what city they lived in.
select c.cname , s.sname , c.city from  salespeople s , customers c  where s.city = c.city or s.snum=c.cnum;

-- 12). Find the largest order taken by each salesperson.
select snum,max(amt) from orders group by snum;

-- 13). Find customers in San Jose who have a rating above 200.**
select cnum,cname from customers where rating > 200;

-- 14).List the names and commissions of all salespeople in London.***
select sname , comm from salespeople where city = 'london';

-- 15). List all the orders of salesperson Motika from the Orders table.
select onum , snum from orders where snum in (select snum from salespeople where sname = 'Motika');

-- 16). Find all customers with orders on October 3.

select * from customers where cnum in (select cnum from orders where odate = '96-10-03');

-- 17). Give the sums of the amounts from the Orders table, grouped by date, eliminating all those
-- dates where the SUM was not at least 2000.00 above the MAX amount. 
select sum(amt) from orders group by odate having sum(amt) < 2000+max(amt);

-- 18). Select all orders that had amounts that were greater than at least one of the orders from
-- October 6.
select onum from orders where amt > any(select amt from orders where odate='96-10-06');

-- 19).Write a query that uses the EXISTS operator to extract all salespeople who have customers
-- with a rating of 300.

select snum,sname from salespeople s where EXISTS (select snum from customers c where s.snum=c.snum and c.rating = 300);

-- 20). Find all pairs of customers having the same rating.

select * from customers order by rating;

-- 21. Find all customers whose CNUM is 1000 above the SNUM of Serres.

select cnum, cname from cust where cnum > ( select snum+1000  from salespeople where sname = 'Serres');

-- 22. Give the salespeople’s commissions as percentages instead of decimal numbers.
select snum, sname,city,comm,(comm*100),'%' as percentages from salespeople;

-- 23. Find the largest order taken by each salesperson on each date, eliminating those MAX orders
-- which are less than $3000.00 in value.
select o.onum,o.snum,s.sname,max(o.amt) from orders o join salespeople s on s.snum = o.snum group by odate having max(amt) > 3000;

-- 24. List the largest orders for October 3, for each salesperson.

select o.snum ,s.sname,o.onum,max(o.amt) from orders o join salespeople s on o.snum = s.snum group by s.sname, o.odate having o.odate = '1996-03-10';

-- 25. Find all customers located in cities where Serres (SNUM 1002) has customers.
select* from customers where snum=(select snum from salespeople where sname='serres');

-- 26.Select all customers with a rating above 200.00.
select * from customers where rating > 200.00;

-- 27. Count the number of salespeople currently listing orders in the Orders table.
select count(snum) from orders;

-- 28. Write a query that produces all customers serviced by salespeople with a commission above
-- 12%. Output the customer’s name and the salesperson’s rate of commission.

select c.cname ,s.comm from customers c join salespeople s on c.snum=s.snum where s.comm>0.12;

-- 29. Find salespeople who have multiple customers.
select s.snum,s.sname,count(c.cnum) from customers c join salespeople s on c.snum = s.snum group by s.snum having count(c.cnum)>1;

-- 30. Find salespeople with customers located in their city.

select s.sname,s.snum,c.cname,c.cnum from salespeople s , customers c where s.snum=c.snum and s.city=c.city;

-- 31. Find all salespeople whose name starts with ‘P’ and the fourth character is ‘l’.

select * from salespeople where sname like 'P___I%';

-- 32. Write a query that uses a subquery to obtain all orders for the customer named Cisneros.
-- Assume you do not know his customer number.

select * from orders where cnum = (select cnum from customers where cname = "Cisneros");

-- 33. Find the largest orders for Serres and Rifkin.
select s.sname,s.snum , max(o.amt) from salespeople s , customers c , orders o 
where s.snum = c.snum and c.cnum=o.cnum and s.sname="Serres" or s.sname="Rifkin" 
group by s.snum;

-- 34. Extract the Salespeople table in the following order : SNUM, SNAME, COMMISSION, CITY.
select snum , sname , comm , city from salespeople;

-- 35. Select all customers whose names fall in between ‘A’ and ‘G’ alphabetical range.
select * from customers where left(cname,1) between 'A' and 'G';

-- 36. Select all the possible combinations of customers that you can assign.
select c1.cname , c2.cname , c1.rating from customers c1 ,customers c2 
where c1.cname>c2.cname;

-- 37. Select all orders that are greater than the average for October 4.
select * from orders where amt > (select avg(amt) from orders where odate="1996-04-10");


-- 38. Write a select command using a corelated subquery that selects the names and numbers of all
-- customers with ratings equal to the maximum for their city.

-- 39. Write a query that totals the orders for each day and places the results in descending order.
select odate,sum(amt) as total_order from orders group by odate order by total_order desc;

-- 40. Write a select command that produces the rating followed by the name of each customer in
-- San Jose.
select rating , cname from customers where city = "san jose";

-- 41). Find all orders with amounts smaller than any amount for a customer in San Jose.
select onum,amt,odate from orders 
where amt<(select max(amt) from orders o join customers c on o.cnum=c.cnum group by city having city='San jose');

-- 42). Find all orders with above average amounts for their customers.
select c.cname, o.amt from customers c , orders o where c.cnum = o.cnum and amt > (select avg(amt) from orders) group by cname;

-- 43).Write a query that selects the highest rating in each city.
select max(rating) as highest_Rating, city from customers group by city;

-- 44). Write a query that calculates the amount of the salesperson’s commission on each order by a customer with a 
-- rating above 100.00.
select o.amt,o.cnum,c.rating,c.snum,s.sname,s.comm,o.amt*s.comm from salespeople s, orders o, customers c
where o.snum=s.snum and s.snum=o.snum and c.rating > 100.00;

select o.amt,o.cnum,c.rating,c.snum,s.sname,s.comm,o.amt*s.comm from orders o,customers c,salespeople s 
where o.cnum=c.cnum and c.snum=s.snum and c.rating>100;


-- 45). Count the customers with ratings above San Jose’s average.
select count(cnum)  from customers where rating > (select avg(rating) from customers where city = "San Jose");

-- 46). Write a query that produces all pairs of salespeople with themselves as well as duplicate rows with 
--      the order reversed.

select s1.sname,s2.sname from salespeople s1,salespeople s2;

-- 47). Find all salespeople that are located in either Barcelona or London.
select * from salespeople where city=" Barcelona" or city="London";


-- 48). Find all salespeople with only one customer.
select * from salespeople where snum in 
(SELECT snum FROM Customers GROUP BY snum HAVING COUNT(*) = 1);

-- 49). Write a query that joins the Customer table to itself to find all pairs of customers served by a single 
-- salesperson.
select c1.cname,c2.cname from customers c1, customers c2,salespeople c3 where c1.snum = c2.snum and  c2.snum=c3.snum;

-- 51). Write a query that lists each order number followed by the name of the customer who made
-- that order.
select o.onum, c.cname from orders o , customers c where o.cnum=c.cnum;


-- 52). Write 2 queries that select all salespeople (by name and number) who have customers in their
-- cities who they do not service, one using a join and one a corelated subquery. Which solution
-- is more elegant?

select distinct sname from salespeople s join customers c on c.city=s.city where s.snum!=c.snum;

-- 53). Write a query that selects all customers whose ratings are equal to or greater than ANY (in the
-- SQL sense) of Serres’?

select * from customers where rating>=200;

-- 54). Write 2 queries that will produce all orders taken on October 3 or October 4.
select * from orders where monthname(odate) = 'october' and( day(odate)=03 or day(odate)=04);

-- 56). Find only those customers whose ratings are higher than every customer in Rome.
select * from customers where rating >(select max(rating) from customers where city='Rome');

-- 57). Write a query on the Customers table whose output will exclude all customers with a rating <=
-- 100.00, unless they are located in Rome.

select * from customers where rating >=100 and city!='Rome';


-- 59). Find the total amount in Orders for each salesperson for whom this total is greater than the
-- amount of the largest order in the table. 
select sname,sum(amt) from orders o join salespeople s on o.snum=s.snum group by sname having sum(amt)>(select max(amt) from orders);


-- 60).Write a query that selects all orders save those with zeroes or NULLs in the amount field.  
select * from orders where amt=0 or amt is null;

-- 61. Produce all combinations of salespeople and customer names such that the former precedes
-- the latter alphabetically, and the latter has a rating of less than 200.

select s.sname ,c.cname from salespeople s, customers c where s.sname>c.cname and rating < 200;


-- 63. Write a query that produces the names and cities of all customers with the same rating as
-- Hoffman. Write the query using Hoffman’s CNUM rather than his rating, so that it would still be
-- usable if his rating changed.
select cname ,city from customers where rating=(select rating from customers where cnum=(select cnum from customers where cname='Hoffman'));


-- 65.Write a query that produces the names and ratings of all customers of all who have above
-- average orders.


select distinct cname,rating from customers c, orders o 
where c.cnum=o.cnum and amt>
(select avg(amt) from orders);

-- 66. Find the SUM of all purchases from the Orders table.
select sum(amt) from orders;

-- 67. Write a SELECT command that produces the order number, amount and date for all rows in
-- the order table.

select onum,amt,odate from orders;

-- 68. Count the number of nonNULL rating fields in the Customers table (including repeats).
select count(rating) from customers where rating is not null;

-- 69. Write a query that gives the names of both the salesperson and the customer for each order
-- after the order number.

select o.onum ,s.sname,c.cname
from
orders o join customers c
on o.cnum=c.cnum
join
salespeople s 
on
 o.snum=s.snum
and c.snum=s.snum
;

-- 70. List the commissions of all salespeople servicing customers in London.
select snum , comm from salespeople where snum in(select snum from customers where city ='London');

-- 71. Write a query using ANY or ALL that will find all salespeople who have no customers located in
-- their city.
select snum, sname from salespeople where city!= all(select city from customers);

-- 72. Write a query using the EXISTS operator that selects all salespeople with customers located in
-- their cities who are not assigned to them.

select snum , sname from salespeople s where exists(select s.snum from customers c  where s.city=c.city and s.snum != c.snum);


-- 73. Write a query that selects all customers serviced by Peel or Motika. (Hint : The SNUM field
-- relates the two tables to one another.)
select distinct(c.cnum) from customers c,salespeople s where s.sname='Peel' or s.sname='Motika';


-- 74. Count the number of salespeople registering orders for each day. (If a salesperson has more
-- than one order on a given day, he or she should be counted only once.)

select count(snum) , odate from orders group by odate;

-- 75. Find all orders attributed to salespeople in London.

select distinct(o.onum), s.city from orders o , salespeople s where s.snum=o.snum and s.city='London';

-- 76. Find all orders by customers not located in the same cities as their salespeople.

select distinct(o.onum) from orders o , customers c , salespeople s where o.snum=s.snum and c.snum=o.snum and s.city=c.city;

-- 77. Find all salespeople who have customers with more than one current order.
select * from salespeople where snum in 
(select c.snum from customers c join orders o on c.cnum = o.cnum group by c.cnum having count(c.cnum)>1);

-- 78. Write a query that extracts from the Customers table every customer assigned to a
-- salesperson who currently has at least one other customer (besides the customer being
-- selected) with orders in the Orders table.

select s.sname , c.cname from salespeople s join customers c on s.snum = c.snum where cname in 
(select max(c.cname) from customers c join orders o on c.cnum = o.cnum group by o.onum);


-- 79.Write a query that selects all customers whose names begin with ‘C’.
select * from customers where cname like 'c%';

-- 80. Write a query on the Customers table that will find the highest rating in each city. Put the output
-- in this form : for the city (city) the highest rating is : (rating).

select city,max(rating) as 'highest rating is' from customers group by city;

-- 81). Write a query that will produce the SNUM values of all salespeople with orders currently in the Orders table 
-- (without any repeats).
select snum from salespeople s where exists(select 1 from orders o where o.snum=s.snum);

-- 82). Write a query that lists customers in descending order of rating. Output the rating field first,
-- followed by the customer’s names and numbers.
select rating ,cname,cnum from customers order by rating desc;


-- 83). Find the average commission for salespeople in London.

select avg(comm*o.amt) as 'average commision of london' from salespeople s, orders o   where s.snum = o.snum group by city having city='London';

-- 84). Find all orders credited to the same salesperson who services Hoffman (CNUM 2001).

select o.* from orders o , customers c where o.cnum = c.cnum and  c.snum = (select snum from customers where cname='hoffman');

-- 85). Find all salespeople whose commission is in between 0.10 and 0.12 (both inclusive).

select * from salespeople where comm between 0.10 and 0.12;

-- 86). Write a query that will give you the names and cities of all salespeople in London with a commission above 0.10.
select sname, city from salespeople where comm>0.10 and city='London';

-- 88). Write a query that selects each customer’s smallest order.
select cnum,min(amt) from orders group by cnum order by cnum;

-- 89). Write a query that selects the first customer in alphabetical order whose name begins with G.
select cname from customers where cname like 'G%' order by cname;

-- 90). Write a query that counts the number of different nonNULL city values in the Customers table.
select count(city) from customers where city is not null;

-- 91). Find the average amount from the Orders table.
select avg(amt) from orders;

-- 93). Find all customers who are not located in San Jose and whose rating is above 200.
select * from customers where city != 'San Jose' and rating > 200;

-- 94). Give a simpler way to write this query :

-- SELECT snum, sname city, comm FROM salespeople WHERE (comm >  0.12 OR comm < 0.14);

SELECT snum, sname city, comm FROM salespeople WHERE comm between 0.12 and  0.14;


-- 96). Which salespersons attend to customers not in the city they have been assigned to?
select sname,c.city,s.city from salespeople s join customers c on s.snum = c.snum and s.city != c.city;

-- 97). Which salespeople get commission greater than 0.11 are serving customers rated less than 250?

select * from salespeople s, customers c where s.snum = c.snum and s.comm > 0.11 and c.rating < 250;

-- 98). Which salespeople have been assigned to the same city but get different commission percentages?

select distinct(s1.sname) from salespeople s1 , salespeople s2 where s1.city = s2.city and s1.comm != s2. comm;

-- 99). Which salesperson has earned the most by way of commission?

select sum(comm*amt) as comm_total from salespeople s, orders o where s.snum = o.snum group by s.snum order by comm_total desc limit 1 ;


-- 100).Does the customer who has placed the maximum number of orders have the maximum rating?

select cname as 'Customers',c as 'No of Orders' 
from(select cname,count(cname) c,dense_rank() over (order by count(cname) desc) rn
from customers c,orders o
where c.cnum=o.cnum group by cname) as t where rn=1;


-- 101).Has the customer who has spent the largest amount of money been given the highest rating?

select cname,sum(amt) as total_spending , rating from customers c, orders o where c.cnum=o.cnum group by cname order by total_spending desc;

-- 102).List all customers in descending order of customer rating.

select cname , rating from customers order by rating desc;

-- 103).On which days has Hoffman placed orders?

select cname,onum,odate from orders o , customers c where o.cnum=c.cnum and cname = 'hoffman';

-- 104).Do all salespeople have different commissions?

select s1.sname,s2.sname from salespeople s1 , salespeople s2 where s1.sname != s2.sname and s1.comm=s2.comm;

-- 105).Which salespeople have no orders between 10/03/1996 and 10/05/1996?

select sname from salespeople s 
where not exists(select 1 from orders o where s.snum=o.snum and odate between'1996-10-03' and '1996-10-05');

-- 106).How many salespersons have succeeded in getting orders?

select s.snum, s.sname, count(o.onum) no_of_orders from salespeople s , orders o where s.snum = o.snum group by s.snum ;

-- 107).How many customers have placed orders?
select count(cname) from customers c where exists(select 1 from customers c , orders o where c.cnum=o.cnum);


-- 108).On which date has each salesperson booked an order of maximum value?
select s.snum,sname,o.odate,max(o.amt) from salespeople s , orders o where s.snum = o.snum group by sname;

-- 109).Who is the most successful salesperson?
SELECT s.sname, SUM(o.amt * s.comm) AS max_income 
FROM salespeople s 
JOIN orders o ON s.snum = o.snum 
GROUP BY s.sname 
ORDER BY max_income DESC 
LIMIT 1;

-- 110).Who is the worst customer with respect to the company?

select cname, sum(amt) as total_expenditure from customers c join orders o on c.cnum = o.cnum group by cname order by total_expenditure limit 1;


-- 111).Are all customers not having placed orders greater than 200 totally been serviced by salespersons Peel or Serres?
 
 select s.snum,sname from salespeople s , customers c where c.snum = s.snum and c.cnum in (select cnum from orders where amt < 200);

-- 112).Which customers have the same rating?

select c1.cname , c2.cname from customers c1, customers c2 where c1.cnum<c2.cnum and c1.rating=c2.rating;


-- 113).Find all orders greater than the average for October 4th.
select * from orders where amt >(select avg(amt) from orders where odate ='1996-10-04');

-- 114).Which customers have above average orders?
select distinct(cname) from customers c join orders o on c.cnum=o.cnum  where amt > (select avg(amt) from orders);

-- 115).List all customers with ratings above San Jose’s average.

select cname from customers where rating >(select avg(rating) from customers where city = 'San Jose');

-- 116).Select the total amount in orders for each salesperson for whom the total is greater than the amount of 
-- the largest order in the table.
select sname , sum(amt) as total from salespeople s join orders o on s.snum = o.snum group by s.snum having total > (select max(amt) from orders);

-- 117).Give names and numbers of all salespersons who have more than one customer.

select sname , s.snum from salespeople s where s.snum in ( select snum from customers group by snum having count(cnum) > 1);

SELECT s.sname, COUNT(c.cnum) as num_customers 
FROM salespeople s 
JOIN customers c ON s.snum = c.snum 
GROUP BY s.snum 
HAVING COUNT(c.cnum) > 1;

-- 118).Select all salespersons by name and number who have customers in their city whom they don’t service.

select distinct s.snum, sname from salespeople s join customers c on s.snum != c.snum and c.city = s.city;

-- 119).Which customers’ rating should be lowered?
select cname , sum(amt) as total_spend from customers c join orders o on c.cnum = o.cnum group by c.cnum order by total_spend limit 1;


-- 120).Is there a case for assigning a salesperson to Berlin?

select * from customers where city='berlin';

-- 121). Is there any evidence linking the performance of a salesperson to the commission that he or she is being paid?

select b.snum,c.sname,sum(a.amt) as totalsalesbySP,sum(amt)*c.comm 
from orders a,customers b,salespeople c 
where a.cnum=b.cnum and b.snum=c.snum group by b.snum
order by totalsalesbySP desc;







use 125query;
show tables;
-- 52). Write 2 queries that select all salespeople (by name and number) who have customers in their
-- cities who they do not service, one using a join and one a corelated subquery. Which solution
-- is more elegant?

select s.sname , s.snum ,c.cname, c.cnum , c.city from salespeople s 
join customers c on c.city=s.city 
where s.snum != c.snum;

-- 54). Write 2 queries that will produce all orders taken on October 3 or October 4.
select onum from orders where monthname(odate) = 'october' and day(odate) = 03 or day(odate) = 04;


-- 55). Write a query that produces all pairs of orders by a given customer. Name that customer and
-- eliminate duplicates.

select cname from customers c , orders o where c.cnum=o.cnum;


-- 56). Find only those customers whose ratings are higher than every customer in Rome.
select cname from customers where rating > ( select max(rating) from customers where city = 'rome');



-- Write a query on the Customers table whose output will exclude all customers with a rating <=
-- 100.00, unless they are located in Rome.

select cname from customers where (rating <= 100.00 and city != 'Rome') or rating > 100;




-- 59). Find the total amount in Orders for each salesperson for whom this total is greater than the
-- amount of the largest order in the table.
select distinct(s.sname),sum(amt) total from orders o , salespeople s group by o.snum having total > max(amt);

select sname,sum(amt) from orders o join salespeople s on o.snum=s.snum group by sname having sum(amt)>(select max(amt) from orders);

select distinct city, comm from salespeople order by comm desc limit 5;

-- 63. Write a query that produces the names and cities of all customers with the same rating as
-- Hoffman. Write the query using Hoffman’s CNUM rather than his rating, so that it would still be
-- usable if his rating changed.

select trim(cname) , trim(city) from customers where rating = ( select rating from customers where cname = 'Hoffman');

select trim(cname),trim(city) from customers where rating=(select rating from customers where cname='Hoffman');

-- 65.Write a query that produces the names and ratings of all customers of all who have above
-- average orders.

select cname , rating from customers s , orders o 
where s.cnum = o.cnum and o.amt > (select avg(amt) from orders);  


select distinct cname,rating from customers c, orders o 
where c.cnum=o.cnum and amt>
(select avg(amt) from orders);

-- 67. Write a SELECT command that produces the order number, amount and date for all rows in
-- the order table.

select onum , amt , odate from orders ;

-- 68. Count the number of nonNULL rating fields in the Customers table (including repeats).

select count(cnum) from customers where rating is not null;

-- 69. Write a query that gives the names of both the salesperson and the customer for each order
-- after the order number.

select o.onum ,s.sname,c.cname
from
orders o join customers c
on o.cnum=c.cnum
join
salespeople s 
on
 o.snum=s.snum
and c.snum=s.snum
;

-- 70. List the commissions of all salespeople servicing customers in London.

select sum(comm) , sname from salespeople group by snum;

-- 71. Write a query using ANY or ALL that will find all salespeople who have no customers located in
-- their city.

select snum , sname from salespeople where city != all(select city from customers);

-- 72. Write a query using the EXISTS operator that selects all salespeople with customers located in
-- their cities who are not assigned to them. 

select s.sname ,s.snum from salespeople s where exists (select c.snum from customers c where c.city = s.city and c.snum!=s.snum); 

-- 73. Write a query that selects all customers serviced by Peel or Motika. (Hint : The SNUM field
-- relates the two tables to one another.)

select cname , cnum from customers where snum not in ( select snum from salespeople where sname != 'Peel' and sname != 'Motika');

-- 74. Count the number of salespeople registering orders for each day. (If a salesperson has more
-- than one order on a given day, he or she should be counted only once.)

select o.odate, count(distinct snum)  from orders  o group by o.odate;

-- 75. Find all orders attributed to salespeople in London.
select o.onum from orders o join salespeople s on s.snum=o.snum where s.city='london';

-- 76. Find all orders by customers not located in the same cities as their salespeople.

(select onum from orders where cnum in(select  cnum from customers c join salespeople s on c.city != s.city));

-- 77. Find all salespeople who have customers with more than one current order.

select s.sname from salespeople s join customers c on s.snum = c.snum where c.cname 
in
(select c.cname from customers c join orders o on c.cnum = o.onum group by o.cnum having count(o.cnum)>1);

-- 78. Write a query that extracts from the Customers table every customer assigned to a
-- salesperson who currently has at least one other customer (besides the customer being
-- selected) with orders in the Orders table.

-- 81). Write a query that will produce the SNUM values of all salespeople with orders currently in the Orders table (without any repeats).

select distinct(s.snum) from salespeople s join orders o on s.snum = o.snum;

-- 83). Find the average commission for salespeople in London.

select avg(s.comm*o.amt) from salespeople s join orders o on s.snum = o.snum  group by city having city = 'London';

select * from orders limit 10;
-- 84). 
select amt , dense_rank() over(order by amt desc) as ranking from orders where ranking = 2;