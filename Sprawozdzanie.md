
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

Nazwa tabeli: Klienci
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_klienta   |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
| imie   |  varchar(255)   |     Imię klienta płacącego za wycieczkę       |
|nazwisko|varchar(255)|Nazwisko klienta płacącego za wycieczkę |
|adres|varchar(255)|Adres klienta płacącego za wycieczkę|
|telefon|varchar(255)|Numer telefonu klienta płacącego za wycieczkę|

- kod DDL

```sql
CREATE TABLE Klienci (
    id_klienta int  NOT NULL,
    imie varchar(255)  NOT NULL,
    nazwisko varchar(255)  NOT NULL,
    adres varchar(255)  NOT NULL,
    telefon varchar(255)  NOT NULL,
    CONSTRAINT Klienci_pk PRIMARY KEY (id_klienta)
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
    id_kraju varchar(2)  NOT NULL,
    nazwa_kraju varchar(255)  NOT NULL,
    CONSTRAINT Kraje_pk PRIMARY KEY (id_kraju)
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
    id_miasta int  NOT NULL,
    id_kraju varchar(2)  NOT NULL,
    nazwa_miasta varchar(255)  NOT NULL,
    CONSTRAINT Miasta_pk PRIMARY KEY (id_miasta)
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
| cena | decimal (2,10) | Łączna cena całej rezerwacji |
| zaplacono | decimal (2,10) | Zapłacona kwota |


- kod DDL

```sql
CREATE TABLE Rererwacje_wycieczek (
    id_rezerwacji int  NOT NULL,
    id_wycieczki int  NOT NULL,
    id_klienta int  NOT NULL,
    id_statusu int  NOT NULL,
    liczba_uczestnikow int  NOT NULL,
    cena decimal(10,2)  NOT NULL,
    zaplacono decimal(10,2)  NOT NULL,
    CONSTRAINT Rererwacje_wycieczek_pk PRIMARY KEY (id_rezerwacji)
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
| cena | decimal (2,10) | Łączna cena strakcji |
| zaplacono | decimal (2,10) | Zapłacona kwota |


- kod DDL

```sql
CREATE TABLE Rezerwacje_uslugi (
    id_rezerwacji_uslugi int  NOT NULL,
    id_rezerwacji int  NOT NULL,
    id_uslugi int  NOT NULL,
    liczba_uczestnikow int  NOT NULL,
    cena decimal(10,2)  NOT NULL,
    zaplacono decimal(10,2)  NOT NULL,
    CONSTRAINT Rezerwacje_uslugi_pk PRIMARY KEY (id_rezerwacji_uslugi)
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
    id_statusu int  NOT NULL,
    status varchar(255)  NOT NULL,
    CONSTRAINT Statusy_pk PRIMARY KEY (id_statusu)
);
```
Nazwa tabeli: Uczestnicy
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_uczestnika  |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
|id_rezerwacji|int |Klucz obcy z tabeli rezerwacje|
|imie|varchar(255)|Imie uczestnika wycieczki|
|nazwisko|varchar(255)|Nazwisko uczestnika wycieczki|
|telefon|varchar(255)|Numer telefonu uczestnika wycieczki|

```sql
CREATE TABLE Uczestnicy (
    id_uczestnika int  NOT NULL,
    id_rezerwacji int  NOT NULL,
    imie varchar(255)  NOT NULL,
    nazwisko varchar(255)  NOT NULL,
    telefon varchar(255)  NOT NULL,
    CONSTRAINT Uczestnicy_pk PRIMARY KEY (id_uczestnika)
);
```
Nazwa tabeli: Uczestnicy_uslugi
- Opis:

| Nazwa atrybutu | Typ | Opis/Uwagi |
| -------------- | --- | ---------- |
| id_uczestnika_uslugi  |  int   |    Klucz główny, niepowtarzalny, który się inkrementuje automatycznie        |
|id_uczestnika|int |Klucz obcy z tabeli Uczestnicy|
|id_rezerwacji_uslugi | int | Klucz obcy z tabeli Rezerwacje_uslugi |

```sql
CREATE TABLE Uczestnicy_uslugi (
    id_uczestnika_uslugi int  NOT NULL,
    id_uczestnika int  NOT NULL,
    id_rezerwacji_uslugi int  NOT NULL,
    CONSTRAINT Uczestnicy_uslugi_pk PRIMARY KEY (id_uczestnika_uslugi)
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
    id_uslugi int  NOT NULL,
    id_wycieczki int  NOT NULL,
    nazwa varchar(255)  NOT NULL,
    liczba_miejsc int  NOT NULL,
    cena decimal(10,2)  NOT NULL,
    CONSTRAINT Uslugi_pk PRIMARY KEY (id_uslugi)
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
|cena|double(10,2)|Cena wycieczki zł/gr|

- kod DDL

```sql
CREATE TABLE Wycieczki (
    id_wycieczki int  NOT NULL,
    id_miasta int  NOT NULL,
    data_wyjazdu datetime  NOT NULL,
    data_przyjazdu datetime  NOT NULL,
    miejsce_wyjazdu varchar(255)  NOT NULL,
    liczba_miejsc int  NOT NULL,
    cena double(10,2)  NOT NULL,
    CONSTRAINT Wycieczki_pk PRIMARY KEY (id_wycieczki)
);
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
