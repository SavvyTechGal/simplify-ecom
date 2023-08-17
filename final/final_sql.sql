--p2-q1 which age group visits this store most frequently?:
SELECT c.c_age, COUNT(DISTINCT t.transaction_ID) AS visit_count
FROM Customer c
LEFT JOIN Transaction t ON c.customer_id = t.customer_id
GROUP BY c.c_age
ORDER BY visit_count DESC
LIMIT 1;

--p2-q2 Given an age group, what time of the day are they most likely to visit this store ?:
WITH AgeVisitCounts AS (
    SELECT 
        c.c_age, 
        t.hr_of_trans, 
        COUNT(DISTINCT t.transaction_ID) AS visit_count
    FROM Transaction t
    LEFT JOIN Customer c ON t.customer_id = c.customer_id
    GROUP BY c.c_age, t.hr_of_trans
)
SELECT c_age, hr_of_trans, visit_count
FROM (
    SELECT 
        c_age, 
        hr_of_trans, 
        visit_count,
        ROW_NUMBER() OVER(PARTITION BY c_age ORDER BY visit_count DESC) AS rn
    FROM AgeVisitCounts
) ranked
WHERE rn = 1;


--p2-q3 Which product-class is most frequently sold in this store?
SELECT pc.class_type, COUNT(distinct transaction_ID) AS sales_count
FROM Transaction_Products tp
left JOIN Product_Class pc ON tp.product_id = pc.product_id
GROUP BY pc.class_type
ORDER BY sales_count DESC
limit 1;

--p2-q4 Find pairs of customers who purchase similar products?
SELECT
    t1.customer_id AS customer1,
    t2.customer_id AS customer2,
    COUNT(DISTINCT pc1.class_type) AS common_class_types
FROM Transaction t1
JOIN Transaction_Products tp1 ON t1.transaction_id = tp1.transaction_id
JOIN Product_Class pc1 ON tp1.product_id = pc1.product_id
JOIN Transaction t2 ON t1.customer_id < t2.customer_id
JOIN Transaction_Products tp2 ON t2.transaction_id = tp2.transaction_id
JOIN Product_Class pc2 ON tp2.product_id = pc2.product_id
                       AND pc1.class_type = pc2.class_type
WHERE t1.customer_id != t2.customer_id
GROUP BY t1.customer_id, t2.customer_id
ORDER BY common_class_types DESC;

--p2-q5	customers who purchase same product-class on the same day
SELECT t1.customer_id AS customer1, t2.customer_id AS customer2, t1.dt_of_tran, pc.class_type AS product_class
FROM Transaction_Products tp1
JOIN Transaction_Products tp2 ON tp1.product_id = tp2.product_id AND tp1.transaction_id <> tp2.transaction_id
JOIN Transaction t1 ON tp1.transaction_id = t1.transaction_id
JOIN Transaction t2 ON tp2.transaction_id = t2.transaction_id
JOIN Product_Class pc ON tp1.product_id = pc.product_id
WHERE t1.customer_id < t2.customer_id
GROUP BY t1.customer_id, t2.customer_id, t1.dt_of_tran, pc.class_type
HAVING COUNT(*) >= 2
ORDER BY t1.dt_of_tran, pc.class_type, customer1, customer2;

COPY RAW_TABLE TO '/Users/savana/Desktop/Clean Desktop/school/project/final/raw_table.csv' WITH CSV HEADER;
COPY Customer TO '/Users/savana/Desktop/Clean Desktop/school/project/final/customer.csv' WITH CSV HEADER;
COPY Product TO '/Users/savana/Desktop/Clean Desktop/school/project/final/product.csv' WITH CSV HEADER;
COPY Product_Class TO '/Users/savana/Desktop/Clean Desktop/school/project/final/product_class.csv' WITH CSV HEADER;
COPY Transaction TO '/Users/savana/Desktop/Clean Desktop/school/project/final/transaction.csv' WITH CSV HEADER;
COPY Transaction_Products TO '/Users/savana/Desktop/Clean Desktop/school/project/final/transaction_products.csv' WITH CSV HEADER;


