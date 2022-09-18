/* 리뷰테이블 */
create table review2(
	idx         int not null auto_increment,	/* 고유번호 */
	orderIdx    varchar(15) not null,   		/* 주문 고유번호 */
	commodity	varchar(500) not null,   		/* 상품명 */
	mid         varchar(50) not null,   		/* 주문자 ID */
	name 		varchar(50) not null,			/* 주문자 성명 */
	title 		varchar(50) not null,			/* 리뷰제목 */
	content		varchar(100) not null,			/* 리뷰내용 */
	rating		int not null,					/* 리뷰점수 */
	fName		varchar(100),					/* 사진이름(시스템) */
	fSize		int,					/* 사진크기 */
	reviewDate	datetime default now(),			/* 리뷰등록일 */
	primary key(idx)
	/*foreign key(orderIdx) references order2(orderIdx)
	on update cascade on delete cascade */
);

desc review2;
drop table review2;
delete from review2;
select * from review2;

select * from baesong2 left join review2 on baesong2.orderIdx = review2.orderIdx where baesong2.mid = 'junmo8492' order by baesong2.idx desc;
update review2 set fSName = '' where orderIdx = 2022072112;
select * from review2 where review2.commodity like '%blute_Classic Diffuser%';