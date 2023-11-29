--Task 1 : Film tablosundaki film sayisi 10 dan az ise "Film sayisi az" yazdirin,
--10 dan cok ise "Film sayisi yeterli" yazdiralim

do $$
declare
	sayi integer :=0;
begin
	select count(*)
	from film
	into sayi;
	
	if sayi<10 then
		raise notice 'Film sayisi 10 dan az';
		
	else
		raise notice 'Film sayisi yeterli';
	end if;
end $$;

-- Task 2: user_age isminde integer data turunde bir degisken tanimlayip default olarak bir deger verelim,
--If yapisi ile girilen deger 18 den buyuk ise Access Granted, kucuk ise Access Denied yazdiralim

do $$
declare
	user_age integer :=0;
begin
	if user_age>18 then
		raise notice 'Access Granted';
		
	else
		raise notice 'Access Denied';
	end if;
end $$;

-- (Odev)Task 3: a ve b isimli integer turunde 2 degisken tanimlayip default degerlerini verelim,
--eger a nin degeri b den buyukse "a , b den buyuktur" yazalim, tam tersi durum icin "b, a dan buyuktur" yazalim,
--iki deger birbirine esit ise " a,  b'ye esittir" yazalim:



--**************************************************
-- ************ WHILE LOOP *************************
--**************************************************
--syntax :
while condition loop
	statements;
end loop;

-- Task : 1 dan 4 e kadar counter degerlerini ekrana basalim

do $$
declare
	n integer :=4;
	counter integer :=0;
begin
	while counter<n loop
		counter=counter+1;
	raise notice '%',counter;
	end loop;
end $$;

-- Task : sayac isminde bir degisken olusturun ve dongu icinde sayaci birer artirin,
--	her dongude sayacin degerini ekrana basin ve sayac degeri 5 e esit olunca donguden cikin

do $$
declare
	sayac integer :=0;
begin
	loop
		raise notice '%',sayac;
		sayac=sayac+1;
		exit when sayac =5;
	end loop;
end $$;

--***********************************************
-- **************  FOR LOOP *********************
--***********************************************
--syntax :
FOR loop_counter IN {reverse} FROM ..TO {by step} LOOP
	statement;
	END LOOP;
	
--Ornek (in)
do $$
begin
	for counter in 1..5 loop
		raise notice 'counter : %',counter;
	end loop;
end $$;

--Ekstra degisken yok ise declare yazilmayabilir


do $$
declare
begin
	for counter in reverse 5..1 loop
		raise notice 'counter : %',counter;
	end loop;
end $$;


-- Task : 10 dan 20 ye kadar 2 ser 2 ser ekrana sayilari basalim :

--Ornek (by)
do $$
begin
	for counter in 1..10 by 2 loop
		raise notice 'counter : %',counter;
	end loop;
end $$;

do $$
begin
	for counter in 10..20 by 2 loop
		raise notice 'counter : %',counter;
	end loop;
end $$;

--ornek : DB de for loop kullanimi
--syntax :
FOR target IN query loop --target hedef degisken targeta atanıyor
	statements
END LOOP;

-- Task : Filmleri suresine gore siraladigimizda en uzun 2 filmi gosterelim

DO $$
declare
 	f record;
begin
	for f in select title,length
		from film
		order by length desc
		limit 3
	loop
		raise notice '% % dakika',f.title,f.length;
	end loop;
end $$;


CREATE TABLE employees (
  employee_id serial PRIMARY KEY,
  full_name VARCHAR NOT NULL,
  manager_id INT
);

INSERT INTO employees (
  employee_id,
  full_name,
  manager_id
)
VALUES
  (1, 'M.S Dhoni', NULL),
  (2, 'Sachin Tendulkar', 1),
  (3, 'R. Sharma', 1),
  (4, 'S. Raina', 1),
  (5, 'B. Kumar', 1),
  (6, 'Y. Singh', 2),
  (7, 'Virender Sehwag ', 2),
  (8, 'Ajinkya Rahane', 2),
  (9, 'Shikhar Dhawan', 2),
  (10, 'Mohammed Shami', 3),
  (11, 'Shreyas Iyer', 3),
  (12, 'Mayank Agarwal', 3),
  (13, 'K. L. Rahul', 3),
  (14, 'Hardik Pandya', 4),
  (15, 'Dinesh Karthik', 4),
  (16, 'Jasprit Bumrah', 7),
  (17, 'Kuldeep Yadav', 7),
  (18, 'Yuzvendra Chahal', 8),
  (19, 'Rishabh Pant', 8),
  (20, 'Sanju Samson', 8);

-- Task :  manager ID si en buyuk ilk 10 kisiyi ekrana yazalim

do $$
declare
	f record;
begin
	for f in select full_name, manager_id
	from employees
	order by manager_id desc
	limit 10
	
	loop
		raise notice '% - % ',f.manager_id,f.full_name;
	end loop;
end $$;

--*****************************************
-- ***************** EXIT *****************
--*****************************************
--1.yol :
exit when counter > 10;
2.yol
if counter > 10 then
	exit;
end if;

--*****************************************
-- ************ CONTINUE ******************
--*****************************************

--Syntax :
continue {loop_label} {when condition}....--verilen condition saglandiginda gecer
-- Task : continue yapisi kullanarak 1 dahil 10 a kadar olan tek sayilari ekrana basalim

-- ********************************************************	
--  ********************* FUNCTION ***********************
-- ********************************************************

--syntax :
/*
create {or replace} function function_name(param_list)-- mevcut bir fonksiyon varsa replace kullanilmali
	returns return_type  --donen data turunu belirityorum
	language plpgsql    --kullanilan procedurel dil tanimalniyor Pl-Java ,Pl-Pyton
	as --yukarida fonksiyon tanimalndi as ile yapilacak islemlere gecilir
	
$$
declare
--variable declaration
begin
--logic
end $$;
	
*/

-- Film tablomuzdaki filmlerin sayisini getiren bir fonksiyon yazalim

create function get_film_count(len_from int, len_to int)
	returns int
	language plpgsql
	as
$$
declare
	film_count integer;
begin
	select count(*)
	into film_count
	from film
	where length between len_from and len_to;
	
	return film_count;
end $$;

--yukaridaki fonksiyonu kullanmak icin
select get_film_count(40,120);






















