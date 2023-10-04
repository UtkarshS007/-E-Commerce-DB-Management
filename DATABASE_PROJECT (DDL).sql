# create a database
CREATE DATABASE IF NOT EXISTS DMA_project1;
USE DMA_project1;
# -------------------------------------------------------
# create a customer details table
CREATE TABLE dma_project1.customer_details (
CUST_ID VARCHAR(16) NOT NULL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
registered_date DATE,
birth_date DATE,
email VARCHAR(60) NOT NULL,
address VARCHAR(30) NOT NULL,
city VARCHAR(30) NOT NULL,
zipcode INTEGER);
# -------------------------------------------------------
# Create a prodcut Information table

CREATE TABLE dma_project1.product_info(
product_id VARCHAR(16) NOT NULL PRIMARY KEY,
product_name VARCHAR(50) NOT NULL,
brand_name VARCHAR(50) NOT NULL,
product_category VARCHAR(40),
product_price DOUBLE(10,2));

# -------------------------------------------------------
# Create a stock details table

CREATE TABLE dma_project1.stock_details(
stock_id VARCHAR(15) NOT NULL PRIMARY KEY,
warehouse_id VARCHAR(15) NOT NULL,
stock_quantity INTEGER,
manager_id VARCHAR(15) NOT NULL,
product_id VARCHAR(16) NOT NULL,
article_id VARCHAR(16) NOT NULL,
CONSTRAINT UC1 UNIQUE(article_id),
SKU VARCHAR(15),
CONSTRAINT fk_prod
FOREIGN KEY (product_id) REFERENCES dma_project1.product_info(product_id));

# -------------------------------------------------------
# Create a campaign details table

CREATE TABLE dma_project1.campaign_details(
campaign_id INTEGER NOT NULL PRIMARY KEY,
campaign_name VARCHAR(50) NOT NULL,
c_start_date DATE,
c_end_date DATE,
product_id VARCHAR(16) NOT NULL,
article_id VARCHAR(16) NOT NULL,
CONSTRAINT fk_prod_camp
FOREIGN KEY (product_id) REFERENCES dma_project1.product_info(product_id),
CONSTRAINT fk_article_camp
FOREIGN KEY (article_id) REFERENCES dma_project1.stock_details(article_id));

# -------------------------------------------------------
# Create a sale date table

CREATE TABLE dma_project1.sale_date(
order_id VARCHAR(16) NOT NULL PRIMARY KEY,
customer_id VARCHAR(16) NOT NULL,
order_date DATE,
CONSTRAINT fk_sale_cust
FOREIGN KEY (customer_id) REFERENCES dma_project1.customer_details(cust_id)
);


# -------------------------------------------------------
# Create a sales table

CREATE TABLE dma_project1.sales(
order_id VARCHAR(16) NOT NULL,
customer_id VARCHAR(16) NOT NULL,
article_id VARCHAR(16) NOT NULL,
sales_price DOUBLE(10,2) NOT NULL,
discount_applied DOUBLE(10,2),
order_date DATE,
campaign_id INTEGER NOT NULL,
product_id VARCHAR(16) NOT NULL,
CONSTRAINT fk_order_sales
FOREIGN KEY (order_id) REFERENCES dma_project1.sale_date(order_id),
CONSTRAINT fk_prod_sales
FOREIGN KEY (product_id) REFERENCES dma_project1.product_info(product_id),
CONSTRAINT fk_cust_sales
FOREIGN KEY (customer_id) REFERENCES dma_project1.customer_details(cust_id),
CONSTRAINT fk_camp_sales
FOREIGN KEY (campaign_id) REFERENCES dma_project1.campaign_details(campaign_id),
CONSTRAINT fk_stock_sales
FOREIGN KEY (article_id) REFERENCES dma_project1.stock_details(article_id));

# -------------------------------------------------------
# Create a logistic details table

CREATE TABLE dma_project1.logistic_details(
ship_id VARCHAR(16) NOT NULL PRIMARY KEY,
ship_partner_id VARCHAR(10) NOT NULL,
ship_partner_name VARCHAR(16) NOT NULL,
camp_id INTEGER NOT NULL,
city VARCHAR(30) NOT NULL,
zipcode INTEGER,
customer_id VARCHAR(16) NOT NULL,
order_id VARCHAR(16) NOT NULL,
CONSTRAINT fk_camp_log
FOREIGN KEY (camp_id) REFERENCES dma_project1.campaign_details(campaign_id),
CONSTRAINT fk_cust_log
FOREIGN KEY (customer_id) REFERENCES dma_project1.customer_details(cust_id),
CONSTRAINT fk_sales_log
FOREIGN KEY (order_id) REFERENCES dma_project1.sales(order_id));

# -------------------------------------------------------
# Create a customer segment history table

CREATE TABLE dma_project1.customer_segment_history(
customer_id VARCHAR(16) NOT NULL,
total_orders INTEGER,
cust_value_seg VARCHAR(10) NOT NULL,
cust_tenure INTEGER,
cust_age INTEGER,
CONSTRAINT fk_cust_seg
FOREIGN KEY (customer_id) REFERENCES dma_project1.customer_details(cust_id));

# -------------------------------------------------------
# Create a campaign procurement details table

CREATE TABLE dma_project1.campaign_procurement_details(
campaign_id INTEGER NOT NULL,
manager_id VARCHAR(15) NOT NULL,
buyer_id VARCHAR(15) NOT NULL,
brand_name VARCHAR(20),
brand_id VARCHAR(15) NOT NULL,
CONSTRAINT fk_camp_proc
FOREIGN KEY (campaign_id) REFERENCES dma_project1.campaign_details(campaign_id));
# -------------------------------------------------------