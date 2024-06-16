CREATE OR ALTER PROCEDURE AddReservation
    @p_id_wycieczki INT,
    @p_id_klienta INT,
    @p_liczba_uczestnikow INT,
    @p_data_rezerwacji DATE = NULL
AS
BEGIN
    DECLARE @p_id_rezerwacji INT;
    IF @p_data_rezerwacji IS NULL
    BEGIN
        SET @p_data_rezerwacji = CONVERT(DATE, GETDATE());
    END
    INSERT INTO Rezerwacje_wycieczek (id_wycieczki, id_klienta, id_statusu, liczba_uczestnikow, data_rezerwacji)
    VALUES (@p_id_wycieczki, @p_id_klienta, 1, @p_liczba_uczestnikow, @p_data_rezerwacji);    
    SET @p_id_rezerwacji = SCOPE_IDENTITY();
    SELECT @p_id_rezerwacji AS id_rezerwacji;
END;

CREATE OR ALTER PROCEDURE AddParticipant
    @p_id_rezerwacji INT,
    @p_imie varchar(255),
    @p_nazwisko varchar(255),
    @p_telefon INT
AS
BEGIN
    DECLARE @p_id_uczestnika INT;
    IF (select count(*) from Uczestnicy where id_rezerwacji = @p_id_rezerwacji) < (select Liczba_uczestnikow from Rezerwacje_wycieczek where id_rezerwacji = @p_id_rezerwacji)
    BEGIN
        INSERT INTO Uczestnicy (id_rezerwacji, imie, nazwisko, telefon)
        VALUES (@p_id_rezerwacji, @p_imie, @p_nazwisko, @p_telefon);    
        SET @p_id_uczestnika = SCOPE_IDENTITY();
        SELECT @p_id_uczestnika AS id_uczestnika;
    END;
    ELSE
    BEGIN
        SELECT 'Nie można dodać kolejnego uczestnika do tej rezerwacji' AS Message;
    END
END;

CREATE OR ALTER PROCEDURE CancelReservation
    @p_id_rezerwacji INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Rezerwacje_wycieczek WHERE id_rezerwacji = @p_id_rezerwacji)
    BEGIN
        UPDATE Rezerwacje_wycieczek
        SET id_statusu = 0
        WHERE id_rezerwacji = @p_id_rezerwacji;
        SELECT 'Reservation canceled successfully.' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'Reservation not found.' AS Message;
    END
END;