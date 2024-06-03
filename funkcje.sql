create function f_wplaty_w_danym_miesiacu (@month int)  
returns table  
as return (  
select *  
from wplaty  
where month(data_wplaty) = @month 
);

create function f_rezerwacje_wycieczek_w_danym_miesiacu (@month int)  
returns table  
as return (  
select *
from Rezerwacje_wycieczek  
where month(data_rezerwacji) = @month 
);

create function f_aktywne_wycieczki (@data date)
returns table  
as return (  
select *
from wycieczki 
where data_rozpoczecia_rez <= @data
);