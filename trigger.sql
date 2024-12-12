# giảm stock của sách khi đặt hàng
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

    CLOSE cur;
END$$
DELIMITER ;


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

    -- Mở CURSOR
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
    -- Đóng CURSOR
    CLOSE cur;
  END IF;
END$$
DELIMITER ;


