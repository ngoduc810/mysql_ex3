-- qs2: 
select * from testing_system_assignment.department;

-- qs3:
select departmentid from testing_system_assignment.department where DepartmentName like '%Sale%';
 
-- qs4:
select * from testing_system_assignment.account where length(fullname) = (select max(length(fullname)) from testing_system_assignment.account); 

-- qs6:
select * from testing_system_assignment.group_table where CreateDate < '2019-12-20';

-- qs8:
select * from testing_system_assignment.exam where Duaration > '60' and CreateDate > '2019-12-20';

-- qs9:
select * from testing_system_assignment.group_table order by CreateDate desc limit 5; 

-- qs10: 
select count(*) from testing_system_assignment.account where DepartmentID = 2;

-- qs11: 
select * from testing_system_assignment.account where FullName like 'D%' and FullName like '%a';

-- qs12;
delete from testing_system_assignment.exam where CreateDate = '2019-12-20';

-- qs13:
delete from testing_system_assignment.question where Content like 'What%';

-- qs14:
update testing_system_assignment.account set FullName = 'Nguyen Ba Loc', email = 'loc.nguyenba@vti.com' where AccountId = 5;

-- qs15:
update testing_system_assignment.group_account set GroupId = 4 where AccountID = 5;