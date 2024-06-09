/* (Database Fundamentals, Assignment Part D, Spring  2023 */
/* First author's name: Thanh Quan Nguyen (Student ID:14189450)*/
/* First author's email: ThanhQuan.Nguyen-1@student.uts.edu.au*/
/* Second author's name: Khanh Toan Nguyen (Student ID: 24885608)*/
/* Second author's email:Khanh.T.Nguyen@student.uts.edu.au*/
/* Third author's name: David Nguyen (Student ID:14384630)*/
/* Third author's email:David.Nguyen-11@student.uts.edu.au*/
/* script name: Food_Database.SQL */
/* purpose:     Builds PostgreSQL tables for food database of Marley Spoon */
/* date:        22 October 2023 */
/* The URL for the website related to this database is https://marleyspoon.com.au/select-plan?kw=marley%20spoon&cpn=669164124&cq_src=google_ads&cq_cmp=669164124&cq_con=33385787466&cq_term=marley%20spoon&cq_med=&cq_plac=&cq_net=g&cq_pos=&cq_plt=gp&&CLID=goog&GKEY=marley&v=AUMSSEAGOOGBR215MMSQ32023&gclid=CjwKCAjwloynBhBbEiwAGY25dEozsYuD_0jOxwO6Ju8vP6R2mWDRaGADSZkLZE3cWPR2xbJTrX234RoCu4cQAvD_BwE&gclsrc=aw.ds*/

--=================================================================================================
-- Drop the tables below
DROP TABLE IF EXISTS Customer_T;
DROP TABLE IF EXISTS Orders_T;
DROP TABLE IF EXISTS Food_T;
DROP TABLE IF EXISTS SubscriptionPlan_T;
-- Create Food_T table

CREATE TABLE Customer_T (
  Customer_ID      NUMERIC(4)     NOT NULL,
  email_address    VARCHAR(255)   NOT NULL,
  first_name       VARCHAR(50),
  last_name        VARCHAR(50),
  phone_number     VARCHAR(20),
  password         VARCHAR(255),
  CONSTRAINT Customer_PK PRIMARY KEY (Customer_ID),
  CONSTRAINT Email_Unique UNIQUE (email_address)
);

-- Create Orders_T table
CREATE TABLE Orders_T (
  Order_ID         NUMERIC(4)     NOT NULL,
  Customer_ID      NUMERIC(4)     NOT NULL,
  FirstOrderDate   DATE,
  Vegetarian       VARCHAR(1) CHECK (Vegetarian IN ('Y', 'N')),
  PackagePosition  VARCHAR(255),
  Slot             VARCHAR(20),
  DeliverStatus    VARCHAR(20),
  OrderNote        TEXT,
  CONSTRAINT Orders_PK PRIMARY KEY (Order_ID, Customer_ID),
  CONSTRAINT Orders_Customer_FK FOREIGN KEY (Customer_ID) REFERENCES Customer_T(Customer_ID)
);

-- Create Food_T table
CREATE TABLE Food_T (
  Food_ID          NUMERIC(4)     NOT NULL,
  FoodName         VARCHAR(255),
  FoodDesc        VARCHAR(255),
  FoodNote         TEXT,
  Quantity         INT,
  CONSTRAINT Food_PK PRIMARY KEY (Food_ID)
);
-- Create SubscriptionPlan_T table
CREATE TABLE SubscriptionPlan_T (
  Customer_ID          NUMERIC(4)     NOT NULL,
  Order_ID             NUMERIC(4)     NOT NULL,
  Food_ID              NUMERIC(4)     NOT NULL,
  NumberOfPeople       NUMERIC(4),
  NumberOfDaysWeeks    VARCHAR(50),
  Price                DECIMAL(10, 2),
  CONSTRAINT SubscriptionPlan_PK PRIMARY KEY (Customer_ID, Order_ID, Food_ID),
  CONSTRAINT SubscriptionPlan_Food_FK1 FOREIGN KEY (Food_ID) REFERENCES Food_T(Food_ID),
  CONSTRAINT SubscriptionPlan_Food_FK2 FOREIGN KEY (Customer_ID, Order_ID) REFERENCES Orders_T(Customer_ID, Order_ID)
);
-- 1. INSER INTO Customer_T
INSERT INTO Customer_T (customer_id, email_address, first_name, last_name, phone_number, password) 
VALUES (101, 'abcdxyz@gmail.com', 'Adam', 'John', '012345678', 'abcdxyz'),
       (102, 'johndoe@gmail.com', 'John', 'Doe', '987654321', 'johndoe'),
       (103, 'marysmith@gmail.com', 'Mary', 'Smith', '555555555', 'marysmith'),
       (104, 'janejones@gmail.com', 'Jane', 'Jones', '123456789', 'janejones'),
       (105, 'robertbrown@gmail.com', 'Robert', 'Brown', '999888777', 'robertbrown');

-- 2. INSERT INTO Orders_T
INSERT INTO Orders_T (Order_ID, Customer_ID, FirstOrderDate, Vegetarian, PackagePosition, Slot, DeliverStatus, OrderNote)
VALUES (1, 101, '2023-10-16', 'Y', 'Front', 'Lunch', 'Delivered', 'No allergies, extra sauce'),
       (2, 102, '2023-10-16', 'N', 'Back', 'Dinner', 'In Progress', 'Gluten-free, no onions'),
       (3, 103, '2023-10-16', 'Y', 'Front', 'Breakfast', 'Pending', 'No nuts, extra cheese'),
       (4, 104, '2023-10-16', 'N', 'Back', 'Lunch', 'Canceled', 'Spicy, extra rice'),
       (5, 105, '2023-10-16', 'N', 'Front', 'Dinner', 'Delivered', 'No dietary restrictions, extra salad');

--3. INSERT INTO Food_T
INSERT INTO Food_T(Food_ID, FoodName, FoodDesc, FoodNote, Quantity)
VALUES (1, 'Spaghetti', 'Delicious pasta with tomato sauce', 'No allergies', 2),
       (2, 'Chicken Curry', 'Spicy curry with chicken and rice', 'Extra spicy, no onions', 1),
       (3, 'Caesar Salad', 'Fresh salad with Caesar dressing', 'Extra croutons, no nuts', 3),
       (4, 'Pizza Margherita', 'Classic Margherita pizza', 'No dietary restrictions', 1),
       (5, 'Sushi Combo', 'Assorted sushi rolls and sashimi', 'No allergies, extra wasabi', 2);

--4. INSERT INTO SubscriptionPlan_T 
INSERT INTO SubscriptionPlan_T(Customer_ID, Order_ID, Food_ID, NumberOfPeople, NumberOfDaysWeeks, Price)
VALUES (101, 1, 1, 2, '3 days a week', 150.00),
       (102, 2, 3, 1, '5 days a week', 250.00),
       (103, 3, 2, 4, '2 days a week', 180.00),
       (104, 4, 3, 4, '3 days a week', 190.00),
       (105, 5, 5, 3, '4 days a week', 210.00);

--=================================================================================================
-- Create and insert into the tables below


--=================================================================================================
-- Select * from TableName Statements
-- Note: Please write the “select * from TableName” statements in one line.

-- 2.b.1: Question: 
-- 2.b.1: SELECT statement: 
select * from Customer_T;

-- 2.b.2: Question: 
-- 2.b.2: SELECT statement:
select * from Orders_T;

-- 2.b.3: Question: 
-- 2.b.3: SELECT statement:
select * from Food_T;

-- 2.b.4: Question:
-- 2.b.4: SELECT Statement:
select * from SubscriptionPlan_T;

--=================================================================================================
-- 3.a: Question: 
-- 3.a: SELECT statement uinsg Group by:
Select Food_ID, Count(Food_ID) from SubscriptionPlan_T
Group by Food_ID
Order by Food_ID ASC;
-- 3.b: Question: 
-- 3.b: SELECT statement uisng Inner Join:
Select * from Customer_T C
inner join Orders_T O on C.Customer_ID = O.Customer_ID
where last_name ='John';
-- 3.c: Question: 
-- 3.c: SELECT statement using Sub Query:
Select C.Customer_ID, first_name, last_name, 
(Select Max(Price) from SubscriptionPlan_T) from Customer_T C
inner join SubscriptionPlan_T S on C.Customer_ID = S.Customer_ID
where Price >= all(select Price from SubscriptionPlan_T);







