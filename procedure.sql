-- insert orders mới -> tạo một payment tương ứng

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS insert_order_and_payment(
    IN p_cartID INT,
    IN p_customerId INT,
    IN p_order_date DATE,
    IN p_Dest_Address VARCHAR(255),
    IN p_Status ENUM ('Pending', 'Shipped', 'Delivered', 'Cancelled'),
    IN p_Payment_Method ENUM ('Credit Card', 'Debit Card', 'Net Banking', 'UPI', 'Cash on Delivery')
)
BEGIN
    DECLARE last_order_id INT;
    -- Insert vào bảng orders
    INSERT INTO orders (Cart_Id, Customer_Id, Order_Date, Dest_Address, Status, Payment)
    VALUES (p_cartID, p_customerId, p_order_date, p_Dest_Address, p_Status, 0);
    -- Lấy Order_Id vừa được tạo
    SET last_order_id = LAST_INSERT_ID();
    -- Insert vào bảng payment
    INSERT INTO payment (Customer_Id, Order_Id, Status, Payment_Method)
    VALUES (p_customerId, last_order_id, 'Pending', p_Payment_Method);
END $$

DELIMITER ;


-- Hiển thị thông tin sách bằng ID
CREATE PROCEDURE getBookById(IN p_Id INT)
BEGIN
    SELECT * FROM book WHERE Book_Id = p_Id;
END;

-- Hiển thị các bài review của user bằng User_Id
CREATE PROCEDURE getReviewsByUserId(IN p_userId INT)
BEGIN
    SELECT u.User_Id, CONCAT(u.First_Name, ' ', u.Last_Name) AS Full_Name, b.Book_Id, b.Title, r.Review
    FROM user u JOIN review r ON u.User_Id = r.Customer_Id
    JOIN Book b ON r.Book_Id = b.Book_Id WHERE u.User_Id = p_userId;
END;

-- Hiển thị số tiền mua sách của user bằng User_Id
CREATE PROCEDURE getTotalPriceByUserId(
    IN p_userId INT,
    OUT p_totalPrice FLOAT
)
BEGIN
    SELECT
        IFNULL(SUM(Total_Price), 0)
    INTO p_totalPrice
    FROM
        cart
    GROUP BY User_Id
    HAVING User_Id = p_userId;
END;

-- Hiển thị những khách hàng chưa nhận được hàng
CREATE PROCEDURE displayCustomerNotReceived()
BEGIN
    SELECT u.User_Id, CONCAT(u.First_Name, ' ', u.Last_Name) AS Customer_Name, o.Dest_Address, o.Status AS Status FROM user u
    JOIN cart c on u.User_Id = c.User_Id
    JOIN orders o on o.Customer_Id = c.User_Id
    WHERE NOT o.Status = 'Shipped';
END;

-- Hiển thị số sách được bán ra của mỗi tác giả
CREATE PROCEDURE displaySellBooksOfAuthors()
BEGIN
    SELECT 
        a.Author_Id, 
        a.Name, 
        IFNULL(
            (SELECT SUM(w.Number_Of_Books) 
             FROM book b 
             JOIN Wishlist w ON b.Book_Id = w.Book_Id 
             WHERE b.Author_Id = a.Author_Id), 
            0
        ) AS Total_Books_Sell_For_Each_Author 
    FROM 
        Author a;
END;



