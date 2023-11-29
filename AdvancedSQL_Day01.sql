--Tek satirli yorum
/*
Cok satirli yorum
*/
--*****************************************************
--*******DEĞİŞKEN TANIMLAMA****************************
--*****************************************************

do $$ --anonim bir block oldugunu gosterir
	--dolar : ozel karakterler oncesinde tirnak isareti kullanmamak icin
	
declare 
	counter integer :=1;
	first_name varchar(50) :='Ahmet';
	last_name varchar(50)  :='Gok';
	payment numeric(4,2)   :=20.5 ; --1.si toplam rakam sayisini, 2.si de virgulden sonra kac rakam olacagini verir.
	
begin
	raise notice '% % % has been paid % USD',
			counter,
			first_name,
			last_name,
			payment;

end $$;

--Task 1:değişkenler oluşturarak ekrana Ahmet ve Mehmet beyler 120 TL ye
--bilet aldılar. cümlesini ekrana basınız

do $$
declare
	first_person varchar(50) :='Ahmet';
	second_person varchar(50) :='Mehmet';
	payment numeric(3) :=120;
begin
	raise notice '% ve % beyler % TL ye bilet aldılar.',
		first_person,
		second_person,
		payment;
end $$ ;



--*****************************************
-- ********  BEKLETME KOMUDU **************
--*****************************************
do $$
declare
	create_at time :=now();  --atama yapıldı
begin
	raise notice '%', create_at;
	perform pg_sleep(5);  --5 sn bekle
	raise notice '%',create_at;
end $$;

--*************************************************	
-- ******** TABLODAN DATA TİPİNİ KOPYALAMA ********
--*************************************************
do $$
declare
	film_title film.title%type; --film tablosunda title headerindaki datatypeini secer
	
begin
	--1 id li filmin ismini getirelim
	select title 
	from film
	into film_title
	where id=1;
	
	raise notice 'Film title with id : 1 %',film_title;

end $$;


--Task :1 id li filmin turunu yazdirin
do $$
declare
	film_type film.type%type; 
	
begin
	--1 id li filmin ismini getirelim
	select type 
	from film
	into film_type
	where id=1;
	
	raise notice 'Film type with id : 1 %',film_type;
end $$;

--Task : 1 id li filmin ismini ve turunu ekrana yazdiralim
do $$
declare
   film_type film.type%type; 
   film_title film.title%type;
begin 
   select type,title  
   from film 
   into film_type,film_title 
   where id=1;
   
   raise notice 'Film type with id : 1 %, Film title with id : 1 %', film_type, film_title;
 
end $$;


--************************************************
-- ***************** ROW TYPE ********************
--************************************************
do $$
declare
	selected_actor actor%rowtype;
begin
	--id si 1 olan actoru getirelim
	select *
	from actor
	into selected_actor
	where id=1;
	
	raise notice 'The actors name is : % %',
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
	select id,title,type
	from film
	into rec
	where id=2;
	
	raise notice '% % %',rec.id, rec.title, rec.type;
end $$;


--******************************************
-- ******** İç İÇE BLOK ********************
--******************************************

--eger block icine block tanimlamasi yapilacaksa blocktaki begin ile end arasinda tanimalanir
do $$
<<outer_block>>
declare  --outer blok
	counter integer :=0;
begin
	counter :=counter + 1;
	raise notice 'counter degerim : %',
		counter;
		
		declare --inner block
			counter integer :=0;
		
		begin --inner block
			counter :=counter + 10;
			raise notice 'iç blocktaki counter degerim : %',counter;
			raise notice 'dış blocktaki counter degerim : %',outer_block.counter; --label ile ulastik
		
		end;  --inner block sonu
end $$; --outer blok


--*************************************
-- ********** Constant ****************
--*************************************

--selling_price :=net_price*0,1;

do $$
declare
	rate constant numeric :=0.1;
	net_price numeric :=20.5;
begin
	raise notice 'Satış fiyatı : %', net_price * (1+rate);
	--rate :=0.2; constant bir ifadeyi degistirmeye calisirsak hata verir
end $$;

--constant bir ifadeye runtime de deger verilebilir mi
do $$
declare
	start_at constant time :=now();
begin
	raise notice 'blogun calisma zamani : %',start_at;
end $$;

















