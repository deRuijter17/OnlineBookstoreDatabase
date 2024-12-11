-- Thêm 1 khách hàng mới vào bảng, sau đó quay lại trước khi thêm
select * from user;
START TRANSACTION;
INSERT INTO User (Id, First_Name, Last_Name, Email, Password, DOB, Address_Line1, City, Phone_Number, Role)
VALUES (7, 'Ivan', 'Brown', 'ivan.brown@example.com', 'Ivan123!', '1985-12-25', '456 Brown St', 1, '1112223333', 'Customer');
ROLLBACK;

-- Cập nhật trạng thái của 1 đơn hàng, sau đó quay lại trước khi thêm
START TRANSACTION;
UPDATE Orders
SET Status = 'Delivered', Payment = TRUE
WHERE Id = 3;
ROLLBACK;

-- Xoá sách và review về sách, sau đó quay lại trước khi thêm
DELETE FROM Review
WHERE Book_Id = 6;
DELETE FROM Book
WHERE Book_Id = 6;
ROLLBACK;

-- Thêm người dùng, thêm sản phẩm của người đó vào giỏ hàng, cập nhật số lượng sách, sau đó quay lại ban đầu
START TRANSACTION;
-- 1. Thêm người dùng mới vào bảng User
INSERT INTO User (Id, First_Name, Last_Name, Email, Password, DOB, Address_Line1, City, Phone_Number, Role)
VALUES (10, 'John', 'Doe', 'johndoe@example.com', 'JohnDoe123!', '1988-06-15', '789 Maple St', 1, '5551234567', 'Customer');
-- 2. Thêm sản phẩm vào giỏ hàng của người dùng
INSERT INTO Cart (Id, User_Id, Book_Id, Total_Books, Total_Price, Discount)
VALUES (20, 10, 2, 3, 77.97, 5);
-- 3. Cập nhật số lượng sách trong bảng Book (Giảm số lượng sách tồn kho)
UPDATE Book
SET Stock = Stock - 3
WHERE Book_Id = 2;
ROLLBACK;