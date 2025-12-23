drop table if exists liczby;
go
create table liczby ( liczba int );
go
insert liczby values ( 10 );
go

-- 1 --
set transaction isolation level repeatable read;
begin transaction
select * from liczby

-- ponownie w drugim po��czeniu robimy update: update liczby set liczba=4
-- Na tym etapie jest tzw. shared lock na wszystkie transakcje, wiec druga 
-- transakcja nie bedzie w stanie wykonac update - tylko odczyt 
-- ogl�damy blokady: sp_lock

commit


-- ---2----
set transaction isolation level serializable;
begin transaction
select * from liczby

-- ponownie w drugim po��czeniu robimy insert: insert liczby values(151)
-- Na tym etapie oprocz shared lock jest tez ranged lock ktory prewentuje phantom reads, zatem dodanie nowej kolumny tez nie bedzie mozliwe
-- ogl�damy blokady: sp_lock

commit