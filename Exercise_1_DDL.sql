--using plumbing DB --
USE plumbing;
-- To verify tables --
DESC auditories;
-- Tables creation --
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

-- Un cliente puede solicitar uno o varios servicios. Un servicio esta asociado a un solo cliente. --
ALTER TABLE services ADD customer_id INT, ADD FOREIGN KEY (customer_id) REFERENCES customers (id);

-- Todas las tablas tienen una relación con la tabla auditoria de 1:N. --
ALTER TABLE auditories ADD customer_id INT, ADD FOREIGN KEY (customer_id) REFERENCES customers (id);
ALTER TABLE auditories ADD service_id INT, ADD FOREIGN KEY (service_id) REFERENCES services (id);
ALTER TABLE auditories ADD plumber_id INT, ADD FOREIGN KEY (plumber_id) REFERENCES plumbers (id);
ALTER TABLE auditories ADD billing_id INT, ADD FOREIGN KEY (billing_id) REFERENCES billings (id);
ALTER TABLE auditories ADD discount_id INT, ADD FOREIGN KEY (discount_id) REFERENCES discounts (id);
ALTER TABLE auditories ADD payment_id INT, ADD FOREIGN KEY (payment_id) REFERENCES payments (id);

-- Un plomero puede realizar uno o varios servicios. Un servicio puede ser realizado por uno o varios plomeros.--
CREATE TABLE plumber_services (
	id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    plumber_id INT,
    service_id INT,
    FOREIGN KEY (plumber_id) REFERENCES plumbers (id),
    FOREIGN KEY (service_id) REFERENCES services (id)
);
/* El DBA se equivocó y olvidó agregar un campo a la tabla clientes.
Agrega un campo llamado direccion (cadena de texto de máximo 255 caracteres) a la tabla clientes.**/

ALTER TABLE customers ADD COLUMN address VARCHAR(255);

-- El DBA también olvidó agregar un campo a la tabla servicios. Agrega un campo llamado fecha (fecha) a la tabla servicios.--
ALTER TABLE services ADD COLUMN date DATE;

/*El DBA cometió otro error y olvidó agregar un campo a la tabla plomeros.
Agrega un campo llamado direccion (cadena de texto de máximo 255 caracteres) a la tabla plomeros.**/
ALTER TABLE plumbers ADD COLUMN address VARCHAR(255);

/* El DBA cometió otro error y olvidó agregar un campo a la tabla facturas.
Agrega un campo llamado direccion (cadena de texto de máximo 255 caracteres) a la tabla facturas. **/
ALTER TABLE billings ADD COLUMN address VARCHAR(255);

/*El DBA cometió otro error y es que olvido definir como no nulo el campo factura_id en la tabla pagos.
Modifica la tabla pagos para que el campo factura_id sea no nulo. A este punto recuerda que tienes el archivo data-types y foreign-keys como referencia.**/
ALTER TABLE payments MODIFY COLUMN billing_id INT NULL;
ALTER TABLE payments MODIFY COLUMN billing_id INT NOT NULL;
-- To see constraints --
SHOW CREATE TABLE auditories;
/*El DBA se percató que cometió otro error y es que olvido que la tabla descuentos no tiene relación con la tabla auditoria.
Has esto leyendo el archivo foreign-keys como referencia **/
ALTER TABLE auditories DROP FOREIGN KEY auditories_ibfk_5;
ALTER TABLE auditories DROP COLUMN discount_id;
