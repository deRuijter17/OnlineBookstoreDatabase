# giảm stock của sách khi đặt hàng
DROP TRIGGER IF EXISTS tr_update_stock_after_order;
CREATE TRIGGER tr_update_stock_after_order
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    DECLARE new_stock INT;
  -- Calculate new stock level
    SET new_stock = (SELECT Stock FROM Book WHERE Book_Id = (
        SELECT c.Book_Id
        FROM Orders o
        JOIN onlinebookstore.cart c ON o.Cart_Id = c.Id
        WHERE o.Cart_Id = NEW.Cart_Id
    )) - NEW.Quantity;
  -- Check for negative stock and throw error if applicable
    IF new_stock < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for order. Please reduce quantity.';
    END IF;
    IF NEW.Quantity < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order quantity must be greater than 0';
    END IF;
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
