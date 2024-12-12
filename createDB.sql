CREATE DATABASE IF NOT EXISTS OnlineBookstore;
USE OnlineBookstore;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Language;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS Wishlist;

CREATE TABLE IF NOT EXISTS Country
(
    Country_Id   INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS City
(
    Pincode INT PRIMARY KEY AUTO_INCREMENT,
    Name    VARCHAR(255) NOT NULL,
    Country INT
);

CREATE TABLE IF NOT EXISTS User
(
    User_Id            INT PRIMARY KEY AUTO_INCREMENT,
    First_Name    VARCHAR(255)               NOT NULL,
    Last_Name     VARCHAR(255),
    Email         VARCHAR(255) UNIQUE        NOT NULL,
    Password      VARCHAR(255)               NOT NULL,
    DOB           DATE,
    Address_Line1 VARCHAR(255),
    Address_Line2 VARCHAR(255),
    City          INT,
    Phone_Number  VARCHAR(15) UNIQUE         NOT NULL,
    Role          ENUM ('Admin', 'Customer') NOT NULL
);

CREATE TABLE IF NOT EXISTS Language
(
    Language_Id   INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Book
(
    Book_Id          INT PRIMARY KEY AUTO_INCREMENT,
    Title            VARCHAR(255)                                                     NOT NULL,
    Language         INT,
    Publication_Date DATE,
    Author_Id        INT,
    Price            FLOAT                                                            NOT NULL CHECK ( Price >= 0 ),
    Image            BLOB,
    Edition          INT,
    Status           BOOLEAN                                                          NOT NULL,
    Stock            INT                                                              NOT NULL CHECK ( Stock >= 0 ),
    Genre            ENUM ('Fiction', 'Non-Fiction', 'Science', 'Biography', 'Other') NOT NULL
);

CREATE TABLE IF NOT EXISTS Author
(
    Author_Id   INT PRIMARY KEY AUTO_INCREMENT,
    Name        VARCHAR(255) NOT NULL,
    Description VARCHAR(500),
    Photo       BLOB,
    DOB         DATE
);

CREATE TABLE IF NOT EXISTS Review
(
    Review_Id          INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Id INT NOT NULL,
    Book_Id     INT NOT NULL,
    Review      VARCHAR(1000),
    Date        DATE
);

CREATE TABLE IF NOT EXISTS Cart
(
    Cart_Id          INT PRIMARY KEY AUTO_INCREMENT,
    User_Id     INT   NOT NULL,
    Total_Books INT CHECK ( Total_Books >=0 ),
    Total_Price FLOAT NOT NULL CHECK ( Total_Price >=0 ),
    Discount    FLOAT
);

CREATE TABLE IF NOT EXISTS Orders
(
    Order_Id           INT PRIMARY KEY AUTO_INCREMENT,
    Cart_Id      INT,
    Customer_Id  INT,
    Order_Date   DATE                                                  NOT NULL,
    Dest_Address VARCHAR(255)                                          NOT NULL,
    Status       ENUM ('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL,
    Payment      BOOLEAN                                               NOT NULL
);

CREATE TABLE IF NOT EXISTS Payment
(
    Payment_Id             INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Id    INT,
    Order_Id       INT,
    Status         ENUM ('Success', 'Pending', 'Failed')                                        NOT NULL,
    Payment_Method ENUM ('Credit Card', 'Debit Card', 'Net Banking', 'UPI', 'Cash on Delivery') NOT NULL
);

CREATE TABLE IF NOT EXISTS Wishlist
(
    Cart_Id     INT   NOT NULL,
    Book_Id     INT   NOT NULL,
    Number_of_Books INT CHECK ( Number_of_Books >=1 )
);

