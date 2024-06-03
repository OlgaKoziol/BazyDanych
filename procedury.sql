create or alter proc lista_uczestnikow_danej_rezerwacji  
@id_rezerwacji int  
as  
begin  
if not exists (select * from Rezerwacje_wycieczek where id_rezerwacji = @id_rezerwacji)  
throw 50001, 'Brak rezerwacji o takim id', 1;  
end;
select *  
from Lista_uczestnikow_rezerwacji 
where id_rezerwacji = @id_rezerwacji; 

create or alter proc wplaty_danego_klienta
@id_klienta int  
as  
begin  
if not exists (select * from Klienci where id_klienta = @id_klienta)  
throw 50001, 'Brak klienta o takim id', 1;  
end;
SELECT Klienci.id_klienta, Klienci.imie, Klienci.nazwisko, wplaty.wplata
FROM Klienci
JOIN Wplaty ON Klienci.id_klienta = Wplaty.id_klienta
where id_klienta = @id_klienta; 

create or alter proc liczba_uczestnikow_danej_uslugi
@id_uslugi int  
as  
begin  
    if not exists (select * from uslugi where id_uslugi = @id_uslugi)  
        throw 50001, 'Brak wycieczki o takim id', 1;  
    SELECT id_uslugi, sum(liczba_uczestnikow)
    FROM Rezerwacje_uslugi
    where id_uslugi = @id_uslugi
    group by id_uslugi
end;

create or alter proc informacje_o_danym_kliencie
@id_klienta int  
as  
begin  
    if not exists (select * from klienci where id_klienta = @id_klienta)  
        throw 50001, 'Brak klienta o takim id', 1;  
    SELECT *
    FROM Info_klient
    where id_klienta = @id_klienta
end;