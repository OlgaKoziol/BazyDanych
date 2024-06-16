CREATE VIEW v_informacje_o_wycieczkach
AS
SELECT w.id_wycieczki, w.liczba_miejsc "Liczba miejsc na wycieczkę", u.id_uslugi, u.liczba_miejsc "Liczba miejsc na usługę"
from Wycieczki w
left join Uslugi u on w.id_wycieczki=u.id_wycieczki

CREATE VIEW v_rezerwacje_zamowienia
AS
SELECT rw.id_rezerwacji, rw.liczba_uczestnikow, w.cena * rw.liczba_uczestnikow as koszt_wycieczki, sum(ru.cena) koszt_uslug, w.cena * rw.liczba_uczestnikow + sum(ru.cena) as calkowity_koszt
from Rezerwacje_wycieczek rw
join Wycieczki w on rw.id_wycieczki=w.id_wycieczki
join Rezerwacje_uslugi ru on ru.id_rezerwacji=rw.id_rezerwacji
group by rw.id_rezerwacji, rw.liczba_uczestnikow, w.cena

CREATE VIEW v_saldo_rezerwacji
AS
SELECT rw.id_rezerwacji, v.calkowity_koszt, sum(wplata) as wplata, sum(wplata) - v.calkowity_koszt saldo
from Rezerwacje_wycieczek rw 
join v_rezerwacje_zamowienia v on v.id_rezerwacji=rw.id_rezerwacji
join wplaty w on w.id_rezerwacji=rw.id_rezerwacji
group by rw.id_rezerwacji, v.calkowity_koszt

CREATE VIEW v_wykaz_uczestnikow
AS
SELECT rw.id_rezerwacji, ru.id_rezerwacji_uslugi, id_uczestnika, imie, nazwisko
from Rezerwacje_wycieczek rw 
join Rezerwacje_uslugi ru on rw.id_rezerwacji=ru.id_rezerwacji
join Uczestnicy u on u.id_rezerwacji=rw.id_rezerwacji
