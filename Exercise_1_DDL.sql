USE plumbing;
DESC auditories;
CREATE TABLE customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
	phone_number VARCHAR(15) NOT NULL
);

CREATE TABLE services (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL,
    price DECIMAL (10,2) NOT NULL
);

CREATE TABLE plumbers (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
	phone_number VARCHAR(15) NOT NULL
);

CREATE TABLE billings (
	id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    service_id INT NOT NULL,
    plumber_id INT NOT NULL,
    date DATE NOT NULL,
    total DECIMAL NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (id),
    FOREIGN KEY (service_id) REFERENCES services (id),
    FOREIGN KEY (plumber_id) REFERENCES plumbers (id)
);

CREATE TABLE discounts(
	id INT AUTO_INCREMENT PRIMARY KEY,
    billing_id INT NOT NULL,
    amount DECIMAL NOT NULL,
	FOREIGN KEY (billing_id) REFERENCES billings (id)
);

CREATE TABLE payments (
	id INT AUTO_INCREMENT PRIMARY KEY,
    billing_id INT NOT NULL,
    amount DECIMAL NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (billing_id) REFERENCES billings (id)
);

CREATE TABLE auditories (
	id INT AUTO_INCREMENT PRIMARY KEY,
    table_colum VARCHAR(50) NOT NULL,
    action VARCHAR(50) NOT NULL,
    date DATE NOT NULL
);

ALTER TABLE services ADD customer_id INT, ADD FOREIGN KEY (customer_id) REFERENCES customers (id);
ALTER TABLE auditories ADD customer_id INT, ADD FOREIGN KEY (customer_id) REFERENCES customers (id);
ALTER TABLE auditories ADD service_id INT, ADD FOREIGN KEY (service_id) REFERENCES services (id);
ALTER TABLE auditories ADD plumber_id INT, ADD FOREIGN KEY (plumber_id) REFERENCES plumbers (id);
ALTER TABLE auditories ADD billing_id INT, ADD FOREIGN KEY (billing_id) REFERENCES billings (id);
ALTER TABLE auditories ADD discount_id INT, ADD FOREIGN KEY (discount_id) REFERENCES discounts (id);
ALTER TABLE auditories ADD payment_id INT, ADD FOREIGN KEY (payment_id) REFERENCES payments (id);


CREATE TABLE plumber_services (
	id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    plumber_id INT,
    service_id INT,
    FOREIGN KEY (plumber_id) REFERENCES plumbers (id),
    FOREIGN KEY (service_id) REFERENCES services (id)
);

ALTER TABLE customers ADD COLUMN address VARCHAR(255);
ALTER TABLE services ADD COLUMN date DATE;
ALTER TABLE plumbers ADD COLUMN address VARCHAR(255);
ALTER TABLE billings ADD COLUMN address VARCHAR(255);
ALTER TABLE payments MODIFY COLUMN billing_id INT NULL;
ALTER TABLE payments MODIFY COLUMN billing_id INT NOT NULL;
SHOW CREATE TABLE auditories;
ALTER TABLE auditories DROP FOREIGN KEY auditories_ibfk_5;
ALTER TABLE auditories DROP COLUMN discount_id;