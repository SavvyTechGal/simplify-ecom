INSERT INTO Customer (c_name, c_age, c_gender, c_cell)
SELECT DISTINCT
    TRIM(customer),
    c_age,
    c_gender,
    c_cell
FROM raw_table
WHERE TRIM(customer) NOT IN (SELECT TRIM(c_name) FROM Customer);

INSERT INTO Product (prod_name, prod_unit_price, prod_weight, prod_weight_unit, manufacturer, supplier)
SELECT DISTINCT
    r.prod_name,
    r.prod_unit_price,
    SPLIT_PART(r.prod_size, ' ', 1)::int, 
    SPLIT_PART(r.prod_size, ' ', 2), 
    r.manufacturer,
    r.supplier
FROM raw_table r
WHERE NOT EXISTS (
    SELECT 1
    FROM Product p
    WHERE p.prod_name = r.prod_name
);

INSERT INTO Product_Class (product_id, class_type)
SELECT DISTINCT
    p.product_id,
    s.class_type
FROM raw_table r
JOIN Product p ON r.prod_name = p.prod_name
CROSS JOIN LATERAL unnest(string_to_array(r.prod_class, '-')) as s(class_type)
WHERE NOT EXISTS (
    SELECT 1
    FROM Product_Class pc
    WHERE pc.product_id = p.product_id AND pc.class_type = s.class_type
);

INSERT INTO Transaction (dt_of_tran, hr_of_trans, customer_id)
SELECT
    DISTINCT 
    dt_of_tran,
    hr_of_trans,
    c.customer_id
FROM raw_table r
JOIN Customer c ON r.customer = c.c_name
WHERE NOT EXISTS (
    SELECT 1
    FROM Transaction t
    WHERE t.dt_of_tran = r.dt_of_tran AND t.hr_of_trans = r.hr_of_trans AND t.customer_id = c.customer_id
);

INSERT INTO Transaction_Products (transaction_id, product_id, qty_purchased)
SELECT DISTINCT
    t.transaction_id,
    p.product_id,
    r.qty_purchased
FROM raw_table r
JOIN Transaction t ON r.dt_of_tran = t.dt_of_tran AND r.hr_of_trans = t.hr_of_trans 
JOIN Customer c ON r.customer = c.c_name and c.customer_id = t.customer_id
JOIN Product p ON r.prod_name = p.prod_name
WHERE NOT EXISTS (
    SELECT 1
    FROM Transaction_Products tp
    WHERE tp.transaction_id = t.transaction_id AND tp.product_id = p.product_id
);














