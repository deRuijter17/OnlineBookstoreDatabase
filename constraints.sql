USE OnlineBookstore;

ALTER TABLE City
    ADD CONSTRAINT FK_City_Country FOREIGN KEY (Country) REFERENCES Country (Country_Id);

ALTER TABLE User
    ADD CONSTRAINT FK_User_City FOREIGN KEY (City) REFERENCES City (Pincode);

ALTER TABLE Book
    ADD CONSTRAINT FK_Book_Language FOREIGN KEY (Language) REFERENCES Language (Language_Id),
    ADD CONSTRAINT FK_Book_Author FOREIGN KEY (Author_Id) REFERENCES Author (Author_Id);

ALTER TABLE Cart
    ADD CONSTRAINT FK_Cart_User FOREIGN KEY (User_Id) REFERENCES User (User_Id);

ALTER TABLE Orders
    ADD CONSTRAINT FK_Orders_Cart FOREIGN KEY (Cart_Id) REFERENCES Cart (Cart_Id),
    ADD CONSTRAINT FK_Orders_Customer FOREIGN KEY (Customer_Id) REFERENCES User (User_Id);

ALTER TABLE Payment
    ADD CONSTRAINT FK_Payment_Customer FOREIGN KEY (Customer_Id) REFERENCES User (User_Id),
    ADD CONSTRAINT FK_Payment_Order FOREIGN KEY (Order_Id) REFERENCES Orders (Order_Id);

ALTER TABLE Review
    ADD CONSTRAINT FK_Review_Customer FOREIGN KEY (Customer_Id) REFERENCES User (User_Id),
    ADD CONSTRAINT FK_Review_Book FOREIGN KEY (Book_Id) REFERENCES Book (Book_Id);

ALTER TABLE Wishlist
    ADD CONSTRAINT FK_Wishlist_Cart FOREIGN KEY (Cart_Id) REFERENCES Cart (Cart_Id),
    ADD CONSTRAINT FK_Wishlist_Book FOREIGN KEY (Book_Id) REFERENCES Book (Book_Id)