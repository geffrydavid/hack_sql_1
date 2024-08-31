CREATE TABLE countries(
id_country SERIAL PRIMARY KEY,
name VARCHAR(50) not null  
);

INSERT INTO countries (name) VALUES('Japon'),('Estados Unidos'),('Italia'),('Francia'),('Turquia');
SELECT * FROM countries;

CREATE TABLE priorities(
id_priority SERIAL PRIMARY KEY,
type_name VARCHAR(50) not null  
);

INSERT INTO priorities (type_name) VALUES('Alta'),('Media'),('Baja');
SELECT * FROM priorities;

CREATE TABLE contact_request(
id_email VARCHAR(100) PRIMARY KEY,
id_country INT REFERENCES countries(id_country),
id_priority INT REFERENCES priorities(id_priority),
name VARCHAR(50),
detail VARCHAR(50),
physical_address VARCHAR(100)
);

INSERT INTO contact_request (id_email, id_country, id_priority, name, physical_address) 
VALUES('geffrydavid@gmail.com', 3, 1,'Geffry','Florencia'), ('ehden@gmail.com', 5, 2,'Ehden','Estambul'), 
('jose@gmail.com', 3, 3,'Jose','Venecia');

SELECT * FROM contact_request;

DELETE FROM contact_request where id_email = 'jose@gmail.com';

UPDATE contact_request
SET physical_address = 'Milan'
WHERE name = 'Geffry';
