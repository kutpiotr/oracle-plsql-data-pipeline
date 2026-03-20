INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('API', 'Laptop', 2, 3500, DATE '2026-03-15');

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('API', 'Monitor', 4, 900, DATE '2026-03-15');

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('CSV', 'Keyboard', 10, 120, DATE '2026-03-16');

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('CSV', 'Mouse', 8, 80, DATE '2026-03-16');

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('MANUAL', 'Docking Station', 3, 650, DATE '2026-03-17');

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('API', NULL, 5, 200, DATE '2026-03-17');

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('CSV', 'Headphones', NULL, 300, DATE '2026-03-17');

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('API', 'Webcam', 2, -150, DATE '2026-03-18');

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('MANUAL', 'Microphone', 0, 450, DATE '2026-03-18');

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('CSV', 'Chair', 1, 0, DATE '2026-03-18');

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('API', 'Desk', 2, 1200, NULL);

INSERT INTO raw_sales (source_system, product_name, quantity, price, sale_date)
VALUES ('API', 'Laptop', 2, 3500, DATE '2026-03-15');

COMMIT;