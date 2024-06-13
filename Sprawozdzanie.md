
---
# Bazy danych


**Autorzy:** (Olga Kozioł, Dawid Ryba, Wojciech Cieplichiewicz, Klaudia Kiliańska)

--- 

# 1.	Wymagania i funkcje systemu

Główną funkcją systemu jest wspomaganie działalności firmy świadczącej usługi turystyczne dla klientów indywidualnych oraz firm.

Klientom powinien on udostępniać możliwość zarezerwowania wycieczki. Aby to wykonać, klient musi wprowadzić swoje dane, liczbę uczestników, ich dane oraz id wycieczki i wybrać, jakie usługi chce zarezerwować. 

Wówczas tabele zostają uzupełnione o podane wyżej dane, a dodatkowo id klienta oraz datę dokonania rezerwacji. Automatycznie wprowadzana jest również data, do której możliwe jest dokonanie zmian w zamówieniu oraz koszt całego zamówienia. Aktualizowana jest również liczba dostępnych miejsc.

Rolą administratora jest dodawanie do bazy wycieczek, możliwych dla nich usług oraz limitów miejsc. 

# 2.	Baza danych

## Schemat bazy danych

![](images/schemat.png)

## Opis poszczególnych tabel

Nazwa tabeli: Klienci
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_klienta   |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
| typ_klienta | varchar (50) | Może przyjmować dwie wartości: I - indywidualny, F - firma |
| imie   |  varchar(255)   |     Imię klienta płacącego za wycieczkę       |
|nazwisko|varchar(255)|Nazwisko klienta płacącego za wycieczkę |
|adres|varchar(255)|Adres klienta płacącego za wycieczkę|
| miasto | varchar (255) | Adres - miasto |
| kraj | varchar (255) | Adres - kraj |
|telefon|varchar(255)|Numer telefonu klienta płacącego za wycieczkę|
|nazwa_firmy| varchar(255)| Nazwa firmy, jeśli osoba prytatna to pole zawiera napis "brak"|



- kod DDL

```sql
CREATE TABLE Klienci (
    typ_klienta varchar(50) NOT NULL CHECK (typ_klienta in ('I', 'F')),
    id_klienta int IDENTITY(1,1) PRIMARY KEY,
    imie varchar(255)  NOT NULL,
    nazwisko varchar(255)  NOT NULL,
    adres varchar(255)  NOT NULL,
    miasto varchar(255) NOT NULL,
    kraj varchar(255) NOT NULL,
    telefon varchar(255)  NOT NULL
    nazwa_firmy varchar(255)  NOT NULL
);
```

Nazwa tabeli: Kraje
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_kraju   |  varchar(2)   |    Klucz główny, niepowtarzalny, kod kraju        |
| nazwa_kraju   |  varchar(255)   |     Nazwa kraju       |


- kod DDL

```sql
CREATE TABLE Kraje (
    id_kraju varchar(2) NOT NULL PRIMARY KEY,
    nazwa_kraju varchar(255)  NOT NULL,
);
```

Nazwa tabeli: Miasta
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_miasta   |  int  |    Klucz główny, niepowtarzalny, który się inkrementuje       |
| id_kraju   |  varchar(2)  |    Klucz obcy, z tabeli Kraje       |
| nazwa_miasta  |  varchar(255)   |     Nazwa miasta      |


- kod DDL

```sql
CREATE TABLE Miasta (
	id_miasta int IDENTITY(1,1) PRIMARY KEY,
    id_kraju varchar(2)  NOT NULL,
    nazwa_miasta varchar(255)  NOT NULL,
    FOREIGN KEY (id_kraju) REFERENCES Kraje(id_kraju)
);
```
Nazwa tabeli: Wycieczki
- Opis:  

| Nazwa atrybutu | Typ | Opis/Uwagi                                      |
| -------------- | --- | ----------------------------------------------- |
| id_wycieczki   | int | Klucz główny, niepowtarzalny, który się inkrementuje automatycznie |
|id_miasta | int | Nazwa miasta |
|data_wyjazdu|date|Data rozpoczęcia wycieczki|
|data_przyjazdu|date|Data zakończenia wycieczki|
|miejsce_wyjazdu|varchar(255)|Miejsce wyjazdu|
|liczba_miejsc|int|Liczba dostępnych miejsc|
|cena|decimal(10,2)|Cena wycieczki zł/gr|
|data_rozpoczecia_rezerwacji | date | data, od kiedy można rezerwować wycieczkę |

- kod DDL

```sql
CREATE TABLE Wycieczki (
    id_wycieczki int IDENTITY(1,1) PRIMARY KEY,
    id_miasta int NOT NULL,
    data_wyjazdu datetime NOT NULL,
    data_przyjazdu datetime NOT NULL,
    miejsce_wyjazdu varchar(255) NOT NULL,
    liczba_miejsc int NOT NULL CHECK (liczba_miejsc > 0),
    cena decimal(10,2) NOT NULL CHECK (cena > 0),
    data_rozpoczecia_rez datetime NOT NULL,
    FOREIGN KEY (id_miasta) REFERENCES Miasta(id_miasta)
);
```

Nazwa tabeli: Statusy
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_statusu | int | Klucz główny, niepowtarzalny, który się automatycznie inkrementuje |
| status | varchar(255) | Opis statusu |

- kod DDL

```sql
CREATE TABLE Statusy (
    id_statusu int  NOT NULL CHECK (id_statusu in (0, 1)) PRIMARY KEY,
    status varchar(255)  NOT NULL,
);
```

Nazwa tabeli: Rezerwacje_wycieczek
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_rezerwacji   |  int  |    Klucz główny, niepowtarzalny, który się inkrementuje       |
| id_wycieczki   |  int  |    Klucz obcy, z tabeli Wycieczki      |
| id_klienta | int | Klucz obcy, z tabeli Klienci |
| id_statusu | int | Klucz obcy, z tabeli słownikowej Statusy |
| liczba_uczestnikow | int | Liczba uczestników |
| data_rezerwacji | date | Data rezerwacji |


- kod DDL

```sql
CREATE TABLE Rezerwacje_wycieczek (
    id_rezerwacji int IDENTITY(1,1) PRIMARY KEY,
    id_wycieczki int NOT NULL,
    id_statusu int NOT NULL CHECK (id_statusu in (0, 1)),
    id_klienta int NOT NULL,
    liczba_uczestnikow int NOT NULL CHECK (liczba_uczestnikow > 0),
    data_rezerwacji date NOT NULL,
	FOREIGN KEY (id_wycieczki) REFERENCES Wycieczki(id_wycieczki),
	FOREIGN KEY (id_klienta) REFERENCES Klienci(id_klienta),
	FOREIGN KEY (id_statusu) REFERENCES Statusy(id_statusu)
);

```

Nazwa tabeli: Uslugi
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_uslugi   |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
|id_wycieczki|int|Klucz obcy z tabeli Wycieczki|
| nazwa   |  varchar(255)   |     Nazwa Usługi       |
|liczba_miejsc|int|Liczba miejsc na daną usługę|
|cena|decimal(10,2)|Cena za daną usługę zł/gr|

- kod DDL

```sql
CREATE TABLE Uslugi (
	id_uslugi int IDENTITY(1,1) PRIMARY KEY,
	id_wycieczki int NOT NULL,
    nazwa varchar(255)  NOT NULL,
    liczba_miejsc int NOT NULL CHECK (liczba_miejsc > 0),
    cena decimal(10,2) NOT NULL CHECK (cena > 0),
    FOREIGN KEY (id_wycieczki) REFERENCES Wycieczki(id_wycieczki)
);
```

Nazwa tabeli: Rezerwacje_uslugi
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_rezerwacji_uslugi   |  int  |    Klucz główny, niepowtarzalny, który się inkrementuje       |
| id_rezerwacji   |  int  |    Klucz obcy, z tabeli Rezerwacje_wycieczek      |
| id_uslugi | int | Klucz obcy, z tabeli Uslugi |
| liczba_uczestnikow | int | Liczba uczestników |
| data_rezerwacji | date | Data rezerwacji |
| cena | decimal(2,10) | Cena usługi
- kod DDL

```sql
CREATE TABLE Rezerwacje_uslugi (
    id_rezerwacji_uslugi int IDENTITY(1,1) PRIMARY KEY,
    id_rezerwacji int  NOT NULL,
    id_uslugi int  NOT NULL,
    liczba_uczestnikow int  NOT NULL CHECK (liczba_uczestnikow > 0),
    data_rezerwacji date NOT NULL,
    cena decimal(10,2) NOT NULL CHECK (cena > 0),
    FOREIGN KEY (id_rezerwacji) REFERENCES Rezerwacje_wycieczek(id_rezerwacji),
	FOREIGN KEY (id_uslugi) REFERENCES Uslugi(id_uslugi)
);
```

Nazwa tabeli: Uczestnicy
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_uczestnika  |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie |
|id_rezerwacji|int |Klucz obcy z tabeli rezerwacje|
|imie|varchar(255)|Imie uczestnika wycieczki|
|nazwisko|varchar(255)|Nazwisko uczestnika wycieczki|
|telefon|varchar(255)|Numer telefonu uczestnika wycieczki|

```sql
CREATE TABLE Uczestnicy (
    id_uczestnika int IDENTITY(1,1) PRIMARY KEY,
    id_rezerwacji int NOT NULL,
    imie varchar(255) NOT NULL,
    nazwisko varchar(255) NOT NULL,
    telefon varchar(255) NOT NULL,
    FOREIGN KEY (id_rezerwacji) REFERENCES Rezerwacje_wycieczek(id_rezerwacji)
);
```
Nazwa tabeli: Uczestnicy_uslugi
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
|id_uczestnika_uslugi  |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
|id_uczestnika|int |Klucz obcy z tabeli Uczestnicy|
|id_rezerwacji_uslugi | int | Klucz obcy z tabeli Rezerwacje_uslugi |

```sql
CREATE TABLE Uczestnicy_uslugi (
    id_uczestnika_uslugi int IDENTITY(1,1) PRIMARY KEY,
    id_uczestnika int  NOT NULL,
    id_rezerwacji_uslugi int  NOT NULL,
	FOREIGN KEY (id_uczestnika) REFERENCES Uczestnicy(id_uczestnika),
	FOREIGN KEY (id_rezerwacji_uslugi) REFERENCES Rezerwacje_uslugi(id_rezerwacji_uslugi)
);
```

Nazwa tabeli: Wpłaty
- Opis:  

| Nazwa atrybutu | Typ | Opis/Uwagi                                      |
| -------------- | --- | ----------------------------------------------- |
|id_wplaty | int | Klucz główny, który sie automatycznie inkrementuje | 
|id_klienta | int | Klucz obcy do tabeli Klienci |
|id_rezerwacji | int | Klucz obcy do tabeli Rezerwacje |
|wplata | decimal (10,2) | Wpłacona kwota |
| data_wplaty | date | Data wpłaty |

- kod DDL

```sql
CREATE TABLE Wplaty (
    id_wplaty int IDENTITY(1,1) PRIMARY KEY,
    id_klienta int NOT NULL,
    id_rezerwacji int NOT NULL,
    wplata decimal(10,2) NOT NULL CHECK (wplata > 0),
    data_wplaty date NOT NULL,
    FOREIGN KEY (id_klienta) REFERENCES Klienci(id_klienta),
    FOREIGN KEY (id_rezerwacji) REFERENCES Rezerwacje_wycieczek(id_rezerwacji)
);
```

# 3.  Widoki, procedury/funkcje, triggery 


## Widoki

Nazwa widoku: v_informacje_o_wycieczkach
- Opis: Wyświetla wycieczki/usługi wraz z informacjami o dostępnych miejscach
![](images/views_1.png)
- kod DDL
```sql
CREATE VIEW v_informacje_o_wycieczkach
AS
SELECT w.id_wycieczki, w.liczba_miejsc "Liczba miejsc na wycieczkę", u.id_uslugi, u.liczba_miejsc "Liczba miejsc na usługę"
from Wycieczki w
left join Uslugi u on w.id_wycieczki=u.id_wycieczki
```

Nazwa widoku: v_rezerwacje_zamowienia
- Opis: Wyświetla rezerwacje i ich całkowity koszt
![](images/views_2.png)
- kod DDL
```sql
CREATE VIEW v_rezerwacje_zamowienia
AS
SELECT rw.id_rezerwacji, rw.liczba_uczestnikow, w.cena * rw.liczba_uczestnikow as koszt_wycieczki, sum(ru.cena) koszt_uslug, w.cena * rw.liczba_uczestnikow + sum(ru.cena) as calkowity_koszt
from Rezerwacje_wycieczek rw
join Wycieczki w on rw.id_wycieczki=w.id_wycieczki
join Rezerwacje_uslugi ru on ru.id_rezerwacji=rw.id_rezerwacji
group by rw.id_rezerwacji, rw.liczba_uczestnikow, w.cena
```

Nazwa widoku: v_saldo_rezerwacji
- Opis: Wyświetla informacje o sumie wpłat za daną rezerwację i kwocie do zapłaty lub nadpłacie
![](images/views_3.png)
- kod DDL
```sql
CREATE VIEW v_saldo_rezerwacji
AS
SELECT rw.id_rezerwacji, v.calkowity_koszt, sum(wplata) as wplata, sum(wplata) - v.calkowity_koszt saldo
from Rezerwacje_wycieczek rw 
join v_rezerwacje_zamowienia v on v.id_rezerwacji=rw.id_rezerwacji
join wplaty w on w.id_rezerwacji=rw.id_rezerwacji
group by rw.id_rezerwacji, v.calkowity_koszt
```

Nazwa widoku: v_wykaz_uczestnikow
- Opis: Wyświetla wykaz uczestników poszczególnych wycieczek i atrakcji
![](images/views_4.png)
- kod DDL
```sql
CREATE VIEW v_wykaz_uczestnikow
AS
SELECT rw.id_rezerwacji, ru.id_rezerwacji_uslugi, id_uczestnika, imie, nazwisko
from Rezerwacje_wycieczek rw 
join Rezerwacje_uslugi ru on rw.id_rezerwacji=ru.id_rezerwacji
join Uczestnicy u on u.id_rezerwacji=rw.id_rezerwacji
```

## Procedury/funkcje

- Opis: Procedura wyświetlająca listę uczestników danej rezerwacji
- kod DDL
```sql
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
```

- Opis: Procedura wyświetlająca listę wszystkich wplat danego klienta
- kod DDL
```sql
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
```

- Opis: Procedura wyświetlająca liczbę uczestników danej usługi
- kod DDL
```sql
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
```

- Opis: Procedura wyświetlająca informacje o danym kliencie
- kod DDL
```sql
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
```

- Opis: Funkcja wyświetlacjąca wpłaty w danym miesiącu
- kod DDL
```sql
create function f_wplaty_w_danym_miesiacu (@month int)  
returns table  
as return (  
select *  
from wplaty  
where month(data_wplaty) = @month 
);
```
- Opis: Funkcja wyświetlacjąca wycieczki zarezerwowane w danym miesiącu
- kod DDL
```sql
create function f_rezerwacje_wycieczek_w_danym_miesiacu (@month int)  
returns table  
as return (  
select *
from Rezerwacje_wycieczek  
where month(data_rezerwacji) = @month 
);
```


- Opis: Funkcja wyświetlacjąca wycieczki, które można rezerwować w danym dniu
- kod DDL
```sql
create function f_aktywne_wycieczki (@data date)
returns table  
as return (  
select *
from wycieczki 
where data_rozpoczecia_rez <= @data
);
```

- Opis: Procedura dodająca rezerwacje. Wstawia nową rezerwację do tabeli Rezerwacje_wycieczek i zwraca ID utworzonej rezerwacji.
- kod DDL
```sql
CREATE PROCEDURE AddReservation (
    IN p_id_wycieczki INT,
    IN p_id_klienta INT,
    IN p_id_statusu INT,
    IN p_liczba_uczestnikow INT,
    IN p_suma_wycieczki DECIMAL(10,2)
)
BEGIN
    DECLARE p_id_rezerwacji INT;
    
    -- Insert into Rezerwacje_wycieczek
    INSERT INTO Rezerwacje_wycieczek (id_wycieczki, id_klienta, id_statusu, liczba_uczestnikow, suma_wycieczki)
    VALUES (p_id_wycieczki, p_id_klienta, p_id_statusu, p_liczba_uczestnikow, p_suma_wycieczki);
    
    SET p_id_rezerwacji = LAST_INSERT_ID();
    
    -- Return the ID of the new reservation
    SELECT p_id_rezerwacji AS id_rezerwacji;
END 
```

- Opis: Procedura modyfikująca rezerwację. Aktualizuje szczegóły istniejącej rezerwacji w tabeli Rezerwacje_wycieczek na podstawie ID.
- kod DDL
```sql
CREATE PROCEDURE ModifyReservation (
    IN p_id_rezerwacji INT,
    IN p_id_wycieczki INT,
    IN p_id_klienta INT,
    IN p_id_statusu INT,
    IN p_liczba_uczestnikow INT,
    IN p_suma_wycieczki DECIMAL(10,2)
)
BEGIN
    -- Update Rezerwacje_wycieczek
    UPDATE Rezerwacje_wycieczek
    SET id_wycieczki = p_id_wycieczki,
        id_klienta = p_id_klienta,
        id_statusu = p_id_statusu,
        liczba_uczestnikow = p_liczba_uczestnikow,
        suma_wycieczki = p_suma_wycieczki
    WHERE id_rezerwacji = p_id_rezerwacji;
END //
```

- Opis: Procedura odwołująca rezerwację. Procedura usuwa wszystkie wpisy w tabelach Uczestnicy_uslugi, Uczestnicy, Rezerwacje_uslugi oraz Wplaty, zanim usunie rezerwację z tabeli Rezerwacje_wycieczek.
- kod DDL
```sql
CREATE PROCEDURE CancelReservation (
    IN p_id_rezerwacji INT
)
BEGIN
    -- Delete from Uczestnicy_uslugi
    DELETE FROM Uczestnicy_uslugi
    WHERE id_rezerwacji_uslugi IN (SELECT id_rezerwacji_uslugi FROM Rezerwacje_uslugi WHERE id_rezerwacji = p_id_rezerwacji);
    
    -- Delete from Uczestnicy
    DELETE FROM Uczestnicy
    WHERE id_rezerwacji = p_id_rezerwacji;
    
    -- Delete from Rezerwacje_uslugi
    DELETE FROM Rezerwacje_uslugi
    WHERE id_rezerwacji = p_id_rezerwacji;
    
    -- Delete from Wplaty
    DELETE FROM Wplaty
    WHERE id_rezerwacji = p_id_rezerwacji;
    
    -- Delete from Rezerwacje_wycieczek
    DELETE FROM Rezerwacje_wycieczek
    WHERE id_rezerwacji = p_id_rezerwacji;
END //
```



## Triggery

- Opis: Trigger aktualizujący liczbę uczestników w rezerwacji usługi po dodaniu nowego uczestnika.
- kod DDL
```sql
CREATE TRIGGER update_participant_count_after_insert
AFTER INSERT ON Uczestnicy_uslugi
FOR EACH ROW
BEGIN
    UPDATE Rezerwacje_uslugi
    SET liczba_uczestnikow = liczba_uczestnikow + 1
    WHERE id_rezerwacji = NEW.id_rezerwacji_uslugi;
END;

```

- Opis: Trigger aktualizujący liczbę uczestników w rezerwacji usługi po usunięciu uczestnika:
- kod DDL
```sql
CREATE TRIGGER aktualizuj_liczbe_uczestnikow_po_usunieciu
AFTER DELETE ON Uczestnicy_uslugi
FOR EACH ROW
BEGIN
    UPDATE Rezerwacje_uslugi
    SET liczba_uczestnikow = liczba_uczestnikow - 1
    WHERE id_rezerwacji = OLD.id_rezerwacji_uslugi;
END;

```

- Opis: Trigger obliczający kwotę wpłat dla rezerwacji wycieczki po dodaniu nowej wpłaty.

- kod DDL
```sql
CREATE TRIGGER oblicz_calosc_wplat_po_dodaniu
AFTER INSERT ON Wplaty
FOR EACH ROW
BEGIN
    UPDATE Rezerwacje_wycieczek
    SET suma_wycieczki = suma_wycieczki + NEW.wplata
    WHERE id_rezerwacji = NEW.id_rezerwacji;
END;

```

- Opis: Trigger aktualizujący status rezerwacji wycieczki na podstawie liczby uczestników.


- kod DDL
```sql
CREATE TRIGGER aktualizuj_status_po_dodaniu_uczestnika
AFTER INSERT ON Uczestnicy
FOR EACH ROW
BEGIN
    DECLARE total_participants INT;
    SELECT liczba_uczestnikow INTO total_participants
    FROM Rezerwacje_wycieczek
    WHERE id_rezerwacji = NEW.id_rezerwacji;

    IF total_participants >= (SELECT liczba_miejsc FROM Wycieczki WHERE id_wycieczki = (SELECT id_wycieczki FROM Rezerwacje_wycieczek WHERE id_rezerwacji = NEW.id_rezerwacji)) THEN
        UPDATE Rezerwacje_wycieczek
        SET id_statusu = (SELECT id_statusu FROM Statusy WHERE status = 'Full')
        WHERE id_rezerwacji = NEW.id_rezerwacji;
    END IF;
END;

```

- Opis: Trigger dodający aktualną datę przy tworzeniu rezerwacji.

- kod DDL
```sql
CREATE TRIGGER ustaw_date_rezerwacji
BEFORE INSERT ON Rezerwacje_wycieczek
FOR EACH ROW
SET NEW.data_rozpoczecia_rezerw = IFNULL(NEW.data_rozpoczecia_rezerw, NOW());


```


# 4. Inne

(informacja o sposobie wygenerowania danych, uprawnienia …)
