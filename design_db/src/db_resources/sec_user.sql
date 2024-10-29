
CREATE SEQUENCE nonsocial_member_sequence START 1; 
CREATE TABLE nonsocial_member(		
  auth_id               INTEGER		 DEFAULT nextval('nonsocial_member_sequence')  PRIMARY KEY ,
  login_type            int,
  login_id              VARCHAR(100),
  user_name             VARCHAR(100),
  email                 VARCHAR(50),
  password              VARCHAR(100),
  email_verified        boolean,
  address               VARCHAR(100),           
  locked                boolean,
  authorities           jsonb,
  user_ph               VARCHAR(100)
);
-- 유저 리스트
INSERT INTO tb_user(u_email, u_name, u_pw, u_type, u_address, u_img_url, u_ph, agree_flag, agree_flag_date, biz_email, pw_temp_flag, pw_invalid_count)
VALUES('osm@naver.com', '오수만', '2848', 'A', '서울 영등포구 ', '', '01012345678', true, '2024-08-01', 'osoomansour@naver.com', true, 0);
INSERT INTO tb_user(u_email, u_name, u_pw, u_type, u_address, u_img_url, u_ph, agree_flag, biz_email, pw_temp_flag, pw_invalid_count) 
VALUES('osm2@naver.com', '오수만2', '2848', 'G','서울 서초구 방배', '', '01036383330', true, 'osoomansour@naver.com', true, 0);
-- ##################################### mariaDB, #######################################


-- 트리거 함수 생성
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



