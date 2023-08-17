CREATE TABLE raw_table (
    dt_of_tran INT,
    hr_of_trans INT,
    customer VARCHAR(32),
    c_age VARCHAR(4),
    c_gender VARCHAR(6),
    c_cell VARCHAR(32),
    prod_name VARCHAR(32),
    generic_or_brand VARCHAR(32),
    manufacturer VARCHAR(32),
    supplier VARCHAR(32),
    prod_class VARCHAR(32),
    prod_unit_price DOUBLE PRECISION,
    qty_purchased INT,
    prod_size VARCHAR(32)
);

CREATE TABLE Transaction (
    transaction_ID SERIAL PRIMARY KEY,
    dt_of_tran INT,
    hr_of_trans INT,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);


CREATE TABLE Transaction_Products (
    transaction_id INT,
    product_id INT,
    qty_purchased INT,
    PRIMARY KEY (transaction_id, product_id),
    FOREIGN KEY (transaction_id) REFERENCES Transaction(transaction_ID),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    c_name VARCHAR(32),
    c_age VARCHAR(4),
    c_gender VARCHAR(6),
    c_cell VARCHAR(32)
);

CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    prod_name VARCHAR(32),
    prod_unit_price DOUBLE PRECISION,
    prod_weight INT,
    prod_weight_unit VARCHAR(5),
    manufacturer VARCHAR(32),
    supplier VARCHAR(32)
);

CREATE TABLE Product_Class (
    product_id INT,
    class_type VARCHAR(32),
    PRIMARY KEY (product_id, class_type),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

