USE OnlineBookstore;

ALTER TABLE City
    ADD FOREIGN KEY (Country) REFERENCES Country (Id);

ALTER TABLE User
    ADD FOREIGN KEY (City) REFERENCES City (Pincode);

ALTER TABLE Book
    ADD FOREIGN KEY (Language) REFERENCES Language (Id),
    ADD FOREIGN KEY (Author_Id) REFERENCES Author (Author_Id);

ALTER TABLE Cart
    ADD FOREIGN KEY (User_Id) REFERENCES User (Id),
    ADD FOREIGN KEY (Book_Id) REFERENCES Book (Book_Id);

ALTER TABLE Orders
    ADD FOREIGN KEY (Cart_Id) REFERENCES Cart (Id),
    ADD FOREIGN KEY (Customer_Id) REFERENCES User (Id);

ALTER TABLE Payment
    ADD FOREIGN KEY (Customer_Id) REFERENCES User (Id),
    ADD FOREIGN KEY (Order_Id) REFERENCES Orders (Id);