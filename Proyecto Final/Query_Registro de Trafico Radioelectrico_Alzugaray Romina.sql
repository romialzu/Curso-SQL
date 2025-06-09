-- Creación de la Base de datos
CREATE DATABASE IF NOT EXISTS registro_trafico_radioelectrico;

-- Usamos la base de datos
USE registro_trafico_radioelectrico;

-- Creación de las tablas
CREATE TABLE comunicaciones (
	id_comunicacion INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    inicio TIME NOT NULL,
    fin TIME NOT NULL,
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
    fecha_nacimiento DATETIME,
    fecha_de_ingreso DATETIME,
    email VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE corresponsales (
	id_corresponsales INT PRIMARY KEY,
    nombre_establecimiento VARCHAR(100),
    nombre_propietario VARCHAR(50) NOT NULL,
    apellido_propietario VARCHAR(50) NOT NULL,
    id_ubicacion INT NOT NULL,
    id_red INT NOT NULL,
    telefono VARCHAR(25) NOT NULL
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

CREATE INDEX idx_establecimiento ON corresponsales(nombre_establecimiento);

-- Inserción de datos
INSERT INTO observaciones (observacion)
	VALUES ('Solicitud de auxilio'),
		   ('Confirmación de estado de ruta'),
		   ('Llamado al contestador automático'),
	   	   ('Interferencia en la comunicación'),
		   ('Comunicado de emergencia'),
		   ('Accidente vial reportado'),
		   ('Reporte de condiciones meteorológicas'),
		   ('Prueba de señal'),
		   ('Incendio en progreso'),
		   ('Comunicación exitosa');
           
INSERT INTO tipo_de_comunicacion (tipo_de_comunicacion)
	VALUES ('Llamada entrante'),
		   ('Llamada saliente');
           
INSERT INTO codigo_q (tipo_de_codigo, significado)
	VALUES ('QRA', 'Mi estación se llama o mi indicativo es...'),
		   ('QAP', 'Estoy atento o en frecuencia'),
		   ('QRG', 'Mi frecuencia es...'),
		   ('QRJ', 'Estoy herido, mala frecuencia'),
		   ('QRK','Su señal es ininteligible'),
		   ('QRL','Esta frecuencia está ocupada'),
		   ('QRM','Interferencia artificial'),
		   ('QRN','Ruido de electricidad estática o atmosférica'),
		   ('QRO','Aumentar potencia de emisión'),
		   ('QRP','Bajar potencia de emisión'),
		   ('QRQ','Aumento la velocidad de transmisión'),
		   ('QRS','Envío el código Morse más despacio'),
		   ('QRT','Cesó la transmisión'),
		   ('QRU','Estado'),
		   ('QRV','Listo para recibir'),
		   ('QRX','Esperar un momento, lo llamaré nuevamente'),
		   ('QRY','Turno'),
		   ('QRZ','Identificación'),
		   ('QSA','Intensidad de señal'),
		   ('QSB','La señal se desvanece'),
		   ('QSL','Acuse de recibo'),
		   ('QSO','Establecer conversación con...'),
		   ('QSY','Cambio de frencuencia a...'),
		   ('QTA','Cancelo mensaje, anulo'),
		   ('QTC','Tengo mensaje para terceros'),
		   ('QTH','Posición geográfica o ubicación'),
		   ('QTR','Hora exacta');
    
INSERT INTO ubicacion (localidad, departamento)
	VALUES ('Comodoro Rivadavia', 'Escalante'),
		   ('Trelew', 'Rawson'),
		   ('Puerto Madryn', 'Biedma'),
		   ('Esquel', 'Futaleufú'),
		   ('Rawson', 'Rawson'),
		   ('Sarmiento', 'Sarmiento'),
		   ('Trevelin', 'Futaleufú'),
		   ('Gaiman', 'Gaiman'),
		   ('Rada Tilly', 'Escalante'),
		   ('Lago Puelo', 'Cushamen'),
		   ('Dolavon', 'Gaiman'),
		   ('El Maiten', 'Cushamen'),
		   ('Cholila', 'Cushamen'),
		   ('Corcovado', 'Futaleufú'),
		   ('El Hoyo', 'Cushamen'),
		   ('Epuyen', 'Cushamen'),
		   ('Gualjaina', 'Cushamen'),
		   ('Río Mayo', 'Río Senguer'),
		   ('Río Pico', 'Tehuelches'),
		   ('Alto Río Senguer', 'Río Senguer'),
		   ('José de San Martín', 'Tehuelches'),
		   ('Gobernador Costa', 'Tehuelches'),
		   ('Tecka', 'Languiñeo'),
		   ('Camarones', 'Florentino Ameghino'),
		   ('Gastre', 'Telsen'),
		   ('Gan Gan', 'Telsen'),
		   ('Telsen', 'Telsen'),
		   ('Las Plumas', 'Mártires'),
		   ('Dique Florentino Ameghino', 'Gaiman'),
		   ('Las Chapas', 'Mártires'),
		   ('Cushamen', 'Cushamen'),
		   ('Paso de Indios', 'Paso de Indios'),
		   ('Los Altares', 'Paso de Indios'),
		   ('Lagunita Salada', 'Gastre'),
		   ('Aldea Beleiro', 'Río Senguer'),
		   ('Aldea Epulef', 'Languiñeo'),
           ('Buen Pasto', 'Sarmiento'),
		   ('Ricardo Rojas', 'Río Senguer'),
		   ('Lago Blanco', 'Río Senguer'),
		   ('Aldea Apeleg', 'Río Senguer'),
		   ('Cerro Centinela', 'Futaleufú'),
		   ('Carrenleufu', 'Languiñeo'),
		   ('Paso del Sapo', 'Languiñeo'),
		   ('Puerto Pirámides', 'Biedma'),
		   ('Bahía Bustamante', 'Escalante'),
		   ('Atilio Viglione', 'Tehuelches'),
		   ('Facundo', 'Río Senguer'),
		   ('28 de Julio', 'Gaiman'),
		   ('Colan Conhue', 'Languiñeo'),
		   ('Garayalde', 'Florentino Ameghino'),
		   ('Uzcudun', 'Florentino Ameghino'),
		   ('Arroyo Verde', 'Biedma'),
		   ('El Escorial', 'Gastre'),
		   ('Chacay Oeste', 'Telsen'),
		   ('Yala Laubat', 'Gastre');
    
INSERT INTO tipo_de_red (tipo_de_red)
	VALUES ('Oficial'),
		   ('Rural'),
		   ('Comunidad aborigen');
        
INSERT INTO corresponsales
	VALUES (1, 'Arroyo Verde', 'Miguel', 'Acosta', 25, 1, 29456727972),
		   (21, 'La Marcelita', 'Thiago', 'Gomez', 53, 2, 2804356180),
		   (24, 'Zully', 'Luciano', 'Sanchez', 36, 2, 2978842218),
		   (47, 'La Victoria', 'Erik', 'Godoy', 1, 2, 29459802852),
		   (51, 'Ragon Ñuque', 'Juan', 'Cardozo', 34, 2, 29669530594),
		   (53, 'Móvil Ragon Ñuque', 'Roman', 'Vega', 12, 2, 2804498025),
		   (54, 'Vista Alegre', 'Santiago', 'Montiel', 27, 2, 29721894995),
		   (55, 'Guillermina', 'Alan', 'Rodríguez', 55, 2, 29459954823),
		   (64, 'El Bosque', 'Maximiliano', 'Romero', 40, 2, 29725759482),
		   (65, 'La Rosada', 'Gastón', 'Verón', 54, 2, 2804471334),
		   (66, 'Bella Vista', 'Damián', 'Batallini', 38, 2, 29664634295),
		   (67, 'La Mary', 'Gonzalo', 'Siri Payer', 33, 2, 2977386881),
		   (69, 'Móvil Rodríguez', 'Tobías', 'Palacio', 3, 2, 29666423458),
		   (73, 'Don Martín', 'Kevin', 'Coronel', 37, 2, 29666728849),
		   (74, 'Correo Telsen', 'Leonardo', 'Heredia', 15, 1, 2804271740),
		   (76, 'Móvil Pesca', 'Francisco', 'Álvarez', 28, 2, 2804376087),
		   (81, 'El Luján', 'Franco', 'Moyano', 19, 1, 2978384751),
		   (93, 'El Sauce', 'Fernando', 'Meza', 11, 2, 29665952082),
		   (94, 'Aguada La Flecha', 'Jonathan', 'Galván', 11, 2, 29667236971),
		   (95, 'La Figura', 'Sebastián', 'Prieto', 21, 2, 2804379388),
		   (96, 'El Pajarito', 'Nicolás', 'Oroz', 46, 2, 2976744148),
		   (97, 'Móvil El Bosque', 'Alan', 'Lescano', 28, 2, 2804890340),
		   (98, 'Santa Genara', 'Thiago', 'Santamaría', 10, 2, 2804547778),
		   (99, 'La Florida', 'Mateo', 'Díaz Chaves', 5, 2, 29723159085),
		   (100, 'Móvil Cerro Manquel', 'Lucas', 'Gomez', 10, 2, 2973595116),
		   (101, 'El Encuentro', 'José', 'Herrera', 54, 2, 2804757652),
		   (102, 'Don Rafael', 'Elías', 'Peralta', 37, 2, 2974924405),
		   (103, 'La Nueva Poupee', 'Matías', 'Perello', 32, 2, 2979403509),
		   (104, 'La Esperanza', 'Emiliano', 'Viveros', 34, 2, 2945671010),
		   (105, 'El Bañado', 'Giovanni', 'Marques', 55, 2, 2804894211),
		   (106, 'Los Dos Hermanos', 'Jairo', 'Oneil', 46, 2, 2804371463),
		   (107, 'La Elisita', 'Luciano', 'Gondou', 17, 2, 2966608425),
		   (108, 'Móvil Don Pancho', 'Daniel', 'Meza', 41, 2, 2804180542),
		   (109, 'Dos Lagunas', 'Bruno', 'Villalba', 46, 2, 2945259732),
		   (110, 'La Suerte', 'Agustín', 'Mangiaut', 32, 2, 2972147207),
		   (111, 'Dos Puntas', 'Ariel', 'Gamarra', 55, 2, 2972325367),
		   (112, 'La Juanelia', 'Lucas', 'Toffoletti', 35, 2, 2966356965),
		   (113, 'Cabo Raso SRL', 'Franco', 'Vazquez', 29, 2, 2804348785),
		   (114, 'La Palmera', 'Gabriel', 'Rocha', 34, 2, 2804332389),
		   (115, 'La Emilia', 'Diego', 'Barros', 15, 2, 2945176094),
		   (116, 'Los Cerros', 'Facundo', 'Báez', 6, 2, 2972722722),
		   (117, 'La Madrugada', 'Uriel', 'Sosa', 15, 2, 2945308603),
		   (118, 'Comunidad Morales', 'Fernando', 'Álvarez', 39, 2, 2804689294),
		   (119, 'San Francisco', 'Thiago', 'González', 3, 1, 2804202758),
		   (120, 'El Guanaco', 'Santiago', 'Farrera', 47, 2, 2972246896),
		   (121, 'El Zampal', 'Jeremías', 'Correale', 36, 2, 2972294619),
		   (122, 'Los Amigos', 'Diego', 'Porcel', 11, 2, 2976096404),
		   (123, 'La Unión', 'Benjamín', 'Rey', 51, 2, 2945681490),
		   (124, 'Santa Elena', 'Ryoga', 'Kida', 36, 2, 2804897124),
		   (125, 'La Berna', 'Diego', 'Rodríguez', 15, 2, 2945915948),
		   (126, 'Aguada del Toro', 'José', 'Devecchi', 19, 2, 2972808325),
		   (127, 'La Juanita', 'Alexis', 'Flores', 3, 2, 2972741746),
		   (128, 'La Filomena', 'Gonzalo', 'Paz', 35, 2, 2966857241),
		   (129, 'Del Carmen', 'Rodrigo', 'Morales', 30, 2, 2966206497),
		   (130, 'Lago Vintter', 'Adrián', 'Sánchez', 46, 2, 2804760669),
		   (131, 'El Poquito', 'Gianluca', 'Ferrari', 31, 1, 2972955189),
		   (132, 'El Descenso', 'Nicolás', 'Servetto', 30, 2, 2972417713),
		   (133, 'Cerro Manquel', 'Guillermo', 'Acosta', 13, 2, 2966983228),
		   (134, 'Santa Juana', 'Mateo', 'Bajamich', 34, 2, 2945217013),
		   (135, 'Comunidad Ricardo Rojas', 'Joaquín', 'Pereyra', 2, 2, 2975916817),
		   (136, 'El Portezuelo', 'Nicolás', 'Castro', 47, 1, 2966361242),
		   (137, 'La Bienvenida', 'Gustavo', 'Lescano', 14, 2, 2804564007),
		   (138, 'Quichaura 1', 'Agustín', 'Lagos', 20, 3, 2804727600),
		   (139, 'Flor de Lis', 'Néstor', 'Breitenbruch', 18, 3, 2804552480),
		   (140, 'La Mimosa', 'Moisés', 'Brandan', 42, 2, 2945988888),
		   (141, 'El Menuco', 'Renzo', 'Tesuri', 45, 2, 2945621638),
		   (142, 'El Beduino', 'Marcelo', 'Estigarribia', 50, 2, 2804608043),
		   (143, 'El Choique', 'Nicolás', 'Romero', 2, 2, 2804360804),
		   (144, 'Las Violetas', 'Sergio', 'Ortiz', 51, 2, 2975765517),
		   (145, 'Proveeduría - Bar', 'Francisco', 'Bonfiglio', 41, 2, 2979874514),
		   (146, 'Móvil Pozo de Oro', 'Tomás', 'Durso', 12, 1, 2945828922),
		   (147, 'San Eduardo', 'Tomás', 'Castro Ponce', 30, 2, 2804239945),
		   (148, 'Quichaura 2', 'Lucas', 'Ambrogio', 11, 2, 2804506513),
		   (149, 'Doña Flora', 'Juan', 'Infante', 12, 1, 2979055366),
		   (150, 'San Martín', 'Máximo', 'Pereira', 39, 2, 2945330292),
		   (151, 'El Salpu', 'Mateo', 'Coronel', 4, 2, 2974651314),
		   (152, 'Cabo Raso', 'Matías', 'Orihuela', 53, 2, 2966347814),
		   (153, 'Móvil Senasa', 'Justo', 'Giani', 25, 1, 2804587136),
		   (154, 'La Pampa', 'Julián', 'Carrasco', 47, 1, 2945442379),
		   (155, 'Yala Laubat', 'Alexis', 'Rad', 36, 2, 2804739446),
		   (156, 'Laguna Fría', 'Luis', 'Rodríguez', 47, 1, 2974586278),
		   (157, 'Móvil Fauna', 'Marcelo', 'Barovero', 15, 3, 2946157244),
		   (158, 'Móvil Fauna', 'Alexis', 'Maldonado', 15, 1, 2945107693),
		   (159, 'Móvil Fauna', 'Franco', 'Quinteros', 14, 1, 2804761736),
		   (160, 'Luján', 'Alejandro', 'Maciel', 30, 1, 2978680970),
		   (161, 'Móvil Doña Flora', 'Nicolás', 'Linares', 49, 1, 2804623609),
		   (162, 'Hospital Río Pico', 'Aaron', 'Quiros', 8, 2, 2804871717),
		   (163, 'Ñancuñique', 'Gerónimo', 'Rivera', 16, 2, 2973180650),
		   (164, 'La Cumbre', 'Jesús', 'Soraire', 24, 1, 2945229459),
		   (165, 'San José', 'Milton', 'Giménez', 48, 3, 2974497552),
		   (166, 'La Etelvina', 'Matías', 'González', 18, 2, 2972670539),
		   (167, 'Costa del Lepá', 'Bruno', 'Sepúlveda', 19, 2, 2975767587),
		   (168, 'Sierras de Tecka', 'Facundo', 'Sanguinetti', 43, 2, 2804767865),
		   (169, 'Sierras del Huancache', 'Braian', 'Galván', 48, 1, 2978927479),
		   (170, 'Las Golondrinas', 'Lautaro', 'Ríos', 19, 3, 2804538680),
		   (171, 'Móvil Manzano', 'Alejandro', 'Cabrera', 46, 1, 2972406571),
		   (172, 'Aldea Epulef', 'Juan', 'Bisanz', 26, 2, 2966809640),
		   (173, 'Móvil Chacay', 'Mauricio', 'Roldan', 12, 2, 2804637849),
		   (174, 'Los Abuelos', 'Ezequiel', 'Bonifacio', 10, 1, 2945381717),
		   (175, 'Móvil Meseta 1', 'Ignacio', 'Rodríguez', 12, 1, 2973543914),
		   (176, 'Móvil Meseta 2', 'Facundo', 'Vila', 20, 2, 2945165447),
		   (177, 'Pampa de Agnia', 'Juan', 'Álvarez', 47, 1, 2972601287),
		   (178, 'Gure Echea', 'Lucas', 'Palavecino', 44, 1, 2804060612),
		   (179, 'El Pantanito', 'Martín', 'Cañete', 43, 1, 2972123421),
		   (180, 'Tramaleo', 'Luciano', 'Recalde', 37, 2, 2803978290),
		   (181, 'El Puntudo', 'Lautaro', 'Gomez', 49, 2, 2806229352),
		   (182, 'Corral de Piedra', 'Federico', 'Medina', 44, 3, 2966826807),
		   (183, 'Móvil Jones', 'Juan', 'Iribarren', 4, 2, 2973097008),
		   (184, 'Santa Rita', 'Juan', 'Quintana', 25, 2, 2945799561),
		   (185, 'Sierra Fría', 'Yvo', 'Calleros', 11, 2, 2804255544),
		   (186, 'La Porfía', 'Emanuel', 'Coronel', 45, 2, 2971856215),
		   (187, 'Dos Lagunas', 'Emanuel', 'Insúa', 38, 2, 2801247671),
		   (188, 'La Constancia', 'Mateo', 'Pérez', 28, 2, 2804637682),
		   (189, 'La Elenita', 'Lautaro', 'Villegas', 47, 2, 2966162894),
		   (190, 'La Meseta', 'Marcos', 'Echeverría', 16, 2, 2972411598),
		   (191, 'Cerro Negro', 'Alexander', 'Byndgaard', 7, 2, 2804786060),
		   (192, 'Riscoso', 'Lautaro', 'Cardozo', 26, 2, 2804739912),
		   (193, 'Maroma', 'Gabriel', 'Aranda', 31, 2, 2972295039),
		   (194, 'Jara Ubaldo', 'Cristian', 'Núñez', 2, 2, 2945829909),
		   (195, 'La Porteña', 'Rafael', 'Ferrario', 9, 1, 2966458787),
		   (196, 'Sierra Rosada', 'Nicolás', 'Capraro', 50, 1, 2972454764),
		   (197, 'Cerro Luján', 'Nicolás', 'Tolosa', 30, 1, 2945551706),
		   (198, 'Móvil Cerro Luján', 'Pedro', 'Velurtas', 13, 2, 2809462397),
		   (199, 'Central Rawson', 'Rodrigo', 'Herrera', 21, 2, 2972410206),
		   (200, 'Istmo Ameghino', 'Rodrigo', 'Insúa', 17, 2, 2972777083),
		   (237, 'Municipalidad de Telsen', 'Siro', 'Rosane', 47, 1, 2975825852),
		   (295, 'Hospital Río Pico', 'Alexis', 'Domínguez', 42, 1, 2972446569),
		   (296, 'San Efren', 'Alan', 'Cantero', 25, 1, 29454631559),
		   (297, 'La Romanza', 'Gonzalo', 'Goñi', 21, 1, 2966994653),
		   (298, 'Costa del Lepá', 'Nicolás', 'Demartini', 42, 1, 2977215216),
		   (299, 'Costa del Chubut', 'Ramón', 'Ábila', 31, 1, 2966793713),
		   (300, 'Costa del Gualjaina', 'Carlos', 'Arce', 40, 1, 2801264256),
		   (301, 'Colonia Cushamen', 'Jhonatan', 'Candía', 47, 1, 2972130190),
		   (302, 'Cerro Cóndor', 'Lucas', 'Brochero', 1, 1, 2972679176),
		   (303, 'Leleque', 'Bahiano', 'García', 38, 1, 2945892631),
		   (304, 'Sepaucal', 'Lucas', 'Faggioli', 18, 1, 2972430494),
		   (305, 'Ranquil Huao', 'Manuel', 'Duarte', 1, 1, 2966398393),
		   (306, 'Piedra Parada', 'Sebastián', 'Moyano', 55, 1, 297996364),
		   (307, 'Ñorquinco Sur', 'Agustín', 'Irazoque', 4, 1, 2966849492),
		   (308, 'Lago Rosario', 'Marco', 'Iacobellis', 36, 1, 2802581739),
		   (309, 'Fofo Cahuel', 'Daniel', 'Juárez', 35, 1, 297224805),
		   (310, 'Punta Pirámides', 'Marcelo', 'Miño', 54, 1, 2945807627),
		   (311, 'San Jorge', 'Santiago', 'Coronel', 42, 1, 2945766975),
		   (312, 'Lagunita Salada', 'Facundo', 'Mater', 29, 1, 2966192464),
		   (313, 'El Turbio', 'Alex', 'Juárez', 38, 1, 297855639),
		   (315, 'Gorro Frigio', 'Lucas', 'López', 29, 1, 2801833303),
		   (316, 'Santa Ana', 'Maximiliano', 'Zalazar', 38, 1, 280183330),
		   (318, 'La Chiquita', 'Federico', 'Aguirre', 13, 2, 2972825762),
		   (319, 'El Tathuencay', 'Maximiliano', 'Puig', 4, 2, 2966187332),
		   (320, 'El Sombrero', 'Ignacio', 'Chicco', 32, 1, 2807655546),
		   (321, 'El Mirasol', 'Gonzalo', 'Maffini', 28, 1, 2972866784),
		   (322, 'El Escorial', 'Juan', 'Barinaga', 5, 1, 2804638181),
		   (323, 'El Chenque', 'Santiago', 'Longo', 20, 1, 2945291309),
		   (324, 'Chacay Oeste', 'Alejandro', 'Rébola', 12, 1, 2945804290),
		   (325, 'La Tapera', 'Matías', 'Suárez', 1, 1, 2966356413),
		   (326, 'Cabo Dos Bahías', 'Mariano', 'Miño', 26, 1, 2972828646),
		   (327, 'Buen Pasto', 'Lucas', 'Passerini', 23, 1, 2806039078),
		   (328, 'Blancuntre', 'Matías', 'Marin', 41, 1, 2806496318),
		   (329, 'Aldea Apeleg', 'Bryan', 'Reyna', 41, 1, 2973089257),
		   (330, 'Las Malvinas', 'Ulises', 'Sánchez', 43, 1, 2966775219),
		   (331, 'Punta Tombo', 'Nicolás', 'Meriano', 53, 1, 2966663926),
		   (332, 'Puerto Lobos', 'Matías', 'Palavecino', 35, 1, 2972886218),
		   (333, 'Punta Norte', 'Matías', 'García', 13, 1, 2966452273),
		   (334, 'El Desempeño', 'Esteban', 'Rolón', 55, 1, 2945372576),
		   (335, 'Isla de los Pájaros', 'Lautaro', 'Pastrán', 14, 1, 2972133601),
		   (336, 'Caleta Valdés', 'Pablo', 'Chavarría', 4, 1, 2972333933),
		   (337, 'Nant y Fall', 'Nicolás', 'Schiappacasse', 22, 1, 2966685428),
		   (338, 'Yala Laubat', 'Ignacio', 'Tapia', 41, 1, 2803134949),
		   (339, 'Los Tamariscos', 'Alex', 'Ibacache', 9, 1, 2966237538),
		   (341, 'Bosque Petrificado', 'Facundo', 'Quignon', 2, 1, 2802982496),
		   (342, 'El Cipres', 'Francisco', 'González Metilli', 35, 2, 2966438868),
		   (343, 'Don Juan', 'Nahuel', 'Losada', 32, 1, 2972810777),
		   (345, 'Don Alberto', 'Facundo', 'Lencioni', 50, 2, 2945123785),
		   (349, 'Choiquenilahue', 'Matías', 'Daniele', 13, 2, 2978169024),
		   (350, 'San Agustín', 'Franco', 'Jara', 45, 1, 2965957141),
		   (351, 'El Hornito', 'Ariel', 'Rojas', 1, 2, 2965367360),
		   (352, 'Aguada Grande', 'Rafael', 'Delgado', 36, 2, 2965449892),
		   (353, 'Los Colorados', 'Gerónimo', 'Heredia', 20, 1, 2965453296),
		   (401, 'Las Delicias', 'Francisco', 'Facello', 12, 2, 2945628294),
		   (402, 'El Pobre Gaucho', 'Mariano', 'Troilo', 31, 2, 2972761857),
		   (403, 'Pirre Ñuque', 'Lucas', 'Argayo', 6, 2, 2806704888),
		   (404, 'Don Cucho', 'Matías', 'Moreno', 17, 2, 29669652344),
		   (405, 'Aguada La Mula', 'Jeremías', 'Lucco', 13, 2, 2966765243),
		   (406, 'Galpón de Acopio Lagunita Fría', 'Franco', 'Rami', 44, 2, 2965976583),
		   (407, 'El Alamito', 'Elías', 'Ayala', 9, 2, 2945459077),
		   (408, 'La Perezosa', 'Agustín', 'Baldi', 32, 1, 2965111014),
		   (409, 'El Manzano', 'Tiago', 'Benzi', 41, 2, 2965168827),
		   (410, 'La Buitrera', 'Lucas', 'Bernabeu', 9, 2, 2972284865),
		   (411, 'El Cano', 'Lucas', 'Bustos', 24, 2, 2809576104),
		   (412, 'Los 8 Hermanos', 'Yuri', 'Casermeiro', 6, 2, 2966262848),
		   (413, 'El Álamo', 'Santiago', 'Ferez', 48, 2, 2972225152),
		   (414, 'El Pino', 'Ramiro', 'Hernandes', 54, 2, 2972632093),
		   (415, 'El Pangare', 'Máximo', 'Oses', 49, 2, 2972327013),
		   (416, 'El Conejo', 'Juan', 'Velázquez', 41, 2, 2972493289),
		   (417, 'La Pichana', 'Gonzalo', 'Zeralayan', 49, 2, 2965111367),
		   (418, 'El Dormilón', 'Tomás', 'Dietz', 17, 2, 2972348602),
		   (419, 'El Pedrero', 'Álvaro', 'García', 45, 2, 297230039),
		   (420, 'Sierra Chata', 'Santino', 'Gatti', 49, 2, 2966196874),
		   (421, 'Arroyo del Telsen', 'Lautaro', 'Gutiérrez', 54, 2, 2978568717),
		   (422, 'Ranquil Huao', 'Francisco', 'Razzeto', 12, 2, 2945862150),
		   (423, 'Rebeca Ibañez', 'Sergio', 'Romero', 28, 2, 2965699013),
		   (424, 'Los Saucos', 'Cristian', 'Lema', 20, 2, 2976765407),
		   (425, 'Las Horquetas', 'Marcelo', 'Saracchi', 32, 2, 2972706745),
		   (426, 'Las Margaritas', 'Nicolás', 'Figal', 14, 2, 2966292209),
		   (427, 'Crina al Viento', 'Ezequiel', 'Bullaude', 53, 1, 2945769194),
		   (428, 'Oficina CORFO Telsen', 'Marcos', 'Rojo', 17, 2, 297274854),
		   (429, 'Los Berros', 'Exequiel', 'Zeballos', 30, 2, 2965567865),
		   (430, 'Catán Lil', 'Guillermo', 'Fernández', 29, 2, 2972186094),
		   (431, 'El Mirador de Sierra Chata', 'Darío', 'Benedetto', 37, 2, 2945848844),
		   (432, 'Cerro Colorado', 'Edinson', 'Cavani', 41, 2, 2945182439),
		   (433, 'El Rincón', 'Lucas', 'Janson', 38, 2, 2966663875),
		   (434, 'Los Claveles', 'Leandro', 'Brey', 49, 2, 2965133251),
		   (435, 'La Cumbre', 'Javier', 'García', 2, 2, 2965235291),
		   (436, 'Los Sauces', 'Luca', 'Langoni', 27, 2, 2974576084),
		   (437, 'Aguada Grande', 'Nicolás', 'Valentini', 3, 3, 2965789308),
		   (438, 'El Gateado', 'Miguel', 'Merentiel', 22, 2, 2965394605),
		   (439, 'Galpón de Acopio', 'Luis', 'Advíncula', 13, 2, 2965967623),
		   (440, 'La Ventana', 'Frank', 'Fabra', 22, 2, 2971980559),
		   (443, 'La Paloma', 'Juan', 'Ramírez', 47, 2, 2965375434),
		   (444, 'Aníbal González', 'Ezequiel', 'Fernández', 43, 2, 2966879606),
		   (445, 'La Esperanza', 'Kevin', 'Zenón', 15, 2, 28042535142),
		   (446, 'La Chaquira', 'Lautaro', 'Blanco', 43, 2, 2972328179),
		   (447, 'Daniel Carriqueo', 'Bruno', 'Valdez', 28, 2, 2945169176),
		   (448, 'Ceferino', 'Norberto', 'Briasco', 49, 2, 2971341724),
		   (449, 'El Michay', 'Román', 'Rodríguez', 38, 2, 2977931480),
		   (450, 'Nereo Antipán', 'Mateo', 'Mendía', 10, 2, 2965544672),
		   (451, 'Comunidad Fentren Peñi', 'Valentino', 'Simoni', 46, 3, 2965557551),
		   (452, 'El Calafate', 'Cristian', 'Medina', 27, 2, 2945429547),
		   (454, 'El Solitario', 'Sebastián', 'Díaz', 44, 1, 2966693876),
	 	   (456, 'Aldea Cerro Cóndor', 'Aaron', 'Anselmino', 38, 2, 2966592218),
		   (457, 'Laguna Cona', 'Vicente', 'Taborda', 15, 2, 2972666285),
		   (458, 'El Amanecer', 'Lautaro', 'Di Lollo', 4, 1, 2945672557),
		   (459, 'La Esperanza', 'Iker', 'Zufiaurre', 18, 2, 2971000235),
		   (461, 'Laguna Las Liebres', 'Lucas', 'Blondel', 27, 2, 2804427077),
		   (462, 'Equipo BLU 1 CORFO', 'Milton', 'Delgado', 26, 2, 2808261269),
		   (464, 'Equipo BLU 2 CORFO', 'Ignacio', 'Rodríguez', 27, 2, 2972837383),
		   (467, 'Equipo BLU 3 CORFO', 'Mauricio', 'Benítez', 40, 3, 2972796357),
		   (468, 'Don Francisco', 'Juan', 'Payal', 52, 2, 2945427358),
		   (469, 'Los Mimbres', 'Jabes', 'Saralegui', 45, 1, 2807052705),
		   (500, 'Arroyo Pescado', 'Dylan', 'Gorosito', 41, 2, 2809011541),
		   (501, 'Los Retoños', 'Jorman', 'Campuzano', 54, 2, 2966203388),
		   (502, 'Don Ombito', 'Julián', 'Ceballos', 25, 2, 2965387603),
		   (503, '16 de Marzo', 'Santiago', 'Dalmasso', 28, 2, 2966857027),
		   (504, 'Mallín Angosto', 'Walter', 'Molas', 31, 2, 2965359024),
		   (505, 'Manantial Alegre', 'Marcelo', 'Weigandt', 6, 2, 2966981843),
		   (506, 'La Altura', 'Andrés', 'Ferro', 14, 2, 297638350),
		   (507, 'El Chalía', 'Leonardo', 'Marchi', 31, 2, 2965733619),
		   (508, 'Don Alfredo', 'Fernando', 'Torrent', 27, 2, 2966372474),
		   (509, 'Los Manantiales', 'Dardo', 'Miloc', 6, 1, 2972411434),
		   (510, 'Santa Ángela', 'Sebastián', 'Valdez', 52, 2, 2972337165),
		   (511, 'Móvil Guillermo Fernández', 'Maximiliano', 'Alvez', 49, 2, 2966412308),
		   (512, 'Mallín Grande', 'Enzo', 'Kalinski', 26, 2, 2972186604),
		   (513, 'Fundación Patagonia Natural', 'Cristhian', 'Ocampos', 50, 2, 2945836252),
		   (514, 'Tres Manantiales', 'Mateo', 'Sanabria', 44, 2, 2945825970),
		   (515, 'La Chacra', 'Matías', 'Godoy', 21, 2, 2945204144),
		   (516, 'La Soledad', 'Sergio', 'Juárez', 15, 2, 2966135308),
		   (517, 'Móvil John Gago', 'Lautaro', 'Montoya', 7, 2, 2966400048),
		   (518, 'Móvil José Rechene', 'Tomán', 'Molina', 9, 2, 2965604587),
		   (519, 'Móvil José Rechene', 'Harrinson', 'Mancilla', 25, 2, 2973808081),
		   (520, 'Móvil José Rechene', 'Federico', 'Andueza', 44, 2, 2965698822),
		   (521, 'José Rechene', 'Thiago', 'Thomas Nuss', 37, 2, 2965109942),
		   (522, 'Huentelen', 'Agustín', 'Morales', 46, 2, 2965540434),
		   (523, 'Aldea Epulef', 'Brandon', 'Cortes', 16, 2, 2965493977),
		   (610, 'María Isabel', 'Matías', 'Mansilla', 20, 2, 2966191662),
		   (612, 'Los 5 Hermanos', 'Rodrigo', 'Atencio', 52, 2, 2965867683),
		   (613, 'El Caramelo', 'Santiago', 'Laquidain', 4, 3, 2965303242),
		   (614, 'El Mirador', 'Luis', 'Ingolotti', 52, 3, 2972919219),
		   (615, 'Taquetren', 'Juan', 'Meli', 51, 3, 2965315305),
		   (619, 'Atilio Viglione', 'Ramón', 'Cansinos', 19, 1, 2945332994),
		   (628, 'Móvil Vialidad Provincial', 'Kevin', 'Vazquez', 18, 1, 2979618054),
		   (633, 'Móvil Vialidad Provincial', 'Manuel', 'García', 20, 1, 2972801997),
		   (700, 'Móvil Vialidad Provincial', 'Pablo', 'Minissale', 47, 1, 2966358224),
		   (701, 'Móvil Vialidad Provincial', 'Ignacio', 'Galván Vittar', 44, 1, 2965922124),
		   (702, 'Móvil Vialidad Provincial', 'Walter', 'Montoya', 15, 1, 2945762779),
		   (703, 'Móvil Vialidad Provincial', 'Franco', 'Cáceres', 43, 1, 2965579224),
		   (704, 'Móvil Vialidad Provincial', 'Andrés', 'Mehring', 17, 1, 297268656),
		   (705, 'Móvil Vialidad Provincial', 'Brian', 'Rojas', 41, 1, 2979527621),
		   (706, 'Móvil Vialidad Provincial', 'José', 'Gomez', 1, 1, 2965894716),
		   (707, 'Móvil Vialidad Provincial', 'Camilo', 'Viganoni', 31, 1, 2979222752),
		   (708, 'Móvil Vialidad Provincial', 'Brian', 'Leizza', 20, 1, 2965546605),
		   (709, 'Móvil Vialidad Provincial', 'Florián', 'Monzón', 54, 1, 297301346),
		   (710, 'Móvil Vialidad Provincial', 'Oscar', 'Garrido', 53, 1, 2965336876),
		   (711, 'Móvil Vialidad Provincial', 'Lucas', 'Escobar', 10, 1, 2973373590),
		   (712, 'Móvil Vialidad Provincial', 'Andrés', 'Berizovsky', 54, 1, 2945942263),
		   (713, 'Móvil Vialidad Provincial', 'Alexis', 'Soto', 45, 1, 2965373638),
		   (714, 'Móvil Vialidad Provincial', 'Nicolás', 'Tripicchio', 23, 1, 2974226029),
		   (715, 'Móvil Vialidad Provincial', 'Facundo', 'Gutiérrez', 40, 1, 2945903401),
		   (716, 'Móvil Vialidad Provincial', 'Esteban', 'Burgos', 23, 1, 2965843156),
		   (717, 'Móvil Vialidad Provincial', 'Lautaro', 'Fedele', 51, 1, 2979158740),
		   (718, 'Móvil Vialidad Provincial', 'Julián', 'Lopez', 9, 1, 2965948508),
		   (719, 'Móvil Vialidad Provincial', 'Santiago', 'Godoy', 26, 1, 2965130952),
		   (720, 'Móvil Vialidad Provincial', 'Rodrigo', 'Bogarin', 40, 1, 2805541192),
		   (721, 'Móvil Vialidad Provincial', 'Gastón', 'Togni', 45, 1, 2979588783),
		   (722, 'Móvil Vialidad Provincial', 'Máximo', 'Gonzales', 19, 1, 2972791248),
		   (723, 'Móvil Vialidad Provincial', 'Esteban', 'Lucero', 28, 1, 2972384125),
		   (724, 'Móvil Vialidad Provincial', 'Ezequiel', 'Cannavo', 39, 1, 2945468784),
		   (725, 'Móvil Vialidad Provincial', 'Ramiro', 'García', 15, 1, 2965227701),
		   (726, 'Móvil Vialidad Provincial', 'Aaron', 'Molinas', 17, 1, 2945227599),
		   (727, 'Móvil Vialidad Provincial', 'Gabriel', 'Alanís', 18, 1, 2965663924),
		   (728, 'Móvil Vialidad Provincial', 'Franco', 'Romero', 36, 1, 2966657323),
		   (729, 'Móvil Vialidad Provincial', 'David', 'Barbona', 3, 1, 2972741180),
		   (730, 'Móvil Vialidad Provincial', 'Elías', 'Calderon', 46, 1, 2945365128),
		   (731, 'Móvil Vialidad Provincial', 'Santiago', 'Ramos', 8, 1, 2965597426),
		   (732, 'Móvil Vialidad Provincial', 'Cristopher', 'Fiermarin', 12, 1, 2965444429),
		   (733, 'Móvil Vialidad Provincial', 'Enrique', 'Bologna', 11, 1, 2965522866),
		   (734, 'Móvil Vialidad Provincial', 'Francisco', 'Marco', 37, 1, 2966550506),
		   (735, 'Móvil Vialidad Provincial', 'Fernando', 'Farias', 55, 1,2945567588),
		   (736, 'Móvil Vialidad Provincial', 'Jorge', 'Cáceres', 5, 1,2966962099),
		   (737, 'Móvil Vialidad Provincial', 'Luciano', 'Herrera', 21, 1,2809785068),
		   (738, 'Móvil Vialidad Provincial', 'Emanuel', 'Aguilera', 22, 1,2945697952),
		   (739, 'Móvil Vialidad Provincial', 'Nicolás', 'Fernández', 30, 1,2965878944),
		   (740, 'Móvil Vialidad Provincial', 'Kevin', 'López', 5, 1,2966264097),
		   (741, 'Móvil Vialidad Provincial', 'Tiago', 'Serrago', 3, 1,2972154153),
		   (742, 'Móvil Vialidad Provincial', 'Matías', 'Sosa', 18, 1,2945608540),
		   (743, 'Móvil Vialidad Provincial', 'Nicolás', 'Palavecino', 51, 1,2965797987),
		   (744, 'Móvil Vialidad Provincial', 'Facundo', 'Quintana', 54, 1,2801993464),
		   (745, 'Móvil Vialidad Provincial', 'Benjamín', 'Schamine', 55, 1,2806390221),
		   (746, 'Móvil Vialidad Provincial', 'Facundo', 'Echeverría', 5, 1,2965837817),
		   (747, 'Móvil Vialidad Provincial', 'Nicolás', 'Blandi', 51, 1,2966336647),
		   (748, 'Móvil Vialidad Provincial', 'Lorenzo', 'Brun', 3, 1,2972888100),
		   (749, 'Móvil Vialidad Provincial', 'Tomás', 'Sives', 55, 1,2965303305),
		   (750, 'Móvil Vialidad Provincial', 'Ulises', 'Giménez', 46, 1,2965428784),
		   (751, 'Móvil Vialidad Provincial', 'Elián', 'Sosa', 41, 1,2965952137),
		   (752, 'Móvil Vialidad Provincial', 'Alejo', 'Valenzuela', 49, 1,297771226),
		   (753, 'Móvil Vialidad Provincial', 'Thomas', 'Oliveri', 33, 1,2971346048),
		   (754, 'Móvil Vialidad Provincial', 'Mateo', 'Aguiar', 50, 1,2966207116),
		   (755, 'Móvil Vialidad Provincial', 'Yorman', 'Zapata', 20, 1,2807245468),
		   (756, 'Móvil Vialidad Provincial', 'Ignacio', 'Arce', 5, 1,2972932853),
		   (757, 'Móvil Vialidad Provincial', 'Nahuel', 'Iribarren', 29, 1,2945132681),
		   (758, 'Móvil Vialidad Provincial', 'Nicolás', 'Caro Torres', 53, 1,2945651812),
		   (759, 'Móvil Vialidad Provincial', 'Yaison', 'Murillo', 11, 1,2807605321),
		   (760, 'Móvil Vialidad Provincial', 'Pedro', 'Ramírez', 35, 1,2966128167),
		   (761, 'Móvil Vialidad Provincial', 'Nicolás', 'Dematei', 40, 1,2966327667),
		   (762, 'Móvil Vialidad Provincial', 'Mauro', 'Ortiz', 31, 1,2966358662),
		   (763, 'Móvil Vialidad Provincial', 'Milton', 'Celiz', 43, 1,2966645024),
		   (764, 'Móvil Vialidad Provincial', 'Jonathan', 'Herrera', 55, 1,2965281412),
		   (765, 'Móvil Vialidad Provincial', 'Gonzalo', 'Bravo', 6, 1,2966389281),
		   (766, 'Móvil Vialidad Provincial', 'Walter', 'Acuña', 51, 1,2808063567),
		   (767, 'Móvil Vialidad Provincial', 'Nahuel', 'Manganelli', 31, 1,29654783617),
		   (768, 'Móvil Vialidad Provincial', 'Juan Ignacio', 'Dobboletta', 55, 1,29725942556),
		   (769, 'Móvil Vialidad Provincial', 'Pablo', 'Monje', 29, 1,2965430820),
		   (770, 'Móvil Vialidad Provincial', 'Nicolás', 'Sansotre', 12, 1,2801780541),
		   (771, 'Móvil Vialidad Provincial', 'Guillermo', 'Pereira', 54, 1,2972383567),
		   (772, 'Móvil Vialidad Provincial', 'Gustavo', 'Fernández', 7, 1,297124669),
		   (773, 'Móvil Vialidad Provincial', 'Samuel', 'Portillo', 32, 1,297768330),
		   (774, 'Móvil Vialidad Provincial', 'Jonathan', 'Goya', 53, 1,280985116),
		   (775, 'Móvil Vialidad Provincial', 'Enzo', 'Avaro', 30, 1,2804326092),
		   (776, 'Móvil Vialidad Provincial', 'Ramón', 'González', 28, 1,2965873469),
		   (777, 'Móvil Vialidad Provincial', 'José', 'Méndez', 30, 1,2966814499),
		   (778, 'Móvil Vialidad Provincial', 'Joaquín', 'Borja', 18, 1,2803708597),
		   (779, 'Vialidad Provincial', 'Gustavo', 'Benítez', 35, 1,2977572566),
		   (780, 'Vialidad Provincial', 'William', 'Machado', 35, 1,2972900923),
		   (781, 'Vialidad Provincial', 'Tomás', 'Villoldo', 3, 1,2966502181),
		   (782, 'Vialidad Provincial', 'Jonathan', 'Goitia', 12, 1,2972464896),
		   (783, 'Vialidad Provincial', 'Gabriel', 'Cañete', 16, 1,2972790962),
		   (784, 'Móvil Vialidad Provincial', 'Maximiliano', 'Rodríguez', 15, 1,2945542783),
		   (785, 'Móvil Vialidad Provincial', 'Leonardo', 'Landriel', 44, 1,2945668415),
		   (786, 'Móvil Vialidad Provincial', 'Matteo', 'Cucinotta', 2, 1,2972696602),
		   (787, 'Móvil Vialidad Provincial', 'Nicolás', 'Benegas', 15, 1,2945537480),
		   (788, 'Móvil Vialidad Provincial', 'Maximiliano', 'Brito', 25, 1,2965813250),
		   (789, 'Móvil Vialidad Provincial', 'Juan', 'Martins', 30, 1,2803476646),
		   (790, 'Móvil Vialidad Provincial', 'Héctor', 'Varela', 36, 1,2972931243),
		   (791, 'Móvil Vialidad Provincial', 'Delfor', 'Minervino', 10, 1,2965396160),
		   (792, 'Móvil Vialidad Provincial', 'Alan', 'Barrionuevo', 35, 1,2965317290),
		   (793, 'Móvil Vialidad Provincial', 'Fabricio', 'Iacovich', 49, 1,2972812228),
		   (794, 'Móvil Vialidad Provincial', 'Zaid', 'Romero', 40, 1,2972401778),
		   (795, 'Móvil Vialidad Provincial', 'Nicolás', 'Fernández', 11, 1,2966172220),
		   (796, 'Móvil Vialidad Provincial', 'Santiago', 'Flores', 39, 1,297566556),
		   (797, 'Móvil Vialidad Provincial', 'Santiago', 'Ascacibar', 48, 1,2965450898),
		   (798, 'Móvil Vialidad Provincial', 'Federico', 'Fernández', 39, 1,2972190633),
		   (799, 'Móvil Vialidad Provincial', 'José', 'Sosa', 9, 1,2978534015),
		   (800, 'Móvil Vialidad Provincial', 'Fernando', 'Zuqui', 35, 1,2979832090),
		   (801, 'Móvil Vialidad Provincial', 'Guido', 'Carrillo', 21, 1,2966795602),
		   (802, 'Móvil Vialidad Provincial', 'Pablo', 'Piatti', 14, 1,2977398540),
		   (803, 'Móvil Vialidad Provincial', 'Matías', 'Mansilla', 38, 1,2966929329),
		   (804, 'Móvil Vialidad Provincial', 'Gastón', 'Benedetti', 4, 1,2972766742),
		   (805, 'Móvil Vialidad Provincial', 'Eros', 'Mancuso', 39, 1,2973000617),
		   (806, 'Móvil Vialidad Provincial', 'Franco', 'Zapiola', 28, 1,2807994342),
		   (807, 'Móvil Vialidad Provincial', 'Mauro', 'Mendez', 7, 1,2803402870),
		   (808, 'Móvil Vialidad Provincial', 'Javier', 'Altamirano', 6, 1,2972214716),
		   (809, 'Móvil Vialidad Provincial', 'Edwin', 'Cetre', 1, 1,2966592938),
		   (810, 'Móvil Vialidad Provincial', 'Alexis', 'Manyoma', 38, 1,2807036625),
		   (811, 'Móvil Vialidad Provincial', 'Eric', 'Meza', 8, 1,2945863796),
		   (812, 'Móvil Vialidad Provincial', 'Enzo', 'Pérez', 11, 1,2975190115),
		   (813, 'Móvil Vialidad Provincial', 'Ezequiel', 'Naya', 13, 1,2965685871),
		   (814, 'Móvil Vialidad Provincial', 'Bautista', 'Kociubinski', 39, 1,2945751940),
		   (815, 'Móvil Vialidad Provincial', 'Juan', 'Zozaya', 46, 1,2972991949),
		   (816, 'Móvil Vialidad Provincial', 'Luciano', 'Lollo', 2, 1,2966498461),
		   (817, 'Móvil Vialidad Provincial', 'Javier', 'Correa', 9, 1,2975716582),
		   (818, 'Móvil Vialidad Provincial', 'Nehuen', 'Benedetti', 2, 1,2945722622),
		   (819, 'Móvil Vialidad Provincial', 'Axel', 'Atum', 51, 1,2965608181),
		   (820, 'Móvil Vialidad Provincial', 'Rodrigo', 'Borzone', 35, 1,2966190829),
		   (821, 'Móvil Vialidad Provincial', 'Roman', 'Gomez', 19, 1,2965195779),
		   (822, 'Móvil Vialidad Provincial', 'Tiago', 'Palacios', 15, 1,297901575),
		   (823, 'Móvil Vialidad Provincial', 'Fabricio', 'Amato', 55, 1,2945422809),
		   (824, 'Móvil Vialidad Provincial', 'Valente', 'Pierani', 2, 1,2803698336),
		   (825, 'Móvil Vialidad Provincial', 'Mikel', 'Amondarain', 8, 1,2945847204),
		   (826, 'Móvil Vialidad Provincial', 'Juan Ignacio', 'Quattrocchi', 1, 1,2945585026),
		   (827, 'Móvil Vialidad Provincial', 'Fabricio', 'Pérez', 26, 1,2966907134),
		   (828, 'Móvil Vialidad Provincial', 'Joaquín', 'Tobio Burgos', 12, 1,2965274970),
		   (829, 'Móvil Vialidad Provincial', 'Joaquín', 'Pereyra', 28, 1,2800912358),
		   (830, 'Móvil Vialidad Provincial', 'Emanuel', 'Dallaglio', 44, 1,2978365270),
		   (831, 'Móvil Vialidad Provincial', 'Rodrigo', 'González', 47, 1,2945832495),
		   (832, 'Móvil Vialidad Provincial', 'Lucas', 'Cornejo', 24, 1,2965683192),
		   (833, 'Móvil Vialidad Provincial', 'Luca', 'Landriel', 4, 1,2965843587),
		   (834, 'Móvil Vialidad Provincial', 'Franco', 'Basualdo', 45, 1,2966525365),
		   (835, 'Móvil Vialidad Provincial', 'Matías', 'Contrera', 34, 1,2654709798),
		   (836, 'Móvil Vialidad Provincial', 'Juan', 'Arango', 47, 1,2966155983),
		   (837, 'Móvil Vialidad Provincial', 'Faustino', 'Messina', 2, 1,2806417828),
		   (838, 'Móvil Vialidad Provincial', 'Matías', 'Magdaleno', 54, 1,2945717584),
		   (839, 'Móvil Vialidad Provincial', 'Benjamín', 'Sagues', 37, 1,297314617),
		   (840, 'Móvil Vialidad Provincial', 'Rodrigo', 'Gallo', 15, 1,2945452878),
		   (841, 'Móvil Vialidad Provincial', 'Leonardo', 'Morales', 36, 1,2965902936),
		   (842, 'Móvil Vialidad Provincial', 'Rodrigo', 'Saravia', 13, 1,2945114098),
		   (843, 'Móvil Vialidad Provincial', 'Guillermo', 'Enrique', 32, 1,2802991960),
		   (844, 'Móvil Vialidad Provincial', 'Benjamín', 'Domínguez', 51, 1,2945346289),
		   (845, 'Móvil Vialidad Provincial', 'Yonatan', 'Rodríguez', 48, 1,2945493903),
		   (846, 'Móvil Vialidad Provincial', 'Matías', 'Abaldo', 30, 1,2945499372),
		   (847, 'Móvil Vialidad Provincial', 'Pablo', 'De Blasis', 39, 1,2945549090),
		   (848, 'Móvil Vialidad Provincial', 'Eric', 'Ramírez', 43, 1,2945333423),
		   (849, 'Móvil Vialidad Provincial', 'Julián', 'Kadijevic', 28, 1,2966656657),
		   (850, 'Móvil Vialidad Provincial', 'Marcos', 'Ledesma', 13, 1,2804280202),
		   (851, 'Móvil Vialidad Provincial', 'Agustín', 'Bolívar', 14, 1,2972534493),
		   (852, 'Móvil Vialidad Provincial', 'Juan', 'Pintado', 37, 1,2965755587),
		   (853, 'Móvil Vialidad Provincial', 'Matías', 'Ramírez', 10, 1,2945898624),
		   (854, 'Móvil Vialidad Provincial', 'Federico', 'Milo', 5, 1,2972789751),
		   (855, 'Móvil Vialidad Provincial', 'Nicolás', 'Colazo', 25, 1,2971345093),
		   (856, 'Móvil Vialidad Provincial', 'Lucas', 'Castro', 27, 1,2807795970),
		   (857, 'Móvil Vialidad Provincial', 'Jonathan', 'Cabral', 14, 1,2805324228),
		   (858, 'Móvil Vialidad Provincial', 'Lautaro', 'Chavez', 45, 1,2972879717),
		   (859, 'Móvil Vialidad Provincial', 'Matías', 'Miranda', 40, 1,2974680391),
		   (860, 'Móvil Vialidad Provincial', 'Nelson', 'Insfrán', 51, 1,2966747443),
		   (861, 'Móvil Vialidad Provincial', 'Luciano', 'Gomez', 46, 1,2965399253),
		   (862, 'Móvil Vialidad Provincial', 'David', 'Salazar', 14, 1,2972464475),
		   (863, 'Móvil Vialidad Provincial', 'Cristian', 'Colman', 41, 1,2972848644),
		   (864, 'Móvil Vialidad Provincial', 'Bautista', 'Barros Schelotto', 22, 1,2972543086),
		   (2679, 'Móvil Golondrinas', 'Ivo', 'Mammini', 35, 1,2945552151),
		   (2680, 'Móvil Aéreo WPB', 'Rodrigo', 'Castillo', 38, 1,2977990796),
		   (2681, 'Móvil Aéreo WPE', 'Gustavo', 'Canto', 29, 1,2972212380),
		   (2686, 'Móvil Agua', 'Franco', 'Troyansky', 54, 1,2945663029),
		   (2688, 'Móvil DICOF', 'Leandro', 'Mamut', 28, 1,2966202185),
		   (2689, 'Móvil Turismo', 'Juan', 'Cortazzo', 31, 1,2809132931),
		   (3951, 'Móvil 1 Prolana', 'Felipe', 'Sánchez', 43, 1,2972744879),
		   (3956, 'Móvil 2 Prolana', 'Valentín', 'Peñalva', 53, 1,2945326422),
		   (4001, 'Equipo para Central 1', 'Franco', 'Petroli', 17, 1,2945397812),
		   (4002, 'Equipo para Central 2', 'Pier', 'Barrios', 35, 1,2973080214),
		   (4003, 'Equipo para Central 3', 'Thomas', 'Galdames', 44, 1,2972908091),
		   (4004, 'Equipo BLU Móvil 4', 'Lucas', 'Arce', 14, 1,2971599797);
    
INSERT INTO operadores (nombre_operador, apellido_operador, dni, id_ubicacion, telefono, fecha_nacimiento, fecha_de_ingreso, email)
	VALUES ('Amelia', 'Casals', 45760209, 3, '2984445959', '1975-06-05', '1996-12-28', 'acasals@chubut.gov.ar'),
		   ('Damián', 'Pérez', 37394232, 2, '2874377396', '1955-12-10', '1986-05-09', 'dperez@chubut.gov.ar'),
		   ('Eva', 'Lozano', 41403776, 5, '2804984961', '1988-06-23', '2014-11-28', 'elozano@chubut.com.ar'),
		   ('Renata', 'González', 27669591, 2, '2844853353', '1965-04-13', '2004-01-14', 'rgonzalez@chubut.gov.ar'),
		   ('María Manuela', 'Acero', 20889762, 3, '2824778070', '1977-03-17', '2003-09-13', 'mmacero@chubut.gov.ar'),
		   ('Basilio', 'Ponce', 20117871, 5, '2824809095', '1982-09-22', '2012-03-22', 'bponce@chubut.gov.ar'),
		   ('Atilio', 'Requena', 46376464, 3, '2914492559', '1984-06-24', '2011-02-22', 'arequena@chubut.gov.ar'),
		   ('Desiderio', 'Hidalgo', 32156917, 5, '2834188474', '1969-11-28', '1997-08-04', 'dhidalgo@chubut.gov.ar'),
		   ('Aníbal', 'Olmo', 48160883, 2, '284808221', '1973-03-16', '2009-08-28', 'aolmo@chubut.gov.ar'),
		   ('José', 'Leal', 28512998, 5, '2934124467', '1977-09-12', '2015-08-14', 'jleal@chubut.gov.ar'),
		   ('Rómulo', 'Hoz', 36671219, 5, '2824852691', '1957-10-01', '1992-01-06', 'rhoz@chubut.gov.ar'),
		   ('Tomás', 'Fuentes', 41936620, 5, '2854005587', '1953-12-28', '1984-08-17', 'tfuentes@chubut.gov.ar'),
		   ('Gloria', 'Araujo', 34744147, 3, '2874800664', '1962-05-28', '2000-11-13', 'garaujo@chubut.gov.ar'),
		   ('Sebastián', 'Calderon', 32963488, 2, '2924962909', '1967-08-23', '1990-04-24', 'scalderon@chubut.gov.ar'),
		   ('Feliciano', 'Osorio', 20989338, 2, '2844834662', '1969-02-11', '1997-07-17', 'fosorio@chubut.gov.ar'),
		   ('Rosa', 'Calzada', 32933301, 2, '2874878025', '1959-04-04', '1994-05-23', 'rcalzada@chubut.gov.ar'),
		   ('Alfredo', 'Teruel', 28796771, 5, '2834307428', '1990-06-07', '2010-10-18', 'ateruel@chubut.gov.ar');

INSERT INTO comunicaciones (fecha, inicio, fin, id_tipo_comunicacion, id_corresponsal, id_codigo_q, id_observacion, telefono, id_operador)
	VALUES ('2023-01-02', '7:20', '7:22', 2, 513, 27, 10, '29453885362', 5),
		   ('2023-01-08', '5:03', '5:06', 1, 500, 18, 5, '29454072486', 17),
		   ('2023-01-12', '15:16', '15:20', 1, 107, 2, 3, '2809403552', 15),
		   ('2023-01-14', '3:38', '3:40', 1, 180, 10, 10, '3517074557', 12),
		   ('2023-01-15', '18:53', '18:56', 1, 141, 1, 10, '2804901763', 8),
		   ('2023-01-15', '20:20', '20:23', 1, 105, 8, 4, '2641591227', 2),
		   ('2023-01-17', '1:27', '1:32', 2, 165, 9, 10, '3511366810', 3),
		   ('2023-01-17', '3:11', '3:15', 1, 145, 16, 10, '2807051097', 1),
		   ('2023-01-18', '7:50', '7:51', 1, 421, 18, 5, '2976378552', 4),
		   ('2023-01-18', '23:30', '23:33', 1, 109, 26, 2, '29455927185', 12),
		   ('2023-01-23', '5:04', '5:06', 1, 184, 4, 10, '29724137296', 16),
		   ('2023-01-23', '19:44', '19:48', 2, 414, 19, 7, '29657352398', 7),
		   ('2023-01-24', '23:13', '23:15', 1, 117, 24, 9, '29724082947', 8),
		   ('2023-01-25', '2:36', '2:40', 1, 24, 6, 10, '2641970329', 11),
		   ('2023-01-25', '12:17', '12:18', 2, 414, 2, 3, '29654395944', 16),
	 	   ('2023-01-26', '2:59', '3:01', 1, 406, 19, 7, '29665045189', 9),
		   ('2023-01-30', '7:12', '7:15', 2, 116, 4, 10, '117138489', 10),
		   ('2023-01-30', '19:55', '20:00', 2, 295, 15, 1, '3838025555', 4),
		   ('2023-01-31', '12:29', '12:31', 2, 193, 22, 10, '29655466072', 5),
		   ('2023-01-31', '15:17', '15:19', 2, 521, 21, 10, '2973881755', 9),
		   ('2023-02-02', '16:45', '16:47', 1, 118, 21, 10, '3518847443', 4),
		   ('2023-02-03', '0:46', '0:47', 2, 303, 19, 7, '2649379628', 12),
		   ('2023-02-03', '13:38', '13:39', 2, 513, 13, 10, '115258554', 2),
		   ('2023-02-04', '1:19', '1:21', 2, 183, 14, 10, '2808824295', 12),
		   ('2023-02-04', '3:31', '3:34', 1, 191, 10, 10, '29657109756', 10),
		   ('2023-02-05', '19:04', '19:06', 2, 447, 13, 10, '112084782', 4),
		   ('2023-02-07', '18:49', '18:54', 1, 150, 6, 10, '3512212791', 8),
		   ('2023-02-08', '11:21', '11:24', 2, 100, 27, 10, '29456716410', 7),
		   ('2023-02-09', '2:13', '2:15', 1, 517, 9, 10, '29459296770', 3),
		   ('2023-02-09', '20:39', '20:44', 2, 199, 8, 4, '2971023571', 8),
		   ('2023-02-10', '4:07', '4:12', 1, 420, 3, 8, '2642359486', 5),
		   ('2023-02-12', '5:00', '5:03', 1, 166, 21, 10, '114428042', 5),
		   ('2023-02-17', '3:17', '3:22', 2, 325, 16, 10, '2978435311', 17),
		   ('2023-02-17', '11:51', '11:52', 2, 97, 23, 10, '29655730745', 10),
		   ('2023-02-17', '14:37', '14:39', 2, 438, 17, 10, '2619555994', 16),
		   ('2023-02-19', '18:01', '18:03', 2, 193, 11, 10, '117946686', 2),
		   ('2023-02-21', '21:35', '21:39', 1, 124, 26, 2, '2806534824', 5),
		   ('2023-02-23', '7:36', '7:40', 2, 331, 3, 8, '2966773740', 14),
		   ('2023-02-23', '8:33', '8:35', 2, 305, 20, 4, '2648120474', 2),
		   ('2023-02-23', '10:25', '10:27', 2, 144, 13, 10, '2975562486', 9),
		   ('2023-02-23', '21:31', '21:32', 1, 322, 4, 10, '118203746', 16),
		   ('2023-02-27', '3:24', '3:28', 2, 64, 9, 10, '29454407957', 15),
 		   ('2023-02-27', '16:38', '16:40', 1, 150, 18, 5, '29659789982', 16),
		   ('2023-02-28', '6:55', '6:57', 1, 110, 12, 10, '119088483', 13),
		   ('2023-03-01', '20:01', '20:06', 1, 162, 2, 3, '2972413477', 8),
		   ('2023-03-02', '4:10', '4:13', 2, 298, 18, 5, '2965192384', 5),
		   ('2023-03-03', '2:35', '2:40', 1, 196, 11, 10, '2972132702', 4),
		   ('2023-03-04', '14:08', '14:10', 1, 148, 24, 9, '2801579451', 2),
		   ('2023-03-05', '2:13', '2:16', 2, 457, 17, 10, '2974002278', 16),
		   ('2023-03-05', '15:04', '15:07', 1, 21, 12, 10, '2616381013', 7),
		   ('2023-03-05', '21:11', '21:13', 2, 506, 22, 10, '2972642595', 3),
		   ('2023-03-06', '6:38', '6:43', 2, 104, 23, 10, '3514722510', 8),
		   ('2023-03-06', '11:56', '11:57', 1, 456, 13, 10, '2615566677', 12),
		   ('2023-03-07', '2:40', '2:44', 2, 505, 16, 10, '2809756112', 13),
		   ('2023-03-08', '15:46', '15:51', 1, 140, 12, 10, '2945275809', 17),
		   ('2023-03-08', '17:25', '17:27', 1, 613, 3, 8, '2645034090', 2),
		   ('2023-03-18', '15:51', '15:54', 2, 404, 6, 10, '2966744063', 3),
		   ('2023-03-19', '0:26', '0:29', 1, 166, 2, 3, '3835471787', 11),
		   ('2023-03-19', '4:17', '4:22', 2, 338, 2, 3, '2641895219', 14),
		   ('2023-03-20', '9:36', '9:41', 2, 128, 23, 10, '2619060185', 5),
	   	   ('2023-03-20', '9:48', '9:52', 1, 106, 3, 8, '2642984673', 10),
		   ('2023-03-22', '7:57', '7:58', 2, 331, 26, 2, '2618224027', 11),
		   ('2023-03-24', '16:40', '16:42', 1, 298, 25, 6, '3514674915', 8),
		   ('2023-03-28', '2:49', '2:51', 1, 107, 27, 10, '2972928778', 5),
		   ('2023-03-30', '22:19', '22:22', 2, 506, 3, 8, '3514687228', 16),
		   ('2023-03-31', '8:34', '8:36', 1, 407, 20, 4, '3514202077', 1),
		   ('2023-04-01', '22:15', '22:17', 2, 128, 21, 10, '2617921327', 2),
		   ('2023-04-04', '9:08', '9:12', 1, 443, 2, 3, '2644300155', 13),
		   ('2023-04-05', '1:54', '1:59', 2, 350, 18, 5, '2804365248', 11),
		   ('2023-04-07', '9:11', '9:14', 2, 128, 8, 4, '2965250702', 2),
		   ('2023-04-07', '13:40', '13:45', 2, 447, 15, 1, '2945210010', 14),
		   ('2023-04-07', '15:26', '15:29', 1, 295, 18, 5, '3837160088', 11),
		   ('2023-04-08', '21:34', '21:35', 1, 129, 19, 7, '2807334372', 14),
		   ('2023-04-10', '14:55', '14:56', 2, 140, 26, 2, '2972161713', 16),
		   ('2023-04-13', '5:02', '5:04', 2, 339, 23, 10, '2965836822', 12),
		   ('2023-04-18', '3:19', '3:23', 2, 337, 20, 4, '2965490543', 17),
		   ('2023-04-19', '13:08', '13:12', 2, 501, 3, 8, '2643853837', 11),
		   ('2023-04-21', '10:50', '10:52', 1, 518, 19, 7, '2972246899', 12),
		   ('2023-04-22', '12:47', '12:50', 2, 186, 2, 3, '2642422777', 6),
		   ('2023-04-27', '2:03', '2:08', 2, 149, 19, 7, '2802771011', 12),
		   ('2023-04-28', '2:35', '2:38', 2, 503, 27, 10, '2966246059', 11),
		   ('2023-05-02', '13:45', '13:48', 2, 171, 17, 10, '113838415', 14),
		   ('2023-05-05', '17:01', '17:03', 1, 335, 3, 8, '3512034161', 5),
		   ('2023-05-06', '2:01', '2:03', 1, 515, 16, 10, '3832100313', 16),
	   	   ('2023-05-07', '15:32', '15:35', 2, 108, 12, 10, '2972563014', 13),
		   ('2023-05-08', '16:58', '17:01', 2, 64, 17, 10, '3832086948', 9),
		   ('2023-05-09', '3:42', '3:45', 1, 429, 10, 10, '2645880485', 7),
		   ('2023-05-11', '17:51', '17:55', 2, 297, 27, 10, '116849897', 15),
		   ('2023-05-17', '18:03', '18:05', 1, 409, 12, 10, '2976485722', 1),
		   ('2023-05-19', '3:13', '3:18', 2, 98, 26, 2, '2945282525', 4),
		   ('2023-05-19', '8:47', '8:48', 2, 179, 18, 5, '2966619110', 16),
		   ('2023-05-20', '6:18', '6:21', 2, 610, 10, 10, '3513739429', 13),
		   ('2023-05-20', '9:52', '9:55', 2, 180, 19, 7, '2965442937', 3),
		   ('2023-05-24', '0:53', '0:57', 2, 431, 25, 6, '2971472259', 16),
		   ('2023-05-24', '8:08', '8:10', 1, 433, 24, 9, '2966156771', 1),
		   ('2023-05-24', '23:30', '23:35', 2, 435, 2, 3, '3514816606', 11),
		   ('2023-05-26', '6:28', '6:30', 1, 97, 15, 1, '2807791635', 1),
		   ('2023-05-26', '21:24', '21:28', 1, 110, 13, 10, '2612159170', 10),
		   ('2023-05-30', '1:24', '1:25', 1, 126, 26, 2, '119202943', 6),
		   ('2023-06-02', '3:08', '3:09', 1, 107, 1, 10, '2966168636', 15),
		   ('2023-06-02', '12:51', '12:56', 1, 619, 14, 10, '3512286826', 14),
		   ('2023-06-02', '23:01', '23:05', 1, 94, 21, 10, '2966673541', 16),
		   ('2023-06-02', '23:30', '23:35', 1, 140, 11, 10, '2802828947', 4),
		   ('2023-06-03', '8:25', '8:28', 1, 1, 15, 1, '2945216013', 14),
		   ('2023-06-03', '9:14', '9:17', 1, 148, 26, 2, '2976851463', 11),
		   ('2023-06-05', '0:03', '0:05', 1, 95, 2, 3, '2974828245', 10),
		   ('2023-06-06', '7:02', '7:03', 1, 615, 19, 7, '2965136481', 8),
		   ('2023-06-07', '0:47', '0:49', 2, 150, 20, 4, '114342050', 3),
		   ('2023-06-10', '1:55', '1:58', 1, 338, 6, 10, '3513689374', 8),
		   ('2023-06-11', '19:25', '19:28', 1, 132, 26, 2, '3839513881', 17),
		   ('2023-06-14', '17:12', '17:16', 2, 110, 18, 5, '2972958991', 8),
	 	   ('2023-06-16', '5:31', '5:35', 2, 103, 3, 8, '2945349579', 7),
		   ('2023-06-16', '22:25', '22:29', 2, 142, 9, 10, '2613354939', 14),
		   ('2023-06-17', '2:06', '2:08', 1, 462, 27, 10, '2642877129', 13),
		   ('2023-06-23', '9:10', '9:14', 1, 147, 3, 8, '2945902638', 5),
		   ('2023-06-24', '17:10', '17:13', 2, 407, 18, 5, '3519956371', 6),
		   ('2023-06-27', '10:12', '10:14', 1, 180, 15, 1, '2965954398', 12),
	 	   ('2023-06-28', '13:08', '13:10', 1, 120, 17, 10, '3515373942', 6),
		   ('2023-06-29', '3:30', '3:33', 2, 134, 10, 10, '3833149563', 1),
		   ('2023-06-30', '23:02', '23:05', 1, 148, 6, 10, '2972102408', 14),
		   ('2023-07-02', '1:07', '1:08', 1, 162, 21, 10, '2972959990', 3),
		   ('2023-07-02', '7:10', '7:12', 2, 469, 1, 10, '2808586548', 16),
		   ('2023-07-03', '12:22', '12:24', 1, 97, 7, 4, '2973503429', 3),
		   ('2023-07-04', '23:05', '23:06', 1, 97, 7, 4, '2973503429', 3),
		   ('2023-07-06', '1:04', '1:08', 1, 133, 6, 10, '2808118358', 6),
		   ('2023-07-09', '0:57', '1:00', 2, 450, 14, 10, '2972846841', 15),
		   ('2023-07-12', '2:10', '2:13', 1, 106, 24, 9, '2972367967', 8),
		   ('2023-07-12', '12:22', '12:27', 2, 520, 2, 3, '2614339241', 4),
		   ('2023-07-13', '6:12', '6:14', 1, 140, 4, 10, '3513146276', 2),
		   ('2023-07-15', '3:51', '3:53', 1, 321, 19, 7, '2618691702', 11),
		   ('2023-07-15', '19:21', '19:25', 2, 193, 14, 10, '2977390057', 17),
		   ('2023-07-15', '21:36', '21:37', 2, 139, 27, 10, '116150820', 7),
		   ('2023-07-16', '3:27', '3:32', 2, 308, 24, 9, '3517887006', 17),
		   ('2023-07-16', '14:00', '14:02', 1, 316, 1, 10, '2645343175', 10),
		   ('2023-07-23', '13:27', '13:32', 1, 423, 11, 10, '2965720709', 12),
		   ('2023-07-24', '10:32', '10:33', 1, 184, 26, 2, '2646422801', 5),
		   ('2023-07-24', '20:37', '20:40', 2, 130, 21, 10, '117903150', 15),
		   ('2023-07-28', '23:46', '23:50', 1, 95, 17, 10, '2965152884', 1),
		   ('2023-07-30', '7:31', '7:36', 2, 55, 22, 10, '2965304078', 16),
		   ('2023-07-31', '14:09', '14:10', 2, 107, 2, 3, '2966995152', 17),
		   ('2023-08-03', '9:29', '9:32', 2, 166, 1, 10, '2645620822', 9),
		   ('2023-08-05', '20:44', '20:46', 2, 296, 3, 8, '2614296695', 13),
		   ('2023-08-07', '8:06', '8:09', 2, 130, 23, 10, '2643171022', 9),
		   ('2023-08-07', '14:02', '14:06', 2, 500, 1, 10, '2972870669', 2),
		   ('2023-08-07', '14:10', '14:14', 1, 434, 13, 10, '117035548', 2),
		   ('2023-08-08', '16:00', '16:03', 1, 126, 6, 10, '2648643681', 1),
		   ('2023-08-09', '0:36', '0:38', 2, 190, 7, 4, '2975546163', 3),
		   ('2023-08-11', '0:13', '0:15', 2, 456, 9, 10, '3518490516', 8),
		   ('2023-08-11', '2:46', '2:51', 2, 417, 9, 10, '3834087753', 6),
		   ('2023-08-11', '14:10', '14:11', 1, 99, 9, 10, '2972320020', 7),
		   ('2023-08-14', '1:13', '1:17', 2, 189, 27, 10, '2612227661', 12),
		   ('2023-08-19', '19:15', '19:18', 1, 143, 8, 4, '2966442481', 8),
		   ('2023-08-19', '20:51', '20:55', 1, 411, 5, 10, '22645678344', 16),
		   ('2023-08-22', '0:52', '0:53', 2, 443, 26, 2, '2966991833', 10),
		   ('2023-08-22', '4:59', '5:02', 1, 117, 20, 4, '3519919875', 9),
		   ('2023-08-23', '4:03', '4:05', 1, 151, 5, 10, '2945848562', 1),
		   ('2023-08-23', '13:43', '13:47', 1, 74, 17, 10, '119162704', 3),
		   ('2023-08-25', '4:46', '4:47', 2, 194, 21, 10, '3838981198', 13),
		   ('2023-08-31', '8:45', '8:49', 2, 445, 19, 7, '2945928278', 7),
		   ('2023-09-02', '4:02', '4:04', 1, 299, 9, 10, '115151059', 8),
		   ('2023-09-03', '10:12', '10:15', 1, 316, 27, 10, '3831293630', 3),
		   ('2023-09-04', '19:29', '19:33', 1, 297, 10, 10, '2945781471', 2),
		   ('2023-09-05', '9:43', '9:45', 1, 349, 23, 10, '119522063', 14),
		   ('2023-09-06', '4:49', '4:52', 1, 188, 6, 10, '118799151', 5),
		   ('2023-09-06', '14:02', '14:07', 1, 107, 22, 10, '2945590257', 14),
		   ('2023-09-06', '14:58', '15:02', 2, 177, 1, 10, '2945755931', 15),
		   ('2023-09-07', '7:44', '7:48', 2, 325, 12, 10, '2808140525', 9),
		   ('2023-09-10', '3:59', '4:01', 2, 342, 11, 10, '2642054463', 17),
		   ('2023-09-10', '21:08', '21:13', 2, 100, 4, 10, '2649905223', 12),
		   ('2023-09-11', '12:42', '12:44', 1, 69, 18, 5, '2945268576', 2),
		   ('2023-09-15', '16:18', '16:22', 1, 313, 13, 10, '118573307', 5),
		   ('2023-09-16', '1:12', '1:16', 2, 324, 18, 5, '2965411429', 7),
		   ('2023-09-17', '14:23', '14:27', 2, 406, 4, 10, '2646389455', 15),
		   ('2023-09-17', '16:21', '16:22', 2, 433, 27, 10, '3831013092', 12),
		   ('2023-09-18', '2:20', '2:22', 1, 182, 22, 10, '2974431502', 1),
		   ('2023-09-18', '13:41', '13:43', 2, 619, 9, 10, '2615268264', 15),
		   ('2023-09-19', '6:33', '6:35', 1, 197, 11, 10, '2617087633', 14),
		   ('2023-09-19', '21:34', '21:36', 1, 133, 16, 10, '3512023348', 11),
		   ('2023-09-20', '11:14', '11:16', 1, 138, 16, 10, '2973595467', 5),
		   ('2023-09-25', '18:02', '18:06', 2, 143, 25, 6, '2965160096', 12),
		   ('2023-09-26', '6:14', '6:16', 2, 21, 13, 10, '2648855458', 3),
		   ('2023-09-26', '19:06', '19:10', 1, 144, 16, 10, '3838178047', 16),
		   ('2023-09-27', '0:35', '0:39', 2, 128, 23, 10, '2966237448', 14),
		   ('2023-09-28', '18:31', '18:34', 1, 94, 23, 10, '2979304636', 17),
		   ('2023-09-30', '7:50', '7:54', 1, 55, 6, 10, '2806488281', 13),
		   ('2023-09-30', '18:51', '18:54', 2, 103, 10, 10, '2613618142', 14),
		   ('2023-10-01', '6:36', '6:40', 1, 522, 6, 10, '2945304410', 13),
		   ('2023-10-01', '21:15', '21:16', 2, 327, 19, 7, '2612350318', 8),
		   ('2023-10-02', '11:27', '11:30', 2, 159, 14, 10, '2646541888', 15),
		   ('2023-10-03', '1:25', '1:30', 2, 316, 16, 10, '2972212501', 16),
		   ('2023-10-04', '15:40', '15:44', 1, 103, 3, 8, '2802147726', 17),
		   ('2023-10-05', '6:31', '6:35', 1, 338, 18, 5, '2648966115', 7),
		   ('2023-10-05', '22:22', '22:23', 1, 143, 17, 10, '2972400382', 11),
		   ('2023-10-06', '19:46', '19:48', 2, 76, 14, 10, '2945503678', 5),
		   ('2023-10-07', '13:12', '13:15', 1, 319, 24, 9, '2611761758', 2),
		   ('2023-10-11', '13:19', '13:22', 2, 103, 1, 10, '2805911702', 5),
		   ('2023-10-11', '17:54', '17:57', 2, 24, 21, 10, '2978196100', 9),
		   ('2023-10-11', '19:38', '19:43', 2, 81, 23, 10, '2965804378', 17),
		   ('2023-10-12', '21:20', '21:25', 1, 65, 14, 10, '2977710847', 1),
		   ('2023-10-14', '10:52', '10:57', 1, 53, 22, 10, '2615828588', 15),
		   ('2023-10-14', '19:04', '19:08', 2, 353, 19, 7, '119188417', 2),
		   ('2023-10-15', '9:10', '9:15', 2, 500, 12, 10, '2972517990', 5),
		   ('2023-10-18', '13:29', '13:33', 1, 447, 26, 2, '113661960', 14),
		   ('2023-10-22', '20:55', '20:57', 1, 182, 15, 1, '2616919997', 6),
		   ('2023-10-23', '3:42', '3:44', 2, 100, 1, 10, '2945681630', 5),
		   ('2023-10-25', '2:42', '2:47', 1, 418, 16, 10, '2966184078', 12),
		   ('2023-10-28', '14:09', '14:12', 1, 118, 15, 1, '2614821369', 17),
		   ('2023-10-30', '2:03', '2:06', 1, 142, 24, 9, '2966152527', 16),
		   ('2023-10-30', '4:38', '4:41', 1, 300, 22, 10, '3837892624', 17),
		   ('2023-10-31', '0:43', '0:47', 2, 468, 10, 10, '2801425298', 3),
		   ('2023-11-01', '23:48', '23:51', 2, 129, 1, 10, '2801100789', 1),
		   ('2023-11-02', '0:40', '0:45', 2, 467, 24, 9, '29453219412', 1),
		   ('2023-11-03', '17:49', '17:53', 2, 184, 15, 1, '26430898901', 10),
		   ('2023-11-04', '12:53', '12:56', 2, 504, 11, 10, '2975024712', 7),
		   ('2023-11-05', '8:05', '8:07', 2, 177, 19, 7, '2965323029', 3),
		   ('2023-11-06', '17:19', '17:22', 1, 523, 22, 10, '2647409929', 17),
		   ('2023-11-06', '23:54', '23:59', 2, 403, 19, 7, '2965958185', 9),
		   ('2023-11-08', '10:07', '10:09', 1, 523, 20, 4, '3514890413', 9),
		   ('2023-11-08', '16:33', '16:36', 1, 452, 25, 6, '2965681951', 13),
		   ('2023-11-09', '6:59', '7:02', 2, 610, 5, 10, '2806798784', 12),
		   ('2023-11-11', '5:36', '5:40', 2, 54, 13, 10, '119047449', 5),
		   ('2023-11-11', '16:48', '16:50', 1, 446, 16, 10, '3836712919', 13),
		   ('2023-11-11', '23:10', '23:12', 2, 514, 6, 10, '2805542700', 12),
		   ('2023-11-14', '7:56', '8:00', 2, 307, 18, 5, '3834938811', 15),
		   ('2023-11-16', '2:08', '2:11', 2, 142, 17, 10, '3512859896', 9),
		   ('2023-11-20', '7:38', '7:41', 1, 320, 16, 10, '2649442815', 8),
		   ('2023-11-21', '11:30', '11:34', 2, 309, 16, 10, '2977209846', 4),
		   ('2023-11-29', '7:30', '7:33', 1, 176, 17, 10, '2972781698', 9),
		   ('2023-11-30', '13:59', '14:04', 2, 76, 14, 10, '118195765', 2),
		   ('2023-12-02', '4:26', '4:30', 1, 429, 5, 10, '111985538', 1),
		   ('2023-12-03', '22:09', '22:12', 2, 458, 4, 10, '2613012152', 14),
		   ('2023-12-05', '12:21', '12:22', 2, 175, 16, 10, '2978902677', 17),
		   ('2023-12-05', '21:32', '21:33', 2, 351, 25, 6, '2972325252', 2),
		   ('2023-12-06', '6:56', '6:57', 1, 501, 9, 10, '2807637085', 3),
		   ('2023-12-06', '13:36', '13:39', 1, 516, 18, 5, '2972201127', 16),
		   ('2023-12-06', '14:30', '14:34', 2, 104, 2, 3, '2945257354', 8),
		   ('2023-12-09', '11:47', '11:48', 2, 154, 23, 10, '2966613038', 7),
		   ('2023-12-09', '23:19', '23:23', 2, 350, 19, 7, '2945167709', 17),
	   	   ('2023-12-12', '18:57', '19:02', 1, 448, 4, 10, '2803899865', 15),
		   ('2023-12-12', '22:34', '22:39', 1, 168, 27, 10, '2966635682', 7),
		   ('2023-12-15', '13:20', '13:25', 2, 298, 16, 10, '3518618519', 2),
		   ('2023-12-15', '17:55', '17:59', 1, 134, 19, 7, '2801381536', 17),
		   ('2023-12-20', '10:31', '10:35', 2, 413, 3, 8, '2975781546', 7),
		   ('2023-12-22', '21:46', '21:50', 1, 132, 18, 5, '2612043610', 7),
		   ('2023-12-27', '12:44', '12:47', 2, 329, 11, 10, '3519596008', 9),
		   ('2023-12-28', '22:20', '22:23', 1, 430, 6, 10, '2965251581', 17),
		   ('2023-12-29', '4:52', '4:56', 2, 521, 11, 10, '29458208470', 11),
		   ('2023-12-30', '12:06', '12:09', 1, 107, 13, 10, '2945142062', 6);
    
-- Crear vistas
CREATE VIEW vista_comunicaciones_operador AS
SELECT 
    c.id_comunicacion,
    c.fecha,
    c.inicio,
    c.fin,
    c.telefono,
    CONCAT(nombre_operador, ' ', apellido_operador) AS operador
FROM comunicaciones c
JOIN operadores o ON c.id_operador = o.id_operador;

CREATE VIEW vista_trafico_por_localidad AS
SELECT 
    u.localidad,
    COUNT(*) AS total_comunicaciones
FROM comunicaciones c
JOIN corresponsales cr ON c.id_corresponsal = cr.id_corresponsales
JOIN ubicacion u ON cr.id_ubicacion = u.id_ubicacion
GROUP BY u.localidad;

CREATE VIEW vista_comunicaciones_completas AS
SELECT 
    c.id_comunicacion,
    c.fecha,
    c.inicio,
    c.fin,
    tc.tipo_de_comunicacion,
    cr.nombre_establecimiento,
	CONCAT(nombre_propietario, ' ', apellido_propietario) AS propietario,
    u.localidad,
    cq.tipo_de_codigo,
    ob.observacion,
    CONCAT(nombre_operador, ' ', apellido_operador) AS operador
FROM comunicaciones c
JOIN tipo_de_comunicacion tc ON c.id_tipo_comunicacion = tc.id_tipo_comunicacion
JOIN operadores o ON c.id_operador = o.id_operador
JOIN corresponsales cr ON c.id_corresponsal = cr.id_corresponsales
JOIN ubicacion u ON cr.id_ubicacion = u.id_ubicacion
JOIN codigo_q cq ON c.id_codigo_q = cq.id_codigo
JOIN observaciones ob ON c.id_observacion = ob.id_observacion;

CREATE VIEW vista_total_comunicaciones_por_red AS
SELECT 
    tr.tipo_de_red,
    COUNT(c.id_comunicacion) AS total_comunicaciones
FROM comunicaciones c
JOIN corresponsales co ON c.id_corresponsal = co.id_corresponsales
JOIN tipo_de_red tr ON co.id_red = tr.id_red
GROUP BY tr.tipo_de_red;

CREATE VIEW vista_operadores_por_localidad AS
SELECT 
    u.localidad,
    CONCAT(nombre_operador, ' ', apellido_operador) AS operador,
    COUNT(c.id_comunicacion) AS total_comunicaciones
FROM operadores o
JOIN comunicaciones c ON c.id_operador = o.id_operador
JOIN ubicacion u ON o.id_ubicacion = u.id_ubicacion
GROUP BY u.localidad, o.nombre_operador, o.apellido_operador;

-- Crear funciones
DELIMITER //
CREATE FUNCTION fn_total_comunicaciones_por_operador(p_id_operador INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total 
    FROM comunicaciones 
    WHERE id_operador = p_id_operador;
    RETURN total;
END;
//

DELIMITER //
CREATE FUNCTION fn_comunicaciones_por_mes(p_anio INT, p_mes INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM comunicaciones
    WHERE YEAR(fecha) = p_anio
      AND MONTH(fecha) = p_mes;
    RETURN total;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_promedio_duracion_mensual(p_anio INT, p_mes INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    
    SELECT AVG(TIMESTAMPDIFF(MINUTE, inicio, fin))
    INTO promedio
    FROM comunicaciones
    WHERE YEAR(fecha) = p_anio
      AND MONTH(fecha) = p_mes;

    RETURN promedio;
END;
//
DELIMITER ;

-- Crear Stored Procedures
DELIMITER //
CREATE PROCEDURE sp_insertar_comunicacion(
    IN p_id_tipo_comunicacion INT,
    IN p_id_corresponsal INT,
    IN p_id_codigo_q INT,
    IN p_id_observacion INT,
    IN p_telefono VARCHAR(50),
    IN p_id_operador INT
)
BEGIN
    INSERT INTO comunicaciones (
        id_tipo_comunicacion, id_corresponsal, id_codigo_q, 
        id_observacion, telefono, id_operador)
    VALUES (
        p_id_tipo_comunicacion, p_id_corresponsal, p_id_codigo_q, 
        p_id_observacion, p_telefono, p_id_operador);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_comunicaciones_por_rango_fecha(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT * 
    FROM comunicaciones
    WHERE fecha BETWEEN p_fecha_inicio AND p_fecha_fin;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_eliminar_comunicacion(IN p_id_comunicacion INT)
BEGIN
    DELETE FROM comunicaciones
    WHERE id_comunicacion = p_id_comunicacion;
END;
//
DELIMITER ;

-- Crear Triggers

CREATE TABLE IF NOT EXISTS log_comunicaciones (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_comunicacion INT,
    fecha_log DATETIME DEFAULT CURRENT_TIMESTAMP,
    accion VARCHAR(50)
);

DELIMITER //

CREATE TRIGGER trg_log_insert_comunicacion
AFTER INSERT ON comunicaciones
FOR EACH ROW
BEGIN
    INSERT INTO log_comunicaciones (id_comunicacion, accion)
    VALUES (NEW.id_comunicacion, 'INSERT');
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_verifica_duracion
BEFORE INSERT ON comunicaciones
FOR EACH ROW
BEGIN
    IF NEW.fin < NEW.inicio THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La hora de fin no puede ser anterior a la de inicio';
    END IF;
END;
//

DELIMITER ;

