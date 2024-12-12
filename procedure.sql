-- Hiển thị thông tin sách bằng ID
CREATE PROCEDURE getBookById(IN p_Id INT)
BEGIN
    SELECT * FROM book WHERE Book_Id = p_Id;
END;
-- Hiển thị các bài review của user bằng User_Id
CREATE PROCEDURE getReviewsByUserId(IN p_userId INT)
BEGIN
    SELECT u.Id, CONCAT(u.First_Name, " ", u.Last_Name) AS Full_Name, b.Book_Id, b.Title, r.Review
    FROM user u JOIN review r ON u.Id = r.Customer_Id
    JOIN Book b ON r.Book_Id = b.Book_Id WHERE u.Id = p_userId;
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
    SELECT u.Id, CONCAT(u.First_Name, " ", u.Last_Name) AS Customer_Name, o.Dest_Address, o.Status AS Status FROM user u 
    JOIN cart c on u.Id = c.User_Id
    JOIN orders o on o.Customer_Id = c.User_Id
    WHERE NOT o.Status = "Shipped";
END;

-- Hiển thị số sách được bán ra của mỗi tác giả
CREATE PROCEDURE displaySellBooksOfAuthors()
BEGIN
    SELECT a.Author_Id, a.Name,
	IFNULL((SELECT SUM(res.Total_Books) FROM 
    (SELECT b.Book_Id, b.Title, c.Total_Books FROM book b JOIN cart c ON b.Book_Id = c.Book_Id) res
    WHERE a.Author_Id = res.Book_Id), 0) AS Total_Books_Sell
    FROM author a;
END;


