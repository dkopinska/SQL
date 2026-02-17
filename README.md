# 🌍 Project 1: SQL Data Analysis – World Database Project

This project uses the classic MySQL world sample database to demonstrate core and advanced SQL querying skills across relational datasets including city, country, and countrylanguage.

# 🔎 Skills Demonstrated

Basic data retrieval (SELECT, LIMIT)

Filtering with WHERE, BETWEEN, LIKE, NULL

Sorting with ORDER BY

Aggregate functions (AVG, COUNT, MIN, MAX)

Grouped aggregation (GROUP BY)

Relational joins (INNER JOIN, LEFT JOIN)

Subqueries (scalar & analytical)

Window functions (RANK() OVER (PARTITION BY...))

Derived metrics (Population Density, GDP per Capita)

Multi-table analytical queries

# 📊 Analytical Queries Implemented

Countries with highest life expectancy

Most populated cities and countries

Capital city population comparison

Average city population by country

Population density calculations

GDP per capita comparisons

City name frequency analysis

Ranking cities by population within each country

#🧠 Key Concepts Applied

# Relational database modelling

Query optimisation using joins instead of nested queries

Analytical SQL techniques

Window functions for ranking and partitioning

Data-driven insights from structured datasets

# 🛠 Tech Stack

MySQL

SQL (ANSI + MySQL-specific features)



# Project 2 - 🏪 Retail Store Database Design (SQL Project)

# 📌 Project Overview

This project demonstrates the design and implementation of a relational database for a retail store. The system supports inventory management, sales transactions, staff tracking, and a customer loyalty program.

The database was designed using business requirement analysis, normalisation principles, and relational modelling best practices.

# 🧠 1. Business Requirements Analysis

Before designing the schema, key stakeholders and operational needs were identified.

# 🎯 Core Data Requirements

The system stores:

Products (Inventory)

Sales Transactions

Sale Line Items

Customers

Staff

Loyalty Transactions

The design ensures:

Profit calculation (cost vs selling price)

Stock tracking

Staff accountability

Loyalty program tracking

Transaction-level detail

# 👥 2. User Roles & Access Control

![alt text](https://github.com/user-attachments/assets/bfd341da-afa7-4b9b-a008-051a643e0080)


Role-based access control was considered during schema planning.

# 🏗 3. Database Schema Design

The schema follows relational design principles and minimises redundancy.

📊 Core Tables

customer

staff

product

sale

sale_item (junction table)

loyalty_transaction

🔗 Relationships
One-to-Many

Customer → Sale

Staff → Sale

Sale → Sale Item

Product → Sale Item

Customer → Loyalty Transaction

Sale → Loyalty Transaction

Many-to-Many (Resolved)

Sale ↔ Product

Implemented via sale_item junction table

This structure ensures referential integrity and prevents data duplication.
 

# 🗺 Entity Relationship Diagram

![alt text](https://github.com/user-attachments/assets/9e019c9a-750c-4250-b002-d80a4ca7266c).
 

# 💻 4. Implementation (SQL)

The database was created using:

CREATE DATABASE

CREATE TABLE

Primary Keys

Foreign Keys

Auto-increment IDs

Default values

Referential constraints

ON DELETE CASCADE where appropriate

Example Table Definition
CREATE TABLE sale_item (
    sale_item_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_selling_price DECIMAL(10,2) NOT NULL,
    line_discount DECIMAL(10,2) DEFAULT 0.00,
    line_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sale(sale_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

# 📥 5. Data Population

Initial data includes:

- Staff members

- Products (inventory)

- Customers

- Sales transactions

- Sale line items

- Loyalty transactions

Example:

INSERT INTO sale 
(sale_date, sale_time, customer_id, staff_id, total_amount, total_discount, payment_method)
VALUES ('2026-01-23', '15:10:00', 1, 1, 2.00, 0.20, 'Card');

# 🔐 6. Data Integrity & Governance

The project includes planning for:

Referential integrity via foreign keys

Validation rules and constraints

Role-based access control

Audit trail through transaction records

Scheduled backups

Data protection compliance (GDPR considerations)

# ⚙️ Technical Skills Demonstrated

Relational database design

Normalisation

One-to-many & many-to-many modelling

Junction tables

Primary & foreign key constraints

Transaction modelling

Inventory tracking logic

# SQL DDL & DML

Role-based data access planning

Data governance awareness

# 🚀 What This Project Demonstrates

This project shows the ability to:

Translate business requirements into a structured relational schema

Design scalable database systems

Implement referential integrity

Consider security and governance in database design

Build production-style transactional systems

# 🛠 Tech Stack

MySQL

SQL (DDL & DML)

Relational Modelling

#💡 📈 Potential Future Improvements

Stored procedures for processing sales

Triggers for automatic stock updates

Indexing strategy for performance optimisation

Reporting views for management dashboards

API integration for POS systems 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

