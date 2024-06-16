create or alter function f_aktywne_wycieczki (@data date)
returns table  
as return (  
select *
from wycieczki 
where data_rozpoczecia_rez <= @data and liczba_miejsc > 0
);

create function f_rezerwacje_wycieczek_w_danym_miesiacu (@month int)  
returns table  
as return (  
select *
from Rezerwacje_wycieczek  
where month(data_rezerwacji) = @month 
);

create function f_wplaty_w_danym_czasie (@date_1 date, @date_2 date)  
returns table  
as return (  
select *  
from wplaty  
where data_wplaty > @date_1 and data_wplaty < @date_2
);