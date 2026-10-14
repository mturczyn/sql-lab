--set transaction isolation level repeatable read

begin tran

update TestEntities set name = name
where id = '1AA61D6E-5D31-40E7-851B-011DEB513F23'

waitfor delay '00:00:10'

-- update acquires exclusive locks (X)
--update TestEntities set name = name
--where id = '6827FCC2-C38D-4EC7-89C3-053B34F5F48D'

-- select acquires shared locks (S), so won't cause
-- dead lock in this scenario, unless query hint
-- "with (XLOCK)" is used
select * from TestEntities
with (XLOCK)
where id = '6827FCC2-C38D-4EC7-89C3-053B34F5F48D'

commit tran

