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

"Koji tim je dao najvise golova ukupno"
with golovi as (select "HomeTeam" as tim,"FullTimeHomeGoals" as golovi
from utakmice

union all

select "AwayTeam" as tim,"FullTimeAwayGoals" as golovi
from utakmice
)

select tim, SUM(golovi) as ukupno_golova
from golovi
group by tim order by ukupno_golova DESC