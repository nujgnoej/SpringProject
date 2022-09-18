create table cart2 (
	idx int not null auto_increment,
	productIdx int not null,
	pno int not null,
	mid varchar(50) not null,
	commodity varchar(100) not null,
	salePrice int not null,
	optionName  varchar(100),
	optionPrice int,
	orderQuantity int not null,
	totPrice int not null,
	totSavePoint int not null,
	fSName varchar(500),
	cartDay datetime default now(),
	primary key (idx),
	foreign key (productIdx) references product2(idx)
	on update cascade on delete restrict
);

desc cart2;
select * from cart2;
drop table cart2;

insert into cart2 values(default, 1, 1, 'junmo8492', '1번상품', 5000, '', 0, 2, 10000, 500, '1번이미지', default);

select count(*) from cart2 where mid = 'junmo8492';