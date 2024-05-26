CREATE VIEW Lista_uczestnikow_rezerwacji
AS
SELECT Rezerwacje_uslugi.id_rezerwacji, Uczestnicy.imie, Uczestnicy.nazwisko
FROM Rezerwacje_uslugi
JOIN Uczestnicy ON Rezerwacje_uslugi.id_rezerwacji = Uczestnicy.id_rezerwacji;

CREATE VIEW Cala_wplata
AS
SELECT Klienci.id_klienta, Klienci.imie, Klienci.nazwisko, SUM(Wplaty.wplata) as CalaWplata
FROM Klienci
JOIN Wplaty ON Klienci.id_klienta = Wplaty.id_klienta
GROUP BY Klienci.id_klienta, Klienci.imie, Klienci.nazwisko;

CREATE VIEW Liczba_uczestnikow_wycieczki
AS
SELECT Rezerwacje_uslugi.id_rezerwacji, Uslugi.nazwa, COUNT(Uczestnicy.id_uczestnika) as LiczbaUczestnikow
FROM Rezerwacje_uslugi
JOIN Uczestnicy ON Rezerwacje_uslugi.id_rezerwacji = Uczestnicy.id_rezerwacji
JOIN Uslugi ON Rezerwacje_uslugi.id_uslugi = Uslugi.id_uslugi
GROUP BY Rezerwacje_uslugi.id_rezerwacji, Uslugi.nazwa;

CREATE VIEW Wycieczka_i_lokalizacja
AS
SELECT Wycieczki.id_wycieczki, Wycieczki.data_wyjazdu, Miasta.nazwa_miasta, Kraje.nazwa_kraju
FROM Wycieczki
JOIN Miasta ON Wycieczki.id_miasta = Miasta.id_miasta
JOIN Kraje ON Miasta.id_kraju = Kraje.id_kraju;

CREATE VIEW Info_klient
AS
SELECT Klienci.id_klienta, Klienci.imie, Klienci.nazwisko, Rezerwacje_uslugi.id_rezerwacji, SUM(Wplaty.wplata) as WszystkieWplaty
FROM Klienci
JOIN Rezerwacje_uslugi ON Klienci.id_klienta = Rezerwacje_uslugi.id_rezerwacji
JOIN Wplaty ON Klienci.id_klienta = Wplaty.id_klienta
GROUP BY Klienci.id_klienta, Klienci.imie, Klienci.nazwisko, Rezerwacje_uslugi.id_rezerwacji;

CREATE VIEW Dostepne_uslugi_i_cena
AS
SELECT Uslugi.nazwa, Uslugi.cena, Uslugi.liczba_miejsc
FROM Uslugi
WHERE Uslugi.liczba_miejsc > 0;
