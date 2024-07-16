--Task 1 : If the number of films in the film table is less than 10, print "Film count is low", otherwise print "Film count is sufficient"

do $$
declare
	count_films integer := 0;
begin
	select count(*)
	into count_films
	from film;
	
	if count_films < 10 then
		raise notice 'Film count is low';
	else
		raise notice 'Film count is sufficient';
	end if;
end $$;

-- Task 2: Define a variable named user_age of integer data type with a default value,
-- using an if statement, print "Access Granted" if the entered value is greater than 18, otherwise print "Access Denied"

do $$
declare
	user_age integer := 16;
begin
	if user_age > 18 then
		raise notice 'Access Granted';
	else
		raise notice 'Access Denied';
	end if;
end $$;

-- (Assignment) Task 3: Define two variables named a and b of integer type with default values,
-- if the value of a is greater than b, print "a is greater than b", for the opposite condition, print "b is greater than a",
-- if both values are equal, print "a is equal to b":

do $$
declare
	a integer := 15;
	b integer := 10;
begin
	if a > b then
		raise notice '% is greater than %', 'a', 'b';
	elsif b > a then
		raise notice '% is greater than %', 'b', 'a';
	else
		raise notice 'a is equal to b';
	end if;
end $$;


--**************************************************
-- ************ WHILE LOOP *************************
--**************************************************
--syntax :
while condition loop
	statements;
end loop;

-- Task : Print counter values from 1 to 4

do $$
declare
	n integer := 4;
	counter integer := 0;
begin
	while counter < n loop
		counter := counter + 1;
		raise notice '%', counter;
	end loop;
end $$;

-- Task : Define a variable named sayac, increment the counter within the loop,
-- print the value of sayac in each iteration and exit the loop when sayac equals 5

do $$
declare
	sayac integer := 0;
begin
	loop
		raise notice '%', sayac;
		sayac := sayac + 1;
		exit when sayac = 5;
	end loop;
end $$;

--***********************************************
-- **************  FOR LOOP *********************
--***********************************************
--syntax :
FOR loop_counter IN {reverse} FROM ..TO {by step} LOOP
	statement;
	END LOOP;
	
--Example (in)
do $$
begin
	for counter in 1..5 loop
		raise notice 'counter : %', counter;
	end loop;
end $$;

--No need for declare if there are no extra variables

begin
	for counter in reverse 5..1 loop
		raise notice 'counter : %', counter;
	end loop;
end $$;


-- Task : Print numbers from 10 to 20 in steps of 2 :

--Example (by)
do $$
begin
	for counter in 10..20 by 2 loop
		raise notice 'counter : %', counter;
	end loop;
end $$;

--Example : Using for loop in the database
--syntax :
FOR target IN query loop --target variable assigned from query result
	statements
END LOOP;

-- Task : Display the top 2 longest films when sorted by length

DO $$
declare
 	f record;
begin
	for f in select title, length
		from film
		order by length desc
		limit 2
	loop
		raise notice '% - % minutes', f.title, f.length;
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

-- Task : Print the top 10 individuals with the highest manager ID

do $$
declare
	f record;
begin
	for f in select full_name, manager_id
	from employees
	order by manager_id desc
	limit 10
	
	loop
		raise notice '% - % ', f.manager_id, f.full_name;
	end loop;
end $$;

--*****************************************
-- ***************** EXIT *****************
--*****************************************
--1st method :
exit when counter > 10;
2nd method
if counter > 10 then
	exit;
end if;

--*****************************************
-- ************ CONTINUE ******************
--*****************************************

--Syntax :
continue {loop_label} {when condition}....--is applied when the condition is met
-- Task : Print odd numbers from 1 to 10 using continue statement

-- ********************************************************	
--  ********************* FUNCTION ***********************
-- ********************************************************

--syntax :
/*
create {or replace} function function_name(param_list)-- if there is an existing function, replace must be used
	returns return_type  --specify the return data type
	language plpgsql    --specify the procedural language used Pl-Java ,Pl-Python
	as --function defined above as is the statement
$$
declare
--variable declaration
begin
--logic
end $$;
	
*/

-- Write a function that returns the count of films in our film table within a certain length range

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

--To use the above function
select get_film_count(40,120);
