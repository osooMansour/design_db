-- 쇼핑몰: 주문 테이블 SERIAL 자동 증가
-- order 테이블: "하나의 주문에 대한 정보를 저장"  / order_items 테이블(세부사항): "각 주문에 포함된 상품들을 저장" 
-- orders : order_items =  1 : N 관계 
CREATE TABLE orders (
    order_id                SERIAL PRIMARY KEY,
    login_id                VARCHAR(100) NOT NULL,         
    order_date              TIMESTAMP NOT NULL,
    order_status            VARCHAR(20) NOT NULL,
    total_amount            DECIMAL(10, 2) NOT null,
    payment_method          VARCHAR(20),
    shipping_address        VARCHAR(255),
    created_at              TIMESTAMP DEFAULT NOW(),
    updated_at              TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_member    FOREIGN KEY (login_id) REFERENCES member(login_id)
);
INSERT INTO orders(login_id, order_date, order_status, total_amount, payment_method, shipping_address)
VALUES('ceoosm@gmail.com', '2024-10-08 12:30:00', 'Pending', 100.50, 'NaverPay', '123 Main St, City A');
INSERT INTO orders(login_id, order_date, order_status, total_amount, payment_method, shipping_address)
    ('ceoosm@gmail.com', '2024-10-08 13:45:00', 'Shipped', 45.00, 'KaoKaoPay', '456 Maple St, City B');


CREATE TABLE order_items (
    order_item_id        SERIAL PRIMARY KEY,        -- 주문 항목 고유 ID (자동 증가)
    order_id             INT NOT NULL,              -- 주문 ID (FK로 주문 테이블과 연결)
    prod_id              VARCHAR(100) NOT NULL,              -- 상품 ID (FK로 상품 테이블과 연결)
    quantity             INT NOT NULL,              -- 주문한 상품의 수량
    price                DECIMAL(10, 2) NOT NULL,   -- 단일 상품 가격
    CONSTRAINT fk_order     FOREIGN KEY (order_id) REFERENCES orders(order_id),  -- 주문 테이블과 외래 키 연결
    CONSTRAINT fk_product   FOREIGN KEY (prod_id)  REFERENCES product(prod_id) -- 상품 테이블과 외래 키 연결
);

INSERT INTO order_items VALUES('', 'ceoosm@gmail.com', "OCOS_2_7_A", 2, 21000);
insert into order_items values(1, 2, 'OCOS_1_1_T', 1, 11000);

-- LEFT JOIN: member와 orders와 order_items 테이블 -> left join
-- 
SELECT * FROM member m 
    LEFT JOIN orders o ON m.login_id = o.login_id
    LEFT JOIN order_items oi ON oi.order_id = o.order_id 
    WHERE m.login_id IS NOT NULL
    AND o.order_id IS NOT NULL;



