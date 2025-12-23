-- 2
begin tran
insert liczby2 values ( 1 )

-- 4 
update liczby1 set liczba=10

-- tutaj robi sie zakleszczenie - mamy 0 rows affected

select * from liczby1 -- nic nie pokaze
select * from liczby2 -- pokaze ok

-- 5
commit