--***************************************************
-- ******************** If Statement ****************
--***************************************************

--syntax
/*
if condition then
	statement;
end if;
*/
-- Task : 0 id li filmi bulalım eğer yoksa ekrana uyarı yazısı verelim

do $$
declare
	selected_film film%rowtype;
	input_film_id film.id%type :=0;
	
begin
	select * from film
	into selected_film
	where id = input_film_id;
	
	if not found then
		raise notice 'Girdiginiz id li film bulunamadi : %',input_film_id;
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

--Task : 2 id li filmi bulalım, eğer yoksa ekrana uyarı yazalım, varsa da ismini ekrana yazalım

do $$
declare
	selected_film  film%rowtype;
	input_film_id film.id%type :=2;
begin
	select * from film
	into selected_film
	where id=input_film_id;
	
	
	if not found then
		raise notice 'Girmis oldugunuz id li film bulunamadi : %',input_film_id;
	else
		raise notice 'Filmin ismi : %',selected_film.title;
	end if;
end $$;

--Task : Eğer film tablosu bos degilse (count methodu ile) film tablosuna id, title
--degerlerini ayarlayarak yeni veri girisi yapan kodu yazalim

do $$
declare
	count_rows integer;
begin
	select count(*)
	from film
	into count_rows;
	
	if count_rows > 0 then
	insert into film (id,title)
	values (5,'Kara Şahin Düştü');
	raise notice 'Yeni film eklendi';
	
	else
		raise notice 'Film tablosu boş';
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
/* 	Task : 1 id li film varsa ;
			süresi 50 dakikanın altında ise Short,
			50<length<120 ise Medium,
			length>120 ise Long yazalım
*/

do $$
declare
	v_film film%rowtype;
	len_description varchar(50);
begin
	select * from film
	into v_film
	where id=3;
	
	if not found then
		raise notice 'Film bulunamadi';
	else
		if v_film.length > 0 and v_film.length <=50 then
			len_description='Kisa';
			elseif v_film.length>50 and v_film.length <120 then
			len_description='Orta';
			elsif v_film.length >= 120 then
			len_description='Uzun';
			else
			len_description='Tanimsiz';
		end if;
		
	raise notice '% filminin suresi : % ',v_film.title, len_description;
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

-- Task : Filmin türüne göre çocuklara uygun olup olmadığını ekrana yazalım

do $$
declare
	tur film.type%type;
	uyari varchar(50);
begin
	select type
	from film
	into tur
	where id=4;
	
	if found then
		case tur
			when 'Korku' then
				uyari='Çocuklar için uygun değil';
			when 'Macera' then
				uyari='Çocuklar için uygun';
			when 'Animasyon' then
				uyari='Çocuklar için tavsiye edilir';
			else
				uyari='Tanimlanmadi';
		end case;
		raise notice '%',uyari;
	end if;
	
end $$;

--******************************************
--************** LOOP **********************
--******************************************

--syntax
/*
<<label>> --1.ornek
loop
	statement;
end loop;
--loopu sonlandırmak icin if yapisi kullanilabilir
<<label>>  2.ornek
loop
	statements;
	if condition then
	exit; --loop dan cikilmasini saglar
end loop;
--nested loop --3.ornek
<<outer>>
loop
	statements;
	<<inner>>
	loop
	....
	exit --inner
	end loop --inner loop endi
exit;
end loop; --outer loop endi
*/

-- Task : Fibonacci serisinde, belli bir sıradaki sayıyı ekrana getirelim

do $$
declare
	n integer :=6;  --fibonacci serisinde n.sayiyi getir
	counter integer :=0; --0 dan basla istenen indise kadar git
	i integer :=0;  --kendinden onceki 2 sayidan 1.si
	j integer :=1;  --kendinden onceki 2 sayidan 2.si
	fib integer :=0; --ekrana yansiyacak sayi
begin
	if(n<1) then
		fib:=0;
	end if;
	
	loop
		exit when counter=n;
		counter:=counter + 1;
		select j,i+j into i,j; --j'yi i'ye, i+j'yi j' ye koy ---1,1,2,3,5,8...
	end loop;
	fib :=i;
	raise notice '%. siradaki Fibonacci Sayisi : %',n,fib;
end $$;
































































