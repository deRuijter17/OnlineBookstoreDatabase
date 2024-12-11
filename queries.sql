# Query using inner join.
# tổng số lượng sách trong giỏ của khách hàng
SELECT User_Id, First_Name, Last_Name , sum(Total_Books) as total_books FROM cart
INNER JOIN user on cart.User_Id = user.Id
where Role = 'Customer'
GROUP BY User_Id;

#Query using outer join.
# danh sách sách hàng mua sách và sách không được mua



