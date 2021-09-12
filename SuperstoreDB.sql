/*  My Name Jagdish Kumar
	this is my SQL superstoreDB Project
    Mob. 8449030780
    Email Jlohni05@gmail.com
*/

create database superstorDB;
show databases;

use superstorDB;
show tables;
/*
Identify and list the Primary Keys and Foreign Keys for this dataset
	(Hint: If a table don’t have Primary Key or Foreign Key, then specifically mention it in your answer.)
	1. cust_dimen
		Primary Key: Cust_id
        Foreign Key: NA
	
    2. market_fact
		Primary Key: NA
        Foreign Key: Ord_id, Prod_id, Ship_id, Cust_id
	
    3. orders_dimen
		Primary Key: Ord_id
        Foreign Key: NA
	
    4. prod_dimen
		Primary Key: Prod_id, Product_Sub_Category
        Foreign Key: NA
	

*/

/*
Table-1
	cust_dimen: Details of all the customers
*/

create table cust_Dimen(

Customer_Name varchar(25) not null,
Province varchar(25) not null,
Region varchar(25) not null,
Customer_Segment varchar(25) not null,
Cust_id varchar(25) not null
);

select*from superstorDB.cust_dimen;
/*
1. Write a query to display the Customer_Name and Customer Segment using alias 
name “Customer Name", "Customer Segment" from table Cust_dimen. 
*/
SELECT 
	Customer_name AS "Customer Name",
    Customer_Segment AS "Customer Segment"
FROM
	superstorDB.cust_dimen;
    
/*
2. Write a query to find all the details of the customer from the table cust_dimen 
order by desc.
*/

SELECT*
FROM superstorDB.cust_dimen
order by Customer_name desc;

/*
table-2
	Create a new table for quation number 3
	orders_dimen: Details of every order placed
*/
create table orders_dimen(
Order_ID int not null,
Order_Date varchar(225) not null,
Order_Priority varchar(225) not null,
Ord_id char(25) not null
);
use superstordb;
SELECT*FROM orders_dimen;

/*
3. Write a query to get the Order ID, Order date from table orders_dimen where 
‘Order Priority’ is high.
*/

SELECT 
	Order_ID,
    Order_Date,
    Order_Priority
FROM
	Orders_dimen
WHERE
	Order_Priority = 'HIGH';


/*
table-3
	market_fact: Details of every order item sold
    I use DATA TYPE For Decimal values Float You will also use Double
*/    
create table market_fact(
Ord_id char(25) not null,
Prod_id varchar(225) not null,
Ship_id varchar(225) not null,
Cust_id char(25) not null,
Sales int not null,
Discount float not null,
Order_Quantity int not null,
Profit float not null,
Shipping_Cost float not null,
Product_Base_Margin float not null
);

/*
4. Find the total and the average sales (display total_sales and avg_sales) 
*/

SELECT
	sum(sales) as TotalSale,
    avg(Sales) as AvgSale
FROM
	market_fact;



SELECT*FROM superstordb.market_fact;

/*
5. Write a query to get the maximum and minimum sales from maket_fact table.
*/

SELECT
	min(sales) as MinSale,
    max(Sales) as MaxSale
FROM
	market_fact;

-- SELECT*FROM market_fact
-- where sales = 2;

select*from superstordb.cust_dimen;

/*
6. Display the number of customers in each region in decreasing order of 
no_of_customers. The result should contain columns Region, no_of_customers.
*/

SELECT 
    region, 
    COUNT(*) AS CustomerNumber
FROM
    cust_dimen
GROUP BY region
ORDER BY CustomerNumber desc;

/*
7. Find the region having maximum customers (display the region name and 
max(no_of_customers)
*/
-- I have 2 way to do this Quation
 
-- I-Way 
SELECT 
    region, 
    COUNT(*) AS CustomerNumber
FROM
    cust_dimen
GROUP BY region
ORDER BY CustomerNumber desc limit 1;

-- II -Way

 SELECT 
    region, 
    COUNT(*) AS CustomerNumber
FROM
    cust_dimen
GROUP BY region
HAVING 
    CustomerNumber >= ALL (SELECT 
							COUNT(*) AS CustomerNumber
						  FROM
							cust_dimen
						  GROUP BY region );
                          
                          
select*from superstordb.market_fact;
/*
Table_4
	orders_dimen: Details of every order placed
*/

CREATE TABLE Prod_dimen(
	Product_Category varchar(225),
	Product_Sub_Category varchar(225),
	Prod_id char(25)
    );

SELECT*FROM Prod_dimen;
SELECT*FROM Cust_dimen;
SELECT*FROM market_fact;

/*
8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ 
and the number of tables purchased (display the customer name, no_of_tables 
purchased)
*/

select 
	c.Customer_name,
    region,
	count(m.Prod_id) Number_Of_Table_Purchase
    
from 
	cust_dimen c join
	market_fact m
	on m.Cust_id = c.Cust_id 
    join prod_dimen p 
	on p.Prod_id = m.Prod_id 
where c.Region = 'ATLANTIC' and p.Product_Sub_Category = 'TABlES'
group by c.Customer_name
order by Number_Of_Table_Purchase desc;

/*
9. Find all the customers from Ontario province who own Small Business. (display 
the customer name, no of small business owners)
*/


select 
	Customer_Name,
    count(*) as 'Small_Business_Owner' 
from 
	cust_dimen 
where 
	Customer_Segment = 'SMALL BUSINESS' and Province = 'ONTARIO'
group by Customer_Name;

/*
10. Find the number and id of products sold in decreasing order of products sold 
(display product id, no_of_products sold)
*/
select*from product_dime;
select 
	Prod_id,
    count(*) as 'no_of_products_sold' 
from 
	market_fact 
group by Prod_id 
order by count('no_of_products_sold') desc;

select 
	Prod_id,
    count(prod_id) as 'no_of_products_sold' 
from 
	market_fact 
group by Prod_id 
order by no_of_products_sold desc;
/*
11. Display product Id and product sub category whose produt category belongs to 
Furniture and Technlogy. The result should contain columns product id, product 
sub category
*/ 

select 
	Prod_id,
    Product_Sub_Category,
    Product_Category
from 
	prod_dimen
where Product_Category='FURNITURE' or Product_Category='TECHNOLOGY';

/*
12. Display the product categories in descending order of profits (display the product 
category wise profits i.e. product_category, profits)?
*/


select 
	Product_Category,
    Profit 
from 
	market_fact s,
    prod_dimen p
where 
	s.Prod_id = p.Prod_id
group by Product_Category order by Profit desc;

/*
13. Display the product category, product sub-category and the profit within each 
subcategory in three columns.
*/

select 
	Product_Category,
    Product_Sub_Category,
    Profit 
from 
	market_fact s,
    prod_dimen p
where 
	s.Prod_id = p.Prod_id;

/*
14. Display the order date, order quantity and the sales for the order.
*/

select 
	Order_Date,
    Order_Quantity,
    Sales 
from 
	market_fact s, 
    orders_dimen c
where 
	s.Ord_id = c.Ord_id;
 
 /*
Q15 Display the names of the customers whose name contains the 
 i) Second letter as ‘R’
 ii) Fourth letter as ‘D’   

*/

select 
	Customer_Name 
from 
	cust_dimen 
where 
	Customer_Name like '_R%' and Customer_Name like '___D%';

/*
Q16 Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000.
*/

select 	
	c.Cust_id,
    s.Sales,
    c.Customer_Name,
    c.Region 
from 
	market_fact s,
    cust_dimen c
where 
	s.Cust_id = c.Cust_id and Sales between 1000 and 5000;
    
/*    
Q17 Write a SQL query to find the 3rd highest sales
*/

select sales from market_fact
order by sales desc;

select 
	min(Sales) as '3rd_highest_sales'
FROM (  
		select 
			Sales 
		from 
			market_fact 
		order by Sales desc limit 2
) as a;
 
/* 
Q18 Where is the least profitable product subcategory shipped the most
 */
select 
	Region,
    count(Ship_id) as no_of_shipment,
    sum(Profit) as profit_in_each_region 
from 
	cust_dimen c,
    market_fact s,
    prod_dimen p
where c.Cust_id = s.Cust_id and s.Prod_id = p.Prod_id
group by Region
order by profit_in_each_region asc;
