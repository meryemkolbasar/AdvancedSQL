--***************************************************
-- ******************** If Statement ****************
--***************************************************

--syntax
/*
if condition then
	statement;
end if;
*/
-- Task : Find film with id 0, if not found, display a warning message

do $$
declare
	selected_film film%rowtype;
	input_film_id film.id%type := 0;
	
begin
	select * from film
	into selected_film
	where id = input_film_id;
	
	if not found then
		raise notice 'Film with id % not found.', input_film_id;
	end if;
	
end $$;


--*********************************************
-- ************** IF-THEN-ELSE ****************
--*********************************************

--syntax
/*
	if condition then
		statement;
	else
		alternative-statement;
	end if;
*/

--Task : Find film with id 2, if not found, display a warning message, otherwise, print its title

do $$
declare
	selected_film  film%rowtype;
	input_film_id film.id%type := 2;
begin
	select * from film
	into selected_film
	where id = input_film_id;
	
	
	if not found then
		raise notice 'Film with id % not found.', input_film_id;
	else
		raise notice 'Film title: %', selected_film.title;
	end if;
end $$;

--Task : If the film table is not empty (using count method), insert id and title into the film table for new data entry

do $$
declare
	count_rows integer;
begin
	select count(*)
	from film
	into count_rows;
	
	if count_rows > 0 then
	insert into film (id, title)
	values (5, 'Kara Şahin Düştü');
	raise notice 'New film added.';
	
	else
		raise notice 'Film table is empty.';
	end if;
	
end $$;

--*******************************************************
-- ************* IF-THEN-ELSE-IF ************************
--*******************************************************

--syntax
/*
	if condition_1 then
		statement_1;
	elseif condition_2 then
		statement_2;
		...
	elseif condition_n then
		statement_n;
		
	else
		else_statement;
	end if;
*/
/* 	Task : If film with id 1 exists ;
			if length < 50 then Short,
			if 50 < length < 120 then Medium,
			if length > 120 then Long
*/

do $$
declare
	v_film film%rowtype;
	len_description varchar(50);
begin
	select * from film
	into v_film
	where id = 3;
	
	if not found then
		raise notice 'Film not found.';
	else
		if v_film.length > 0 and v_film.length <= 50 then
			len_description = 'Short';
			elseif v_film.length > 50 and v_film.length < 120 then
			len_description = 'Medium';
			elsif v_film.length >= 120 then
			len_description = 'Long';
			else
			len_description = 'Undefined';
		end if;
		
	raise notice '% film duration : % ', v_film.title, len_description;
	end if;
			
end $$;

--***************************************************
-- ******** Case Statement **************************
--***************************************************

--syntax
/*
case search-expression
	when expression_1 {, expression_2...} then
	statements
	{....}
else
else_statements
end case;
*/

-- Task : Based on the film genre, determine if it's suitable for children and print the appropriate message

do $$
declare
	genre film.type%type;
	notification varchar(50);
begin
	select type
	from film
	into genre
	where id = 4;
	
	if found then
		case genre
			when 'Horror' then
				notification = 'Not suitable for children';
			when 'Adventure' then
				notification = 'Suitable for children';
			when 'Animation' then
				notification = 'Recommended for children';
			else
				notification = 'Undefined';
		end case;
		raise notice '%', notification;
	end if;
	
end $$;

--******************************************
--************** LOOP **********************
--******************************************

--syntax
/*
<<label>> --1.example
loop
	statement;
end loop;
--To end the loop, use if statement
<<label>> --2.example
loop
	statements;
	if condition then
	exit; --exits the loop
end loop;
--nested loop --3.example
<<outer>>
loop
	statements;
	<<inner>>
	loop
	....
	exit --inner
	end loop --end of inner loop
exit;
end loop; --end of outer loop
*/

-- Task : In Fibonacci series, display a specific number

do $$
declare
	n integer := 6;  --display nth number in fibonacci series
	counter integer := 0; --start from 0 to reach the desired index
	i integer := 0;  --1st from the previous 2 numbers
	j integer := 1;  --2nd from the previous 2 numbers
	fib integer := 0; --number to be displayed
begin
	if(n < 1) then
		fib := 0;
	end if;
	
	loop
		exit when counter = n;
		counter := counter + 1;
		select j, i+j into i, j; --assign j to i, i+j to j ---1,1,2,3,5,8...
	end loop;
	fib := i;
	raise notice '%th Fibonacci Number : %', n, fib;
end $$;
