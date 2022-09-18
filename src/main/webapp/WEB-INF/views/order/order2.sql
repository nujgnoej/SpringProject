/* 주문 테이블 -  */
create table order2 (
	idx         int not null auto_increment, /* 고유번호 */
	orderIdx    varchar(15) not null,   /* 주문 고유번호(새롭게 만들어 주어야 한다.) */
	mid         varchar(50) not null,   /* 주문자 ID */
	productIdx  int not null,           /* 상품 고유번호 */
	commodity	varchar(100) not null,	/* 상품명 */
	salePrice   int not null,			/* 메인 상품 가격(옵션가포함) */
	orderQuantity  int not null,		/* 주문수량 */
	optionName  varchar(100) not null,  /* 옵션명    리스트 -배열로 넘어온다- */
	totPrice	int not null,			/* 구매한 상품 항목(상품과 옵션포함)에 따른 총 가격 */
	totSavePoint  int not null,			/* 적립금 */		  
	fSName		varchar(200),	/* 썸네일(서버에 저장된 메인상품 이미지) */
	orderDate	datetime default now(), /* 실제 주문을 한 날짜 */
	primary key(idx, orderIdx, productIdx),
	foreign key(productIdx) references product2(idx)
	on update cascade on delete cascade
);

desc order2;
drop table order2;
delete from order2;
select * from order2;

/* 배송테이블 */
create table baesong2 (
	idx     int not null auto_increment,
	oIdx    int not null,				/* 주문테이블의 고유번호를 외래키로 지정함 */
	orderIdx    varchar(15) not null,	/* 주문 고유번호 */
	orderTotalPrice int     not null,	/* 주문한 모든 상품의 총 가격 */
	mid         varchar(50) not null,	/* 회원 아이디 */
	name		  varchar(50) not null,	/* 배송지 받는사람 이름 */
	address     varchar(100) not null,	/* 배송지 (우편번호)주소 */
	tel		  varchar(30) not null,		/* 받는사람 전화번호 */
	email	varchar(100) not null,		/* 이메일 */
	message     varchar(100),			/* 배송시 요청사항 */
	payment	  varchar(10)  not null,	/* 결재종류 */
	orderStatus varchar(10)  not null default '결제완료', /* 주문순서(결제완료->배송중->배송완료/주문취소) */
	baesongDate datetime default now(), /* orderStatus가 수정된 날짜(결제완료일,주문취소일) */
	primary key(idx),
	foreign key(oIdx) references order2(idx)
	on update cascade on delete cascade
);
alter table baesong2 add baesongDate datetime default now();

desc baesong2;
drop table baesong2;
delete from baesong2;
select * from baesong2;

select * from baesong2, order2 where baesong2.orderIdx = order2.orderIdx GROUP BY baesong2.orderIdx order by baesong2.idx desc;
select * from baesong2, order2 where baesong2.orderIdx = order2.orderIdx and baesong2.mid = 'junmo8492' GROUP BY baesong2.orderIdx order by baesong2.idx desc;
select count(*) from baesong2, order2 where baesong2.orderIdx = order2.orderIdx and order2.orderIdx = 202207201 and baesong2.mid = 'junmo8492' order by baesong2.idx desc;
select * from baesong2, order2 where baesong2.orderIdx = order2.orderIdx and order2.orderIdx = 202207201 and baesong2.mid = 'junmo8492' order by baesong2.idx desc;
update baesong2 set orderStatus = '결제취소' where orderIdx = 2022072234;

select b.*, o.commodity, o.orderDate from baesong2 as b, order2 as o where b.orderIdx = o.orderIdx group by b.orderIdx order by b.orderIdx desc limit 5;
select b.orderIdx, o.orderIdx, o.productIdx, o.orderDate, p.idx, p.pno, pt.*, count(pt.pno) as orderCount from baesong2 as b, order2 as o, product2 as p, productType2 as pt where b.orderIdx = o.orderIdx and o.productIdx = p.idx and p.pno = pt.pno and orderStatus = '배송완료' group by pt.pno;
select substring(o.orderDate,1,10) as orderDate, count(o.orderDate) as orderCount from order2 as o group by substring(o.orderDate,1,10) order by o.orderDate desc limit 7;