-- qs1:
INSERT INTO group_table (GroupName, 				CreatorID, 	CreateDate) 
VALUES 				('abcabc', 	12, 		'2019-10-11');
-- Trigger
DROP TRIGGER IF EXISTS Insert_CreateDate_into_Group;
	Delimiter //
CREATE TRIGGER 		Insert_CreateDate_into_Group
BEFORE INSERT ON 	group_table
FOR EACH ROW
BEGIN

IF 
	NEW.CreateDate < (curdate() - interval 1 year) THEN
	SIGNAL SQLSTATE 	'12345'
	SET MESSAGE_TEXT = 	'Can not insert to creatdate into group';
END IF;


END //
Delimiter ;

-- 	Question 2: 
INSERT INTO account (	Email, Username, FullName, DepartmentID, PositionID, CreateDate) 
VALUES 	(	'abcabc.com', 'abcdez', 	'HIHIHI', 	62, 			78, 		'2019-01-19');

-- Trigger
DROP TRIGGER IF EXISTS Str_Insert_username_departmentSale_into_Group;
	Delimiter //
CREATE TRIGGER 		Str_Insert_username_departmentSale_into_Group
BEFORE INSERT ON 	account
FOR EACH ROW
BEGIN
	DECLARE	v_id_of_departmentSale INT;
    
    SELECT	DepartmentID INTO v_id_of_departmentSale
    FROM	Department 
    WHERE 	DepartmentName = 'Sales';
    
IF 
	NEW.departmentID = v_id_of_departmentSale	THEN
	SIGNAL SQLSTATE 	'12345'
	SET MESSAGE_TEXT = 	'Department "Sale" cannot add more user';
END IF;
END //
Delimiter ;

-- Question 3:

DROP TRIGGER IF EXISTS Insert_max_5user;
	Delimiter //
CREATE TRIGGER 		Insert_max_5user
BEFORE INSERT ON 	groupaccount
FOR EACH ROW
BEGIN

DECLARE	v_Count_user INT;
SELECT	COUNT(1) INTO	v_Count_user
FROM	groupaccount AS GA
WHERE	NEW.GroupID = GA.GroupID;


IF 
	v_Count_user >	5 THEN
	SIGNAL SQLSTATE '12345'
	SET MESSAGE_TEXT = 'Can not creat more user';
END IF;


END //
Delimiter ;


-- 	Question 5:



-- Use
DELETE FROM `account` WHERE Email = 'admin@gmail.com';

-- Trigger
DROP TRIGGER IF EXISTS Cannot_delete_email_Admin;
	Delimiter //
CREATE TRIGGER 		Cannot_delete_email_Admin
BEFORE DELETE ON 	`account`
FOR EACH ROW
BEGIN

IF 
	OLD.Email = 'admin@gmail.com' THEN
	SIGNAL SQLSTATE '12345'
	SET MESSAGE_TEXT = 'Cannot delete email-admin';
END IF;


END //
Delimiter ;


-- 	Question 6: 
INSERT INTO `Account` (Email, 	Username, FullName, PositionID, CreateDate) 
VALUES 				('aaaaaaa@gmail.com', 	'aaaaaaa', 	'bbbb aaaaa', 	78, 			'2019-01-19');

-- Trigger
DROP TRIGGER IF EXISTS New_Account_departmentID_null;
	Delimiter //
CREATE TRIGGER 		New_Account_departmentID_null
BEFORE INSERT ON 	`account`
FOR EACH ROW
BEGIN

DECLARE v_DepartmentID_of_waitingDepartment INT;
SELECT	DepartmentID INTO v_DepartmentID_of_waitingDepartment
FROM 	department
WHERE 	DepartmentName = "waiting Department";

IF 
	NEW.DepartmentID is NULL THEN
	SET NEW.DepartmentID = v_DepartmentID_of_waitingDepartment;
END IF;


END //
	Delimiter ;

-- Question 7:

DROP TRIGGER IF EXISTS Question_7;
	Delimiter //
CREATE TRIGGER 		Question_7
BEFORE INSERT ON 	answer
FOR EACH ROW
BEGIN

DECLARE Count_answer INT;
DECLARE Count_isCorrect INT;

SELECT 		COUNT(A.QuestionID) INTO Count_answer
FROM		answer AS A
WHERE		A.QuestionID = NEW.QuestionID;


SELECT 		COUNT(A.isCorrect) INTO Count_isCorrect
FROM		answer AS A
WHERE		A.QuestionID = NEW.QuestionID AND A.isCorrect = NEW.isCorrect;

IF (Count_answer > 4) OR (Count_isCorrect > 2) THEN	
SIGNAL SQLSTATE 	'12345'
SET MESSAGE_TEXT = 	'Can not insert more data';
END IF;


END //
Delimiter ;

-- Question 8:

DROP TRIGGER IF EXISTS Question_8;
	Delimiter //
CREATE TRIGGER 		Question_8
BEFORE INSERT ON 	`account`
FOR EACH ROW
BEGIN

IF 		
		NEW.Gender = 'Nam' 				THEN SET NEW.Gender = 'M';
ELSEIF 	NEW.Gender = 'Nữ' 				THEN SET NEW.Gender = 'F';
ELSEIF 	NEW.Gender = 'Chưa xác định' 	THEN SET NEW.Gender = 'U';
END IF;

END //
	Delimiter ;

-- Question 9:

DROP TRIGGER IF EXISTS Question_9;
	Delimiter //
CREATE TRIGGER 		Question_9
BEFORE DELETE ON 	exam
FOR EACH ROW
BEGIN

IF	
	OLD.CreateDate > (CURRENT_DATE() - INTERVAL 2 DAY) THEN
	SIGNAL SQLSTATE '12345'
	SET MESSAGE_TEXT = ' Cannot delete Exam created since 2d';
END IF;

END //
	Delimiter ;

-- Question 12: 

SELECT	*,
	CASE
		WHEN Duration <= 30 THEN 'Shoet time'
        WHEN Duration <= 60 THEN 'Medium time'
        ELSE 'Long time'
        END as Sap_xep
FROM	exam;

-- 	Question 13: 

SELECT	GroupID, COUNT(Accountid), 
	CASE
		WHEN COUNT(Accountid) <= 5 THEN 'few'
        WHEN COUNT(Accountid) <= 20 THEN 'normal'
        ELSE 'higher'
	END as the_number_user_amount
FROM	groupaccount
GROUP BY	GroupID;
-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
SELECT 		D.*, COUNT(A.AccountID), 
	CASE
		WHEN	COUNT(A.AccountID) = 0 THEN "Không có User"
        ELSE	COUNT(A.AccountID)
	END as Statistic_user_eachDepartment
FROM		department as D
LEFT JOIN	`account` as A USING(DepartmentID)
GROUP BY	A.DepartmentID;