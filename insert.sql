INSERT INTO Country (Country_Id, Name) VALUES
(1, 'United States'),
(2, 'United Kingdom'),
(3, 'France'),
(4, 'Germany'),
(5, 'China');

INSERT INTO City (Pincode, Name, Country) VALUES
(1, 'New York', 1),
(2, 'London', 2),
(3, 'Paris', 3),
(4, 'Berlin', 4),
(5, 'Shanghai', 5);

INSERT INTO User (User_Id, First_Name, Last_Name, Email, Password, DOB, Address_Line1, City, Phone_Number, Role) VALUES
(1, 'Alice', 'Smith', 'alicesmith01@gmail.com', 'Alice@123', '1990-01-01', '123 Elm St', 1, '1234567890', 'Customer'),
(2, 'Bob', 'Johnson', 'bobjohnson22@gmail.com', 'Bob@456!', '1985-02-15', '456 Oak St', 2, '9876543211', 'Customer'),
(3, 'Charlie', 'Brown', 'charliebrown36@gmail.com', 'Charlie#789$', '1975-03-30', '789 Pine St', 3, '1928374652', 'Customer'),
(4, 'Daisy', 'Miller', 'daisymiller49@gmail.com', 'Daisy@321!', '2000-05-20', '654 Maple St', 4, '5647382913', 'Customer'),
(5, 'Eve', 'Davis', 'evedavis58@gmail.com', 'Eve#654$', '1995-07-15', '321 Cedar St', 1, '8273649584', 'Customer'),
(6, 'Fan', 'Xiaoping', 'fxy1506@gmail.com', 'Fxy#jqkA', '2005-06-15', '17 Kuomintang St', 5, '8271239584', 'Customer');

INSERT INTO Language (Language_Id, Name) VALUES
(1, 'English'),
(2, 'Spanish'),
(3, 'French'),
(4, 'German'),
(5, 'Chinese');

INSERT INTO Author (Author_Id, Name, Description, Photo, DOB) VALUES
(1, 'J.K. Rowling', 'Author of Harry Potter series', 'photo1.jpg', '1965-07-31'),
(2, 'Gabriel García Márquez', 'Author of Cien años de soledad and Love in the Time of Cholera', 'photo2.jpg', '1927-03-06'),
(3, 'George Orwell', 'Author of dystopian novels', 'photo3.jpg', '1903-06-25'),
(4, 'Jane Austen', 'Author of Pride and Prejudice', 'photo4.jpg', '1775-12-16'),
(5, 'Victor Hugo', 'Author of Les Misérables', 'photo5.jpg', '1802-02-26'),
(6, 'Johann Wolfgang von Goethe', 'Author of Faust and pioneer of German literature', 'photo6.jpg', '1749-08-28'),
(7, 'Cao Xueqin', 'Author of Dream of the Red Chamber', 'photo7.jpg', '1715-01-01');

INSERT INTO Book (Book_Id, Title, Language, Publication_Date, Author_Id, Price, Edition, Stock, Status, Genre) VALUES
(1, 'Harry Potter and the Philosopher''s Stone', 1, '1997-06-26', 1, 29.99, 1, 100, TRUE, 'Fiction'),
(2, 'Harry Potter and the Chamber of Secrets', 1, '1998-07-02', 1, 31.99, 1, 90, TRUE, 'Fiction'),
(3, 'Cien anos de soledad', 2, '1967-06-05', 2, 25.99, 1, 60, TRUE, 'Non-Fiction'),
(4, 'Love in the Time of Cholera', 1, '1985-03-06', 2, 28.99, 1, 55, TRUE, 'Science'),
(5, '1984', 1, '1949-06-08', 3, 20.99, 1, 70, TRUE, 'Non-Fiction'),
(6, 'Animal Farm', 1, '1945-08-17', 3, 15.99, 1, 85, TRUE, 'Other'),
(7, 'Pride and Prejudice', 1, '1813-01-28', 4, 18.99, 1, 100, TRUE, 'Science'),
(8, 'Les Misérables', 3, '1862-04-03', 5, 25.99, 1, 50, TRUE, 'Non-Fiction'),
(9, 'Faust', 4, '1808-01-01', 6, 30.00, 1, 20, TRUE, 'Biography'),
(10, 'Dream of the Red Chamber', 5, '1791-01-01', 7, 35.99, 1, 40, TRUE, 'Biography');

INSERT INTO Review (Review_Id, Customer_Id, Book_Id, Review, Date) VALUES
(1, 1, 1, 'Great book! A magical journey that introduces readers to the enchanting world of Hogwarts.', '2024-12-05'),
(2, 1, 5, 'A chilling look into a dystopian world, must read for 1984 fans.', '2024-12-07'),
(3, 3, 6, 'A powerful political allegory that critiques the corruption of power through a group of farm animals.', '2024-12-15'),
(4, 3, 7, 'A timeless romance with witty dialogue and sharp social commentary, highly recommended it!', '2024-12-18'),
(5, 5, 9, 'A deeply philosophical work that delves into human desires, morality, and the quest for meaning.', '2024-12-19');

INSERT INTO Cart (Cart_Id, User_Id, Total_Books, Total_Price, Discount) VALUES
(1, 4, 1, 25.99, 0.00),
(2, 2, 3, 77.97, 5.00),
(3, 1, 3, 71.97, 2.00),
(4, 5, 1, 30.00, 0.00),
(5, 6, 3, 107.97, 3.00),
(6, 3, 3, 53.97, 1.00);

INSERT INTO Wishlist (Cart_Id, Book_Id, Number_Of_Books) VALUES
(1, 8, 1),
(2, 3, 3),
(3, 1, 1),
(3, 5, 2),
(4, 9, 1),
(5, 10,3),
(6, 6, 1),
(6, 7, 2);

INSERT INTO Orders (Order_Id, Cart_Id, Customer_Id, Order_Date, Dest_Address, Status, Payment) VALUES
(1, 1, 1, '2024-11-25', '123 Elm St, New York', 'Shipped', TRUE),
(2, 2, 1, '2024-11-28', '123 Elm St, New York', 'Shipped', TRUE),
(3, 3, 2, '2024-12-03', '456 Oak St, London', 'Pending', FALSE),
(4, 4, 3, '2024-12-07', '789 Pine St, Paris', 'Shipped', TRUE),
(5, 5, 3, '2024-12-11', '789 Pine St, Paris', 'Shipped', TRUE),
(6, 6, 4, '2024-12-12', '654 Maple St, Berlin', 'Delivered', TRUE),
(7, 7, 5, '2024-12-13', '321 Cedar St, New York', 'Shipped', TRUE),
(8, 8, 6, '2024-12-15', '17 Kuomintang St, Shanghai', 'Delivered', TRUE);

INSERT INTO Payment (Payment_Id, Customer_Id, Order_Id, Status, Payment_Method) VALUES
(1, 1, 1, 'Success', 'Credit Card'),
(2, 1, 2, 'Success', 'Debit Card'),
(3, 2, 3, 'Pending', 'Cash on Delivery'),
(4, 3, 4, 'Success', 'Credit Card'),
(5, 3, 5, 'Success', 'Debit Card'),
(6, 4, 6, 'Success', 'Net Banking'),
(7, 5, 7, 'Success', 'Cash on Delivery'),
(8, 6, 8, 'Success', 'Credit Card');
