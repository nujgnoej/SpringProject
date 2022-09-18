create table qna2 (
	idx		int  not null auto_increment,	/* 게시글의 고유번호 */
	mid		varchar(50) not null,			/* 회원 아이디(게시글 조회시 사용) */
	name	varchar(50) not null,			/* 회원 닉네임 */
	qnaTypeIdx int not null,					/* 질문종류 */
	title	varchar(100) not null,			/* 글 제목 */
	content	text not null,					/* 글 내용 */
	wDate	datetime default now(),			/* 글 올린 날짜 */
	openSw	varchar(3) default '공개',		/* 글 공개여부 */
	adChk	varchar(3) default 'no',		/* 관리자 답변여부 */
	primary key(idx),						
	foreign key(qnaType) references qnaType2(idx)
	on update cascade on delete restrict
);

desc qna2;
select * from qna2;
drop table qna2;

insert into qna2 values(default, 'junmo8492', '정준모', 1, '상품재고문의', 'Baby Candle Holder 재고언제쯤 들어오는지 궁금합니다.', default, '공개', 'no');
insert into qna2 values(default, 'lkj1234', '이기자', 2, '배송관련 문의드립니다.', '빨리 사용해보고 싶은데 언제쯤 출고될까요?', default, '비공개', 'no');
insert into qna2 values(default, 'kms1234', '김말숙', 4, '논픽션제품들 언제쯤 런칭할지 궁금합니다.', '개인적으로 논픽션 향을 좋아하는데 언제쯤 런칭될까요?', default, '공개', 'no');
insert into qna2 values(default, 'hkd1234', '홍길동', 3, '리뷰관련', '#.5점 기능도 추가되면 좋을거같습니다.', default, '공개', 'no');
insert into qna2 values(default, 'hkd1234', '정준모', 4, '배송시 부탁드릴사항', '저희집이 3층인데 2.5층 반계단안쪽에 택배 놓아주실수 있을까요?', default, '비공개', 'no');
select count(*) from qna2;

create table qnaType2 (
	idx int not null auto_increment,
	qnaType varchar(50) not null,
	primary key(idx)
);

desc qnaType2;
select * from qnaType2;
drop table qnaType2;

insert into qnaType2 values(default, '상품문의');
insert into qnaType2 values(default, '배송문의');
insert into qnaType2 values(default, '리뷰문의');
insert into qnaType2 values(default, '기타');

select * from qna2, qnaType2 where qna2.qnaTypeIdx = qnaType2.idx and mid = 'junmo8492';
select * from qna2, qnaType2 where qna2.qnaTypeIdx = qnaType2.idx order by qna2.idx desc limit 0, 10;
select count(*) from qna2 where adChk = 'no';