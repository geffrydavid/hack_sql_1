create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);
INSERT INTO countries (name) VALUES 
('USA'),
('Canada'),
('Mexico');

create table roles(
  id_role serial primary key,
  name varchar(50) not null  
);
INSERT INTO roles (name) VALUES 
('Admin'),
('User'),
('Guest');

create table taxes(
id_tax serial primary key,
percentage float
);
INSERT INTO taxes (percentage) VALUES 
(5.00),
(10.00),
(15.00);
UPDATE taxes
SET percentage = percentage * 1.05;

create table offers(
id_offer serial primary key,
status varchar(50)
);
INSERT INTO offers (status) VALUES 
('Active'),
('Expired'),
('Upcoming');

create table discounts(
id_discount serial primary key,
status varchar(50),
percentage float
);
INSERT INTO discounts (status, percentage) VALUES 
('Active', 10.00),
('Inactive', 5.00),
('Pending', 20.00);

create table payments(
id_payment serial primary key,
type varchar(50)
);
INSERT INTO payments (type) VALUES 
('Credit Card'),
('PayPal'),
('Bank Transfer');

create table customers(
id_customer serial primary key,
email varchar(100) UNIQUE NOT NULL,
id_country integer not null,
id_role integer not null,
name varchar(50) not null,
age integer not null,
password varchar(100) not null,
physical_address varchar(100),
foreign key (id_country) references countries (id_country),
foreign key (id_role) references roles (id_role)
);
INSERT INTO customers (email, id_country, id_role, name, age, password, physical_address) VALUES 
('john.doe@example.com', 1, 1, 'John Doe', 30, 'password123', '123 Main St, Anytown, USA'),
('jane.smith@example.com', 2, 2, 'Jane Smith', 28, 'password456', '456 Elm St, Somewhere, Canada'),
('michael.johnson@example.com', 3, 3, 'Michael Johnson', 35, 'password789', '789 Oak St, Nowhere, Mexico');
DELETE FROM customers
WHERE email = 'michael.johnson@example.com';
UPDATE customers
SET email = 'nuevo.email@example.com'
WHERE id_customer = (
    SELECT id_customer
    FROM customers
    ORDER BY id_customer DESC
    LIMIT 1
);

create table invoice_status(
id_invoice_status serial primary key,
status varchar(50)
);
INSERT INTO invoice_status (status) VALUES 
('Paid'),
('Unpaid'),
('Pending');

create table products(
id_product serial primary key,
id_discount integer not null,
id_offer integer not null,
id_tax integer not null,
name varchar(100) not null,
details varchar(100) not null,
minimum_stock integer not null,
maximum_stock integer not null,
current_stock integer not null,
price float not null,
total_with_tax float not null,
foreign key (id_discount) references discounts (id_discount),
foreign key (id_offer) references offers (id_offer),
foreign key (id_tax) references taxes (id_tax)
);
INSERT INTO products (id_discount, id_offer, id_tax, name, details, minimum_stock, maximum_stock, current_stock, price, total_with_tax) VALUES 
(1, 1, 1, 'Product 1', 'Description of Product 1', 10, 100, 50, 20.00, 21.00),
(2, 2, 2, 'Product 2', 'Description of Product 2', 15, 150, 75, 30.00, 33.00),
(3, 3, 3, 'Product 3', 'Description of Product 3', 5, 50, 25, 40.00, 46.00);
UPDATE products
SET price = price * 1.10;

create table products_customers (
id_customer integer,
id_product integer,
foreign key (id_customer) references customers (id_customer),
foreign key (id_product) references products (id_product),
PRIMARY KEY (id_customer, id_product)
);
INSERT INTO products_customers (id_customer, id_product) VALUES 
(1, 1),
(2, 2),
(3, 3);

create table invoices(
id_invoice serial primary key,
id_costumer integer not null,
id_payment integer not null,
id_invoice_status integer not null,
date timestamp,
total_to_pay float not null,
foreign key (id_costumer) references customers (id_customer),
foreign key (id_payment) references payments (id_payment),
foreign key (id_invoice_status) references invoice_status (id_invoice_status)
);
INSERT INTO invoices (id_costumer, id_payment, id_invoice_status, date, total_to_pay) VALUES 
(1, 1, 1, '2024-08-30 10:00:00', 100.00),
(2, 2, 2, '2024-08-31 11:00:00', 150.00),
(3, 3, 3, '2024-09-01 12:00:00', 200.00);

create table orders(
id_order serial primary key,
id_invoice integer not null,
id_product integer not null,
detail varchar(100),
amount integer,
price float,
foreign key (id_invoice) references invoices (id_invoice),
foreign key (id_product) references products (id_product)
);
INSERT INTO orders (id_invoice, id_product, detail, amount, price) VALUES 
(1, 1, 'Order detail for Product 1', 2, 20.00),
(2, 2, 'Order detail for Product 2', 1, 30.00),
(3, 3, 'Order detail for Product 3', 3, 40.00);
select * from orders


