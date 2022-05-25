-- qs2: 
SELECT 
    *
FROM
    testing_system_assignment.department;

-- qs3:
SELECT 
    departmentid
FROM
    testing_system_assignment.department
WHERE
    DepartmentName LIKE '%Sale%';
 
-- qs4:
SELECT 
    *
FROM
    testing_system_assignment.account
WHERE
    LENGTH(fullname) = (SELECT 
            MAX(LENGTH(fullname))
        FROM
            testing_system_assignment.account); 

-- qs6:
SELECT 
    *
FROM
    testing_system_assignment.group_table
WHERE
    CreateDate < '2019-12-20';

-- qs8:
SELECT 
    *
FROM
    testing_system_assignment.exam
WHERE
    Duaration > '60'
        AND CreateDate > '2019-12-20';

-- qs9:
SELECT 
    *
FROM
    testing_system_assignment.group_table
WHERE
    CreateDate < CURDATE()
ORDER BY CreateDate DESC
LIMIT 5; 

-- qs10: 
SELECT 
    COUNT(*)
FROM
    testing_system_assignment.account
WHERE
    DepartmentID = 2;

-- qs11: 
SELECT 
    *
FROM
    testing_system_assignment.account
WHERE
    FullName LIKE 'D%'
        AND FullName LIKE '%a';

-- qs12;
DELETE FROM testing_system_assignment.exam 
WHERE
    CreateDate = '2019-12-20';

-- qs13:
DELETE FROM testing_system_assignment.question 
WHERE
    Content LIKE 'What%';

-- qs14:
UPDATE testing_system_assignment.account 
SET 
    FullName = 'Nguyen Ba Loc',
    email = 'loc.nguyenba@vti.com'
WHERE
    AccountId = 5;

-- qs15:
UPDATE testing_system_assignment.group_account 
SET 
    GroupId = 4
WHERE
    AccountID = 5;