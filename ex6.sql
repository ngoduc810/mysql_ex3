-- qs1:
DELIMITER $$ 
create procedure get_account_name (in in_dept_name varchar(250))
	begin
        select A.*, D.DepartmentName from account as A join department as D on A.DepartmentID = D.DepartmentID
        where D.DepartmentName = in_dept_name;
        end$$
DELIMITER ;

CALL get_account_name('training');

-- qs2:
DELIMITER $$ 
create procedure get_account_in_group (in in_dept_name int, out total_account int)
	begin
        select count(*) into total_account
        from account as A join group_account as G on A.AccountID = G.AccountID group by (G.AccountID)  
        having (G.AccountID) = in_dept_name;
        end$$
DELIMITER ;
-- qs6:
DELIMITER $$ 
create procedure get_group_or_account_in_input (in input_name varchar(250))
	begin
        select A.UserName,G.AccountID, GA.GroupName
        from account as A join group_account as G on A.AccountID = G.AccountID join group_table as GA on G.GroupID = GA.GroupID 
        where A.UserName like concat('%',input_name,'%')
        or GA.GroupName like concat('%', input_name,'%')
        ;
        end$$
DELIMITER ;

-- qs7:
DELIMITER $$
create procedure pro_create_account (in full_name varchar(250), 
										in email varchar(250))
		begin
			declare FullName varchar(250) default full_name;
			declare user_name varchar(250) default substring_index(email,'@',1);
			declare department varchar(50) default 'developer';
            declare position_id tinyint default 1;
            select FullName, user_name, department, position_id;
        end$$
DELIMITER ;
call testing_system_assignment.pro_create_account('Ngo Van Duc', 'ngoduc810@gail,.com');

-- qs8:
DELIMITER $$
create procedure pro_get_max_content (in type_name enum('essay','Multiple-Choice'))
		begin
			select Q.*, TQ.TypeName from question as Q join typequestion as TQ on Q.CategoryID = TQ.TypeID where TQ.TypeName = type_name 
            and length(Q.Content) = (select max(length(content)) from question);
        end$$
DELIMITER ;
-- qs11:
DELIMITER $$
create procedure del_dept_by_name (in dept_name varchar(200))
		begin
			declare dept_id tinyint;
			select D.DepartmentID into dept_id from department as D where D.DepartmentName = dept_name;
            update account as A set A.DepartmentID = '0' where A.DepartmentID = dept_id;
            delete from department as D where  D.DepartmentName = dept_name;
        end$$
DELIMITER ;

-- qs12:
DELIMITER $$
create procedure count_qs_in_month ()
		begin
			with cte_12_month as (
            select 1 as month
            union select 2 as month	
			union select 3 as month
            union select 4 as month
            union select 5 as month
            union select 6 as month
            union select 7 as month
            union select 8 as month
            union select 9 as month
            union select 10 as month
            union select 11 as month
            union select 12 as month
            )
		select M.month, count(month(Qs.CreateDate)) from cte_12_month as M left join (select * from question as Q where year(Q.CreateDate) = year(now() - interval 1 year)) as Qs
			on M.month = month(Qs.CreateDate)
            group by M.month;
        end$$
DELIMITER ;

