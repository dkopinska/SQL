# Designing a store data base

1. Understanding the Business Requirements 

a) What kind of data will the database need to store? 

1. Product(inventory data): 

product_id - Unique identifier for each product 

barcode - Product barcode for scanning 

product_name - Full name of the item 

product_category - Main category (Bakery, Dairy, Drinks) 

product_subcategory - More specific category (Bread, Milk, Soft Drinks) 

product_description - Detailed product information 

cost_price - Price paid to supplier (for profit calculation) 

selling_price - Price charged to customers 

stock_quantity - Current stock level 

is_discontinued - Whether item is still sold 

2. Sale(transactions) data:  

sale_id - Unique transaction identifier 

sale_date - Date of sale 

sale_time - Time of sale 

customer_id - Customer who made purchase (if loyalty used) 

staff_id - Staff member who processed sale 

total_amount - Total sale value before discount 

total_discount - Total discount applied 

payment_method - Cash, Card, etc. 

3. Sale item data: 

sale_item_id - Unique line item identifier 

sale_id - Links to sale table 

product_id - Product purchased 

quantity - Number of items 

unit_selling_price - Price per item 

line_discount - Discount on this line 

line_total - Total for this line after discount 

 4. Customer data: 

customer_id - Unique customer identifier 

customer_name - Full name 

phone_number - Contact phone 

address_line1 - First line of address 

address_line2 - Second line of address 

city - City/Town 

postcode - Postal code 

loyalty_points_balance - Current loyalty points 

3. Staff Data: 

staff_id - Unique identifier 

staff_name - Employee name 

role - Cashier/Supervisor/Manager 

 We would need to speak to different stakeholders in the business who would be involved in data collection, handling, safeguarding analysis to understand what data/fields they need and create a minimal viable product based on that. 

b) Who will be the users of the database, and what will they need to accomplish? 

1. Business Owner/Manager 
Manages overall operations, reviews sales and profit reports, monitors stock levels, tracks best-selling products, monitors loyalty programs,forecasts demand, and plans orders. Requires read access to all tables, report generation functions, and limited write access to update stock or approve adjustments. 

2. Sales Staff/Cashiers 
Record sales transactions, update stock quantities in real time, and register new customers in the loyalty program. Require insert and update access to Sale, Sales_Items, and Customer tables, plus read access to inventory for product availability. 

3. Administrative/Inventory Staff 
Update product details, pricing, add new employees, manage loyalty points, and support financial or inventory reporting. Require insert, update, and read access to Product, Staff, Customer, and Loyalty transactions, with read-only access to Sale and Sales_Items. 

4. Store Accountant/Finance Staff 
Monitor sales revenue, generate financial reports, and track customer payments or refunds. Require read access to Sale, Sales_Items, Customer, and Loyalty Transactions tables, and limited update access for adjusting financial records where necessary. 

2. Designing the Database Schema 

a) How would you structure the database tables? 

The database would be structured using multiple related tables to reduce duplication and improve efficiency. Key tables include Customer, Staff, Product, Sale, Sale Items and Loyalty Transactions.  

Customer table required for communication, marketing and loyalty programme. 

customer_id             INT PRIMARY KEY AUTO_INCREMENT 
customer_name      VARCHAR(100) NOT NULL 
phone_number        VARCHAR(20) 
address_line1           VARCHAR(100) 
address_line2           VARCHAR(100) 
city                             VARCHAR(50) 
postcode                   VARCHAR(10) 
loyalty_points_balance  INT NOT NULL DEFAULT 0 
created_date            DATE NOT NULL DEFAULT CURDATE() 

Staff table to store information about staff and link them back to individual transactions. 

staff_id    INT PRIMARY KEY AUTO_INCREMENT 
staff_name  VARCHAR(100) NOT NULL 
role        VARCHAR(50) 
created_date DATE NOT NULL DEFAULT CURDATE() 
 

Product Table to store information related to items sold in the shop, including pricing and stock quantity. 

product_id          INT PRIMARY KEY AUTO_INCREMENT 
barcode             VARCHAR(30) NOT NULL UNIQUE 
product_name        VARCHAR(100) NOT NULL 
product_category    VARCHAR(50) NOT NULL 
product_subcategory VARCHAR(50) 
product_description TEXT 
cost_price          DECIMAL(10,2) NOT NULL 
selling_price       DECIMAL(10,2) NOT NULL 
stock_quantity      INT NOT NULL DEFAULT 0 
is_discontinued     BOOLEAN NOT NULL DEFAULT FALSE 
created_date        DATE NOT NULL DEFAULT CURDATE() 

 
  4. Sale table to record each transaction made in the store. 

sale_id         INT PRIMARY KEY AUTO_INCREMENT 
sale_date       DATE NOT NULL 
sale_time       TIME NOT NULL 
customer_id     INT NULL  
staff_id        INT NOT NULL 
total_amount    DECIMAL(10,2) NOT NULL 
total_discount  DECIMAL(10,2) NOT NULL DEFAULT 0.00 
payment_method  VARCHAR(20) NOT NULL 
created_date    DATETIME NOT NULL DEFAULT NOW() 
 

5. sale_item table to break all sales into individual items. 

sale_item_id       INT PRIMARY KEY AUTO_INCREMENT 
sale_id            INT NOT NULL 
product_id         INT NOT NULL 
quantity           INT NOT NULL 
unit_selling_price DECIMAL(10,2) NOT NULL 
line_discount      DECIMAL(10,2) NOT NULL DEFAULT 0.00 
line_total         DECIMAL(10,2) NOT NULL 
created_date       DATETIME NOT NULL DEFAULT NOW() 
 

6. loyalty_transaction table totrack loyalty points earned and redeemed by each customer and link them to specific transactions. 

loyalty_txn_id  INT PRIMARY KEY AUTO_INCREMENT 
customer_id     INT NOT NULL 
sale_id         INT NULL 
points_change   INT NOT NULL 
reason          VARCHAR(100) 
txn_datetime    DATETIME NOT NULL DEFAULT NOW() 

 

b) What relationships between tables are necessary? 

The schema diagram shows how the tables in the RetailStore database are related using primary and foreign keys. The following relationships are implemented: 

customer → sale (One-to-Many) 
One customer can make many sales, but each sale is associated with only one customer (or none for cash sales). This relationship is implemented using customer_id (Primary Key in customer table) as a foreign key in the Sale table. 

staff → sale (One-to-Many) 
One staff member can process many sales, but each sale is handled by only one staff member. This relationship is implemented using staff_id (Primary Key in staff table) as a foreign key in the Sale table. 

sale → sale_item (One-to-Many) 
Each sale can contain multiple sale items, but each sale item belongs to only one sale. This allows individual products, quantities, and line totals to be recorded per transaction. Implemented using sale_id (Primary Key in Sale table) as a foreign key in the Sale_item table. 

product → sale_item (One-to-Many) 
A product can appear in many sale items across different sales, but each sale item refers to one product. This enables accurate tracking of product sales and stock updates. Implemented using product_id (Primary Key in Product table) as a foreign key in the Sale_item table. 

sale ↔ product (Many-to-Many via sale_item) 
Each sale can contain multiple products, and each product can appear in many sales, which requires a many-to-many relationship. The many-to-many relationship between sales and products is resolved using the Sale_item junction table, which stores quantity, unit_selling_price, and line_total per product per sale. 

customer → loyalty_transaction (One-to-Many) 
One customer can have many loyalty transactions (points earned/redeemed), but each transaction belongs to one customer. Implemented using customer_id (Primary Key in customer table) as a foreign key in the loyalty_transaction table. 

sale → loyalty_transaction (One-to-Many) 
One sale can generate loyalty transactions (points earned or redeemed), but each transaction links to one sale. Implemented using sale_id (Primary Key in sale table) as a foreign key in the loyalty_transaction table. 

Sale item is the junction table used to create relationships. It resolves the many-to-many relationship between sale and product. 

 ![alt text](https://github.com/user-attachments/assets/0db48371-9279-4e03-9876-7a59c69df25f)



3. Implementing the Database 

a) What SQL commands would you use to create the database and tables? 

The database is created using the CREATE DATABASE command. Individual tables are then defined using the CREATE TABLE command, specifying appropriate columns and data types for each attribute. Primary keys are assigned to uniquely identify each record, while foreign keys are used to enforce relationships between tables, ensuring referential integrity and supporting accurate data linkage across the database. 

b) Examples of SQL statements for creating tables and relationship 

CREATE DATABASE retail_store; 
USE retail_store; 


CREATE TABLE customer ( 
    customer_id             INT PRIMARY KEY AUTO_INCREMENT, 
    customer_name           VARCHAR(100) NOT NULL, 
    phone_number            VARCHAR(20), 
    address_line1           VARCHAR(100), 
    address_line2           VARCHAR(100), 
    city                    VARCHAR(50), 
    postcode                VARCHAR(10), 
    loyalty_points_balance  INT NOT NULL DEFAULT 0, 
    created_date            DATE NOT NULL DEFAULT CURDATE() 
); 
 

CREATE TABLE staff ( 
    staff_id    INT PRIMARY KEY AUTO_INCREMENT, 
    staff_name  VARCHAR(100) NOT NULL, 
    role        VARCHAR(50), 
    created_date DATE NOT NULL DEFAULT CURDATE() 
); 
 

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
    created_date        DATE NOT NULL DEFAULT CURDATE() 
); 
 

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

 

 

4. Populating the Database 

a) How would you input initial data? 

Initial data should be imported from existing records and validated to minimise errors, preserve historical information, and prevent accidental overwrites. This includes products, customers, prices, starting stock levels, loyalty points, and purchase history. Manual data entry should be avoided where possible, as it increases the risk of errors and breaks the audit trail. 

b) Examples of SQL INSERT statements 

INSERT INTO Products VALUES (1, 'Bread', 3.00, 20); 
INSERT INTO Customers VALUES (1, 'John Brown', '0423456789'); 
 

1. Staff Members 

INSERT INTO staff (staff_name, role) VALUES  
('Sarah Jones', 'Cashier'), 
('Mark Lee', 'Supervisor'), 
('Aisha Patel', 'Manager'); 
 

2. Products (Inventory) 

INSERT INTO product (barcode, product_name, product_category, product_subcategory,  

                     cost_price, selling_price, stock_quantity) VALUES  

('5010001234567', 'White Bread', 'Bakery', 'Bread', 0.60, 1.20, 50), 

('5010007654321', 'Milk 2L', 'Dairy', 'Milk', 0.70, 1.10, 80), 

('5010009876543', 'Coca Cola', 'Drinks', 'Soft Drinks', 0.25, 0.80, 100); 

 

3. Customers 

INSERT INTO customer (customer_name, phone_number, address_line1, city, postcode) VALUES  

('John Smith', '07123456789', '1 High Street', 'London', 'SW1A 1AA'), 

('Aisha Khan', '07987654321', '10 Park Road', 'London', 'W1A 1AB'), 

('Mike Wilson', '07700998877', '5 Market Square', 'London', 'EC1A 1BB'); 

 
 

4. Sale 

# Create sale record (customer 1, staff 1) 
INSERT INTO sale (sale_date, sale_time, customer_id, staff_id, total_amount, total_discount, payment_method)  
VALUES ('2026-01-23', '15:10:00', 1, 1, 2.00, 0.20, 'Card'); 
 

# Add sale items to that sale (sale_id = 1) 
INSERT INTO sale_item (sale_id, product_id, quantity, unit_selling_price, line_discount, line_total) VALUES  
(1, 1, 1, 1.20, 0.00, 1.20),  -- 1 loaf of bread 
(1, 2, 1, 1.00, 0.20, 0.80);  -- 1 milk with discount 
 

 

6. Record Loyalty Points Earned 

# Log loyalty transaction 
INSERT INTO loyalty_transaction (customer_id, sale_id, points_change, reason)  
VALUES (1, 1, 5, 'Points earned on purchase'); 
 
 

7. Redeem Loyalty Points 

# Customer redeems 3 points for discount (no sale linked) 
INSERT INTO loyalty_transaction (customer_id, points_change, reason)  
VALUES (1, -3, 'Points redeemed for discount'); 

 

5. Maintaining the Database 

a) Keeping the database accurate and up to date

To ensure the database remains accurate and up to date, all changes and sales should be recorded through systematic audits and, where possible, automated updates for prices, product lists, and stock levels. Standard operating procedures (SOPs) should be established to maintain data accuracy, including recording all transactions and updates. Data validation rules must be enforced, such as enforcing value ranges, correct data formats, avoiding NULL values in primary keys and checking that all values are unique using distinct command) and follow the same format (consistency), and regularly checking for errors or duplicates. Staff training is essential to ensure consistent and correct use of the system across all users. Any discrepancies should be investigated and corrected immediately. Additionally, a RACI matrix should be used to assign responsibilities, clearly defining who is Responsible, Accountable, Consulted, and Informed for managing and maintaining each type of data. 

b) Handling backups and data security

Daily backups would be automatically scheduled, stored securely, and replicated to a cloud environment to prevent data loss. Data security would be maintained by implementing role-based access controls, permission levels, passwords, and encryption, ensuring customer information is protected from unauthorised access. All staff would receive training on GDPR, the Data Protection Act, and the company’s data governance policies to maintain legal compliance, confidentiality, and best-practice data management. We would also integrate different responsibilities in different data job descriptions and define who is clearly defining who is Responsible, Accountable, Consulted, and Informed for different tasks in handling backups and data security. 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

