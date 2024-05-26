-- Insert data into Kraje
INSERT INTO Kraje (id_kraju, nazwa_kraju) VALUES 
('PL', 'Poland'),
('DE', 'Germany'),
('FR', 'France');
('ES', 'Spain');
('GR', 'Greece');

-- Insert data into Miasta
INSERT INTO Miasta (id_kraju, nazwa_miasta) VALUES 
(1, 'PL', 'Warsaw'),
(2, 'DE', 'Berlin'),
(3, 'FR', 'Paris');
(4, 'ES', 'Barcelona');
(5, 'ES', 'Madrid');
(6, 'GR', 'Athens');
(7, 'PL', 'Cracow');

-- Insert data into Klienci
INSERT INTO Klienci (id_klienta, typ_klienta, imie, nazwisko, adres, miasto, kraj, telefon) VALUES 
(1, 'I', 'Jan', 'Kowalski', 'ul. Polna 10', 'Warsaw', 'Poland', '123456789'),
(2, 'F', 'Anna', 'Nowak', 'ul. Miodowa 2', 'Warsaw', 'Poland', '987654321');
(3, 'I', 'Piotr', 'Wójcik', 'ul. Czarnowiejska 20', 'Cracow', 'Poland', '321654987');
(4, 'I', 'Katarzyna', 'Nowakowska', 'ul. Reymonta 34', 'Cracow', 'Poland', '321987654');

-- Insert data into Wycieczki
INSERT INTO Wycieczki (id_miasta, data_wyjazdu, data_przyjazdu, miejsce_wyjazdu, liczba_miejsc, cena) VALUES 
(1, '2024-07-01 09:00:00', '2024-07-10 18:00:00', 'Warsaw', 30, 2000.00),
(2, '2024-08-01 09:00:00', '2024-08-10 18:00:00', 'Berlin', 20, 1500.00);
(3, '2024-07-15 09:00:00', '2024-07-25 18:00:00', 'Cracow', 10, 1200.00);
(4, '2024-08-15 09:00:00', '2024-08-25 18:00:00', 'Warsaw', 15, 1600.00);

-- Insert data into Statusy
INSERT INTO Statusy (id_statusu, status) VALUES 
(0, 'Cancelled'),
(1, 'Confirmed');

-- Insert data into Rezerwacje_wycieczek
INSERT INTO Rezerwacje_wycieczek (id_wycieczki, id_statusu, id_klienta, liczba_uczestnikow, suma_wycieczki) VALUES 
(1, 1, 1, 2, 4000.00),
(2, 1, 2, 1, 1500.00);
(1, 1, 3, 3, 6000.00);
(3, 1, 2, 1, 1200.00);
(4, 0, 4, 1, 16000.00);

-- Insert data into Uslugi
INSERT INTO Uslugi (id_wycieczki, nazwa, liczba_miejsc, cena) VALUES 
(1, 'City Tour', 30, 300.00),
(2, 'Museum Visit', 20, 100.00);
(3, 'Wawel Castle', 5, 150.00)

-- Insert data into Rezerwacje_uslugi
INSERT INTO Rezerwacje_uslugi (id_rezerwacji, id_uslugi, liczba_uczestnikow, cena, zaplacono) VALUES 
(1, 1, 2, 600.00, 600.00),
(2, 2, 1, 100.00, 100.00);

-- Insert data into Uczestnicy
INSERT INTO Uczestnicy (id_rezerwacji, imie, nazwisko, telefon) VALUES 
(1, 'Piotr', 'Kowalski', '123123123'),
(1, 'Maria', 'Kowalska', '321321321');
(2, 'Jan', 'Nowak', '111222333');
()

-- Insert data into Uczestnicy_uslugi
INSERT INTO Uczestnicy_uslugi (id_uczestnika, id_rezerwacji_uslugi) VALUES 
(1, 1),
(2, 1);

-- Insert data into Wplaty
INSERT INTO Wplaty (id_klienta, id_rezerwacji, wplata) VALUES 
(1, 1, 2000.00),
(2, 2, 1500.00);
