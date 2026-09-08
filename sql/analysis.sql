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

"Analiza ishoda meceva u procentima, domacin, gost i nereseno"
select "FullTimeResult", COUNT(*) as broj,
round(COUNT(*) * 100.0 / sum(COUNT(*)) over (),2) as procenat
from utakmice
group by "FullTimeResult"


"zuti kartoni"
with kartoni as (select "HomeTeam" as tim,"HomeYellowCards" as kartoni
from utakmice

union all

select "AwayTeam" as tim,"AwayYellowCards" as kartoni
from utakmice
)
select tim, SUM(kartoni) as broj_kartona
from kartoni
group by tim
order by broj_kartona DESC

"efikasnost timova, odnos golova i suteva u okvir"
WITH efikasnost AS (
    SELECT "HomeTeam" AS tim, "FullTimeHomeGoals" AS golovi, "HomeShotsOnTarget" AS sutevi
    FROM utakmice
    UNION ALL
    SELECT "AwayTeam" AS tim, "FullTimeAwayGoals" AS golovi, "AwayShotsOnTarget" AS sutevi
    FROM utakmice
)
SELECT 
    tim,
    SUM(golovi) AS broj_golova,
    SUM(sutevi) AS broj_suteva,
    ROUND(SUM(golovi) * 100.0 / SUM(sutevi), 2) || '%' AS efikasnost
FROM efikasnost
GROUP BY tim
ORDER BY efikasnost DESC

"prosecan broj golova po mecu po sezoni"
select "Season" as sezona,
ROUND(AVG("FullTimeHomeGoals" + "FullTimeAwayGoals"), 2) as prosek_golova
from utakmice
group by "Season" 
order by "Season"



"najvise crvenih kartona"
with crveni_kartoni as (
select "HomeTeam" as tim, "HomeRedCards" as kartoni
from utakmice
union all 
select "AwayTeam" as tim, "AwayRedCards" as kartoni
from utakmice
)
select tim, SUM(kartoni) as ukupno_kartona
from crveni_kartoni
group by tim
order by ukupno_kartona desc
limit 10;