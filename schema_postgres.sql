BEGIN;

-- =========================
-- Tables
-- =========================

CREATE TABLE product_brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(20) NOT NULL
);

CREATE TABLE store_account (
    account_id SERIAL PRIMARY KEY,
    account_name VARCHAR(50) NOT NULL
);

CREATE TABLE store_area (
    area_id SERIAL PRIMARY KEY,
    area_name VARCHAR(50) NOT NULL
);

CREATE TABLE store (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(50) NOT NULL,
    account_id INTEGER NOT NULL REFERENCES store_account (account_id),
    area_id INTEGER NOT NULL REFERENCES store_area (area_id),
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    brand_id INTEGER NOT NULL REFERENCES product_brand (brand_id)
);

CREATE TABLE report_product (
    report_id SERIAL PRIMARY KEY,
    store_id INTEGER NOT NULL REFERENCES store (store_id),
    product_id INTEGER NOT NULL REFERENCES product (product_id),
    compliance SMALLINT NOT NULL,
    tanggal DATE NOT NULL
);

-- =========================
-- Seed data
-- =========================

INSERT INTO
    product_brand (brand_id, brand_name)
VALUES (1, 'ROTI TAWAR'),
    (2, 'SUSU KALENG');

INSERT INTO
    store_account (account_id, account_name)
VALUES (1, 'Indomaret'),
    (2, 'Hypermarket');

INSERT INTO
    store_area (area_id, area_name)
VALUES (1, 'DKI jakarta'),
    (2, 'Jawa Barat'),
    (3, 'Kalimantan'),
    (4, 'Jawa Tengah'),
    (5, 'Bali');

INSERT INTO
    store (
        store_id,
        store_name,
        account_id,
        area_id,
        is_active
    )
VALUES (
        1,
        'Indomaret Djakarta',
        1,
        1,
        TRUE
    ),
    (
        2,
        'Indomaret Jawa Barat',
        1,
        2,
        TRUE
    ),
    (
        3,
        'Indomaret Kalimantan',
        1,
        3,
        TRUE
    ),
    (
        4,
        'Indomaret Jawa Tengah',
        1,
        4,
        TRUE
    ),
    (
        5,
        'Indomaret Bali',
        1,
        5,
        TRUE
    ),
    (
        6,
        'Hypermart Djakarta',
        2,
        1,
        TRUE
    ),
    (
        7,
        'Hypermart Jawa Barat',
        2,
        2,
        TRUE
    ),
    (
        8,
        'Hypermart Kalimantan',
        2,
        3,
        TRUE
    ),
    (
        9,
        'Hypermart Jawa Tengah',
        2,
        4,
        TRUE
    ),
    (
        10,
        'Hypermart Bali',
        2,
        5,
        TRUE
    );

INSERT INTO
    product (
        product_id,
        product_name,
        brand_id
    )
VALUES (1, 'Product A', 1),
    (2, 'Product B', 1),
    (3, 'Product C', 1),
    (4, 'Product D', 2),
    (5, 'Product E', 2),
    (6, 'Product F', 2);

-- Data report_product (semua baris dari dump kamu)
INSERT INTO
    report_product (
        report_id,
        store_id,
        product_id,
        compliance,
        tanggal
    )
VALUES (1, 1, 1, 1, '2025-09-01'),
    (2, 1, 2, 1, '2025-09-01'),
    (3, 1, 3, 0, '2025-09-01'),
    (4, 1, 4, 0, '2025-09-01'),
    (5, 1, 5, 1, '2025-09-01'),
    (6, 1, 6, 0, '2025-09-01'),
    (7, 2, 1, 1, '2025-09-01'),
    (8, 2, 2, 0, '2025-09-01'),
    (9, 2, 3, 0, '2025-09-01'),
    (10, 2, 4, 1, '2025-09-01'),
    (11, 2, 5, 0, '2025-09-01'),
    (12, 2, 6, 1, '2025-09-01'),
    (13, 3, 1, 0, '2025-09-01'),
    (14, 3, 2, 1, '2025-09-01'),
    (15, 3, 3, 0, '2025-09-01'),
    (16, 3, 4, 0, '2025-09-01'),
    (17, 3, 5, 1, '2025-09-01'),
    (18, 3, 6, 0, '2025-09-01'),
    (19, 4, 1, 1, '2025-09-01'),
    (20, 4, 2, 0, '2025-09-01'),
    (21, 4, 3, 0, '2025-09-01'),
    (22, 4, 4, 0, '2025-09-01'),
    (23, 4, 5, 1, '2025-09-01'),
    (24, 4, 6, 0, '2025-09-01'),
    (25, 5, 1, 1, '2025-09-01'),
    (26, 5, 2, 1, '2025-09-01'),
    (27, 5, 3, 0, '2025-09-01'),
    (28, 5, 4, 1, '2025-09-01'),
    (29, 5, 5, 0, '2025-09-01'),
    (30, 5, 6, 0, '2025-09-01'),
    (31, 6, 1, 0, '2025-09-01'),
    (32, 6, 2, 1, '2025-09-01'),
    (33, 6, 3, 0, '2025-09-01'),
    (34, 6, 4, 0, '2025-09-01'),
    (35, 6, 5, 0, '2025-09-01'),
    (36, 6, 6, 1, '2025-09-01'),
    (37, 7, 1, 1, '2025-09-01'),
    (38, 7, 2, 0, '2025-09-01'),
    (39, 7, 3, 0, '2025-09-01'),
    (40, 7, 4, 0, '2025-09-01'),
    (41, 7, 5, 1, '2025-09-01'),
    (42, 7, 6, 1, '2025-09-01'),
    (43, 8, 1, 1, '2025-09-01'),
    (44, 8, 2, 1, '2025-09-01'),
    (45, 8, 3, 0, '2025-09-01'),
    (46, 8, 4, 0, '2025-09-01'),
    (47, 8, 5, 1, '2025-09-01'),
    (48, 8, 6, 1, '2025-09-01'),
    (49, 9, 1, 0, '2025-09-01'),
    (50, 9, 2, 1, '2025-09-01'),
    (51, 9, 3, 1, '2025-09-01'),
    (52, 9, 4, 0, '2025-09-01'),
    (53, 9, 5, 0, '2025-09-01'),
    (54, 9, 6, 1, '2025-09-01'),
    (55, 10, 1, 0, '2025-09-01'),
    (56, 10, 2, 0, '2025-09-01'),
    (57, 10, 3, 0, '2025-09-01'),
    (58, 10, 4, 0, '2025-09-01'),
    (59, 10, 5, 0, '2025-09-01'),
    (60, 10, 6, 1, '2025-09-01'),
    (61, 1, 1, 0, '2025-09-02'),
    (62, 1, 2, 1, '2025-09-02'),
    (63, 1, 3, 1, '2025-09-02'),
    (64, 1, 4, 0, '2025-09-02'),
    (65, 1, 5, 1, '2025-09-02'),
    (66, 1, 6, 1, '2025-09-02'),
    (67, 2, 1, 1, '2025-09-02'),
    (68, 2, 2, 1, '2025-09-02'),
    (69, 2, 3, 1, '2025-09-02'),
    (70, 2, 4, 0, '2025-09-02'),
    (71, 2, 5, 1, '2025-09-02'),
    (72, 2, 6, 1, '2025-09-02'),
    (73, 3, 1, 1, '2025-09-02'),
    (74, 3, 2, 1, '2025-09-02'),
    (75, 3, 3, 0, '2025-09-02'),
    (76, 3, 4, 0, '2025-09-02'),
    (77, 3, 5, 0, '2025-09-02'),
    (78, 3, 6, 1, '2025-09-02'),
    (79, 4, 1, 0, '2025-09-02'),
    (80, 4, 2, 1, '2025-09-02'),
    (81, 4, 3, 0, '2025-09-02'),
    (82, 4, 4, 0, '2025-09-02'),
    (83, 4, 5, 0, '2025-09-02'),
    (84, 4, 6, 0, '2025-09-02'),
    (85, 5, 1, 1, '2025-09-02'),
    (86, 5, 2, 0, '2025-09-02'),
    (87, 5, 3, 1, '2025-09-02'),
    (88, 5, 4, 1, '2025-09-02'),
    (89, 5, 5, 1, '2025-09-02'),
    (90, 5, 6, 1, '2025-09-02'),
    (91, 6, 1, 0, '2025-09-02'),
    (92, 6, 2, 0, '2025-09-02'),
    (93, 6, 3, 1, '2025-09-02'),
    (94, 6, 4, 0, '2025-09-02'),
    (95, 6, 5, 0, '2025-09-02'),
    (96, 6, 6, 0, '2025-09-02'),
    (97, 7, 1, 1, '2025-09-02'),
    (98, 7, 2, 0, '2025-09-02'),
    (99, 7, 3, 1, '2025-09-02'),
    (100, 7, 4, 0, '2025-09-02'),
    (101, 7, 5, 0, '2025-09-02'),
    (102, 7, 6, 0, '2025-09-02'),
    (103, 8, 1, 1, '2025-09-02'),
    (104, 8, 2, 0, '2025-09-02'),
    (105, 8, 3, 0, '2025-09-02'),
    (106, 8, 4, 0, '2025-09-02'),
    (107, 8, 5, 1, '2025-09-02'),
    (108, 8, 6, 0, '2025-09-02'),
    (109, 9, 1, 0, '2025-09-02'),
    (110, 9, 2, 1, '2025-09-02'),
    (111, 9, 3, 0, '2025-09-02'),
    (112, 9, 4, 0, '2025-09-02'),
    (113, 9, 5, 1, '2025-09-02'),
    (114, 9, 6, 1, '2025-09-02'),
    (115, 10, 1, 1, '2025-09-02'),
    (116, 10, 2, 0, '2025-09-02'),
    (117, 10, 3, 1, '2025-09-02'),
    (118, 10, 4, 0, '2025-09-02'),
    (119, 10, 5, 0, '2025-09-02'),
    (120, 10, 6, 1, '2025-09-02'),
    (121, 1, 1, 1, '2025-09-03'),
    (122, 1, 2, 1, '2025-09-03'),
    (299, 10, 5, 0, '2025-09-05'),
    (300, 10, 6, 0, '2025-09-05');

-- =========================
-- Sequences sync (agar SERIAL lanjut dari max id)
-- =========================
SELECT setval(
        pg_get_serial_sequence('product_brand', 'brand_id'), COALESCE(MAX(brand_id), 1)
    )
FROM product_brand;

SELECT setval(
        pg_get_serial_sequence('store_account', 'account_id'), COALESCE(MAX(account_id), 1)
    )
FROM store_account;

SELECT setval(
        pg_get_serial_sequence('store_area', 'area_id'), COALESCE(MAX(area_id), 1)
    )
FROM store_area;

SELECT setval(
        pg_get_serial_sequence('store', 'store_id'), COALESCE(MAX(store_id), 1)
    )
FROM store;

SELECT setval(
        pg_get_serial_sequence('product', 'product_id'), COALESCE(MAX(product_id), 1)
    )
FROM product;

SELECT setval(
        pg_get_serial_sequence('report_product', 'report_id'), COALESCE(MAX(report_id), 1)
    )
FROM report_product;

COMMIT;