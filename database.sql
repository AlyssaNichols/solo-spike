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
    "total_price" DECIMAL NOT NULL,
    "customer_id" INT REFERENCES customers(id) NOT NULL
);

CREATE TABLE line_item (
    "id" serial primary key,
    "service_id" INT REFERENCES services(id) NOT NULL,
    "date_performed" DATE NOT NULL,
    "service_price" DECIMAL NOT NULL,
    "invoice_id" INT REFERENCES invoice(id) NOT NULL
);


