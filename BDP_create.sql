
CREATE TABLE Kraje (
    id_kraju varchar(2)  NOT NULL,
    nazwa_kraju varchar(255)  NOT NULL,
    CONSTRAINT Kraje_pk PRIMARY KEY (id_kraju)
);




CREATE TABLE Miasta (
	id_miasta int IDENTITY(1,1) PRIMARY KEY,
    id_kraju varchar(2)  NOT NULL,
    nazwa_miasta varchar(255)  NOT NULL,
    FOREIGN KEY (id_kraju) REFERENCES Kraje(id_kraju)
);


INSERT INTO Miasta (id_kraju, nazwa_miasta) VALUES
('JP', 'Tokio'),
('CN', 'Pekin'),
('RU', 'Moskwa'),
('IN', 'Delhi'),
('BR', 'São Paulo'),
('CA', 'Toronto'),
('AU', 'Sydney'),
('KR', 'Seul'),
('IT', 'Rzym'),
('ES', 'Madryt'),
('MX', 'Meksyk'),
('ID', 'Dżakarta'),
('TR', 'Stambuł'),
('NL', 'Amsterdam'),
('SA', 'Rijad'),
('CH', 'Zurych'),
('SE', 'Sztokholm'),
('BE', 'Bruksela'),
('AT', 'Wiedeń'),
('PL', 'Warszawa');

INSERT INTO Kraje (id_kraju, nazwa_kraju) VALUES
('JP', 'Japonia'),
('CN', 'Chiny'),
('RU', 'Rosja'),
('IN', 'Indie'),
('BR', 'Brazylia'),
('CA', 'Kanada'),
('AU', 'Australia'),
('KR', 'Korea Południowa'),
('IT', 'Włochy'),
('ES', 'Hiszpania'),
('MX', 'Meksyk'),
('ID', 'Indonezja'),
('TR', 'Turcja'),
('NL', 'Holandia'),
('SA', 'Arabia Saudyjska'),
('CH', 'Szwajcaria'),
('SE', 'Szwecja'),
('BE', 'Belgia'),
('AT', 'Austria'),
('PL', 'Polska');



CREATE TABLE Wycieczki (
    id_wycieczki int IDENTITY(1,1) PRIMARY KEY,
    id_miasta int NOT NULL,
    data_wyjazdu datetime2(0) NOT NULL,
    data_przyjazdu datetime2(0) NOT NULL,
    miejsce_wyjazdu varchar(255) NOT NULL,
    liczba_miejsc int NOT NULL,
    cena decimal(10,2) NOT NULL
	FOREIGN KEY (id_miasta) REFERENCES Miasta(id_miasta)
);

INSERT INTO Wycieczki (id_miasta, data_wyjazdu, data_przyjazdu, miejsce_wyjazdu, liczba_miejsc, cena) VALUES
(1, '2024-06-01 07:45', '2024-06-15 19:30', 'Kraków', 50, 3500.00),
(5, '2024-07-01 09:30', '2024-07-15 21:15', 'Gdańsk', 45, 3200.00),
(9, '2024-08-01 10:15', '2024-08-15 22:00', 'Warszawa', 60, 4500.00),
(13, '2024-09-01 11:00', '2024-09-15 23:45', 'Wrocław', 40, 4000.00),
(17, '2024-10-01 12:45', '2024-10-15 13:30', 'Poznań', 55, 4800.00),
(3, '2024-11-01 14:30', '2024-11-15 15:15', 'Łódź', 70, 4200.00),
(7, '2024-12-01 15:15', '2024-12-15 17:00', 'Katowice', 30, 3900.00),
(11, '2025-01-01 16:00', '2025-01-15 17:45', 'Lublin', 65, 3100.00),
(15, '2025-02-01 17:45', '2025-02-15 19:30', 'Bydgoszcz', 75, 3500.00),
(19, '2025-03-01 18:30', '2025-03-15 20:15', 'Szczecin', 50, 4000.00),
(2, '2025-04-01 19:15', '2025-04-15 21:00', 'Białystok', 60, 4200.00),
(6, '2025-05-01 20:00', '2025-05-15 21:45', 'Rzeszów', 80, 4400.00),
(10, '2025-06-01 21:45', '2025-06-15 23:30', 'Gdynia', 55, 3600.00),
(14, '2025-07-01 22:30', '2025-07-15 10:15', 'Sopot', 65, 3700.00),
(18, '2025-08-01 23:15', '2025-08-15 11:00', 'Opole', 70, 4100.00),
(4, '2025-09-01 07:00', '2025-09-15 12:45', 'Radom', 40, 3300.00),
(8, '2025-10-01 08:45', '2025-10-15 13:30', 'Kielce', 75, 3500.00),
(12, '2025-11-01 09:30', '2025-11-15 14:15', 'Toruń', 60, 3900.00),
(16, '2025-12-01 10:15', '2025-12-15 15:00', 'Zielona Góra', 45, 3700.00),
(20, '2026-01-01 11:00', '2026-01-15 15:45', 'Olsztyn', 50, 4500.00);




CREATE TABLE Uslugi (
	id_uslugi int IDENTITY(1,1) PRIMARY KEY,
	id_wycieczki int NOT NULL,
    nazwa varchar(255)  NOT NULL,
    liczba_miejsc int  NOT NULL,
    cena decimal(10,2)  NOT NULL,
    FOREIGN KEY (id_wycieczki) REFERENCES Wycieczki(id_wycieczki)
);


INSERT INTO Uslugi (id_wycieczki, nazwa, liczba_miejsc, cena) VALUES
(1, 'Zwiedzanie świątyni Asakusa', 30, 50.00),
(2, 'Spacer po Parku Ibirapuera', 40, 45.00),
(17, 'Wycieczka do Pałacu Gyeongbokgung', 20, 55.00),
(18, 'Wizyta w Parku Narodowym Taman Mini', 20, 50.00),
(9, 'Spacer po Al-Turaif', 25, 55.00),
(13, 'Spacer po Parku Retiro', 30, 60.00),
(19, 'Wycieczka do Zoo w Zurychu', 20, 40.00),
(20, 'Zwiedzanie Starego Miasta', 20, 50.00),
(3, 'Zwiedzanie Koloseum', 35, 70.00),
(4, 'Wizyta w Pałacu Topkapi', 35, 65.00),
(5, 'Zwiedzanie Muzeum Vasa', 35, 75.00),
(10, 'Spacer po Pałacu Schönbrunn', 25, 65.00),
(11, 'Wycieczka po Zakazanym Mieście', 25, 70.00),
(12, 'Wycieczka do CN Tower', 30, 65.00),
(6, 'Zwiedzanie Kremla', 20, 60.00),
(7, 'Rejs statkiem po Zatoce Sydney', 25, 80.00),
(8, 'Zwiedzanie piramid w Teotihuacán', 25, 75.00),
(14, 'Zwiedzanie Muzeum Van Gogha', 30, 70.00),
(15, 'Wizyta w Atomium', 30, 60.00),
(16, 'Wizyta w Czerwonym Fort', 35, 55.00)


CREATE TABLE Statusy (
    id_statusu int  NOT NULL,
    status varchar(255)  NOT NULL,
    CONSTRAINT Statusy_pk PRIMARY KEY (id_statusu)
);

insert into Statusy (id_statusu,status) values (0,'Niedostepne'),(1,'Dostepne')

select * from Statusy


CREATE TABLE Rezerwacje_wycieczek (
    id_rezerwacji int IDENTITY(1,1) PRIMARY KEY,
    id_wycieczki int  NOT NULL,
    id_klienta int  NOT NULL,
    id_statusu int  NOT NULL,
    liczba_uczestnikow int  NOT NULL,
    cena decimal(10,2)  NOT NULL,
    zaplacono decimal(10,2)  NOT NULL,
	FOREIGN KEY (id_wycieczki) REFERENCES Wycieczki(id_wycieczki),
	FOREIGN KEY (id_klienta) REFERENCES Klienci(id_klienta),
	FOREIGN KEY (id_statusu) REFERENCES Statusy(id_statusu)
);


INSERT INTO Rezerwacje_wycieczek (id_wycieczki, id_klienta, id_statusu, liczba_uczestnikow, cena, zaplacono)
VALUES
(1, 1, 1, 2, 3500.00, 1000.00),
(5, 2, 1, 3, 4800.00, 1500.00),
(9, 3, 1, 4, 3500.00, 2000.00),
(13, 4, 1, 2, 3600.00, 1800.00),
(17, 5, 1, 3, 3500.00, 2300.00),
(3, 6, 1, 4, 4500.00, 1900.00),
(7, 7, 1, 2, 3900.00, 1800.00),
(11, 8, 1, 3, 4200.00, 1200.00),
(15, 9, 1, 4, 4100.00, 1600.00),
(19, 10, 1, 2, 3700.00, 2000.00),
(2, 11, 1, 3, 3200.00, 1700.00),
(6, 12, 1, 4, 4200.00, 2100.00),
(10, 13, 1, 2, 4000.00, 1400.00),
(14, 14, 1, 3, 3700.00, 1800.00),
(18, 15, 1, 4, 3900.00, 2200.00),
(4, 16, 1, 2, 4000.00, 1600.00),
(8, 17, 1, 3, 3500.00, 2000.00),
(12, 18, 1, 4, 3600.00, 1900.00),
(16, 19, 1, 2, 3500.00, 1700.00),
(20, 20, 1, 3, 4500.00, 2100.00);


CREATE TABLE Uczestnicy (
    id_uczestnika int IDENTITY(1,1) PRIMARY KEY,
    id_rezerwacji int  NOT NULL,
    imie varchar(255)  NOT NULL,
    nazwisko varchar(255)  NOT NULL,
    telefon varchar(255)  NOT NULL,
    FOREIGN KEY (id_rezerwacji) REFERENCES Rezerwacje_wycieczek(id_rezerwacji)
);


INSERT INTO Uczestnicy (id_rezerwacji, imie, nazwisko, telefon)
VALUES
    (1, 'Anna', 'Nowak', '123456789'),
    (1, 'Piotr', 'Kowalski', '987654321'),
    (5, 'Joanna', 'Wiśniewska', '555123456'),
    (5, 'Michał', 'Lewandowski', '555987654'),
    (5, 'Katarzyna', 'Dąbrowska', '555789123'),
    (9, 'Jan', 'Woźniak', '111222333'),
    (9, 'Małgorzata', 'Kamińska', '444555666'),
    (9, 'Andrzej', 'Kowalczyk', '777888999'),
    (9, 'Agnieszka', 'Zielińska', '111444777'),
    (13, 'Marek', 'Szymański', '222333444'),
    (13, 'Beata', 'Woźniak', '555333111'),
    (17, 'Krzysztof', 'Kozłowski', '444111777'),
    (17, 'Elżbieta', 'Jankowska', '222555888'),
    (17, 'Adam', 'Mazur', '333888999'),
    (3, 'Marta', 'Wojciechowska', '123123123'),
    (3, 'Paweł', 'Kwiatkowski', '456456456'),
    (3, 'Justyna', 'Kaczmarek', '789789789'),
    (3, 'Tomasz', 'Piotrowski', '321321321'),
    (7, 'Monika', 'Grabowska', '654654654'),
    (7, 'Rafał', 'Nowakowski', '987987987'),
    (11, 'Michał', 'Wróbel', '357357357'),
    (11, 'Agata', 'Michalska', '246246246'),
    (11, 'Robert', 'Adamczyk', '135135135'),
    (15, 'Anna', 'Król', '531531531'),
    (15, 'Kamil', 'Sikora', '642642642'),
    (15, 'Magdalena', 'Krajewska', '753753753'),
    (15, 'Kacper', 'Wojcik', '864864864'),
    (19, 'Julia', 'Nowicka', '975975975'),
    (19, 'Jakub', 'Witkowski', '123987654'),      
    (2, 'Weronika', 'Kowal', '111222333'),
    (2, 'Ryszard', 'Michalak', '444555666'),
    (2, 'Natalia', 'Nowakowska', '777888999'),
    (6, 'Dawid', 'Zielinski', '111444777'),
    (6, 'Angelika', 'Lewandowska', '555333111'),
    (6, 'Kornelia', 'Duda', '444111777'),
    (6, 'Łukasz', 'Zając', '789456123'),
    (10, 'Artur', 'Mazur', '222555888'),
    (10, 'Agnieszka', 'Wojciechowska', '333888999'),   
    (14, 'Marcin', 'Kaczmarek', '456456456'),
    (14, 'Karolina', 'Nowakowska', '789789789'),
    (14, 'Mateusz', 'Wiśniewski', '321321321'),
    (18, 'Kamil', 'Zając', '123123123'),
    (18, 'Dominik', 'Kowalczyk', '654654654'),
    (18, 'Klaudia', 'Szymańska', '987987987'),
    (18, 'Szymon', 'Wojciechowski', '159159159'),
    (4, 'Zuzanna', 'Lewandowska', '357357357'),
    (4, 'Konrad', 'Jankowski', '246246246'),   
    (8, 'Jan', 'Mazur', '531531531'),
    (8, 'Aleksandra', 'Kaczmarek', '642642642'),
    (8, 'Kacper', 'Pawlak', '753753753'),
    (12, 'Wiktoria', 'Nowak', '864864864'),
    (12, 'Piotr', 'Kowalczyk', '975975975'),
    (12, 'Agnieszka', 'Kowalik', '123987654'),
    (12, 'Ewa', 'Kowalska', '135135135'),
    (16, 'Adrian', 'Nowak', '456789123'),
    (16, 'Weronika', 'Kaczmarek', '789456123'),
    (20, 'Hubert', 'Szymański', '987654321'),
    (20, 'Oliwia', 'Jastrzębska', '456789123'),
    (20, 'Karolina', 'Pawłowska', '159159159');



    CREATE TABLE Rezerwacje_uslugi (
    id_rezerwacji_uslugi int IDENTITY(1,1) PRIMARY KEY,
    id_rezerwacji int  NOT NULL,
    id_uslugi int  NOT NULL,
    liczba_uczestnikow int  NOT NULL,
    cena decimal(10,2)  NOT NULL,
    zaplacono decimal(10,2)  NOT NULL,
    FOREIGN KEY (id_rezerwacji) REFERENCES Rezerwacje_wycieczek(id_rezerwacji),
	FOREIGN KEY (id_uslugi) REFERENCES Uslugi(id_uslugi)
);


CREATE TABLE Uczestnicy_uslugi (
    id_uczestnika_uslugi int IDENTITY(1,1) PRIMARY KEY,
    id_uczestnika int  NOT NULL,
    id_rezerwacji_uslugi int  NOT NULL,
	FOREIGN KEY (id_uczestnika) REFERENCES Uczestnicy(id_uczestnika),
	FOREIGN KEY (id_rezerwacji_uslugi) REFERENCES Rezerwacje_uslugi(id_rezerwacji_uslugi)
);