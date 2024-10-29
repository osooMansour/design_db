CREATE TABLE division
(
    division_code character varying(20) NOT NULL PRIMARY KEY,
    division_name character varying(20) NOT NULL,
    upper_division_code character varying(20) NOT NULL
);

INSERT INTO division VALUES ('develop_division', '개발본부', '');
INSERT INTO division VALUES ('front_team', '프론트팀', 'develop_division');
INSERT INTO division VALUES ('infra_team', '인프라팀', 'develop_division');
INSERT INTO division VALUES ('back_team', '백엔드팀', 'develop_division');
INSERT INTO division VALUES ('web_part', '웹파트', 'front_team');
INSERT INTO division VALUES ('aos_part', 'AOS파트', 'front_team');
INSERT INTO division VALUES ('ios_part', 'IOS파트', 'front_team');
INSERT INTO division VALUES ('1_part', '1파트', 'back_team');
INSERT INTO division VALUES ('2_part', '2파트', 'back_team');

1. 재귀쿼리 (모든 하위 부서 찾기)
첫번째 케이스는 기준 부서의 조직도 아래 모든 부서를 찾아본다.

WITH RECURSIVE find_division(division_code, division_name, upper_division_code, DEPTH) 
as (
  --START_QUERY
  select division_code, division_name, upper_division_code, 1
  from division
  where 1=1
  and division_code = 'develop_division'	
  
  union
  
  --REPEAT_QUERY : 예를들어 fd.division_code = 'front_division' 의 depth가 2 이면 2+1 = 3   
  select d.division_code, d.division_name, d.upper_division_code, fd.DEPTH+1
  from find_division fd
  INNER JOIN division d on d.upper_division_code = fd.division_code --case1. 조직도 아래의 모든 부서 찾기 
)
-- VIEW_QUERY
select * from find_division;


2. 하위 부서에서 상위 부서 찾기

WITH RECURSIVE find_division(division_code, division_name, upper_division_code, DEPTH) 
as (
  --START_QUERY
  select division_code, division_name, upper_division_code, 1
  from division
  where 1=1
  and division_code = 'web_part'
	
  union
  --REPEAT_QUERY
  select d.division_code, d.division_name, d.upper_division_code, fd.DEPTH+1
  from find_division fd      -- 'front_team' 
  INNER JOIN division d on fd.upper_division_code = d.division_code
)
--VIEW_QUERY
select * from find_division;