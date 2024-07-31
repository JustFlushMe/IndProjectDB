-- Клиент - Договор
SELECT cu_id, cu_type, cu_name, cu_PSRN, cu_mail, cu_phone, cu_dateOfReg, agr_id, agr_status, agr_localnumb, agr_dateS, agr_dateE, agr_sum FROM Customers INNER JOIN Agreements ON Customers.cu_id = Agreements.agr_customer;

-- Кол-во клиентов привлечено за сегодня
SELECT COUNT(cu_id) FROM Customers WHERE cu_dateOfReg = (SELECT CAST(CURRENT_TIMESTAMP AS Date));

-- Процент отмен от определенного клиента
SELECT (COUNT(cu_id) * 100) / (SELECT COUNT(cu_id) FROM Customers) FROM Customers WHERE cu_id < 10;



-- Триггер: после добавления отмены - статус отмены присваивается нужному договору
CREATE TRIGGER Cancels_sync
ON Cancels
AFTER INSERT
AS
BEGIN
	UPDATE Agreements SET agr_status = 'Canceled' WHERE agr_id IN (SELECT can_agr FROM Cancels WHERE can_id = (SELECT MAX(can_id) FROM Cancels));
END



-- VIEWS
CREATE VIEW Show_Agreements AS SELECT * FROM Agreements;
CREATE VIEW Show_Routes AS SELECT * FROM Routes;
CREATE VIEW Show_Cancels AS SELECT * FROM Cancels;
