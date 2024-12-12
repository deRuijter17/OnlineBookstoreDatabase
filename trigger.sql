-- giảm stock của sách khi đặt hàng
DROP TRIGGER IF EXISTS tr_update_stock_after_order;
DELIMITER $$
CREATE TRIGGER tr_update_stock_after_order
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    DECLARE book_id_tmp INT;
    DECLARE book_quantity INT;
    DECLARE new_stock INT;

    -- Lặp qua từng sách trong Cart (thông qua Wishlist) để cập nhật tồn kho
    DECLARE done INT DEFAULT 0; -- để dừng vòng lặp nếu done = 1
    DECLARE cur CURSOR FOR
        SELECT w.Book_Id, w.Number_of_books
        FROM Wishlist w
        WHERE w.Cart_Id = NEW.Cart_Id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1; -- nếu đã hết cur sẽ chuyển done thành 1
    IF (NEW.Status != 'Cancelled') THEN
        OPEN cur;

        read_loop: LOOP
            FETCH cur INTO book_id_tmp, book_quantity;
            IF done THEN
                LEAVE read_loop;
            END IF;

            -- Lấy số lượng tồn kho hiện tại
            SELECT Stock INTO new_stock FROM Book WHERE Book_Id = book_id_tmp;

            -- Kiểm tra tồn kho có đủ không
            IF new_stock < book_quantity THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for order. Please reduce quantity.';
            END IF;

            -- Cập nhật tồn kho
            UPDATE Book
            SET Stock = Stock - book_quantity
            WHERE Book_Id = book_id_tmp;
        END LOOP;
    END IF;
    CLOSE cur;
END$$
DELIMITER ;

-- thuc hiện việc tăng stock lên khi order bị cancel
DROP TRIGGER IF EXISTS tr_update_stock_after_cancel_order;
DELIMITER $$
CREATE TRIGGER tr_update_stock_after_cancel_order
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    DECLARE book_id_tmp INT;
    DECLARE book_quantity INT;
    DECLARE done INT DEFAULT 0;
    -- CURSOR để duyệt qua tất cả sách trong Wishlist thuộc giỏ hàng
    DECLARE cur CURSOR FOR
    SELECT w.Book_Id, w.Number_of_books
    FROM Wishlist w
    WHERE w.Cart_Id = NEW.Cart_Id;
    -- Xử lý khi CURSOR không có dữ liệu
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  -- Chỉ thực thi khi trạng thái đơn hàng được cập nhật thành 'Cancelled'
  IF (NEW.Status = 'Cancelled') AND (OLD.Status != 'Cancelled') THEN
    OPEN cur;
    -- Duyệt qua từng bản ghi trong CURSOR
    read_loop: LOOP
      FETCH cur INTO book_id_tmp, book_quantity;
      IF done THEN
        LEAVE read_loop;
      END IF;
      -- Cập nhật tồn kho: tăng số lượng sách bị hủy
      UPDATE Book
      SET Stock = Stock + book_quantity
      WHERE Book_Id = book_id_tmp;
    END LOOP;
    CLOSE cur;
  END IF;
END$$
DELIMITER ;


-- cập nhật total_book và total_price trong cart khi thêm hoặc sửa wishlist

DROP TRIGGER IF EXISTS tr_update_cart_on_wishlist_insert;
DELIMITER $$
CREATE TRIGGER tr_update_cart_on_wishlist_insert
AFTER INSERT ON Wishlist
FOR EACH ROW
BEGIN
    DECLARE total_books INT DEFAULT 0;
    DECLARE total_price FLOAT DEFAULT 0.0;

    -- Tính tổng số lượng sách (Total_Books) trong giỏ hàng (Cart)
    SELECT SUM(w.Number_of_books)
    INTO total_books
    FROM Wishlist w
    WHERE w.Cart_Id = NEW.Cart_Id;

    -- Tính tổng giá trị sách (Total_Price) trong giỏ hàng (Cart)
    SELECT SUM(w.Number_of_books * b.Price)
    INTO total_price
    FROM Wishlist w
    JOIN Book b ON w.Book_Id = b.Book_Id
    WHERE w.Cart_Id = NEW.Cart_Id;

    -- Cập nhật Total_Books và Total_Price vào bảng Cart
    UPDATE Cart
    SET Total_Books = total_books,
        Total_Price = total_price
    WHERE Cart_Id = NEW.Cart_Id;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS tr_update_cart_on_wishlist_update;
DELIMITER $$
CREATE TRIGGER tr_update_cart_on_wishlist_update
AFTER UPDATE ON Wishlist
FOR EACH ROW
BEGIN
    DECLARE total_books INT DEFAULT 0;
    DECLARE total_price FLOAT DEFAULT 0.0;

    -- Tính tổng số lượng sách (Total_Books) trong giỏ hàng (Cart)
    SELECT SUM(w.Number_of_books)
    INTO total_books
    FROM Wishlist w
    WHERE w.Cart_Id = NEW.Cart_Id;

    -- Tính tổng giá trị sách (Total_Price) trong giỏ hàng (Cart)
    SELECT SUM(w.Number_of_books * b.Price)
    INTO total_price
    FROM Wishlist w
    JOIN Book b ON w.Book_Id = b.Book_Id
    WHERE w.Cart_Id = NEW.Cart_Id;

    -- Cập nhật Total_Books và Total_Price vào bảng Cart
    UPDATE Cart
    SET Total_Books = total_books,
        Total_Price = total_price
    WHERE Cart_Id = NEW.Cart_Id;
END$$
DELIMITER ;
