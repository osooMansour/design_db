/* ############################################################### Postgresql ################################################  */
CREATE SEQUENCE tb_menu_seqno_sequence START 1;
CREATE TABLE tb_menu(
    menu_seqno              INTEGER          DEFAULT nextval('tb_menu_seqno_sequence'), 
    menu_id                 VARCHAR(30)      NOT NULL PRIMARY KEY,
    parent_menu_id          VARCHAR(30)      NULL,   
    menu_name               VARCHAR(50)      NOT NULL,
    menu_url                VARCHAR(100)     NOT NULL, 
    use_yn                  VARCHAR(1)       NULL,
    depth                   INTEGER          NOT NULL,
    auth_seqno              INTEGER          NOT NULL
)
-- postgresql에서 컬럼 타입 변경

drop table if exists tb_menu CASCADE;
-- ############################################################### MariaDB(Mysql)  ###################################################
CREATE TABLE tb_menu (
    menu_seqno              INT AUTO_INCREMENT PRIMARY KEY, 
    menu_id                 VARCHAR(30)      NOT NULL,
    parent_menu_id          VARCHAR(30)      NULL,   
    menu_name               VARCHAR(50)      NOT NULL,
    menu_url                VARCHAR(100)     NOT NULL, 
    use_yn                  VARCHAR(1)       NULL,
    depth                   INT              NOT NULL,
    auth_seqno              INT              NOT NULL,
    UNIQUE KEY unique_menu_id (menu_id) -- 추가적인 제약 조건으로 menu_id의 유니크 키 설정
);



-- ####################################################### Postgresql ################################################  
CREATE SEQUENCE tb_menu_auth_sequence START 1;
CREATE TABLE tb_menu_auth(
    auth_seqno          INTEGER        NOT NULL DEFAULT nextval('tb_menu_auth_sequence') PRIMARY KEY, 
    menu_id             VARCHAR(20)    NOT NULL,
    member_type         VARCHAR(10)    NOT NULL,
    explain             VARCHAR(20)    NOT NULL,
    CONSTRAINT TB_MENU_AUTH_FK FOREIGN KEY(menu_id) REFERENCES tb_menu(menu_id) ON UPDATE CASCADE ON DELETE CASCADE
)
-- 제약조건, 외부 키 추가
alter table tb_menu_auth add CONSTRAINT TB_MENU_AUTH_FK FOREIGN KEY(menu_id) REFERENCES tb_menu(menu_id) ON UPDATE CASCADE ON DELETE CASCADE


/* tb_menu & tb_menu_auth 테이블 등록  */

INSERT INTO tb_menu(menu_id, parent_menu_id, menu_name, menu_url, use_yn, depth, auth_seqno) 
VALUES('A0', 'A0', '회원관리', '/admin/memberList.do', 'Y', 0, 1);

INSERT INTO tb_menu(menu_id, parent_menu_id, menu_name, menu_url, use_yn, depth, auth_seqno) 
VALUES('A1', 'A0', '회원 정보 수정', '/admin/AeditMember.do', 'Y', 1, 1);

INSERT INTO tb_menu(menu_id, parent_menu_id, menu_name, menu_url, use_yn, depth, auth_seqno) 
VALUES('A2', 'A0', '', '/admin/getPoint.do', 'Y', 1, 1);

INSERT INTO tb_menu(menu_id, parent_menu_id, menu_name, menu_url, use_yn, depth, auth_seqno) 
VALUES('U0', 'U0', '로그인', '/user/login', 'Y', 0, 7);

INSERT INTO tb_menu(menu_id, parent_menu_id, menu_name, menu_url, use_yn, depth, auth_seqno) 
VALUES('U1', 'U0', '회원 가입', '/user/signup', 'Y', 0, 9);


INSERT INTO tb_menu(menu_id, parent_menu_id, menu_name, menu_url, use_yn, depth, auth_seqno) 
VALUES('P0', 'P0', '아이템 리스트', '/products', 'Y', 0, 10);

INSERT INTO tb_menu_auth(menu_id, member_type, explain)
VALUES('P0', 'CUSTOMER', 'General(관리자+고객)');


INSERT INTO tb_menu_auth(menu_id, member_type, explain)
VALUES('U0', 'CUSTOMER', 'General(관리자+고객)');
INSERT INTO tb_menu_auth(menu_id, member_type, explain)
VALUES('U1', 'CUSTOMER', 'General(관리자+고객)');

INSERT INTO tb_menu_auth(menu_id, member_type, explain)
VALUES('A0', 'ADMIN', 'ADMIN')

INSERT INTO tb_menu_auth(menu_id, member_type, explain)
VALUES('A1', 'ADMIN', 'ADMIN')

INSERT INTO tb_menu_auth(menu_id, member_type, explain)
VALUES('A1', 'ADMIN', 'ADMIN')


-- 연관 서브쿼리 연습 및



-- 컬럼 이름 변경
ALTER TABLE product RENAME COLUMN dep_incharge_code TO division_code;
-- 컬럼 타입 변경
ALTER TABLE product ALTER COLUMN division_code char 

-- 목적: 존재하는 부서 전체에서 개발을 담당하고 있는 부서들을 필터해서 전체 조회  
select p.product_id,
	   p.part,
	   (select division_code from "division" d where d.division_code = p.dep_incharge_code )
	   AS department
	from "product" p;
/* 
 - 목적1: (현재 모든 부서에서) part 라고 불리는 부서들 중 현재 모든 제품들을 개발하고 있는 %part% 부서들
 - 목적2: 추상적인 검색 키워드의 경우 사용하는 것이 적합 
*/
SELECT * 
	FROM product
	WHERE division_code IN
	(
		select division_code from division where division_code  like '%part%'
	)
-- ###################################################################################################################################
-- ############################################################### MariaDB(Mysql)  ###################################################
CREATE TABLE tb_menu_auth (
    auth_seqno          INT            AUTO_INCREMENT PRIMARY KEY, 
    menu_id             VARCHAR(20)    NOT NULL,
    member_type         VARCHAR(10)    NOT NULL,
    `explain`           VARCHAR(20)    NOT NULL,
    CONSTRAINT TB_MENU_AUTH_FK FOREIGN KEY (menu_id) REFERENCES tb_menu (menu_id) ON UPDATE CASCADE ON DELETE CASCADE
);
-- ###################################################################################################################################
 


