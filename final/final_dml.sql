INSERT INTO Customer (c_name, c_age, c_gender, c_cell)
SELECT DISTINCT
    customer,
    c_age,
    c_gender,
    c_cell
FROM raw_table;

INSERT INTO Product (prod_name, prod_unit_price, prod_weight, prod_weight_unit, manufacturer, supplier)
SELECT DISTINCT
    r.prod_name,
    r.prod_unit_price,
    r.prod_weight,
    r.prod_size,
    r.manufacturer,
    r.supplier
FROM raw_table r;

INSERT INTO Product_Class (product_id, class_type)
SELECT DISTINCT
    p.product_id,
    r.prod_class
FROM raw_table r
JOIN Product p ON r.prod_name = p.prod_name;

INSERT INTO Transaction (dt_of_tran, hr_of_trans, customer_id)
SELECT
    dt_of_tran,
    hr_of_trans,
    c.customer_id
FROM raw_table r
JOIN Customer c ON r.customer = c.c_name;

INSERT INTO Transaction_Products (transaction_id, product_id, qty_purchased)
SELECT
    t.transaction_id,
    p.product_id,
    r.qty_purchased
FROM raw_table r
JOIN Transaction t ON r.dt_of_tran = t.dt_of_tran AND r.hr_of_trans = t.hr_of_trans 
JOIN Customer c ON r.customer = c.c_name and c.customer_id = t.customer_id
JOIN Product p ON r.prod_name = p.prod_name;













