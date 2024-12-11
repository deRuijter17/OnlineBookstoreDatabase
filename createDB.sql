CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;

CREATE TABLE Country
(
    Id   INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE City
(
    Pincode INT PRIMARY KEY AUTO_INCREMENT,
    Name    VARCHAR(255) NOT NULL,
    Country INT
);

CREATE TABLE User
(
    Id            INT PRIMARY KEY AUTO_INCREMENT,
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

CREATE TABLE Language
(
    Id   INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Book
(
    Book_Id          INT PRIMARY KEY AUTO_INCREMENT,
    Title            VARCHAR(255)                                                     NOT NULL,
    Language         INT,
    Publication_Date DATE,
    Author_Id        INT,
    Price            FLOAT                                                            NOT NULL,
    Image            BLOB,
    Edition          INT,
    Status           BOOLEAN                                                          NOT NULL,
    Stock            INT                                                              NOT NULL,
    Genre            ENUM ('Fiction', 'Non-Fiction', 'Science', 'Biography', 'Other') NOT NULL
);

CREATE TABLE Author
(
    Author_Id   INT PRIMARY KEY AUTO_INCREMENT,
    Name        VARCHAR(255) NOT NULL,
    Description VARCHAR(500),
    Photo       BLOB,
    DOB         DATE
);

CREATE TABLE Review
(
    Id          INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Id INT NOT NULL,
    Book_Id     INT NOT NULL,
    Review      VARCHAR(1000),
    Date        DATE,
    FOREIGN KEY (Customer_Id) REFERENCES User (Id),
    FOREIGN KEY (Book_Id) REFERENCES Book (Book_Id)
);

CREATE TABLE Cart
(
    Id          INT PRIMARY KEY AUTO_INCREMENT,
    User_Id     INT   NOT NULL,
    Book_Id     INT   NOT NULL,
    Total_Books INT,
    Total_Price FLOAT NOT NULL,
    Discount    FLOAT
);

CREATE TABLE Orders
(
    Id           INT PRIMARY KEY AUTO_INCREMENT,
    Cart_Id      INT,
    Quantity     INT                                                   NOT NULL,
    Customer_Id  INT,
    Order_Date   DATE                                                  NOT NULL,
    Dest_Address VARCHAR(255)                                          NOT NULL,
    Status       ENUM ('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL,
    Payment      BOOLEAN                                               NOT NULL
);

CREATE TABLE Payment
(
    Id             INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Id    INT,
    Order_Id       INT,
    Status         ENUM ('Success', 'Pending', 'Failed')                                        NOT NULL,
    Payment_Method ENUM ('Credit Card', 'Debit Card', 'Net Banking', 'UPI', 'Cash on Delivery') NOT NULL
);
