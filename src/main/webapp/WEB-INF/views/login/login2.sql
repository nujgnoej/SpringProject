create table login2 (
	idx 	int not null auto_increment primary key,
	mid 	varchar(50) not null,
	pwd 	varchar(200) not null,
	name 	varchar(50) not null,
	address varchar(100) not null,
	tel 	varchar(30) not null,
	email 	varchar(50) not null,
	gender 	varchar(5),
	birthday date,
	mailCheck char(3) default 'NO',		/* mail 수신여부 */
	level 	int default 2,				/* 4:일반회원, 3:실버회원, 2:골드회원, 1:관리자 */
	point	int default 3000,			/* 적립금 */
	lastDate datetime default now(),	/* 마지막 접속일 */
	userDel char(2) default 'NO'		/* 회원 탈퇴 신청 여부(OK:탈퇴신청한회원, NO:가입중인회원) */
);

desc login2;
drop table login2;

update login2 set lastDate = default, userDel = 'OK' where mid = 'ckckck';