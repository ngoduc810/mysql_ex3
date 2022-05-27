drop view if exists ex1;
CREATE VIEW ex1 AS
    SELECT 
        *
    FROM
        account
    WHERE
        DepartmentID = SOME (SELECT 
                department.DepartmentID
            FROM
                department
            WHERE
                DepartmentName LIKE '%Dev%');
SELECT 
    *
FROM
    ex1;
-- qs2:
drop view if exists ex2;
CREATE VIEW ex2 AS
    SELECT 
        *
    FROM
        account
    WHERE
        AccountID = (SELECT 
                group_account.AccountID
            FROM
                group_account
            GROUP BY group_account.AccountID
            ORDER BY COUNT(group_account.AccountID) DESC
            LIMIT 1);
SELECT 
    *
FROM
    ex2;
-- qs3:
drop view if exists ex3;
CREATE VIEW ex3 AS
    SELECT 
        *
    FROM
        question
    WHERE
        LENGTH(question.content) > 11;
select * from ex3;
DELETE FROM question 
WHERE
    LENGTH(question.content) > 11; 
SELECT 
    *
FROM
    ex3;
-- qs4:
drop view if exists ex4;
CREATE VIEW ex4 AS
    SELECT 
    D.*, COUNT(A.DepartmentID)
FROM
    testing_system_assignment.account AS A
        JOIN
    testing_system_assignment.department AS D ON A.DepartmentID = D.DepartmentID
GROUP BY A.DepartmentID
having count(A.DepartmentID) = (SELECT 
       count(A.DepartmentID)
    FROM
        testing_system_assignment.department AS D
            JOIN
        testing_system_assignment.account AS A ON D.DepartmentID = A.DepartmentID
    GROUP BY A.DepartmentID
    ORDER BY COUNT(A.DepartmentID) DESC
    LIMIT 1);
SELECT 
    *
FROM
    ex4;
-- qs5:
drop view ex5;
CREATE VIEW ex5 AS
    SELECT 
        A.*
    FROM
        testing_system_assignment.account AS A
            JOIN
        testing_system_assignment.question AS Q ON A.AccountID = Q.CretorID
    WHERE
        A.FullName LIKE '%winny%';
SELECT 
    *
FROM
    ex5;