INSERT INTO Transaction (dt_of_tran, hr_of_trans, customer_id)
SELECT
    dt_of_tran,
    hr_of_trans,
    c.customer_id
FROM raw_table r
JOIN Customer c ON r.customer = c.c_name;


INSERT INTO Customer (c_name, c_age, c_gender, c_cell)
SELECT DISTINCT
    customer,
    c_age,
    c_gender,
    c_cell
FROM raw_table;

INSERT INTO Product_Class (product_id, class_type)
SELECT DISTINCT
    p.product_id,
    r.prod_class
FROM raw_table r
JOIN Product p ON r.prod_name = p.prod_name;