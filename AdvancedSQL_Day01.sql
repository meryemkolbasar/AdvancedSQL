--Single line comment
/*
Multi-line comment
*/
--*****************************************************
--*******VARIABLE DECLARATION****************************
--*****************************************************

do $$ --indicates an anonymous block
	--dollar sign: used to avoid quoting special characters
	
declare 
	counter integer := 1;
	first_name varchar(50) := 'Ahmet';
	last_name varchar(50) := 'Gok';
	payment numeric(4,2) := 20.5 ; --1st is total number of digits, 2nd is number of digits after the decimal
	
begin
	raise notice '% % % has been paid % USD',
			counter,
			first_name,
			last_name,
			payment;

end $$;

--Task 1: Define variables and print the sentence 'Ahmet and Mehmet gentlemen bought tickets for 120 TL.'

do $$
declare
	first_person varchar(50) := 'Ahmet';
	second_person varchar(50) := 'Mehmet';
	payment numeric(3) := 120;
begin
	raise notice '% and % gentlemen bought tickets for % TL.',
		first_person,
		second_person,
		payment;
end $$ ;



--*****************************************
-- ********  WAIT COMMAND **************
--*****************************************
do $$
declare
	create_at time := now();  --assignment
begin
	raise notice '%', create_at;
	perform pg_sleep(5);  --wait for 5 seconds
	raise notice '%', create_at;
end $$;

--*************************************************	
-- ******** COPYING DATA TYPE FROM TABLE ********
--*************************************************
do $$
declare
	film_title film.title%type; --selects datatype from title header in film table
	
begin
	--Get the name of the film with id 1
	select title 
	from film
	into film_title
	where id = 1;
	
	raise notice 'Film title with id : 1 %', film_title;

end $$;


--Task: Print the genre of the film with id 1
do $$
declare
	film_type film.type%type; 
	
begin
	--Get the genre of the film with id 1
	select type 
	from film
	into film_type
	where id = 1;
	
	raise notice 'Film type with id : 1 %', film_type;
end $$;

--Task: Print the name and genre of the film with id 1
do $$
declare
   film_type film.type%type; 
   film_title film.title%type;
begin 
   select type, title  
   from film 
   into film_type, film_title 
   where id = 1;
   
   raise notice 'Film type with id : 1 %, Film title with id : 1 %', film_type, film_title;
 
end $$;


--************************************************
-- ***************** ROW TYPE ********************
--************************************************
do $$
declare
	selected_actor actor%rowtype;
begin
	--Get the actor with id 1
	select *
	from actor
	into selected_actor
	where id = 1;
	
	raise notice 'The actor\'s name is : % %',
		selected_actor.first_name,
		selected_actor.last_name;
end $$;


--******************************************
-- ******* Record Type *********************
--******************************************
do $$
declare
	rec record;
begin
	select id, title, type
	from film
	into rec
	where id = 2;
	
	raise notice '% % %', rec.id, rec.title, rec.type;
end $$;


--******************************************
-- ******** NESTED BLOCK ********************
--******************************************

--If defining a block inside another block, it should be defined between the begin and end of that block
do $$
<<outer_block>>
declare  --outer block
	counter integer := 0;
begin
	counter := counter + 1;
	raise notice 'counter value : %',
		counter;
		
		declare --inner block
			counter integer := 0;
		
		begin --inner block
			counter := counter + 10;
			raise notice 'counter value in inner block : %', counter;
			raise notice 'counter value in outer block : %', outer_block.counter; --accessed using label
		
		end;  --end of inner block
end $$; --end of outer block


--*************************************
-- ********** Constant ****************
--*************************************

--selling_price := net_price * 0.1;

do $$
declare
	rate constant numeric := 0.1;
	net_price numeric := 20.5;
begin
	raise notice 'Selling price : %', net_price * (1 + rate);
	--attempting to change a constant value will result in an error
end $$;

--Can a constant value be assigned a value at runtime?
do $$
declare
	start_at constant time := now();
begin
	raise notice 'Blog start time : %', start_at;
end $$;
