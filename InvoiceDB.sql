-- Assignment2-DDL.sql
-- script to create Inventory database, create TABLEs
-- Stanley Yoo, Sifat Jamaly, Nathan Fan
-- CST 8215-301

drop table if exists Payment_T;
drop table if exists Invoice_Product_T;
drop table if exists Product_T;
DROP TABLE IF EXISTS Invoice_T;
drop table if exists Shipper_T;
drop table if exists Customer_T;
DROP TABLE IF EXISTS Employee_T;
drop table if exists Branch_T;

CREATE TABLE Branch_T (
Branch_ID CHAR(3),
Branch_Phone varchar(15) not null,
Branch_Fax varchar (15) not null,
Branch_Address VARCHAR(20) NOT NULL,
Branch_City VARCHAR(15) NOT NULL,
Branch_Prov CHAR(2),
Branch_PostCode CHAR(6) NOT NULL,
CONSTRAINT PK_Branch PRIMARY KEY( Branch_ID )
);

CREATE TABLE Employee_T (
Emp_ID CHAR(4),
Emp_Branch CHAR (3) not null,
Emp_Fname VARCHAR(30) not NULL,
Emp_Lname VARCHAR(30) NOT NULL,
Emp_Email VARCHAR(20) NOT NULL,
Emp_Phone VARCHAR(15) NOT NULL,
Emp_Title VARCHAR(15),
CONSTRAINT PK_Employee PRIMARY KEY( Emp_Id ),
CONSTRAINT FK_Branch_ID FOREIGN KEY ( Emp_Branch ) REFERENCES Branch_T( Branch_ID )
);

CREATE TABLE Customer_T (
Cust_ID CHAR(5),
Cust_Fname VARCHAR(30) not null,
Cust_Lname VARCHAR(30) NOT NULL,
Cust_Company varchar (30),
Cust_Phone VARCHAR(15) NOT NULL,
Cust_Address VARCHAR(20) NOT NULL,
Cust_City VARCHAR(15) NOT NULL,
Cust_Prov CHAR(2),
Cust_PostCode CHAR(6) NOT NULL,
Cust_Salesperson_ID char(4),
CONSTRAINT PK_Customer PRIMARY KEY( Cust_Id ),
constraint FK_Cust_Salesperson foreign key( Cust_Salesperson_ID ) references Employee_T( Emp_ID )
);

create table Shipper_T (
Ship_ID char(5),
Ship_Company_Name varchar(30) not null,
Ship_Phone varchar(15) not null,
constraint PK_Shipper primary key( Ship_ID )
);

create table Invoice_T (
Inv_ID char(5),
Inv_Ship_To char (5) not null,
Inv_Order_Date date,
Inv_Description varchar(60),
Inv_Shipper_ID char(5) not null,
Inv_Delivery_Date date,
constraint PK_Invoice primary key( Inv_ID ),
constraint FK_Inv_Shipper foreign key( Inv_Shipper_ID ) references Shipper_T( Ship_ID ),
constraint FK_Inv_Receiver foreign key( Inv_Ship_To ) references Customer_T( Cust_ID )
);

CREATE TABLE Product_T (
Prod_ID CHAR(5),
Prod_Description VARCHAR(60) NOT NULL,
Prod_Price DECIMAL (5,2) NOT NULL,
Prod_Discount decimal (5,2),
Prod_QOH int not null,
CONSTRAINT PK_Product PRIMARY KEY( Prod_ID )
);

create table Invoice_Product_T (
Inv_ID char(5),
Prod_ID char(5),
Line_Unit integer not null,
Line_Price decimal(5,2) not null,
constraint PK_Invoice_Product primary key( Inv_ID, Prod_ID ),
constraint FK_Invoice_ID foreign key( Inv_ID ) references Invoice_T( Inv_ID ),
constraint FK_Product_ID foreign key( Prod_ID ) references Product_T( Prod_ID )
);

CREATE TABLE Payment_T (
Pay_ID CHAR(5),
Pay_Invoice_ID char(5) not null,
Pay_Paid_By CHar(5) not null,
Pay_Amount decimal(5,2) not null,
Pay_Due_Date date,
Pay_CC_Number char(16) not null,
Pay_CC_Expire_Date date not null,
Pay_CC_CVV char(3) not null,
constraint PK_Payment primary key( Pay_ID ),
constraint FK_Payment_Invoice foreign key( Pay_Invoice_ID ) references Invoice_T( Inv_ID ),
constraint FK_Payment_Payer foreign KEY( Pay_Paid_By ) references Customer_T( Cust_ID )
);

--eof: Inventory-DDL.sql
