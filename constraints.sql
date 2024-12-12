USE OnlineBookstore;

ALTER TABLE City
    ADD FOREIGN KEY (Country) REFERENCES Country (Country_Id);

ALTER TABLE User
    ADD FOREIGN KEY (City) REFERENCES City (Pincode);

ALTER TABLE Book
    ADD FOREIGN KEY (Language) REFERENCES Language (Language_Id),
    ADD FOREIGN KEY (Author_Id) REFERENCES Author (Author_Id);

ALTER TABLE Cart
    ADD FOREIGN KEY (User_Id) REFERENCES User (User_Id);

ALTER TABLE Orders
    ADD FOREIGN KEY (Cart_Id) REFERENCES Cart (Cart_Id),
    ADD FOREIGN KEY (Customer_Id) REFERENCES Cart (Cart_Id);

ALTER TABLE Payment
    ADD FOREIGN KEY (Customer_Id) REFERENCES User (User_Id),
    ADD FOREIGN KEY (Order_Id) REFERENCES Orders (Order_Id);

ALTER TABLE Review
    ADD FOREIGN KEY (Customer_Id) REFERENCES User (User_Id),
    ADD FOREIGN KEY (Book_Id) REFERENCES Book (Book_Id);

ALTER TABLE Wishlist
    ADD FOREIGN KEY (Cart_Id) REFERENCES Cart (Cart_Id),
    ADD FOREIGN KEY (Book_Id) REFERENCES Book (Book_Id);