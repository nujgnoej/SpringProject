show tables;

create table product2 (
	idx int not null auto_increment,
	pno int not null,
	commodity varchar(100) not null,
	quantity int not null,
	price int not null,
	discount int not null,
	size varchar(20) not null,
	fName varchar(500),
	fSName varchar(500),
	fSize int,
	optionName  varchar(500) not null,		/* 옵션명 리스트(배열처리) */
	optionPrice varchar(500) not null,		/* 옵션가격 리스트(배열처리) */
	content text,
	inputDay datetime default now(),
	primary key (idx),
	foreign key (pno) references productType2(pno)
	on update cascade on delete restrict
);

desc product2;
drop table product2;
select * from product2;

create table productType2 (
	pno int not null auto_increment,
	product varchar(100),
	primary key(pno, product)
);

desc productType2;
drop table productType2;
select * from productType2;

insert into productType2 values (default, 'Candle');
insert into productType2 values (default, 'Diffuser');
insert into productType2 values (default, 'Room Spray');
insert into productType2 values (default, 'Sachet');
insert into productType2 values (default, 'Hand&Body');
insert into productType2 values (default, 'Perfume');

select * from product2, productType2 where product2.pno = productType2.pno;
select * from product2, productType2 where product2.pno = productType2.pno and product2.pno = 1;
select * from product2 where commodity like 'blute_Classic Diffuser';