


INSERT INTO Product (prod_name, prod_unit_price, prod_weight, prod_weight_unit, manufacturer, supplier)
SELECT DISTINCT prod_name, prod_unit_price, prod_weight, prod_size, manufacturer, supplier
FROM raw_table
ON CONFLICT (prod_name, prod_unit_price, prod_weight, prod_weight_unit, manufacturer, supplier) DO NOTHING;



INSERT INTO Transaction_Products (transaction_id, product_id, qty_purchased)
SELECT t.transaction_ID, p.product_id, r.qty_purchased
FROM raw_table r
JOIN Transaction t ON r.dt_of_tran = t.dt_of_tran AND r.hr_of_trans = t.hr_of_trans
JOIN Product p ON r.prod_name = p.prod_name AND r.prod_unit_price = p.prod_unit_price AND r.prod_weight = p.prod_weight AND r.prod_size = p.prod_weight_unit AND r.manufacturer = p.manufacturer AND r.supplier = p.supplier
ON CONFLICT (transaction_id, product_id) DO NOTHING;
