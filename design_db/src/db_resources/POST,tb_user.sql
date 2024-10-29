
--                  'YYYY-MM-DD HH:MM' 형식                   *create_at 컬럼에 대한 값이 명시되지 않으면, 자동으로 '현재 시각'이 기록

-- ###################################################################### postgresql #################################################       
-- 왜 POST 테이블과 file 파일 별도 : 1:N 구조이기 때문에 JOIN을 해서 불러오는 게 좋음 
/*
  CREATE TABLE tb_user(		
    u_id                   INTEGER		 DEFAULT nextval('u_id_sequence')  PRIMARY KEY ,
    u_email                VARCHAR(50),
    u_name                 VARCHAR(50),
    u_pw                   VARCHAR(100),
    u_type               VARCHAR(50),
    u_address              TEXT,
    u_img_url				VARCHAR(200),
    u_ph                 	VARCHAR(50),
    agree_flag            BOOLEAN NULL,
    agree_flag_date       TIMESTAMP DEFAULT CURRENT_DATE,        
    biz_email             VARCHAR(50),
    pw_temp_flag           BOOLEAN,
    pw_invalid_count       int,
    pw_changed_at    	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
*/
/*

*/
 /**
   *@1:N 관계 : tb_user 테이블이 '1'file_info테이블의 u_email 컬럼이 'N'  
   *@ 외래 키 보유 : POST 테이블의 u_email 
   */

CREATE SEQUENCE f_id_sequence START 1;  
create table file_info(
  f_id                    INTEGER         DEFAULT nextval('f_id_sequence')  PRIMARY KEY, 
  reg_date                VARCHAR(20),
  original_file           VARCHAR(200),
  save_file               VARCHAR(200),
  created_at              TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
  foreign key(p_id)       references "post"(p_id),
  foreign key(u_email)    references "tb_user"(u_email)
);

  /*
   *@1:N 관계 : tb_user 테이블이 '1' POST테이블의 u_email 컬럼이 'N'  
   *@ 외래 키 보유 : POST 테이블의 u_email 
   */
CREATE SEQUENCE p_id_sequence START 1; 
-- u_email 유니크 키를 가지고 있어야 한다. 
create table POST(
	p_id			             INTEGER  		        DEFAULT nextval('p_id_sequence')  PRIMARY KEY ,     
	u_email					     VARCHAR(100),
	p_title			             VARCHAR(100),
	p_desc			             TEXT,
	p_img_url		             VARCHAR(300),
	p_img_name		           VARCHAR(50),
	p_contents		           VARCHAR(50),
	p_view			             INTEGER,
	p_secure		             INTEGER,
	p_like_cnt		           INTEGER,
	create_at		             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at		           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	foreign key (u_email) references "tb_user"(u_email)
);

-- DBeaver post 샘플
INSERT INTO public.post(p_title, p_desc, p_img_url, p_img_name, p_contents, p_view, p_secure, p_like_cnt) 
VALUES('xx화장품 재고 확인', '수요 폭발로 인한 capa부족', 'img_src', '', '지금 xx화장품 인기가 너무 많아요!', 1, 0, 1)
INSERT INTO public.post
(p_id, u_id, p_title, p_desc, p_img_url, p_img_name, p_contents, p_view, p_secure, p_like_cnt, create_at, updated_at)
VALUES(2, NULL, 'xx화장품 품절 확인', 'xx화장품 품절 사태', '', '', '인기 폭등', 10, 0, 10, '2024-08-01 18:24:07.288', '2024-08-01 18:24:07.288');
-- 컬럼 타입 수정 TIMESTAMP DEFAULT CURRENT_TIMESTAMP


ALTER TABLE POST ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE POST ALTER COLUMN updated_at SET DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE tb_user ALTER COLUMN agree_flag_date TYPE DATE USING to_date(agree_flag_date, 'YYYY-MM-DD');
-- ######################################################## mariaDB #########################################################
CREATE TABLE POST (
    p_id            INT AUTO_INCREMENT PRIMARY KEY,
    p_title         VARCHAR(100),
    p_desc          TEXT,
    p_img_url       VARCHAR(300),
    p_contents      VARCHAR(50),
    p_view          INT,
    p_secure        INT,
    p_like_cnt      INT,
    create_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (u_id) REFERENCES tb_user(u_id)
);

INSERT INTO POST (p_title, p_desc, p_img_url, p_img_name, p_contents, p_view, p_secure, p_like_cnt) 
VALUES ('xx화장품 재고 확인', '수요 폭발로 인한 capa부족', 'img_src', '', '지금 xx화장품 인기가 너무 많아요!', 1, 0, 1);
INSERT INTO POST 
(p_id, u_id, p_title, p_desc, p_img_url, p_img_name, p_contents, p_view, p_secure, p_like_cnt, create_at, updated_at)
VALUES(2, NULL, 'xx화장품 품절 확인', 'xx화장품 품절 사태', '', '', '인기 폭등', 10, 0, 10, '2024-08-01 18:24:07', '2024-08-01 18:24:07');


-- ######################################################################################################################


-- #################################### postgresql,  업데이트 시 트리거가 필요 #############################################
CREATE SEQUENCE u_id_sequence START 1; 
CREATE TABLE tb_user(		
  u_id                  INTEGER		 DEFAULT nextval('u_id_sequence')  PRIMARY KEY ,
  u_email               VARCHAR(50),
  u_name                VARCHAR(50),
  u_pw                  VARCHAR(100),
  u_type                VARCHAR(50),
  u_address             TEXT,
  u_img_url				VARCHAR(200),
  u_ph                 	VARCHAR(50),
  agree_flag            BOOLEAN NULL,
  agree_flag_date       TIMESTAMP DEFAULT CURRENT_DATE,        
  biz_email             VARCHAR(50),
  pw_temp_flag          BOOLEAN,
  pw_invalid_count      int,
  pw_changed_at    		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- 유저 리스트
INSERT INTO tb_user(u_email, u_name, u_pw, u_type, u_address, u_img_url, u_ph, agree_flag, agree_flag_date, biz_email, pw_temp_flag, pw_invalid_count)
VALUES('osm@naver.com', '오수만', '2848', 'A', '서울 영등포구 ', '', '01012345678', true, '2024-08-01', 'osoomansour@naver.com', true, 0);
INSERT INTO tb_user(u_email, u_name, u_pw, u_type, u_address, u_img_url, u_ph, agree_flag, biz_email, pw_temp_flag, pw_invalid_count) 
VALUES('osm2@naver.com', '오수만2', '2848', 'G','서울 서초구 방배', '', '01036383330', true, 'osoomansour@naver.com', true, 0);
-- ##################################### mariaDB, #######################################
CREATE TABLE tb_user(
  u_id                   INT            AUTO_INCREMENT PRIMARY KEY,
  u_email                VARCHAR(50),
  u_name                 VARCHAR(50),
  u_pw                   VARCHAR(100),
  u_type                 VARCHAR(50),
  u_address              TEXT,
  u_img_url              VARCHAR(200),
  u_ph                   VARCHAR(50),
  agree_flag             BOOLEAN,
  agree_flag_date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,        
  biz_email              VARCHAR(50),
  pw_temp_flag           BOOLEAN,
  pw_invalid_count       INT,
  pw_changed_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  created_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- AUTO_INCREMENT 옵션을 사용하여 u_id 컬럼의 값이 자동으로 증가하도록 설정합니다.
-- MariaDB에서는 BOOLEAN 타입이 TINYINT(1)로 구현됩니다.


-- 컬럼 이름 변경
ALTER TABLE tb_user RENAME COLUMN pw_next_change_date TO pw_changed_at


[Postgesql]
-- 트리거될 함수 생성
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- 업데이트 트리거 생성
CREATE TRIGGER set_updated_at
BEFORE UPDATE ON POST
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

[MySQL]
DELIMITER //

CREATE TRIGGER set_updated_at
BEFORE UPDATE ON POST
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER set_updated_at
BEFORE UPDATE ON POST
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END//

DELIMITER ;


[Postgesql]
-- 패스워드 업데이트 트리거 함수 생성
CREATE OR REPLACE FUNCTION update_pw_changed_at()
RETURNS TRIGGER AS $$
BEGIN
  -- 'pw' 컬럼이 변경되면 'password_changed_at' 컬럼을 현재 시간으로 설정
  IF NEW.u_pw IS DISTINCT FROM OLD.u_pw THEN
    NEW.pw_changed_at = NOW();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;  -- Procedural Language/PostgreSQL  Structured Query

-- 3. 트리거 생성
CREATE TRIGGER pw_update_trigger
BEFORE UPDATE ON tb_user
FOR EACH ROW
EXECUTE FUNCTION update_pw_changed_at();

[MySQL]
DELIMITER //

CREATE TRIGGER update_pw_changed_at
BEFORE UPDATE ON your_table_name  -- 테이블 이름을 실제 테이블 이름으로 변경
FOR EACH ROW
BEGIN
    -- u_pw 컬럼이 변경되었을 때만 pw_changed_at 컬럼을 현재 시간으로 설정
    IF NEW.u_pw <> OLD.u_pw THEN
        SET NEW.pw_changed_at = NOW();
    END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER pw_update_trigger
BEFORE UPDATE ON tb_user
FOR EACH ROW
BEGIN
    -- u_pw 컬럼이 변경되었을 때만 pw_changed_at 컬럼을 현재 시간으로 설정
    IF NEW.u_pw <> OLD.u_pw THEN
        SET NEW.pw_changed_at = NOW();
    END IF;
END//

DELIMITER ;



-- 동의 플래그 날짜 트리거 함수
CREATE OR REPLACE FUNCTION update_agree_flag_date()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if agree_flag has changed from FALSE to TRUE
    IF OLD.agree_flag = FALSE AND NEW.agree_flag = TRUE THEN
        -- Update agree_flag_date to current date
        NEW.agree_flag_date := CURRENT_DATE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 동의 플래그 날짜 트리거 생성



