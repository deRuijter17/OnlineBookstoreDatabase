# Query using inner join.
# tổng số lượng sách trong giỏ của khách hàng
SELECT User_Id, First_Name, Last_Name , sum(Total_Books) as total_books FROM cart
INNER JOIN user on cart.User_Id = user.Id
where Role = 'Customer'
GROUP BY User_Id;

#Query using outer join.
# danh sách ngôn ngữ và book tương ứng

SELECT book.Title AS book_title, language.Name AS Language
FROM book
LEFT JOIN language ON book.Language = language.Id
UNION
SELECT book.Title AS book_title, language.Name AS Language
FROM book
RIGHT JOIN language ON book.Language = language.Id;

# Using subquery in where.
# Tìm những sách được đặt trong các đơn hàng có trạng thái là Shipped
SELECT Title
FROM book as b
WHERE b.Book_Id IN (
    SELECT Book_Id
    FROM Orders
    WHERE Status = 'Shipped'
);
#Tìm sách có giá lớn hơn giá trung bình của tất cả các sách
SELECT Title, Price
FROM Book
WHERE Price > (SELECT AVG(Price) FROM Book);


#Tìm người dùng có đánh giá sách theo ID
DELIMITER $$
CREATE PROCEDURE GetUsersByBookReview(IN bookId INT)
BEGIN
    SELECT
        First_Name,
        Last_Name,
        (SELECT Review
         FROM Review
         WHERE Customer_Id = User.Id AND Book_Id = bookId) AS Review
    FROM User
    WHERE Id IN (
        SELECT Customer_Id
        FROM Review
        WHERE Book_Id = bookId
);
END $$
DELIMITER ;

CALL GetUsersByBookReview(1);

-- 7d. Using subquery in from
-- Mỗi một quyển sách có bao nhiêu lượt review
SELECT b.*, (SELECT COUNT(r.Review_Id) FROM review r WHERE r.Book_Id = b.Book_Id) AS Total_Review FROM book b;
-- Mỗi User đã mua bao nhiêu quyển sách?
SELECT u.User_Id, u.First_Name AS NAME,
(SELECT SUM(c.Total_Books) FROM cart c WHERE c.User_Id = u.User_Id) AS Total_Books_Buy FROM user u;
-- 7e. Query using group by and aggregate functions.
-- Mỗi một tác giả đã viết ra bao nhiêu quyển sách?
SELECT a.Author_Id, a.Name, COUNT(b.Book_Id) AS Total_Books FROM author a JOIN book b ON a.Author_Id = b.Author_Id GROUP BY a.Author_Id;
-- Mỗi một user đã review bao nhiêu bài
SELECT u.User_Id, u.Last_Name AS Name, COUNT(r.Review_Id) AS Total_Reviews FROM user u JOIN review r ON u.User_Id = r.Customer_Id GROUP BY u.User_Id;







