USE db_ReservasBungalows
GO

IF DB_ID (N'db_ReservasBungalows') IS NOT NULL
DROP DATABASE db_ReservasBungalows
GO

CREATE DATABASE db_ReservasBungalows
GO


-- tables
-- Table: person
DROP TABLE IF EXISTS person ;
CREATE TABLE person (
    id int IDENTITY(1,1) ,
    names varchar(50)  NOT NULL,
    last_names varchar(80)  NOT NULL,
    email varchar(50)  NOT NULL,
    phone char(9)  NOT NULL,
    documentType char(3)  NOT NULL,
    documentNumber char(15)  NOT NULL,
	Fecha_nacimiento date,
    status char(1) DEFAULT 'A',
    type_person char(1) DEFAULT 'C',
    username varchar(20) ,
    password varchar(20) ,
    registration_date date DEFAULT GETDATE(),
    CONSTRAINT person_pk PRIMARY KEY (id)
);

-- Table: bungalow
DROP TABLE IF EXISTS bungalow;
CREATE TABLE bungalow (
    id int  NOT NULL,
    available char(4)  NOT NULL,
    description varchar(150)  NOT NULL,
    location varchar(100)  NOT NULL,
    rooms int  NOT NULL,
    number_person char(10)  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT bungalow_pk PRIMARY KEY (id)
);

-- Table: reservation
DROP TABLE IF EXISTS reservation ;
CREATE TABLE reservation (
    id int  NOT NULL,
    reservation_date date  NOT NULL,
    checkin_date date  NOT NULL,
    checkout_date date  NOT NULL,
    type_pay int  NOT NULL,
    status char(1)  NOT NULL,
    approbation char(1)  NOT NULL,
    person_id int  NOT NULL,
    bungalow_id int  NOT NULL,
    CONSTRAINT reservation_pk PRIMARY KEY (id)
);


-- foreign keys
-- Reference: reservation_bungalow (table: reservation)
ALTER TABLE reservation ADD CONSTRAINT reservation_bungalow FOREIGN KEY (bungalow_id)
    REFERENCES bungalow (id);

-- Reference: reservation_person (table: reservation)
ALTER TABLE reservation ADD CONSTRAINT reservation_person FOREIGN KEY (person_id)
    REFERENCES person (id);





/*Restriccion para tipo de persona que solo admita C cliente V vendedor*/
ALTER TABLE person
ADD CONSTRAINT type_personCheck CHECK (type_person IN ('C', 'V'));

/*Restricción para la columna "Email"*/
ALTER TABLE person
ADD CONSTRAINT emailUnique UNIQUE (email);

/*Restricción para la columna "NroDocumento"*/
ALTER TABLE person
ADD CONSTRAINT documentNumberUnique UNIQUE (documentNumber);


/*Restricción para la columna "Estado" A activo I inactivo*/
ALTER TABLE person
ADD CONSTRAINT statusCheck CHECK (status IN ('A', 'I'));


/*Restricción de comprobación que verifica el formato del campo "email"*/
ALTER TABLE person
ADD CONSTRAINT CK_ValidEmailFormat CHECK (email LIKE '%@%.%');


/*Restricciones de comprobación para el campo "phone" y "documentNumber"*/
ALTER TABLE person
ADD CONSTRAINT CK_OnlyDigits_Phone CHECK (phone LIKE '%[0-9]%');

ALTER TABLE person
ADD CONSTRAINT CK_OnlyDigits_DocumentNumber CHECK (documentNumber LIKE '%[0-9]%');


/*Restricción de comprobación para el campo "documentNumber" con una longitud máxima de 15 dígitos*/
ALTER TABLE person
ADD CONSTRAINT CK_Max15Digits_DocumentNumber CHECK (LEN(documentNumber) <= 15);

/*Restricciones de comprobación para los campos "names" y "last_names"*/
ALTER TABLE person
ADD CONSTRAINT CK_NoNumbers_Names CHECK (names NOT LIKE '%[0-9]%');

ALTER TABLE person
ADD CONSTRAINT CK_NoNumbers_LastNames CHECK (last_names NOT LIKE '%[0-9]%');


/*Índice no agrupado en la columna "Nombres" de la tabla "PERSONA"*/
CREATE NONCLUSTERED INDEX idx_names ON person (names);




/*Insertar registros en la tabla "person"*/

INSERT INTO person (names, last_names, email, phone, documentType, documentNumber,Fecha_nacimiento, type_person, username, password)
VALUES
('John', 'Doe', 'john@gmail.com', '995456789', 'DNI', '20203654', '1972-12-01', 'C', 'johndoe', 'password123'),
('Jane', 'Smith', 'jane@gmail.com', '987654321', 'DNI', '15279463','1972-12-01', 'C', 'janesmith', 'password456'),
('Michael', 'Johnson', 'michael@gmail.com', '952521445', 'DNI', '85296346','1972-12-01', 'V', 'michaeljohnson', 'secret789'),
('Emily', 'Davis', 'emily@gmail.com', '951753684', 'DNI', '85234169','1972-12-01', 'C', 'emilydavis', 'password123'),
('William', 'Wilson', 'william@gmail.com', '923657841', 'DNI', '75136942','1972-12-01', 'V', 'williamwilson', 'secret123'),
('Elena Sofía', 'Díaz Alvarez', 'diaz1996@gmail.com', '985632714', 'DNI', '87654321','1972-12-01', 'C', 'lauralopez', 'miclave123'),
('David Jorge', 'Silva Fernández', 'David@gmail.com', '993320647', 'DNI', '56781234','1972-12-01', 'C', 'diegohernandez', 'secreto123'),
('Roberto Andrés', 'Torres González', 'andres@gmail.com', '963274815', 'DNI', '87651234','1972-12-01', 'C', 'sofiadiaz', 'contrasena456'),
('Alicia Carmen', 'Santos García', 'carmen20@gmail.com', '917364825', 'DNI', '92347856','1972-12-01', 'C', 'manuelgomez', 'mipassword123'),
('Pablo Jorge', 'Ortega Ramírez', 'Pjorge@gmail.com', '928634751', 'DNI', '45678123','1972-12-01', 'C', 'isabeltorres', 'miclave456');


select * from person
go

/*Actualización de los datos de un cliente PERSONA*/
UPDATE person
SET status = 'I'
WHERE Id = 1;

UPDATE person
SET email = 'pablo2023@hotmail.com'
WHERE Id = 10;


/*Listar todos los activos PERSONA*/
SELECT * FROM person WHERE status = 'A';

/*Eliminación lógica (cambiar su estado a 'Inactivo')*/
UPDATE person
SET status = 'I'
WHERE Id = 1;

select * from person
go

INSERT INTO person (names, last_names, email, phone, documentType, documentNumber, type_person, username, password)
VALUES
('Piero', 'Salvador', 'piero@gmail.com', '995450789', 'DNI', '20200354', 'C', 'piero', '123');


ALTER TABLE person add Fecha_nacimiento date 

 Select id, names, last_names, email, phone, documentType, documentNumber, status, type_person, username, password, registration_date, Fecha_nacimiento from person

 Select id, names, last_names, email, phone, documentType, documentNumber, status, type_person, username, password, registration_date, Fecha_nacimiento from person Where documentNumber = '85234169';

 Select id, names, last_names, email, phone, documentType, documentNumber, status, type_person, username, password, registration_date, Fecha_nacimiento from person Where id = 5;