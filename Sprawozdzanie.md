
---
# Bazy danych


**Autorzy:** (Olga Kozioł, Dawid Ryba, Wojciech Cieplichiewicz, Klaudia Kiliańska)

--- 

# 1.	Wymagania i funkcje systemu

Główną funkcją systemu jest wspomaganie działalności firmy świadczącej usługi turystyczne dla klientów indywidualnych oraz firm.

Klientom powinien on udostępniać możliwość zarezerwowania wycieczki. Aby to wykonać, klient musi wprowadzić swoje dane, liczbę uczestników, ich dane roraz id wycieczki i wybrać, jakie usługi chce zarezerwować. 

Wówczas tabele zostają uzupełnione o podane wyżej dane, a dodatkowo id klienta oraz datę dokonania rezerwacji. Automatycznie wprowadzana jest również data, do której możliwe jest dokonanie zmian w zamówieniu oraz koszt całego zamówienia. Aktualizowana jest również liczba dostępnych miejsc.

Rolą administratora jest dodawanie do bazy wycieczek, możliwych dla nich usług oraz limitów miejsc. 

# 2.	Baza danych

## Schemat bazy danych

![](schemat.png)

## Opis poszczególnych tabel

(Dla każdej tabeli kod + opis w formie tabelki + kod DDL)


Nazwa tabeli: Wycieczki
- Opis:  

| Nazwa atrybutu | Typ | Opis/Uwagi                                      |
| -------------- | --- | ----------------------------------------------- |
| ID_Wycieczki   | int | Klucz główny, niepowtarzalny, który się inkrementuje automatycznie |
| Kraj  |  varchar(255)   |   Nazwa państwa    |
|Miasto|varchar(255)|Miejsce przyjazdu|
|Data_Wyjazdu|date|Data rozpoczęcia wycieczki|
|Miejsce_Wyjazdu|varchar(255)|Miejsce wyjazdu|
|Cena|numeric(10,2)|Cena wycieczki zł/gr|
|Liczba_Miejsc|int|Liczba dostępnych miejsc|



- kod DDL

```sql
create table Wycieczki(
ID_Wycieczki int Identity(1,1) Primary key,
Kraj varchar(255),
Miasto varchar(255),
Data_Wyjazdu date,
Data_Przyjazdu date,
Miejsce_Wyjazdu varchar(255),
Cena numeric(10,2),
Liczba_Miejsc int
)
```


Nazwa tabeli: Uslugi
- Opis: (opis tabeli, komentarz)

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| ID_Uslugi   |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
| Nazwa_Uslugi   |  varchar(255)   |     Nazwa Usługi       |
|Cena|numeric(10,2)|Cena za daną usługę zł/gr|
|Liczba_Miejsc|int|Liczba miejsc na daną usługę|
|ID_Wycieczki|int|Klucz obcy id wycieczki z tabeli Wycieczki|

- kod DDL

```sql
Create table Uslugi(
ID_Uslugi int Identity(1,1) Primary key,
Nazwa_Uslugi varchar(255),
Cena numeric(10,2),
Liczba_Miejsc int,
ID_Wycieczki int,
FOREIGN KEY (ID_Wycieczki) REFERENCES Wycieczki(ID_wycieczki)
)

```

Nazwa tabeli: Klienci
- Opis: (opis tabeli, komentarz)

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| ID_Klienta   |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
| Imie   |  varchar(255)   |     Imie klienta płacącego za wycieczkę       |
|Nazwisko|varchar(255)|Nazwisko klienta płacącego za wycieczkę |
|Adres|varchar(255)|Adres klienta płacącego za wycieczkę|
|Numer_Telefonu |varchar(255)|Numer telefonu klienta płacącego za wycieczkę|
- kod DDL

```sql
Create Table Klienci(

ID_Klienta int Identity(1,1) primary key,
Imie varchar(255),
Nazwisko varchar(255),
Adres varchar(255),
Numer_Telefonu varchar(255)
)

```


Nazwa tabeli: Uczestnicy_Wycieczek
- Opis: (opis tabeli, komentarz)

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| ID_Uczestnika  |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
|ID_Wycieczki|int |Klucz obcy id wycieczki z tabeli Wycieczki|
|ID_Uslugi|int|Klucz obcy id isługi z tabeli Usługi|
|ID_Klienta|int|Klucz obcy id klienta z tabeli klienci|
|Imie|varchar(255)|Imie uczestnika wycieczki|
|Nazwisko|varchar(255)|Nazwisko uczestnika wycieczki|
|Numer_Telefonu|varchar(255)|Numer telefonu uczestnika wycieczki|

- kod DDL

```sql
Create table Uczestnicy_Wycieczek(

ID_Uczestnika int Identity(1,1) primary key,
ID_Wycieczki int,
ID_Uslugi int,
ID_Klienta int,
FOREIGN KEY (ID_Wycieczki) REFERENCES Wycieczki(ID_wycieczki),
FOREIGN KEY (ID_Uslugi) REFERENCES Uslugi(ID_Uslugi),
FOREIGN KEY (ID_Klienta) REFERENCES Klienci(ID_Klienta),
Imie varchar(255),
Nazwisko varchar(255),
Numer_Telefonu varchar(255),

)

```


Nazwa tabeli: Rezerwacje
- Opis: (opis tabeli, komentarz)

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| ID_Rezerwacji |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
|Oplata|numeric(10,2)|Opłata za wycieczkę+usługi|
|Liczba_uczestnikow|int|Liczba uczestników wycieczki|
|Data_Rezerwacji|datetime|Data dokonania rezerwacji|
|Czas_Na_Zmiany|datetime|Ostateczny czas dokonywania zmian|
|ID_Klienta|int|Klucz obcy id klienta z tabeli Klienci|
|ID_Wycieczki |int|Klucz obcy id wycieczki z tabeli wycieczki|
|ID_Uslugi|int|Klucz obcy id usługi z tabeli Uslugi|
- kod DDL

```sql
create table Rezerwacje (
ID_Rezerwacji int Identity(1,1) Primary key,
Oplata numeric(10,2),
Liczba_uczestnikow int,
Data_Rezerwacji datetime,
Czas_Na_Zmiany datetime, --Nalezy pobrac date wyjazdu i odjąć-7  dni
ID_Klienta int,
ID_Wycieczki int,
ID_Uslugi int,
FOREIGN KEY (ID_Klienta) REFERENCES Klienci(ID_Klienta),
FOREIGN KEY (ID_Uslugi) REFERENCES Uslugi(ID_Uslugi),
FOREIGN KEY (ID_Wycieczki) REFERENCES Wycieczki(ID_Wycieczki),
)

```


Nazwa tabeli: Oplaty
- Opis: (opis tabeli, komentarz)

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| ID_Oplaty |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
|Wplata|numeric(10,2)|Wpłata na bieżąco dokonywana przez klienta|
|Calosc|numeric(10,2)|Całkowita kwota|
|Koniec_Czasu|datetime|Ostateczny czas na dokonywanie wpłat|
|ID_Rezerwacji|int|Klucz obcy id rezerwacji z tabeli Rezerwacje|
|ID_Klienta int|int|Klucz obcy id klienta z tabeli Klienci|
- kod DDL

```sql
create table Oplaty(

ID_Oplaty int identity(1,1) primary key,
Wplata numeric(10,2),
Calosc numeric(10,2),
Koniec_Czasu datetime,
ID_Rezerwacji int,
ID_Klienta int,
FOREIGN KEY (ID_Rezerwacji) REFERENCES Rezerwacje(ID_Rezerwacji),
FOREIGN KEY (ID_Klienta) REFERENCES Klienci(ID_Klienta),

)

```


# 3.  Widoki, procedury/funkcje, triggery 


## Widoki

(dla każdego widoku należy wkleić kod polecenia definiującego widok wraz z komentarzem)


## Procedury/funkcje

(dla każdej procedury/funkcji należy wkleić kod polecenia definiującego procedurę wraz z komentarzem)

## Triggery

(dla każdego triggera należy wkleić kod polecenia definiującego trigger wraz z komentarzem)


# 4. Inne

(informacja o sposobie wygenerowania danych, uprawnienia …)
