-- Thêm 1 khách hàng mới vào bảng, sau đó quay lại trước khi thêm
START TRANSACTION;
INSERT INTO User (User_Id, First_Name, Last_Name, Email, Password, DOB, Address_Line1, City, Phone_Number, Role)
VALUES (7, 'Ivan', 'Brown', 'ivan.brown@example.com', 'Ivan123!', '1985-12-25', '456 Brown St', 1, '1112223333', 'Customer');
ROLLBACK;

-- Cập nhật trạng thái của 1 đơn hàng, sau đó quay lại trước khi thêm
START TRANSACTION;
UPDATE Orders
SET Status = 'Delivered', Payment = TRUE
WHERE Order_Id = 3;
ROLLBACK;

-- Xoá sách và review về sách, sau đó quay lại trước khi thêm
DELETE FROM Review
WHERE Book_Id = 6;
DELETE FROM Book
WHERE Book_Id = 6;
ROLLBACK;

-- Thêm sản phẩm cho 1 người dùng vào giỏ hàng, cập nhật số lượng sách, sau đó quay lại ban đầu
START TRANSACTION;
-- 1. Thêm sản phẩm vào wishlist của người dùng
INSERT INTO Wishlist (Cart_Id, Book_Id, Number_Of_Books)
VALUES (10, 2, 3);
-- 2. Cập nhật giỏ hàng
UPDATE Cart
SET cart.Total_Books = cart.Total_Books + (SELECT Number_of_Books FROM Wishlist WHERE Book_Id = 2),
    cart.Total_Price = cart.Total_Price + ((SELECT Number_of_Books FROM Wishlist WHERE Book_Id = 2) * (SELECT Price FROM Book WHERE Book_Id = 2))
WHERE Cart_Id = 10;
-- 3. Cập nhật số lượng sách trong bảng Book (Giảm số lượng sách tồn kho)
UPDATE Book
SET Stock = Stock - (SELECT Number_of_Books FROM Wishlist WHERE Book_Id = 2)
WHERE Book_Id = 2;
ROLLBACK;