-- Dodanie rezerwacji:
exec AddReservation 1, 1, 1

-- wyświetlenie dodanej rezerwacji:
select * from Rezerwacje_wycieczek

-- wyświetlenie zmniejszonej liczby miejsc na wycieczke:
select * from Wycieczki

-- Dodanie uczestnika wycieczki:
exec addparticipant 28, "Jan", "Kowalski", 111

-- Dodanie uczestnika wycieczki (zakończone niepowodzeniem):
exec addparticipant 28, "Janina", "Kowalska", 111

-- Anulowanie rezerwacji:
exec CancelReservation 28

--zmieniony status wycieczki:
select * from Rezerwacje_wycieczek

--zwiekszona liczba miejsc na wycieczkę:
select * from Wycieczki

--wyświetlenie informacji o saldzie rezerwacji:
select * from v_saldo_rezerwacji
