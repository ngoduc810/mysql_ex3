-- qs1:
SELECT 
    A.*, D.DepartmentName
FROM
    testing_system_assignment.account AS A
        JOIN
    testing_system_assignment.department AS D ON A.DepartmentID = D.DepartmentID;
-- qs2:
SELECT 
    A.*, G.JoinDate
FROM
    testing_system_assignment.account AS A
        JOIN
    testing_system_assignment.group_account AS G ON A.AccountID = G.AccountID
WHERE
    G.JoinDate > '2020-12-20';
-- qs3: 
SELECT 
    A.*, D.DepartmentName
FROM
    testing_system_assignment.account AS A
        JOIN
    testing_system_assignment.department AS D ON A.DepartmentID = D.DepartmentID
WHERE
    D.DepartmentName LIKE '%Dev%';
-- qs4:
SELECT 
    COUNT(A.DepartmentID), D.*
FROM
    testing_system_assignment.account AS A
        JOIN
    testing_system_assignment.department AS D ON A.DepartmentID = D.DepartmentID
GROUP BY A.DepartmentID
HAVING COUNT(A.DepartmentID) > 2;
-- qs5:
SELECT 
        Q.*, COUNT(CQ.CategoryID)
    FROM
        testing_system_assignment.question AS Q
            JOIN
        testing_system_assignment.exam AS CQ ON Q.CategoryID = CQ.CategoryID
    GROUP BY CQ.CategoryID
    ORDER BY COUNT(CQ.CategoryID) DESC
    LIMIT 1;
-- qs6:
SELECT 
    CQ.*, count(CQ.CategoryID)
FROM
    testing_system_assignment.question AS Q
        JOIN
    testing_system_assignment.categoryquestion AS CQ ON Q.CategoryID = CQ.CategoryID
    group by CQ.CategoryID;
-- qs7: 
SELECT 
    Q.*, count(E.CategoryID)
FROM
    testing_system_assignment.question AS Q
        JOIN
    testing_system_assignment.exam AS E ON Q.CategoryID = E.CategoryID
GROUP BY E.CategoryID;
-- qs8:
SELECT 
    Q.*, COUNT(A.QuestionID)
FROM
    testing_system_assignment.question AS Q
        JOIN
    testing_system_assignment.answer AS A ON Q.QuestionID = A.QuestionID
GROUP BY Q.QuestionID
ORDER BY COUNT(A.QuestionID) DESC
LIMIT 1;
-- qs9:
SELECT 
    G.*, COUNT(G.AccountID)
FROM
    testing_system_assignment.account AS A
        JOIN
    testing_system_assignment.group_account AS G ON A.AccountID = G.AccountID
GROUP BY G.AccountID;
-- qs10:
SELECT 
    P.*, COUNT(A.PositionID)
FROM
    testing_system_assignment.account AS A
        JOIN
    testing_system_assignment.position AS P ON A.PositionID = P.PositionID
GROUP BY A.PositionID
ORDER BY COUNT(A.PositionID) ASC
LIMIT 1;
-- qs11:
SELECT 
    D.*, count(A.DepartmentID)
FROM
    testing_system_assignment.account AS A
        JOIN
    testing_system_assignment.department AS D ON A.DepartmentID = D.DepartmentID
group by A.DepartmentID having D.DepartmentName like '%Dev%';
-- qs12:
SELECT 
    Q.*, TQ.TypeName, A.Content AS Answer
FROM
    testing_system_assignment.question AS Q
        JOIN
    testing_system_assignment.typequestion AS TQ ON Q.QuestionID = TQ.TypeID
        JOIN
    testing_system_assignment.answer AS A ON Q.QuestionID = A.QuestionID;
-- qs13:
SELECT 
    T.TypeName, count(T.TypeName)
FROM
    testing_system_assignment.question AS Q
        JOIN
    testing_system_assignment.typequestion AS T ON Q.QuestionID = T.TypeID
GROUP BY T.TypeName;
-- qs14:
SELECT 
    *
FROM
    testing_system_assignment.account AS A
        LEFT JOIN
    testing_system_assignment.group_account AS G ON A.AccountID = G.AccountID
WHERE
    G.AccountID IS NULL;
-- qs16:
