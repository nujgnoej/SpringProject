create table qnaReply2 (
	idx		int not null auto_increment,	/* 댓글의 고유번호 */
	qnaIdx	int not null,					/* 원본글의 고유번호(외래키로 지정함) */
	mid     varchar(50) not null,			/* 댓글 올린이의 아이디 */
	name 	varchar(50) not null,			/* 댓글 올린이의 성명 */
	content text not null,					/* 댓글 내용 */
	wDate   datetime default now(),			/* 댓글쓴 날짜 */
	level   int not null default 0,			/* 댓글레벨 - 부모댓글의 레벨은 0 */
	levelOrder int not null default 0,		/* 댓글의 순서 - 부모댓글의 levelOrder은 0 */
	deleteSw varchar(3) default 'no',		/* 댓글삭제여부 */
	primary key(idx),						/* 주키(기본키)는 idx */
	foreign key(qnaIdx) references qna2(idx)	/* board테이블의 idx를 boardReply2테이블의 외래키(boardIdx)로 설정했다. */
	/* on update cascade */				/* 원본테이블에서의 주키의 변경에 영향을 받는다. */
	/* on delete restrict */			/* 원본테이블에서의 주키삭제 시키지 못하게 한다.(삭제시는 에러발생하고 원본키를 삭제하지 못함.) */
);

desc qnaReply2;
select * from qnaReply2;
drop table qnaReply2;