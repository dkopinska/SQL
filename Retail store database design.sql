# Create the database
CREATE DATABASE retail_store; 
USE retail_store; 

# CUSTOMERS TABLE
CREATE TABLE customer (
    customer_id             INT PRIMARY KEY AUTO_INCREMENT,
    customer_name           VARCHAR(100) NOT NULL,
    phone_number            VARCHAR(20),
    address_line1           VARCHAR(100),
    address_line2           VARCHAR(100),
    city                    VARCHAR(50),
    postcode                VARCHAR(10),
    loyalty_points_balance  INT NOT NULL DEFAULT 0,
	created_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

# STAFF TABLE  
CREATE TABLE staff (
    staff_id    INT PRIMARY KEY AUTO_INCREMENT,
    staff_name  VARCHAR(100) NOT NULL,
    role        VARCHAR(50),
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

# PRODUCTS TABLE
CREATE TABLE product (
    product_id          INT PRIMARY KEY AUTO_INCREMENT,
    barcode             VARCHAR(30) NOT NULL UNIQUE,
    product_name        VARCHAR(100) NOT NULL,
    product_category    VARCHAR(50) NOT NULL,
    product_subcategory VARCHAR(50),
    product_description TEXT,
    cost_price          DECIMAL(10,2) NOT NULL,
    selling_price       DECIMAL(10,2) NOT NULL,
    stock_quantity      INT NOT NULL DEFAULT 0,
    is_discontinued     BOOLEAN NOT NULL DEFAULT FALSE,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

# SALES TABLE (one row per transaction)
CREATE TABLE sale (
    sale_id         INT PRIMARY KEY AUTO_INCREMENT,
    sale_date       DATE NOT NULL,
    sale_time       TIME NOT NULL,
    customer_id     INT NULL,
    staff_id        INT NOT NULL,
    total_amount    DECIMAL(10,2) NOT NULL,
    total_discount  DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    payment_method  VARCHAR(20) NOT NULL,
    created_date    DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

# SALE ITEMS TABLE (one row per product in sale)
CREATE TABLE sale_item (
    sale_item_id       INT PRIMARY KEY AUTO_INCREMENT,
    sale_id            INT NOT NULL,
    product_id         INT NOT NULL,
    quantity           INT NOT NULL,
    unit_selling_price DECIMAL(10,2) NOT NULL,
    line_discount      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    line_total         DECIMAL(10,2) NOT NULL,
    created_date       DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (sale_id) REFERENCES sale(sale_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

# LOYALTY TRANSACTIONS TABLE
CREATE TABLE loyalty_transaction (
    loyalty_txn_id  INT PRIMARY KEY AUTO_INCREMENT,
    customer_id     INT NOT NULL,
    sale_id         INT NULL,
    points_change   INT NOT NULL,
    reason          VARCHAR(100),
    txn_datetime    DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (sale_id) REFERENCES sale(sale_id)
);

# Verify tables created
SHOW TABLES;