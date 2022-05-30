with infor_account as 
(select A.*, count(G.AccountID) as total from testing_system_assignment.account as A 
join testing_system_assignment.group_account as G 
on A.AccountID = G.AccountID 
group by G.AccountID),
account_group as (
select total from infor_account order by total desc limit 1),
infor_account_max as ( select * from infor_account where total = (select total from account_group))
select * from infor_account_max where total = (select total from account_group);

-- qs3: 
with answer_content as 
(select Q.*, length(A.Content) as length_content from question as Q join answer as A 
on Q.QuestionID = A.QuestionID group by length_content)
select * from answer_content where length_content > 18;
-- qs4:
with account_department as 
(select D.*, count(A.DepartmentID) as account_in_department from account as A join department as D
on A.DepartmentID = D.DepartmentID 
group by A.DepartmentID),
department_max as 
(select account_in_department from account_department order by account_in_department desc limit 1)
select * from account_department where account_in_department in (select * from department_max);

-- qs5:
with account_question as 
(select Q.*, A.FullName from account as A join question as Q on A.AccountID = Q.CretorID)
select * from account_question where FullName like '%Primo';