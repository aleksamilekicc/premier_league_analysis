with pobede as (select "HomeTeam" as tim
from utakmice
where "FullTimeResult" = 'H' 

union all

select "AwayTeam" as tim
from utakmice
where "FullTimeResult" = 'A')

select tim, COUNT(*) as broj_pobeda
from pobede
group by tim
order by broj_pobeda DESC