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
    "invoice_id" INT REFERENCES invoice(id)
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
    "invoice_id" INT REFERENCES invoice(id)
);

INSERT INTO customers ("first_name", "last_name", "address", "city", "state", "zip", "email", "phone")
VALUES
    ('John', 'Doe', '123 Main St', 'Fargo', 'ND', 58103, 'john.doe@email.com', 1234567890),
    ('Jane', 'Smith', '456 Elm St', 'Moorhead', 'MN', 56560, 'jane.smith@email.com', 9876543210),
    ('Bob', 'Johnson', '789 Oak St', 'West Fargo', 'ND', 58078, 'bob.johnson@email.com', 5551234567),
    ('Alice', 'Williams', '101 Pine St', 'Fargo', 'ND', 58102, 'alice@email.com', 9998887777),
    ('Brent', 'Olson', '1345 Main St', 'Fargo', 'ND', 58103, 'jane.smith@email.com', 9876543210),
    ('Jeff', 'Jackson', '1002 Oak St', 'Moorhead', 'MN', 56560, 'bob.johnson@email.com', 5551234567),
    ('Brittany', 'Williamson', '408 Pine St', 'West Fargo', 'ND', 58078, 'alice@email.com', 9998887777),
    ('David', 'Brown', '567 Willow St', 'Fargo', 'ND', 58104, 'david.brown@email.com', 8887776666),
	('Sarah', 'Miller', '789 Oakwood Ave', 'Fargo', 'ND', 58103, 'sarah.miller@email.com', 7776665555),
	('Michael', 'Wilson', '1010 Birch Ln', 'Fargo', 'ND', 58102, 'michael.wilson@email.com', 6665554444),
	('Emily', 'Anderson', '321 Cedar Dr', 'Fargo', 'ND', 58104, 'emily.anderson@email.com', 5554443333),
	('Robert', 'Martinez', '456 Pine Cone Rd', 'Fargo', 'ND', 58103, 'robert.martinez@email.com', 4443332222);
	
INSERT INTO services ("service") VALUES ('Weekly Mow and Trim'), ('Spring Clean-up'), ('Fall Clean-up'), ('Aeration'), ('Dethatching'), ('One-Time Mow and Trim');
	
INSERT INTO "user" ("username", "email", "password", "is_admin") VALUES ('Carisa', 'carisa.nichols@yahoo.com', '1234', TRUE), ('Rodger', 'rodger.nichols@hersheys.com', '4321', FALSE), ('Alyssa', 'alyssa.s.nichols94@gmail.com', '1234', FALSE), ('Preston', 'preston.e.nichols@gmail.com', '4321', FALSE);

SELECT * FROM services;

INSERT INTO invoice ("user_id", "date_issued", "date_paid", "total_price", "customer_id")
SELECT
    (SELECT id FROM "user" WHERE "username" = 'Carisa'),
    '2023-10-30',
    null,
    (SELECT SUM(service_price) FROM line_item),
    (SELECT id FROM customers WHERE "first_name" = 'John' AND "last_name" = 'Doe');

    
INSERT INTO line_item ("service_id", "date_performed", "service_price", "invoice_id")
VALUES
    ((SELECT id FROM services WHERE "service" = 'Weekly Mow and Trim'), '2023-10-05', 50.00, 1),
    ((SELECT id FROM services WHERE "service" = 'Spring Clean-up'), '2023-10-20', 75.00, 1),
    ((SELECT id FROM services WHERE "service" = 'Weekly Mow and Trim'), '2023-10-12', 50.00, 1),
    ((SELECT id FROM services WHERE "service" = 'Fall Clean-up'), '2023-01-10', 60.00, 2),
    ((SELECT id FROM services WHERE "service" = 'Weekly Mow and Trim'), '2023-10-02', 50.00, 3),
    ((SELECT id FROM services WHERE "service" = 'Spring Clean-up'), '2023-10-14', 75.00, 4),
    ((SELECT id FROM services WHERE "service" = 'Weekly Mow and Trim'), '2023-10-10', 50.00, 3),
    ((SELECT id FROM services WHERE "service" = 'Weekly Mow and Trim'), '2023-10-16', 50.00, 3),
    ((SELECT id FROM services WHERE "service" = 'Weekly Mow and Trim'), '2023-10-24', 50.00, 3);
    
   -- dont think i need this one actually 
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
----------------------------------------------

SELECT * FROM "line_item" WHERE date_performed BETWEEN '2023-01-01' AND '2023-01-30';


SELECT customer_id, invoice_id, service_id, date_performed, service_price, date_issued, date_paid, total_price FROM line_item
JOIN invoice i ON line_item.invoice_id = i.id;


-- FOR UPDATING TOTAL PRICE IN INVOICE TABLE
-- Create a function to update total_price
CREATE OR REPLACE FUNCTION update_invoice_total_price()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE invoice AS i
    SET total_price = (
        SELECT COALESCE(SUM(service_price), 0)
        FROM line_item AS li
        WHERE li.invoice_id = i.id
    )
    WHERE i.id = NEW.invoice_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to call the function after INSERT or UPDATE on line_item
CREATE TRIGGER update_invoice_total_price_trigger
AFTER INSERT OR UPDATE ON line_item
FOR EACH ROW
EXECUTE FUNCTION update_invoice_total_price();

-- get arrays for the invoice information of each invoice
SELECT invoice.id AS invoice_id,
       json_agg(line_item.service_id) AS service_ids,
       json_agg(line_item.date_performed) AS dates_performed,
       json_agg(line_item.service_price) AS service_prices,
       json_agg(s.service) AS services,
       total_price,
       customer_id
FROM invoice
LEFT JOIN line_item ON invoice.id = line_item.invoice_id
LEFT JOIN services AS s ON line_item.service_id = s.id
GROUP BY invoice.id;

-- ONE HUGE TABLE WITH EVERYTHING CONNECTED
SELECT i.id AS invoice_id,
       json_agg(li.service_id) AS service_ids,
       json_agg(li.date_performed) AS dates_performed,
       json_agg(li.service_price) AS service_prices,
       json_agg(s.service) AS services,
       i.total_price,
       i.customer_id,
       c.first_name,
       c.last_name,
       c.address,
       c.city,
       c.state,
       c.zip,
       c.email,
       c.phone
FROM invoice i
LEFT JOIN line_item li ON i.id = li.invoice_id
LEFT JOIN services AS s ON li.service_id = s.id
LEFT JOIN customers AS c ON i.customer_id = c.id
GROUP BY i.id, i.total_price, i.customer_id, c.first_name, c.last_name, c.address, c.city, c.state, c.zip, c.email, c.phone;