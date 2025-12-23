update liczby set liczba=4

-- widzimy ze nic sie nie wykonuje, czeka na zwolnienie blokady z pierwszej kwerendy
-- dopiero po zrobieniu commit tam, tutaj wykonamy polecenie

-- ---2---
-- Spróbuj wykonać INSERT - będzie czekał
insert liczby values(151)

