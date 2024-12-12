# giảm stock của sách khi đặt hàng
DROP TRIGGER IF EXISTS tr_update_stock_after_order;
CREATE TRIGGER tr_update_stock_after_order
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    UPDATE Book
    SET Stock = Stock - NEW.Quantity
    WHERE Book_Id = (
        SELECT c.Book_Id FROM orders
        JOIN onlinebookstore.cart c on orders.Cart_Id = c.Id
        WHERE NEW.Cart_Id = c.Id
    );
END;

#tăng stock khi đơn hàng bị cancel
DROP TRIGGER IF EXISTS tr_update_stock_after_cancel_order;

CREATE TRIGGER tr_update_stock_after_cancel_order
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
  IF NEW.Status = 'Cancelled' THEN
    UPDATE Book
    SET Stock = Stock + NEW.Quantity
    WHERE Book_Id = (
      SELECT c.Book_Id
      FROM Orders o
      JOIN onlinebookstore.cart c ON o.Cart_Id = c.Id
      WHERE o.Cart_Id = NEW.Cart_Id
    );
  END IF;
END;
