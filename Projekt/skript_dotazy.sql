
/*1;1;15;Kolik bylo pøípadù daného typu*/
select type, COUNT(type) as pocPripaduStejnyhoTypu
from cases
group by type
order by pocPripaduStejnyhoTypu desc

/*1;2;100;Všechny osoby a jejich vìk*/
select person_id, first_name, last_name, DATEDIFF(YEAR, birthdate, GETDATE()) as vek
from person 
order by vek

/*1;3;100;Výpis všech osob v person*/
select person_id, first_name, last_name, fingerprint, phone_number, birthdate, sex, address_id
from person

/*1;4;70;Výpis všech osob v person*/
select address_id, city, postal_code, district, street
from adresa


/*2;1;5;Pøípady které nemají pøidìleného soudce nebo je vysetroval detektiv Miller a zaèali po roce 2000*/
select case_id, name, description, type, detective, judge, strat_date, end_date, criminal_history_id
from cases
where Year(strat_date) > 2000 and (judge is null or detective = 'Detective Miller')

/*2;2;17;pripady co v popisu (description) nemaji slovo of*/
select case_id, name, description, type, detective, judge, strat_date, end_date, criminal_history_id
from cases
where description not like ('% of %')

/*2;3;37;Vypis velkym písmem jen lidi co nemají telefonní èíslo v databázi*/
select person_id, UPPER(first_name) as jmeno, UPPER(last_name) as prijmeni
from person
where phone_number is null

/*2;4;50;vypis zeny v persons*/
select person_id, first_name, last_name, fingerprint, phone_number, birthdate, sex, address_id
from person
where sex = 'F'


/*3;1;20;lidi ktery byli svedky s in*/
select person_id
from person 
where person_id in (
	select person_person_id
	from witness
)
/*3;2;20;lidi ktery byli svedky s exist*/
select person_id
from person 
where exists (
	select *
	from witness
	where person.person_id = witness.person_person_id
)
/*3;3;20;lidi ktery byli svedky s intersect*/
select person_id
from person
intersect
select person_person_id
from witness

/*3;1;20;lidi ktery byli svedky s except*/
select person_id
from person
except 
select person_id
from person
where person_id != all(select person_person_id from witness)


/*4;1;8;kolik pripadu vzsetrovali jednotlivi detectivove*/
select detective, count(*) as pocPripadu
from cases
group by detective
order by pocPripadu

/*4;2;2;jmena detektivu ktery vsetrili vic jak 4 pripady*/
select detective
from cases
group by detective
having count(*) > 4

/*4;3;6;kolik pripadu soudili jednotlivi soudci*/
select judge, count(*) as pocPripadu
from cases
where judge is not null
group by judge
order by pocPripadu desc

/*4;4;1;pocet vzresenych (ukoncenych) pripadu*/
select count(*) as pocVyresenych
from cases
where end_date is not null


/*5;1;30; Ty co byli obzalovany s inner join*/
select distinct person.person_id, first_name, last_name
from person join defendant on person.person_id = defendant.person_id

/*5;2;30; Ty co byli obzalovany s in*/
select person.person_id, first_name, last_name
from person
where person_id in (
	select person_id
	from defendant
)

/*5;3;100;pro kaydou osobu poc yapisu v rejstriku*/
SELECT person.person_id, person.first_name, person.last_name, COALESCE(COUNT(criminal_history.criminal_history_id), 0) AS pocZapisu
FROM person
LEFT JOIN criminal_history ON person.person_id = criminal_history.person_person_id
GROUP BY person.person_id, person.first_name, person.last_name;

/*5;4;7;pocet zapisu v rejstriku pro osoby zacinajici na M*/
SELECT person.person_id, person.first_name, person.last_name, COALESCE(COUNT(criminal_history.criminal_history_id), 0) AS pocZapisu
FROM person
LEFT JOIN criminal_history ON person.person_id = criminal_history.person_person_id
where first_name like 'M%'
GROUP BY person.person_id, person.first_name, person.last_name;

/*6;1;100;kolikrat bzli svedkz a obyalovany*/
select person.person_id, first_name, last_name, (
	select count(*)
	from defendant
	where person.person_id = defendant.person_id
) as kolikratZalovany, (
	select count(*)
	from witness
	where person.person_id = witness.person_person_id
) as kolikratSvedcil
from person

/*6;2;30;Kolik maji pripady svedku adukazu*/
select cases.case_id, name, type, description, (
	select count(*)
	from evidence
	where cases.case_id = evidence.case_case_id
) as pocDukazu, (
	select count(*)
	from witness
	where cases.case_id = witness.witness_id
) as pocSvedku
from cases
order by pocDukazu desc
