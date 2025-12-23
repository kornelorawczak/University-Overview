-- 0
drop table if exists liczby1;
drop table if exists liczby2;
go
create table liczby1 ( liczba int );
create table liczby2 ( liczba int );
go

-- 1
begin tran
insert liczby1 values ( 1 )

-- 3 
update liczby2 set liczba=10

select * from liczby1 -- pokaze ok
select * from liczby2 -- nic nie pokaze

-- 5
commit