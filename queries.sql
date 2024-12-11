-- 7d. Using subquery in from
-- Mỗi một quyển sách có bao nhiêu lượt review
SELECT b.*, (SELECT COUNT(r.Id) FROM review r WHERE r.Book_Id = b.Book_Id) AS Total_Review FROM book b;
-- Mỗi User đã mua bao nhiêu quyển sách?
SELECT u.Id, u.First_Name AS NAME, 
(SELECT SUM(c.Total_Books) FROM cart c WHERE c.User_Id = u.Id) FROM user u;
-- 7e. Query using group by and aggregate functions.
-- Mỗi một tác giả đã viết ra bao nhiêu quyển sách?
SELECT a.Author_Id, a.Name, COUNT(b.Book_Id) AS Total_Books FROM author a JOIN book b ON a.Book_Id = b.Book_Id GROUP BY a.Author_Id;
-- Mỗi một user đã review bao nhiêu bài
SELECT u.Id, u.Last_Name AS Name, COUNT(r.Id) FROM user u JOIN review r ON u.Id = r.Customer_Id GROUP BY u.Id;