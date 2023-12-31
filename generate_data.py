# Created with help of ChatGPT - modified by Savana Hughes
import csv
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()

def random_timestamp():
    start = datetime(2020, 1, 1)
    end = datetime(2023, 8, 1)
    delta = end - start
    random_days = random.randint(0, delta.days)
    return start + timedelta(days=random_days)

def generate_dummy_data(num_records):
    data = []

    # dictionary of subscription values
    subscription_values = {
        'Standard': (random.randint(100, 500), random.randint(20, 100)),
        'Premium': (random.randint(100, 500), random.randint(20, 100)),
        'Ultra': (random.randint(100, 500), random.randint(20, 100))
    }

    for _ in range(num_records):
        # business_id = fake.random_int(min=10000, max=99999)
        business_name = fake.company()
        business_url = fake.url()
        business_avg_monthly_sales = random.uniform(50000, 1000000)
        business_avg_net_revenue = random.uniform(40000, 800000)
        business_sub_start_date = random_timestamp()
        business_sub_end_date = business_sub_start_date + timedelta(days=random.randint(30, 365))
        # subscription_id = fake.random_int(min=100000, max=999999)
        subscription_name = random.choice(['Standard', 'Premium', 'Ultra'])
        subscription_order_max, subscription_monthly_price = subscription_values[subscription_name]
        subscription_yearly_price = subscription_monthly_price * 12
        Internal_Order_Number = fake.random_int(min=10000, max=999999)
        order_total = random.uniform(10, 200)
        order_subtotal = order_total - random.uniform(0, 10)
        order_tax = random.uniform(0, 30)
        order_shipping_amount_paid = random.uniform(0, 20)
        order_shipping_cost = random.uniform(0, 5)
        order_product_cost = random.uniform(5, 15)
        order_total_refund = random.uniform(0, 20)
        order_creation_date = random_timestamp()
        order_fulfilled_date = order_creation_date + timedelta(days=random.randint(1, 7))
        order_cancellation_date = order_creation_date + timedelta(days=random.randint(1, 14))
        order_financial_status = random.choice(['Paid', 'Pending', 'Refunded'])
        order_discount_amount = random.uniform(0, 20)
        order_discount_code = fake.word()
        order_country = fake.country_code(representation="alpha-2")
        order_state = fake.state()
        order_zip = fake.zipcode()
        order_address1 = fake.street_address()
        order_address2 = fake.secondary_address()
        order_billing_country = fake.country_code(representation="alpha-2")
        order_billing_state = fake.state()
        order_billing_zip = fake.zipcode()
        order_billing_address1 = fake.street_address()
        order_billing_address2 = fake.secondary_address()
        # lineitem_id = fake.random_int(min=1000, max=9999)
        lineitem_title = fake.word()
        lineitem_sku = fake.word()
        lineitem_gross_revenue = random.uniform(10, 300)
        lineitem_net_revenue = lineitem_gross_revenue - random.uniform(0, 10)
        lineitem_discount_amount = random.uniform(0, 30)
        lineitem_quantity = random.randint(1, 5)
        linetem_tax = random.uniform(0, 10)
        lineitem_cost = random.uniform(5, 30)
        # customer_id = fake.random_int(min=10000, max=99999)
        customer_name = fake.name()
        customer_email = fake.email()
        customer_phone = fake.phone_number()
        customer_first_order_date = random_timestamp()
        customer_last_order_date = customer_first_order_date + timedelta(days=random.randint(1, 365))
        customer_avg_ltv = random.uniform(100, 2000)
        # customer_created_at = random_timestamp()
        # customer_updated_at = customer_created_at + timedelta(days=random.randint(1, 30))
        customer_address1 = fake.street_address()
        customer_address2 = fake.secondary_address()
        # product_id = fake.random_int(min=100000, max=999999)
        product_title = fake.word()
        product_amount = random.uniform(10, 500)
        product_cost = random.uniform(5, 30)
        product_description = fake.sentence(nb_words=10)
        product_sku = fake.word()
        # product_created_at = random_timestamp()
        # product_updated_at = product_created_at + timedelta(days=random.randint(1, 30))

        record = (
            business_name, business_url, business_avg_monthly_sales,
            business_avg_net_revenue, business_sub_start_date, business_sub_end_date,
            subscription_name, subscription_order_max,
            subscription_monthly_price, subscription_yearly_price, Internal_Order_Number,
            order_total, order_subtotal, order_tax,
            order_shipping_amount_paid, order_shipping_cost, order_product_cost,
            order_total_refund, order_creation_date, order_fulfilled_date,
            order_cancellation_date, order_financial_status, order_discount_amount,
            order_discount_code, order_country, order_state, order_zip,
            order_address1, order_address2, order_billing_country,
            order_billing_state, order_billing_zip, order_billing_address1,
            order_billing_address2,
            lineitem_title, lineitem_sku, lineitem_gross_revenue,
            lineitem_net_revenue, lineitem_discount_amount, lineitem_quantity,
            linetem_tax, lineitem_cost,
            customer_name, customer_email, customer_phone,
            customer_first_order_date, customer_last_order_date, customer_avg_ltv, customer_address1,
            customer_address2,
            product_title, product_amount, product_cost,
            product_description, product_sku
        )

        data.append(record)

    return data

num_records = 50
dummy_data = generate_dummy_data(num_records)

# Write data to a CSV file
csv_filename = "dummy_data.csv"
with open(csv_filename, mode='w', newline='', encoding='utf-8') as csv_file:
    csv_writer = csv.writer(csv_file)
    csv_writer.writerow([
        "Business_Name", "Business_URL", "Business_Avg_Monthly_Sales",
        "Business_Avg_Net_Revenue", "Business_Sub_Start_Date", "Business_Sub_End_Date",
        "Subscription_Name", "Subscription_Order_Max",
        "Subscription_Monthly_Price", "Subscription_Yearly_Price", "Internal_Order_Number",
        "Order_Total", "Order_Subtotal", "Order_Tax", "Order_Shipping_Amount_Paid",
        "Order_Shipping_Cost", "Order_Product_Cost", "Order_Total_Refund",
        "Order_Creation_Date", "Order_Fulfilled_Date", "Order_Cancellation_Date",
        "Order_Financial_Status", "Order_Discount_Amount", "Order_Discount_Code",
        "Order_Country", "Order_State", "Order_Zip", "Order_Address1",
        "Order_Address2", "Order_Billing_Country", "Order_Billing_State",
        "Order_Billing_Zip", "Order_Billing_Address1", "Order_Billing_Address2",
        "Lineitem_Title", "Lineitem_Sku", "Lineitem_Gross_Revenue",
        "Lineitem_Net_Revenue", "Lineitem_Discount_Amount", "Lineitem_Quantity",
        "Linetem_Tax", "Lineitem_Cost", "Customer_Name",
        "Customer_Email", "Customer_Phone", "Customer_First_Order_Date",
        "Customer_Last_Order_Date", "Customer_AVG_LTV",
        "Customer_Address1", "Customer_Address2",
        "Product_Title", "Product_Amount", "Product_Cost",
        "Product_Description", "Product_Sku", 
    ])
    
    for record in dummy_data:
        csv_writer.writerow(record)

print(f"Generated {num_records} dummy records and saved to '{csv_filename}'.")
