-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-05-14 19:40:47.902

-- tables
-- Table: Klienci
CREATE TABLE Klienci (
    id_klienta int  NOT NULL,
    imie varchar(255)  NOT NULL,
    nazwisko varchar(255)  NOT NULL,
    adres varchar(255)  NOT NULL,
    telefon varchar(255)  NOT NULL,
    CONSTRAINT Klienci_pk PRIMARY KEY (id_klienta)
);

-- Table: Kraje
CREATE TABLE Kraje (
    id_kraju varchar(2)  NOT NULL,
    nazwa_kraju varchar(255)  NOT NULL,
    CONSTRAINT Kraje_pk PRIMARY KEY (id_kraju)
);

-- Table: Miasta
CREATE TABLE Miasta (
    id_miasta int  NOT NULL,
    id_kraju varchar(2)  NOT NULL,
    nazwa_miasta varchar(255)  NOT NULL,
    CONSTRAINT Miasta_pk PRIMARY KEY (id_miasta)
);

-- Table: Rererwacje_wycieczek
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

-- Table: Rezerwacje_uslugi
CREATE TABLE Rezerwacje_uslugi (
    id_rezerwacji_uslugi int  NOT NULL,
    id_rezerwacji int  NOT NULL,
    id_uslugi int  NOT NULL,
    liczba_uczestnikow int  NOT NULL,
    cena decimal(10,2)  NOT NULL,
    zaplacono decimal(10,2)  NOT NULL,
    CONSTRAINT Rezerwacje_uslugi_pk PRIMARY KEY (id_rezerwacji_uslugi)
);

-- Table: Statusy
CREATE TABLE Statusy (
    id_statusu int  NOT NULL,
    status varchar(255)  NOT NULL,
    CONSTRAINT Statusy_pk PRIMARY KEY (id_statusu)
);

-- Table: Uczestnicy
CREATE TABLE Uczestnicy (
    id_uczestnika int  NOT NULL,
    id_rezerwacji int  NOT NULL,
    imie varchar(255)  NOT NULL,
    nazwisko varchar(255)  NOT NULL,
    telefon varchar(255)  NOT NULL,
    CONSTRAINT Uczestnicy_pk PRIMARY KEY (id_uczestnika)
);

-- Table: Uczestnicy_uslugi
CREATE TABLE Uczestnicy_uslugi (
    id_uczestnika_uslugi int  NOT NULL,
    id_uczestnika int  NOT NULL,
    id_rezerwacji_uslugi int  NOT NULL,
    CONSTRAINT Uczestnicy_uslugi_pk PRIMARY KEY (id_uczestnika_uslugi)
);

-- Table: Uslugi
CREATE TABLE Uslugi (
    id_uslugi int  NOT NULL,
    id_wycieczki int  NOT NULL,
    nazwa varchar(255)  NOT NULL,
    liczba_miejsc int  NOT NULL,
    cena decimal(10,2)  NOT NULL,
    CONSTRAINT Uslugi_pk PRIMARY KEY (id_uslugi)
);

-- Table: Wycieczki
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

-- foreign keys
-- Reference: Miasta_Kraje (table: Miasta)
ALTER TABLE Miasta ADD CONSTRAINT Miasta_Kraje FOREIGN KEY Miasta_Kraje (id_kraju)
    REFERENCES Kraje (id_kraju);

-- Reference: Rererwacje_Klienci (table: Rererwacje_wycieczek)
ALTER TABLE Rererwacje_wycieczek ADD CONSTRAINT Rererwacje_Klienci FOREIGN KEY Rererwacje_Klienci (id_klienta)
    REFERENCES Klienci (id_klienta);

-- Reference: Rererwacje_Statusy (table: Rererwacje_wycieczek)
ALTER TABLE Rererwacje_wycieczek ADD CONSTRAINT Rererwacje_Statusy FOREIGN KEY Rererwacje_Statusy (id_statusu)
    REFERENCES Statusy (id_statusu);

-- Reference: Rererwacje_Wycieczki (table: Rererwacje_wycieczek)
ALTER TABLE Rererwacje_wycieczek ADD CONSTRAINT Rererwacje_Wycieczki FOREIGN KEY Rererwacje_Wycieczki (id_wycieczki)
    REFERENCES Wycieczki (id_wycieczki);

-- Reference: Rezerwacje_uslugi_Rererwacje_wycieczek (table: Rezerwacje_uslugi)
ALTER TABLE Rezerwacje_uslugi ADD CONSTRAINT Rezerwacje_uslugi_Rererwacje_wycieczek FOREIGN KEY Rezerwacje_uslugi_Rererwacje_wycieczek (id_rezerwacji)
    REFERENCES Rererwacje_wycieczek (id_rezerwacji);

-- Reference: Rezerwacje_uslugi_Uslugi (table: Rezerwacje_uslugi)
ALTER TABLE Rezerwacje_uslugi ADD CONSTRAINT Rezerwacje_uslugi_Uslugi FOREIGN KEY Rezerwacje_uslugi_Uslugi (id_uslugi)
    REFERENCES Uslugi (id_uslugi);

-- Reference: Uczestnicy_Rererwacje_wycieczek (table: Uczestnicy)
ALTER TABLE Uczestnicy ADD CONSTRAINT Uczestnicy_Rererwacje_wycieczek FOREIGN KEY Uczestnicy_Rererwacje_wycieczek (id_rezerwacji)
    REFERENCES Rererwacje_wycieczek (id_rezerwacji);

-- Reference: Uczestnicy_uslugi_Rezerwacje_uslugi (table: Uczestnicy_uslugi)
ALTER TABLE Uczestnicy_uslugi ADD CONSTRAINT Uczestnicy_uslugi_Rezerwacje_uslugi FOREIGN KEY Uczestnicy_uslugi_Rezerwacje_uslugi (id_rezerwacji_uslugi)
    REFERENCES Rezerwacje_uslugi (id_rezerwacji_uslugi);

-- Reference: Uczestnicy_uslugi_Uczestnicy (table: Uczestnicy_uslugi)
ALTER TABLE Uczestnicy_uslugi ADD CONSTRAINT Uczestnicy_uslugi_Uczestnicy FOREIGN KEY Uczestnicy_uslugi_Uczestnicy (id_uczestnika)
    REFERENCES Uczestnicy (id_uczestnika);

-- Reference: Uslugi_Wycieczki (table: Uslugi)
ALTER TABLE Uslugi ADD CONSTRAINT Uslugi_Wycieczki FOREIGN KEY Uslugi_Wycieczki (id_wycieczki)
    REFERENCES Wycieczki (id_wycieczki);

-- Reference: Wycieczki_Miasta (table: Wycieczki)
ALTER TABLE Wycieczki ADD CONSTRAINT Wycieczki_Miasta FOREIGN KEY Wycieczki_Miasta (id_miasta)
    REFERENCES Miasta (id_miasta);

-- End of file.

