-- Creación de la Base de datos
CREATE DATABASE registro_trafico_radioelectrico;

-- Usamos la base de datos
USE registro_trafico_radioelectrico;

-- Creación de las tablas
CREATE TABLE comunicaciones (
	id_comunicacion INT AUTO_INCREMENT PRIMARY KEY,
    fecha_inicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_tipo_comunicacion INT,
    id_corresponsal INT NOT NULL,
    id_codigo_q INT,
    id_observacion INT NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    id_operador INT NOT NULL
);

CREATE TABLE operadores (
	id_operador INT AUTO_INCREMENT PRIMARY KEY,
    nombre_operador VARCHAR(20) NOT NULL,
    apellido_operador VARCHAR(20) NOT NULL,
    dni INT UNIQUE NOT NULL,
    id_ubicacion INT,
    telefono INT,
    fecha_nacimiento DATE,
    fecha_de_ingreso DATE,
    email VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE corresponsales (
	id_corresponsales INT AUTO_INCREMENT PRIMARY KEY,
    nombre_establecimiento VARCHAR(100),
    nombre_propietario VARCHAR(50) NOT NULL,
    apellido_propietario VARCHAR(50) NOT NULL,
    id_ubicacion INT NOT NULL,
    id_red INT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
    
CREATE TABLE tipo_de_red (
	id_red INT AUTO_INCREMENT PRIMARY KEY,
    tipo_de_red VARCHAR(50) UNIQUE NOT NULL
);
    
CREATE TABLE ubicacion (
	id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
    localidad VARCHAR(100) UNIQUE NOT NULL,
    departamento VARCHAR(100) NOT NULL
);

CREATE TABLE codigo_q (
	id_codigo INT AUTO_INCREMENT PRIMARY KEY,
    tipo_de_codigo VARCHAR(3) UNIQUE NOT NULL,
    significado VARCHAR(200)
);

CREATE TABLE tipo_de_comunicacion (
	id_tipo_comunicacion INT AUTO_INCREMENT PRIMARY KEY,
    tipo_de_comunicacion VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE observaciones (
	id_observacion INT AUTO_INCREMENT PRIMARY KEY,
    observacion VARCHAR(300) UNIQUE NOT NULL
);

-- Creacion de claves foráneas (FK)
ALTER TABLE comunicaciones
	ADD CONSTRAINT fk_tipo_comunicacion
    FOREIGN KEY (id_tipo_comunicacion) REFERENCES tipo_de_comunicacion(id_tipo_comunicacion);
    
ALTER TABLE comunicaciones
	ADD CONSTRAINT fk_corresponsal
    FOREIGN KEY (id_corresponsal) REFERENCES corresponsales(id_corresponsales);
    
ALTER TABLE comunicaciones
	ADD CONSTRAINT fk_codigo
    FOREIGN KEY (id_codigo_q) REFERENCES codigo_q(id_codigo);	
    
ALTER TABLE comunicaciones
	ADD CONSTRAINT fk_observacion
    FOREIGN KEY (id_observacion) REFERENCES observaciones(id_observacion);	
    
ALTER TABLE comunicaciones
	ADD CONSTRAINT fk_operador
    FOREIGN KEY (id_operador) REFERENCES operadores(id_operador);	
    
ALTER TABLE operadores
	ADD CONSTRAINT fk_ubicacion
    FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id_ubicacion);	
    
ALTER TABLE corresponsales
	ADD CONSTRAINT fk_ubicacion_corresponsales
    FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id_ubicacion);	
    
ALTER TABLE corresponsales
	ADD CONSTRAINT fk_red
    FOREIGN KEY (id_red) REFERENCES tipo_de_red(id_red);	
    
-- Creacion de índices
CREATE INDEX idx_com_corresponsal ON comunicaciones(id_corresponsal);

CREATE INDEX idx_com_observacion ON comunicaciones(id_observacion);

CREATE INDEX idx_com_operador ON comunicaciones(id_operador);

CREATE INDEX idx_email_operador ON operadores(email);

CREATE INDEX idx_email_corresponsal ON corresponsales(email);

CREATE INDEX idx_establecimiento ON corresponsales(nombre_establecimiento);
