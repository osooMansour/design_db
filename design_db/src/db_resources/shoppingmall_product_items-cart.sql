CREATE SEQUENCE product_seq start 1;
CREATE TABLE PRODUCT(
  id        integer         not null    default nextval('product_seq') PRIMARY KEY,
  part_no   varchar(100)    not null,
  name      varchar(100)    not null, 
  price     integer         not null
)
-- LOT  NO : 
-- OCOS사의 1번 라인의 7번 제품이고 A버전의 제품 
INSERT INTO product(part_no, name, price) VALUES('OCOS_1_7_A', '토너', 11000);
INSERT INTO product(part_no, name, price) VALUES('OCOS_2_7_A', '세럼', 13000);

[
  { id: 0, title: 'sm cosmetic', price: 11000, quantity: 0, options: [ { text : '+50ml', value : 0 + "_0", price : 3000, quantity:0 }, {text: '+70ml', value : 0 + "_1",  price: 5000, quantity:0 }]},
  { id: 1, title: '쌔럼', price : 13000, quantity: 0, options: [ {text : '+40ml', value : 1 + "_0", price : 2000, quantity:0 }, {text : '+80ml', value : 1 + "_1",  price : 7000, quantity:0 }]},
  { id: 2, title: '썬크림', price : 12000, quantity: 0, options: [ {text : '+10ml', value : 2 + "_0", price : 2000, quantity:0 }, {text : '+20ml', value : 2 + "_1", price : 7000, quantity:0 }]}
]
-- items_cart, integer       not null  default nextval('items_cart_seq') PRIMARY KEY,
CREATE SEQUENCE items_cart_seq START 1; 
CREATE TABLE items_cart(
  no            SERIAL          PRIMARY KEY,
  u_email       VARCHAR(50)     not null, 
  items_cart    JSONB
)