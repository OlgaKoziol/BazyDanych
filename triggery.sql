CREATE TRIGGER t_update_available_places
ON Rezerwacje_wycieczek
AFTER INSERT
AS
BEGIN
    UPDATE Wycieczki
    SET liczba_miejsc = liczba_miejsc - i.Liczba_uczestnikow
    FROM Wycieczki w
    JOIN INSERTED i ON w.id_wycieczki = i.id_wycieczki;
END;

CREATE TRIGGER t_update_available_places_2
ON Rezerwacje_wycieczek
AFTER UPDATE
AS
BEGIN
    IF UPDATE(id_statusu)
    BEGIN
        UPDATE Wycieczki
        SET liczba_miejsc = liczba_miejsc + d.Liczba_uczestnikow
        FROM Wycieczki w
        JOIN DELETED d ON w.id_wycieczki = d.id_wycieczki
        JOIN INSERTED i ON d.id_rezerwacji = i.id_rezerwacji
        WHERE i.id_statusu = 0 AND d.id_statusu <> 0;
    END
END;