-- create table "customers"
CREATE TABLE "customers" (
	"id" serial primary key,
	"first_name" varchar(20) NOT NULL,
	"last_name" varchar(20) NOT NULL,
	"address" varchar(30) NOT NULL,
	"city" varchar(20) NOT NULL,
	"state" varchar(20) NOT NULL,
	"zip" BIGINT NOT NULL,
	"email" varchar(40),
	"phone" BIGINT NOT NULL
);

-- create table "services"
CREATE TABLE "services" (
	"id" serial primary key,
	"service" varchar(30) NOT NULL
);

-- create table "user"
CREATE TABLE "user" (
	"id" serial primary key,
	"username" varchar(30) NOT NULL UNIQUE,
	"email" varchar(30) NOT NULL,
	"password" varchar(20) NOT NULL,
	"is_admin" BOOLEAN DEFAULT false NOT NULL
);

-- create table "invoice"
CREATE TABLE invoice (
    "id" serial primary key,
    "user_id" INT REFERENCES "user"(id) NOT NULL,
    "date_issued" DATE NOT NULL,
    "date_paid" DATE,
    "total_price" DECIMAL NOT NULL,
    "customer_id" INT REFERENCES customers(id) NOT NULL
);

-- create table line_item
CREATE TABLE line_item (
    "id" serial primary key,
    "service_id" INT REFERENCES services(id) NOT NULL,
    "date_performed" DATE NOT NULL,
    "service_price" DECIMAL NOT NULL,
    "invoice_id" INT REFERENCES invoice(id) NOT NULL
);


-- Insert users into the "customers" table
INSERT INTO customers ("first_name", "last_name", "address", "city", "state", "zip", "email", "phone")
VALUES
    ('John', 'Doe', '123 Main St', 'New York', 'NY', 10001, 'john.doe@email.com', 1234567890),
    ('Jane', 'Smith', '456 Elm St', 'Los Angeles', 'CA', 90001, 'jane.smith@email.com', 9876543210),
    ('Bob', 'Johnson', '789 Oak St', 'Chicago', 'IL', 60601, 'bob.johnson@email.com', 5551234567),
    ('Alice', 'Williams', '101 Pine St', 'San Francisco', 'CA', 94101, 'alice@email.com', 9998887777);

-- Insert users into the "services" table    
INSERT INTO services ("service") VALUES ('Weekly Mow and Trim'), ('Spring Clean-up'), ('Fall Clean-up'), ('Aeration'), ('Dethatching'), ('One-Time Mow and Trim');

-- Insert users into the "user" table
INSERT INTO "user" ("username", "email", "password", "is_admin") VALUES ('Carisa', 'carisa.nichols@yahoo.com', '1234', TRUE), ('Rodger', 'rodger.nichols@hersheys.com', '4321', FALSE), ('Alyssa', 'alyssa.s.nichols94@gmail.com', '1234', FALSE), ('Preston', 'preston.e.nichols@gmail.com', '4321', FALSE);

-- insert into "invoice"
INSERT INTO invoice ("user_id", "date_issued", "date_paid", "total_price", "customer_id")
VALUES
    ((SELECT id FROM "user" WHERE "username" = 'Carisa'), '2023-01-01', '2023-01-10', 100.00, (SELECT id FROM customers WHERE "first_name" = 'John' AND "last_name" = 'Doe')),
    ((SELECT id FROM "user" WHERE "username" = 'Rodger'), '2023-01-15', '2023-01-25', 150.00, (SELECT id FROM customers WHERE "first_name" = 'Jane' AND "last_name" = 'Smith'));

-- insert into "line_item"    
INSERT INTO line_item ("service_id", "date_performed", "service_price", "invoice_id")
VALUES
    ((SELECT id FROM services WHERE "service" = 'Weekly Mow and Trim'), '2023-01-05', 50.00, 1),
    ((SELECT id FROM services WHERE "service" = 'Spring Clean-up'), '2023-01-20', 75.00, 1),
    ((SELECT id FROM services WHERE "service" = 'Weekly Mow and Trim'), '2023-01-05', 50.00, 2),
    ((SELECT id FROM services WHERE "service" = 'Fall Clean-up'), '2023-01-10', 60.00, 2);

-- select invoice_id, customer first name, last name, address, 
-- city, state, zip, and total price
SELECT 
    i.id AS invoice_id,
    c.first_name AS first_name,
    c.last_name AS last_name,
    c.address AS address,
    c.city AS city,
    c.state AS state,
    c.zip AS zip,
    SUM(l.service_price) AS total_price
FROM invoice i
JOIN customers c ON i.customer_id = c.id
JOIN line_item l ON i.id = l.invoice_id
GROUP BY i.id, first_name, last_name, address, city, state, zip
ORDER BY i.id;


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
CREATE TABLE "customers" (
	"id" serial primary key,
	"first_name" varchar(20) NOT NULL,
	"last_name" varchar(20) NOT NULL,
	"address" varchar(30) NOT NULL,
	"city" varchar(20) NOT NULL,
	"state" varchar(20) NOT NULL,
	"zip" BIGINT NOT NULL,
	"email" varchar(40),
	"phone" BIGINT NOT NULL
);

CREATE TABLE "services" (
	"id" serial primary key,
	"service" varchar(30) NOT NULL
);

CREATE TABLE "user" (
	"id" serial primary key,
	"username" varchar(30) NOT NULL UNIQUE,
	"email" varchar(30) NOT NULL,
	"password" varchar(20) NOT NULL,
	"is_admin" BOOLEAN DEFAULT false NOT NULL
);

CREATE TABLE invoice (
    "id" serial primary key,
    "user_id" INT REFERENCES "user"(id) NOT NULL,
    "date_issued" DATE NOT NULL,
    "date_paid" DATE,
    "total_price" DECIMAL,
    "customer_id" INT REFERENCES customers(id) NOT NULL
);

CREATE TABLE line_item (
    "id" serial primary key,
    "service_id" INT REFERENCES services(id) NOT NULL,
    "date_performed" DATE NOT NULL,
    "service_price" DECIMAL NOT NULL,
    "invoice_id" INT REFERENCES invoice(id) NOT NULL
);


-- Insert users into the "customers" table
INSERT INTO customers ("first_name", "last_name", "address", "city", "state", "zip", "email", "phone")
VALUES
    ('John', 'Doe', '123 Main St', 'New York', 'NY', 10001, 'john.doe@email.com', 1234567890),
    ('Jane', 'Smith', '456 Elm St', 'Los Angeles', 'CA', 90001, 'jane.smith@email.com', 9876543210),
    ('Bob', 'Johnson', '789 Oak St', 'Chicago', 'IL', 60601, 'bob.johnson@email.com', 5551234567),
    ('Alice', 'Williams', '101 Pine St', 'San Francisco', 'CA', 94101, 'alice@email.com', 9998887777);

-- Insert users into the "services" table    
INSERT INTO services ("service") VALUES ('Weekly Mow and Trim'), ('Spring Clean-up'), ('Fall Clean-up'), ('Aeration'), ('Dethatching'), ('One-Time Mow and Trim');

-- Insert users into the "user" table
INSERT INTO "user" ("username", "email", "password", "is_admin") VALUES ('Carisa', 'carisa.nichols@yahoo.com', '1234', TRUE), ('Rodger', 'rodger.nichols@hersheys.com', '4321', FALSE), ('Alyssa', 'alyssa.s.nichols94@gmail.com', '1234', FALSE), ('Preston', 'preston.e.nichols@gmail.com', '4321', FALSE);


SELECT 
    i.id AS invoice_id,
    c.first_name AS first_name,
    c.last_name AS last_name,
    c.address AS address,
    c.city AS city,
    c.state AS state,
    c.zip AS zip,
    SUM(l.service_price) AS total_price
FROM invoice i
JOIN customers c ON i.customer_id = c.id
JOIN line_item l ON i.id = l.invoice_id
GROUP BY i.id, first_name, last_name, address, city, state, zip
ORDER BY i.id;


INSERT INTO invoice ("user_id", "date_issued", "date_paid", "total_price", "customer_id")
VALUES
    ((SELECT id FROM "user" WHERE "username" = 'Carisa'), '2023-01-01', '2023-01-10', 100.00, (SELECT id FROM customers WHERE "first_name" = 'John' AND "last_name" = 'Doe')),
    ((SELECT id FROM "user" WHERE "username" = 'Rodger'), '2023-01-15', '2023-01-25', 150.00, (SELECT id FROM customers WHERE "first_name" = 'Jane' AND "last_name" = 'Smith'));
    
INSERT INTO line_item ("service_id", "date_performed", "service_price", "invoice_id")
VALUES
    ((SELECT id FROM services WHERE "service" = 'Weekly Mow and Trim'), '2023-01-05', 50.00, 1),
    ((SELECT id FROM services WHERE "service" = 'Spring Clean-up'), '2023-01-20', 75.00, 1),
    ((SELECT id FROM services WHERE "service" = 'Weekly Mow and Trim'), '2023-01-05', 50.00, 2),
    ((SELECT id FROM services WHERE "service" = 'Fall Clean-up'), '2023-01-10', 60.00, 2);

SELECT 
    i.id AS invoice_id,
    c.first_name AS first_name,
    c.last_name AS last_name,
    c.address AS address,
    c.city AS city,
    c.state AS state,
    c.zip AS zip,
    SUM(l.service_price) AS total_price
FROM invoice i
JOIN customers c ON i.customer_id = c.id
JOIN line_item l ON i.id = l.invoice_id
GROUP BY i.id, first_name, last_name, address, city, state, zip
ORDER BY i.id;