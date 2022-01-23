-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Aerolinea
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Aerolinea
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Aerolinea` DEFAULT CHARACTER SET utf8 ;
USE `Aerolinea` ;

-- -----------------------------------------------------
-- Table `Aerolinea`.`CLASE_VUELOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aerolinea`.`CLASE_VUELOS` (
  `ID_CLASE_VUELOS` INT NOT NULL,
  `clase_vuelo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_CLASE_VUELOS`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Aerolinea`.`pasajero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aerolinea`.`pasajero` (
  `ID_PASAJERO` INT NOT NULL AUTO_INCREMENT,
  `NOMBRE_PASAJERO` VARCHAR(255) NOT NULL,
  `APELLIDO_PASAJERO` VARCHAR(255) NOT NULL,
  `EMAIL` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_PASAJERO`))
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Aerolinea`.`Direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aerolinea`.`Direccion` (
  `ID_DIRECCION` INT NOT NULL,
  `calle` VARCHAR(45) NULL DEFAULT NULL,
  `localidad` VARCHAR(45) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `pasajero_ID_PASAJERO` INT NOT NULL,
  PRIMARY KEY (`ID_DIRECCION`),
  INDEX `fk_Direccion_pasajero1_idx` (`pasajero_ID_PASAJERO` ASC) VISIBLE,
  CONSTRAINT `fk_Direccion_pasajero1`
    FOREIGN KEY (`pasajero_ID_PASAJERO`)
    REFERENCES `Aerolinea`.`pasajero` (`ID_PASAJERO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Aerolinea`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aerolinea`.`factura` (
  `ID_FACTURA` INT NOT NULL,
  `PRECIO` FLOAT NULL DEFAULT NULL,
  `pasajero_ID_PASAJERO` INT NOT NULL,
  PRIMARY KEY (`ID_FACTURA`),
  INDEX `fk_factura_pasajero1_idx` (`pasajero_ID_PASAJERO` ASC) VISIBLE,
  CONSTRAINT `fk_factura_pasajero1`
    FOREIGN KEY (`pasajero_ID_PASAJERO`)
    REFERENCES `Aerolinea`.`pasajero` (`ID_PASAJERO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Aerolinea`.`vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aerolinea`.`vuelo` (
  `ID_VUELO` INT NOT NULL,
  `NUMERO_VUELO` VARCHAR(50) NOT NULL,
  `FECHA_SALIDA` DATETIME NOT NULL,
  `FECHA_LLEGADA` DATETIME NOT NULL,
  `DEPART_CITY` VARCHAR(255) NOT NULL,
  `DEPART_ABREVIATURE` VARCHAR(5) NOT NULL,
  `ARRIVAL_CITY` VARCHAR(255) NOT NULL,
  `ARRIVAL_ABREVIATURE` VARCHAR(5) NULL DEFAULT NULL,
  `AIRPORT_DEPARTURE_NAME` VARCHAR(255) NULL DEFAULT NULL,
  `AIRPORT_ARRIVAL_NAME` VARCHAR(255) NULL DEFAULT NULL,
  `DISTANCIA` FLOAT NULL DEFAULT NULL,
  `TIEMPO_VUELO` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_VUELO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Aerolinea`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aerolinea`.`tickets` (
  `ID_TICKET` INT NOT NULL,
  `NUMERO_TICKET` VARCHAR(45) NOT NULL,
  `CODIGO_CONFIRMACION` VARCHAR(45) NOT NULL,
  `fecha_salida_esperada` DATETIME NOT NULL,
  `fecha_llegada_esperada` DATETIME NOT NULL,
  `duracion_esperada` TIME NOT NULL,
  `factura_ID_FACTURA` INT NOT NULL,
  `CLASE_VUELOS_ID_CLASE_VUELOS` INT NOT NULL,
  `VALOR_TICKET` INT NULL DEFAULT NULL,
  `vuelo_ID_VUELO` INT NOT NULL,
  PRIMARY KEY (`ID_TICKET`),
  INDEX `fk_tickets_CLASE_VUELOS1_idx` (`CLASE_VUELOS_ID_CLASE_VUELOS` ASC) VISIBLE,
  INDEX `fk_tickets_factura1_idx` (`factura_ID_FACTURA` ASC) VISIBLE,
  INDEX `fk_tickets_vuelo1_idx` (`vuelo_ID_VUELO` ASC) VISIBLE,
  CONSTRAINT `fk_tickets_CLASE_VUELOS1`
    FOREIGN KEY (`CLASE_VUELOS_ID_CLASE_VUELOS`)
    REFERENCES `Aerolinea`.`CLASE_VUELOS` (`ID_CLASE_VUELOS`),
  CONSTRAINT `fk_tickets_factura1`
    FOREIGN KEY (`factura_ID_FACTURA`)
    REFERENCES `Aerolinea`.`factura` (`ID_FACTURA`),
  CONSTRAINT `fk_tickets_vuelo1`
    FOREIGN KEY (`vuelo_ID_VUELO`)
    REFERENCES `Aerolinea`.`vuelo` (`ID_VUELO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Aerolinea`.`millas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aerolinea`.`millas` (
  `id_millas` INT NOT NULL,
  `id_pasajero` INT NOT NULL,
  `milles` FLOAT NOT NULL,
  `tickets_ID_TICKET` INT NOT NULL,
  PRIMARY KEY (`id_millas`, `tickets_ID_TICKET`),
  INDEX `fk_id_pasajero` (`id_pasajero` ASC) VISIBLE,
  INDEX `fk_millas_tickets1_idx` (`tickets_ID_TICKET` ASC) VISIBLE,
  CONSTRAINT `fk_millas_tickets1`
    FOREIGN KEY (`tickets_ID_TICKET`)
    REFERENCES `Aerolinea`.`tickets` (`ID_TICKET`),
  CONSTRAINT `millas_ibfk_1`
    FOREIGN KEY (`id_pasajero`)
    REFERENCES `Aerolinea`.`pasajero` (`ID_PASAJERO`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Aerolinea`.`pasajero_has_vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aerolinea`.`pasajero_has_vuelo` (
  `pasajero_ID_PASAJERO` INT NOT NULL,
  `vuelo_ID_VUELO` INT NOT NULL,
  PRIMARY KEY (`pasajero_ID_PASAJERO`, `vuelo_ID_VUELO`),
  INDEX `fk_pasajero_has_vuelo_vuelo1_idx` (`vuelo_ID_VUELO` ASC) VISIBLE,
  INDEX `fk_pasajero_has_vuelo_pasajero1_idx` (`pasajero_ID_PASAJERO` ASC) VISIBLE,
  CONSTRAINT `fk_pasajero_has_vuelo_pasajero1`
    FOREIGN KEY (`pasajero_ID_PASAJERO`)
    REFERENCES `Aerolinea`.`pasajero` (`ID_PASAJERO`),
  CONSTRAINT `fk_pasajero_has_vuelo_vuelo1`
    FOREIGN KEY (`vuelo_ID_VUELO`)
    REFERENCES `Aerolinea`.`vuelo` (`ID_VUELO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- carga de datos por tablas 


-- tabla pasajero 


-- cargando pasajeros corregido 

INSERT INTO pasajero values( 1 , " JOHANN ESTEBAN " , " GOMEZ ROJAS " , " JOHANNESTEBAN-GOMEZROJAS@gmail.com " );
INSERT INTO pasajero values( 2 , " JUAN CAMILO " , " PARADA OSPINA " , " JUANCAMILO-PARADAOSPINA@gmail.com " );
INSERT INTO pasajero values( 3 , " MARIA FERNANDA " , " DAVID BARRERA " , " MARIAFERNANDA-DAVIDBARRERA@gmail.com " );
INSERT INTO pasajero values( 4 , " JUAN DAVID " , " MEJIA ACOSTA " , " JUANDAVID-MEJIAACOSTA@gmail.com " );
INSERT INTO pasajero values( 5 , " JENNY KATHERIN " , " TOMBE SABOYA " , " JENNYKATHERIN-TOMBESABOYA@gmail.com " );
INSERT INTO pasajero values( 6 , " MANUEL  " , " GOMEZ GONZALEZ " , " MANUEL-GOMEZGONZALEZ@gmail.com " );
INSERT INTO pasajero values( 7 , " LUIS DANIEL " , " PACHECO GONZALEZ " , " LUISDANIEL-PACHECOGONZALEZ@gmail.com " );
INSERT INTO pasajero values( 8 , " JUAN CAMILO " , " CAMACHO DURAN " , " JUANCAMILO-CAMACHO DURAN@gmail.com " );
INSERT INTO pasajero values( 9 , " JESICA LORENA " , " FLOREZ VILLAMIL " , " JESICALORENA-FLOREZVILLAMIL@gmail.com " );
INSERT INTO pasajero values( 10 , " WILLIAM ALEJANDRO " , " GOMEZ TULCAN " , " WILLIAMALEJANDRO-GOMEZTULCAN@gmail.com " );
INSERT INTO pasajero values( 11 , " CRISTIAN ANDRES " , " GONZALEZ MARTINEZ " , " CRISTIAN-ANDRES-GONZALEZ-MARTINEZ@gmail.com " );
INSERT INTO pasajero values( 12 , " SARA DANIELA " , " LOPEZ MONTES " , " SARA-DANIELA-LOPEZ MONTES@hotmail.com " );
INSERT INTO pasajero values( 13 , " JOHAN DAVID " , " ARENAS RODRIGUEZ " , " JOHANDAVID-ARENASRODRIGUEZ@hotmail.com " );
INSERT INTO pasajero values( 14 , " MATEO ALEJANDRO " , " PATIÑO VARGAS " , " MATEOALEJANDRO-PATIÑOVARGAS@hotmail.com " );
INSERT INTO pasajero values( 15 , " JUAN CAMILO " , " VARGAS REY " , " JUAN-CAMILO-VARGAS-REY@hotmail.com " );
INSERT INTO pasajero values( 16 , " MARIA FERNANDA " , " PEREZ MEJIA " , " MARIA-FERNANDA-PEREZ-MEJIA@hotmail.com " );
INSERT INTO pasajero values( 17 , " JUAN DAVID " , " BARON OSORIO " , " JUAN-DAVID-BARON-OSORIO@hotmail.com " );
INSERT INTO pasajero values( 18 , " JENNY  " , " CASTRO MONTAÑEZ " , " JENNY-CASTRO-MONTAÑEZ@hotmail.com " );
INSERT INTO pasajero values( 19 , " LAURA SOFIA " , " RODRIGUEZ MARTINEZ " , " LAURA-SOFIA-RODRIGUEZ-MARTINEZ@hotmail.com " );
INSERT INTO pasajero values( 20 , " DAVID SANTIAGO " , " RESTREPO AGUILAR " , " DAVID-SANTIAGO-RESTREPO-AGUILAR@hotmail.com " );
INSERT INTO pasajero values( 21 , " FABIAN ANDRES " , " BELTRAN NEUSA " , " FABIAN-ANDRES-BELTRAN-NEUSA@hotmail.com " );
INSERT INTO pasajero values( 22 , " JUAN DIEGO " , " ORJUELA OLARTE " , " JUAN-DIEGO-ORJUELA-OLARTE@hotmail.com " );
INSERT INTO pasajero values( 23 , " JUAN SEBASTIAN " , " REYES PINTO " , " JUAN_SEBASTIAN_REYES_PINTO@yahoo.com " );
INSERT INTO pasajero values( 24 , " JUAN DAVID " , " GALVIS OVALLE " , " JUAN_DAVID_GALVIS_OVALLE@yahoo.com " );
INSERT INTO pasajero values( 25 , " MIGUEL ANGEL " , " CAMARGO HERRERA " , " MIGUEL_ANGEL_CAMARGO_HERRERA@yahoo.com " );
INSERT INTO pasajero values( 26 , " JUAN  " , " LARA PULIDO " , " JUAN -LARAPULIDO@yahoo.com " );
INSERT INTO pasajero values( 27 , " ANDERSON JAVIER " , " GOMEZ GONZALEZ " , " ANDERSON_JAVIER_GOMEZ_GONZALEZ@yahoo.com " );
INSERT INTO pasajero values( 28 , " ALEXANDER " , " PACHECO GONZALEZ " , " ALEXANDER_PACHECO_GONZALEZ@yahoo.com " );
INSERT INTO pasajero values( 29 , " MICHAEL DILAN " , " CAMACHO DURAN " , " MICHAEL_DILAN_CAMACHO_DURAN@yahoo.com " );
INSERT INTO pasajero values( 30 , " THOMAS " , " FLOREZ VILLAMIL " , " THOMAS-FLOREZ-VILLAMIL@yahoo.com " );
INSERT INTO pasajero values( 31 , " MARIANA " , " CHAVES RODRIGUEZ " , " MARIANA-CHAVES-RODRIGUEZ@outlook.com " );
INSERT INTO pasajero values( 32 , " SANTIAGO " , " GUERRERO RAMIREZ " , " SANTIAGO-GUERRERO-RAMIREZ@outlook.com " );
INSERT INTO pasajero values( 33 , " STEPHANIA " , " GARRIDO HEREDIA " , " STEPHANIA-GARRIDO-HEREDIA@outlook.com " );
INSERT INTO pasajero values( 34 , " SIMON " , " CARDONA ROJAS " , " SIMON-CARDONA-ROJAS@outlook.com " );
INSERT INTO pasajero values( 35 , " MARIA  " , " ROCHA JOYA " , " MARIA-ROCHA-JOYA@outlook.com " );
INSERT INTO pasajero values( 36 , " MARIA VALENTINA " , " GORDILLO LOPEZ " , " MARIA-VALENTINA-GORDILLO-LOPEZ@outlook.com " );
INSERT INTO pasajero values( 37 , " GARCIA MURILLO " , " TORRES GARAVITO " , " GARCIA-MURILLO-TORRES-GARAVITO@outlook.com " );
INSERT INTO pasajero values( 38 , " VIASUS CORTES " , " POVEDA ARENAS " , " VIASUS-CORTES-POVEDA-ARENAS@outlook.com " );
INSERT INTO pasajero values( 39 , " SUAREZ SOLORZANO " , " VARGAS REY " , " SUAREZ-SOLORZANO-VARGAS-REY@outlook.com " );
INSERT INTO pasajero values( 40 , " GARCIA VILLALOBOS " , " PEREZ MEJIA " , " GARCIA-VILLALOBOS-PEREZ-MEJIA@outlook.com " );

select * from pasajero;

-- Cargando Direcciones 

INSERT INTO Direccion VALUES(1001,"Carrera 54 #45A-19 Sur Local 101","KENNEDY","Bogotá","1");
INSERT INTO Direccion VALUES(1002,"Calle 134#7B-83 Edificio El Bosque Local 1","MANRIQUE","Medellin","2");
INSERT INTO Direccion VALUES(1003,"Calle 161#16A-32","Kennedy","Bogotá","3");
INSERT INTO Direccion VALUES(1004,"Calle 49A #80-29","COMUNA 5","Cali","4");
INSERT INTO Direccion VALUES(1005,"Calle 85 #10-74","Juan Nepomuceno ","Valledupar","5");
INSERT INTO Direccion VALUES(1006,"Av Boyaca #72B-02","CASTILLA","Medellin","6");
INSERT INTO Direccion VALUES(1007,"Calle 25G #73A-29","Barrios Unidos","Bogotá","7");
INSERT INTO Direccion VALUES(1008,"Calle 95 #11A-59","Comuna V ","Quibdó","8");
INSERT INTO Direccion VALUES(1009,"Calle 122 #15-21 Local 201","Los Mártires","Bogotá","9");
INSERT INTO Direccion VALUES(1010,"Avenida Calle 72 #81A-64","POPULAR","Medellin","10");
INSERT INTO Direccion VALUES(1011,"Calle 37 Sur #78H-33","SANTA CRUZ","Medellin","11");
INSERT INTO Direccion VALUES(1012,"Calle 146C Bis #90-11","Bosa","Bogotá","12");
INSERT INTO Direccion VALUES(1013,"Carrera 44 #51-42","CASTILLA","Medellin","13");
INSERT INTO Direccion VALUES(1014,"Carrera 64 #78-55","COMUNA 1","Cali","14");
INSERT INTO Direccion VALUES(1015,"Carrera 11 #71-73 Piso 2","ARANJUEZ","Medellin","15");
INSERT INTO Direccion VALUES(1016,"Carrera 76 #32-57","GUAYABAL","Medellin","16");
INSERT INTO Direccion VALUES(1017,"Calle 10 #43E-44","MANRIQUE","Manizales","17");
INSERT INTO Direccion VALUES(1018,"Carrera 74 #49-49","CASTILLA","Neiva","18");
INSERT INTO Direccion VALUES(1019,"Carrera 48 #10-107","POBLADO","Medellin","19");
INSERT INTO Direccion VALUES(1020,"Calle 68 #51D-57","COMUNA 4","Cali","20");
INSERT INTO Direccion values(1021,"Carrera 24 #53-26","Engativá","Bogotá","21");
INSERT INTO Direccion VALUES(1022,"Carrera 58 #128-60","Suba","Bogotá","22"); 
INSERT INTO Direccion VALUES(1023,"Calle 55 #49-07","COMUNA 3","Cali","23");
INSERT INTO Direccion VALUES(1024,"Calle 61A #16-10","POBLADO","Medellin","24"); 
INSERT INTO Direccion VALUES(1025,"Carrera 81 #27A-31","COMUNA 6","Cali","25");
INSERT INTO Direccion VALUES(1026,"Carrera 15A #120-63","De la Virgen","Barranquilla","26");
INSERT INTO Direccion VALUES(1027,"Calle 15 # 80 – 90","Ciro Reina","Yopal","27");
INSERT INTO Direccion VALUES(1028,"Carrera 69B #34-02 Sur","COMUNA 9","Cali","28");
INSERT INTO Direccion VALUES(1029,"Calle 12B #8-39 Edificio Bancoquia","COMUNA NORTE","Manizales","29");
INSERT INTO Direccion VALUES(1030,"Carrera 8 #17-30 Piso 3-4","COMUNA 10","Cali","30");
INSERT INTO Direccion VALUES(1031,"Carrera 9 #69-31","Industrial de la Bahía","Cartagena","31");
INSERT INTO Direccion VALUES(1032,"Carrera 13 #64-29","COMUNA 8","Cali","32");
INSERT INTO Direccion VALUES(1033,"Carrera 15 #82-19","BARRIO 1","Florencia","33");
INSERT INTO Direccion VALUES(1034,"Calle 16 #4-62","COMUNA 7","Cali","34");
INSERT INTO Direccion VALUES(1035,"Calle 100 #10-45","Llano Lindo","Popayán","35");
INSERT INTO Direccion VALUES(1036,"Calle 8 #43B-06","COMUNA 2","Cali","36");
INSERT INTO Direccion VALUES(1037,"Carrera 6 #67-18","Teusaquillo","Bogotá","37");
INSERT INTO Direccion VALUES(1038,"Carrera 13 #63-39 Interior 8-10","Calixto Zambrano","Montería","38");
INSERT INTO Direccion VALUES(1039,"Calle 53 #21-20","Comuna I ","Inírida","39");
INSERT INTO Direccion VALUES(1040,"Calle 13 #60-81","Fontibón","Bogotá","40");

select * from Direccion; -- mostrando tabla direccion


-- cargando tabla vuelos

INSERT INTO vuelo values( " 9001 " , " AV 9001 " , " 2020-01-28 12:00:00 " , " 2020-01-28 15:49:00 " , " Bogotá " , " BOG " , " Miami " , " MIA " , " Aeropuerto El Dorado " , " Miami International Airport " , 2435.0 , " 3:49:00 " );
INSERT INTO vuelo values( " 9002 " , " AV 9002 " , " 2020-01-30 08:00:00 " , " 2020-01-30 08:55:00 " , " Medellin  " , " MDE " , " Bogotá " , " BOG " , " Aeropuerto Olaya Herrera " , " Aeropuerto El Dorado " , 233.0 , " 00:55:00 " );
INSERT INTO vuelo values( " 9003 " , " AV 9003 " , " 2020-02-05 15:00:00 " , " 2020-02-05 18:49:00 " , " Miami " , " MIA " , " Bogotá " , " BOG " , " Miami International Airport " , " Aeropuerto El Dorado " , 2435.0 , " 3:49:00 " );
INSERT INTO vuelo values( " 9004 " , " AV 9004 " , " 2020-02-07 16:00:00 " , " 2020-02-07 16:55:00 " , " Bogotá " , " BOG " , " Medellin  " , " MDE " , " Aeropuerto El Dorado " , " Aeropuerto Olaya Herrera " , 233.0 , " 00:55:00 " );
INSERT INTO vuelo values( " 9005 " , " AV 9005 " , " 2020-05-15 07:55:00 " , " 2020-05-16 09:15:00 " , " Cali " , " CLO " , " Londres " , " LHR " , " AEROPUERTO Alfonso Bonilla Aragon " , " Heathrow Airport " , 9500.0 , " 20:20:00 " );
INSERT INTO vuelo values( " 9006 " , " AV 9006 " , " 2020-07-20 07:30:00 " , " 2020-07-20 23:25:00 " , " Toronto " , " YYZ " , " Medellin  " , " MDE " , " Aeropuerto Olaya Herrera " , " Toronto Pearson Airport " , 4173.0 , " 15:55:00 " );
INSERT INTO vuelo values( " 9007 " , " AV 9007 " , " 2021-01-28 09:55:00 " , " 2021-01-29 11:15:00 " , " Londres " , " LHR " , " Cali " , " CLO " , " Heathrow Airport " , " AEROPUERTO Alfonso Bonilla Aragon " , 9500.0 , " 20:20:00 " );
INSERT INTO vuelo values( " 9008 " , " AV 9008 " , " 2021-02-20 07:30:00 " , " 2021-02-20 23:25:00 " , " Medellin  " , " MDE " , " Toronto " , " YYZ " , " Toronto Pearson Airport " , " Aeropuerto Olaya Herrera " , 4173.0 , " 15:55:00 " );
INSERT INTO vuelo values( " 9009 " , " AV 9009 " , " 2021-03-01 11:57:00 " , " 2021-03-01 23:10:00 " , " Guadalajara " , " GDL " , " Bogotá " , " BOG " , " Aeropuerto Miguel Hidalgo " , " Aeropuerto El Dorado " , 3623.0 , " 10:13:00 " );
INSERT INTO vuelo values( " 9010 " , " AV 9010 " , " 2021-03-15 10:00:00 " , " 2021-03-16 12:15:00 " , " Bogotá " , " BOG " , " Madrid " , " MAD " , " Aeropuerto El Dorado " , " Aeropuerto Adolfo Suarez " , 9000.0 , " 20:15:00 " );
INSERT INTO vuelo values( " 9011 " , " AV 9011 " , " 2021-03-21 12:57:00 " , " 2021-03-22 00:10:00 " , " Bogotá " , " BOG " , " Guadalajara " , " GDL " , " Aeropuerto El Dorado " , " Aeropuerto Miguel Hidalgo " , 3623.0 , " 10:13:00 " );
INSERT INTO vuelo values( " 9012 " , " AV 9012 " , " 2021-03-29 08:00:00 " , " 2021-03-30 10:15:00 " , " Madrid " , " MAD " , " Bogotá " , " BOG " , " Aeropuerto Adolfo Suarez " , " Aeropuerto El Dorado " , 9000.0 , " 20:15:00 " );
INSERT INTO vuelo values( " 9013 " , " AV 9013 " , " 2021-04-03 10:50:00 " , " 2021-04-03 00:12:00 " , " Barranquilla " , " BAQ " , " Houston  " , " IAH " , " Aeropuerto Hernesto Cortissoz " , " George Bush Airport " , 2978.0 , " 14:31:00 " );
INSERT INTO vuelo values( " 9014 " , " AV 9014 " , " 2021-04-15 09:20:00 " , " 2021-04-15 10:24:00 " , " Neiva " , " NVA " , " Bogotá " , " BOG " , " Aeropuerto Benito Salas  " , " Aeropuerto El Dorado " , 309.8 , " 01:04:00 " );
INSERT INTO vuelo values( " 9015 " , " AV 9015 " , " 2021-04-20 05:50:00 " , " 2021-04-21 07:12:00 " , " Houston  " , " IAH " , " Barranquilla " , " BAQ " , " George Bush Airport " , " Aeropuerto Hernesto Cortissoz " , 2978.0 , " 14:31:00 " );
INSERT INTO vuelo values( " 9016 " , " AV 9016 " , " 2021-05-25 07:20:00 " , " 2021-05-25 08:24:00 " , " Bogotá " , " BOG " , " Neiva " , " NVA " , " Aeropuerto El Dorado " , " Aeropuerto Benito Salas  " , 309.8 , " 01:04:00 " );
INSERT INTO vuelo values( " 9017 " , " AV 9017 " , " 2021-06-05 05:21:00 " , " 2021-06-05 06:29:00 " , " Santa Marta " , " SMR " , " Cali " , " CLO " , " Aeropuerto Simon Bolivar " , " AEROPUERTO Alfonso Bonilla Aragon " , 550.0 , " 01:30:00 " );
INSERT INTO vuelo values( " 9018 " , " AV 9018 " , " 2021-06-15 07:20:00 " , " 2021-06-15 09:05:00 " , " Bogotá " , " BOG " , " Quito " , " UIO " , " Aeropuerto El Dorado " , " Aeropuerto Mariscal Sucre " , 720.0 , " 01:45:00 " );
INSERT INTO vuelo values( " 9019 " , " AV 9019 " , " 2021-07-25 05:21:00 " , " 2021-07-25 06:29:00 " , " Cali " , " CLO " , " Santa Marta " , " SMR " , " AEROPUERTO Alfonso Bonilla Aragon " , " Aeropuerto Simon Bolivar " , 550.0 , " 01:30:00 " );
INSERT INTO vuelo values( " 9020 " , " AV 9020 " , " 2021-08-15 07:20:00 " , " 2021-08-15 09:05:00 " , " Quito " , " UIO " , " Bogotá " , " BOG " , " Aeropuerto Mariscal Sucre " , " Aeropuerto El Dorado " , 720.0 , " 01:45:00 " );


-- cargando pasajero_has_vuelo

INSERT INTO pasajero_has_vuelo values( 2 , 9001 );
INSERT INTO pasajero_has_vuelo values( 4 , 9001 );
INSERT INTO pasajero_has_vuelo values( 9 , 9001 );
INSERT INTO pasajero_has_vuelo values( 22 , 9001 );
INSERT INTO pasajero_has_vuelo values( 37 , 9001 );
INSERT INTO pasajero_has_vuelo values( 5 , 9002 );
INSERT INTO pasajero_has_vuelo values( 14 , 9002 );
INSERT INTO pasajero_has_vuelo values( 27 , 9002 );
INSERT INTO pasajero_has_vuelo values( 29 , 9002 );
INSERT INTO pasajero_has_vuelo values( 38 , 9002 );
INSERT INTO pasajero_has_vuelo values( 2 , 9003 );
INSERT INTO pasajero_has_vuelo values( 4 , 9003 );
INSERT INTO pasajero_has_vuelo values( 9 , 9003 );
INSERT INTO pasajero_has_vuelo values( 22 , 9003 );
INSERT INTO pasajero_has_vuelo values( 37 , 9003 );
INSERT INTO pasajero_has_vuelo values( 5 , 9004 );
INSERT INTO pasajero_has_vuelo values( 14 , 9004 );
INSERT INTO pasajero_has_vuelo values( 27 , 9004 );
INSERT INTO pasajero_has_vuelo values( 29 , 9004 );
INSERT INTO pasajero_has_vuelo values( 38 , 9004 );
INSERT INTO pasajero_has_vuelo values( 6 , 9005 );
INSERT INTO pasajero_has_vuelo values( 9 , 9005 );
INSERT INTO pasajero_has_vuelo values( 10 , 9005 );
INSERT INTO pasajero_has_vuelo values( 19 , 9005 );
INSERT INTO pasajero_has_vuelo values( 39 , 9005 );
INSERT INTO pasajero_has_vuelo values( 15 , 9006 );
INSERT INTO pasajero_has_vuelo values( 30 , 9006 );
INSERT INTO pasajero_has_vuelo values( 40 , 9006 );
INSERT INTO pasajero_has_vuelo values( 6 , 9007 );
INSERT INTO pasajero_has_vuelo values( 9 , 9007 );
INSERT INTO pasajero_has_vuelo values( 10 , 9007 );
INSERT INTO pasajero_has_vuelo values( 19 , 9007 );
INSERT INTO pasajero_has_vuelo values( 39 , 9007 );
INSERT INTO pasajero_has_vuelo values( 15 , 9008 );
INSERT INTO pasajero_has_vuelo values( 30 , 9008 );
INSERT INTO pasajero_has_vuelo values( 40 , 9008 );
INSERT INTO pasajero_has_vuelo values( 1 , 9009 );
INSERT INTO pasajero_has_vuelo values( 7 , 9009 );
INSERT INTO pasajero_has_vuelo values( 11 , 9009 );
INSERT INTO pasajero_has_vuelo values( 20 , 9009 );
INSERT INTO pasajero_has_vuelo values( 24 , 9009 );
INSERT INTO pasajero_has_vuelo values( 1 , 9010 );
INSERT INTO pasajero_has_vuelo values( 5 , 9010 );
INSERT INTO pasajero_has_vuelo values( 8 , 9010 );
INSERT INTO pasajero_has_vuelo values( 10 , 9010 );
INSERT INTO pasajero_has_vuelo values( 16 , 9010 );
INSERT INTO pasajero_has_vuelo values( 21 , 9010 );
INSERT INTO pasajero_has_vuelo values( 31 , 9010 );
INSERT INTO pasajero_has_vuelo values( 34 , 9010 );
INSERT INTO pasajero_has_vuelo values( 1 , 9011 );
INSERT INTO pasajero_has_vuelo values( 7 , 9011 );
INSERT INTO pasajero_has_vuelo values( 11 , 9011 );
INSERT INTO pasajero_has_vuelo values( 20 , 9011 );
INSERT INTO pasajero_has_vuelo values( 24 , 9011 );
INSERT INTO pasajero_has_vuelo values( 1 , 9012 );
INSERT INTO pasajero_has_vuelo values( 5 , 9012 );
INSERT INTO pasajero_has_vuelo values( 8 , 9012 );
INSERT INTO pasajero_has_vuelo values( 10 , 9012 );
INSERT INTO pasajero_has_vuelo values( 16 , 9012 );
INSERT INTO pasajero_has_vuelo values( 21 , 9012 );
INSERT INTO pasajero_has_vuelo values( 31 , 9012 );
INSERT INTO pasajero_has_vuelo values( 34 , 9012 );
INSERT INTO pasajero_has_vuelo values( 3 , 9013 );
INSERT INTO pasajero_has_vuelo values( 11 , 9013 );
INSERT INTO pasajero_has_vuelo values( 12 , 9013 );
INSERT INTO pasajero_has_vuelo values( 25 , 9013 );
INSERT INTO pasajero_has_vuelo values( 35 , 9013 );
INSERT INTO pasajero_has_vuelo values( 10 , 9014 );
INSERT INTO pasajero_has_vuelo values( 15 , 9014 );
INSERT INTO pasajero_has_vuelo values( 17 , 9014 );
INSERT INTO pasajero_has_vuelo values( 32 , 9014 );
INSERT INTO pasajero_has_vuelo values( 36 , 9014 );
INSERT INTO pasajero_has_vuelo values( 3 , 9015 );
INSERT INTO pasajero_has_vuelo values( 11 , 9015 );
INSERT INTO pasajero_has_vuelo values( 12 , 9015 );
INSERT INTO pasajero_has_vuelo values( 25 , 9015 );
INSERT INTO pasajero_has_vuelo values( 35 , 9015 );
INSERT INTO pasajero_has_vuelo values( 10 , 9016 );
INSERT INTO pasajero_has_vuelo values( 15 , 9016 );
INSERT INTO pasajero_has_vuelo values( 17 , 9016 );
INSERT INTO pasajero_has_vuelo values( 32 , 9016 );
INSERT INTO pasajero_has_vuelo values( 36 , 9016 );
INSERT INTO pasajero_has_vuelo values( 1 , 9017 );
INSERT INTO pasajero_has_vuelo values( 23 , 9017 );
INSERT INTO pasajero_has_vuelo values( 4 , 9018 );
INSERT INTO pasajero_has_vuelo values( 13 , 9018 );
INSERT INTO pasajero_has_vuelo values( 14 , 9018 );
INSERT INTO pasajero_has_vuelo values( 18 , 9018 );
INSERT INTO pasajero_has_vuelo values( 26 , 9018 );
INSERT INTO pasajero_has_vuelo values( 28 , 9018 );
INSERT INTO pasajero_has_vuelo values( 33 , 9018 );
INSERT INTO pasajero_has_vuelo values( 1 , 9019 );
INSERT INTO pasajero_has_vuelo values( 23 , 9019 );
INSERT INTO pasajero_has_vuelo values( 4 , 9020 );
INSERT INTO pasajero_has_vuelo values( 13 , 9020 );
INSERT INTO pasajero_has_vuelo values( 14 , 9020 );
INSERT INTO pasajero_has_vuelo values( 18 , 9020 );
INSERT INTO pasajero_has_vuelo values( 26 , 9020 );
INSERT INTO pasajero_has_vuelo values( 28 , 9020 );
INSERT INTO pasajero_has_vuelo values( 33 , 9020 );


-- cargando datos tabla CLASE_VUELOS 
insert into CLASE_VUELOS values(1111, "FIRST CLASS");
insert into CLASE_VUELOS values(2222, "BUSINESS");
insert into CLASE_VUELOS values(3333, "PREMIUM ECONOMY");
insert into CLASE_VUELOS values(4444, "ECONOMY");


-- insertando valores de facturas

INSERT INTO factura values( 5500 , 600 , 2 );
INSERT INTO factura values( 5501 , 500 , 4 );
INSERT INTO factura values( 5502 , 500 , 9 );
INSERT INTO factura values( 5503 , 600 , 22 );
INSERT INTO factura values( 5504 , 455 , 37 );

INSERT INTO factura values( 5505 , 100 , 5 );
INSERT INTO factura values( 5506 , 100 , 14 );
INSERT INTO factura values( 5507 , 110 , 27 );
INSERT INTO factura values( 5508 , 125 , 29 );
INSERT INTO factura values( 5509 , 110 , 38 );

INSERT INTO factura values( 5510 , 4000 , 6 );
INSERT INTO factura values( 5511 , 3600 , 9 );
INSERT INTO factura values( 5512 , 3800 , 10 );
INSERT INTO factura values( 5513 , 3600 , 19 );
INSERT INTO factura values( 5514 , 4000 , 39 );

INSERT INTO factura values( 5515 , 2000 , 15 );
INSERT INTO factura values( 5516 , 2000 , 30 );
INSERT INTO factura values( 5517 , 2000 , 40 );

INSERT INTO factura values( 5518 , 1050 , 1 );
INSERT INTO factura values( 5519 , 1050 , 7 );
INSERT INTO factura values( 5520 , 900 , 11);
INSERT INTO factura values( 5521 , 1200 , 20 );
INSERT INTO factura values( 5522 , 1050 , 24 );

INSERT INTO factura values( 5523 , 3400 , 1 );
INSERT INTO factura values( 5524 , 3200 , 5 );
INSERT INTO factura values( 5525 , 3200 , 8 );
INSERT INTO factura values( 5526 , 3000 , 10 );
INSERT INTO factura values( 5527 , 3000 , 16 );
INSERT INTO factura values( 5528 , 3200 , 21 );
INSERT INTO factura values( 5529 , 3200 , 31 );
INSERT INTO factura values( 5530 , 3400 , 34 );

INSERT INTO factura values( 5531 , 2200 , 3 );
INSERT INTO factura values( 5532 , 2200 , 11 );
INSERT INTO factura values( 5533 , 2200 , 12 );
INSERT INTO factura values( 5534 , 2200 , 25 );
INSERT INTO factura values( 5535 , 2200 , 35 );

INSERT INTO factura values( 5536 , 169 , 10 );
INSERT INTO factura values( 5537 , 169 , 15 );
INSERT INTO factura values( 5538 , 130 , 17 );
INSERT INTO factura values( 5539 , 130 , 32 );
INSERT INTO factura values( 5540 , 130 , 36 );

INSERT INTO factura values( 5541 , 147 , 1 );
INSERT INTO factura values( 5542 , 147 , 23 );

INSERT INTO factura values( 5543 , 800 , 4 );
INSERT INTO factura values( 5544 , 700 , 13 );
INSERT INTO factura values( 5545 , 700 , 14 );
INSERT INTO factura values( 5546 , 600 , 18 );
INSERT INTO factura values( 5547 , 700 , 26 );
INSERT INTO factura values( 5548 , 700 , 28 );
INSERT INTO factura values( 5549 , 600 , 33 );

-- insertando datos de tickets

INSERT INTO tickets values( 11000 , 9001-2 , " AV 9001-2 " , " 2020-01-28 12:00:00 " , " 2020-01-28 15:49:00 " , " 03:49:00 " , 5500 , 1111 , 300, 9001 );
INSERT INTO tickets values( 11003 , 9001-22 , " AV 9001-22 " , " 2020-01-28 12:00:00 " , " 2020-01-28 15:49:00 " , " 3:49:00 " , 5503 , 1111 , 300, 9001 );
INSERT INTO tickets values( 11004 , 9001-37 , " AV 9001-37 " , " 2020-01-28 12:00:00 " , " 2020-01-28 15:49:00 " , " 3:49:00 " , 5504 , 3333 , 205, 9001 );
INSERT INTO tickets values( 11001 , 9001-4 , " AV 9001-4 " , " 2020-01-28 12:00:00 " , " 2020-01-28 15:49:00 " , " 3:49:00 " , 5501 , 3333 , 250, 9001 );
INSERT INTO tickets values( 11002 , 9001-9 , " AV 9001-9 " , " 2020-01-28 12:00:00 " , " 2020-01-28 15:49:00 " , " 3:49:00 " , 5502 , 3333 , 250, 9001 );

INSERT INTO tickets values( 11006 , 9002-14 , " AV 9002-14 " , " 2020-01-30 08:00:00 " , " 2020-01-30 08:55:00 " , " 00:55:00 " , 5506 , 4444 , 50, 9002);
INSERT INTO tickets values( 11007 , 9002-27 , " AV 9002-27 " , " 2020-01-30 08:00:00 " , " 2020-01-30 08:55:00 " , " 00:55:00 " , 5507 , 4444 , 50, 9002);
INSERT INTO tickets values( 11008 , 9002-29 , " AV 9002-29 " , " 2020-01-30 08:00:00 " , " 2020-01-30 08:55:00 " , " 00:55:00 " , 5508 , 1111 , 65, 9002);
INSERT INTO tickets values( 11009 , 9002-38 , " AV 9002-38 " , " 2020-01-30 08:00:00 " , " 2020-01-30 08:55:00 " , " 00:55:00 " , 5509 , 4444 , 50, 9002);
INSERT INTO tickets values( 11005 , 9002-5 , " AV 9002-5 " , " 2020-01-30 08:00:00 " , " 2020-01-30 08:55:00 " , " 00:55:00 " , 5505 , 4444 , 50,   9002);

INSERT INTO tickets values( 11010 , 9003-2 , " AV 9003-2 " , " 2020-02-05 15:00:00 " , " 2020-02-05 18:49:00 " , " 3:49:00 " , 5500 , 1111 , 300,  9003 );
INSERT INTO tickets values( 11013 , 9003-22 , " AV 9003-22 " , " 2020-02-05 15:00:00 " , " 2020-02-05 18:49:00 " , " 3:49:00 " , 5503 , 1111 , 300,9003 );
INSERT INTO tickets values( 11014 , 9003-37 , " AV 9003-37 " , " 2020-02-05 15:00:00 " , " 2020-02-05 18:49:00 " , " 3:49:00 " , 5504 , 3333 , 250,9003 );
INSERT INTO tickets values( 11011 , 9003-4 , " AV 9003-4 " , " 2020-02-05 15:00:00 " , " 2020-02-05 18:49:00 " , " 3:49:00 " , 5501 , 3333 , 250,  9003 );
INSERT INTO tickets values( 11012 , 9003-9 , " AV 9003-9 " , " 2020-02-05 15:00:00 " , " 2020-02-05 18:49:00 " , " 3:49:00 " , 5502 , 3333 , 250,  9003 );

INSERT INTO tickets values( 11016 , 9004-14 , " AV 9004-14 " , " 2020-02-07 16:00:00 " , " 2020-02-07 16:55:00 " , " 00:55:00 " , 5506 , 4444 , 50, 9004 );
INSERT INTO tickets values( 11017 , 9004-27 , " AV 9004-27 " , " 2020-02-07 16:00:00 " , " 2020-02-07 16:55:00 " , " 00:55:00 " , 5507 , 2222 , 60, 9004 );
INSERT INTO tickets values( 11018 , 9004-29 , " AV 9004-29 " , " 2020-02-07 16:00:00 " , " 2020-02-07 16:55:00 " , " 00:55:00 " , 5508 , 2222 , 60, 9004 );
INSERT INTO tickets values( 11019 , 9004-38 , " AV 9004-38 " , " 2020-02-07 16:00:00 " , " 2020-02-07 16:55:00 " , " 00:55:00 " , 5509 , 2222 , 60, 9004 );
INSERT INTO tickets values( 11015 , 9004-5 , " AV 9004-5 " , " 2020-02-07 16:00:00 " , " 2020-02-07 16:55:00 " , " 00:55:00 " , 5505 , 4444 , 50  , 9004 );

INSERT INTO tickets values( 11022 , 9005-10 , " AV 9005-10 " , " 2020-05-15 07:55:00 " , " 2020-05-16 09:15:00 " , " 20:20:00 " , 5512 , 1111 , 2000 , 9005);
INSERT INTO tickets values( 11023 , 9005-19 , " AV 9005-19 " , " 2020-05-15 07:55:00 " , " 2020-05-16 09:15:00 " , " 20:20:00 " , 5513 , 3333 , 1800 , 9005);
INSERT INTO tickets values( 11024 , 9005-39 , " AV 9005-39 " , " 2020-05-15 07:55:00 " , " 2020-05-16 09:15:00 " , " 20:20:00 " , 5514 , 1111 , 2000 , 9005);
INSERT INTO tickets values( 11020 , 9005-6 , " AV 9005-6 " , " 2020-05-15 07:55:00 " , " 2020-05-16 09:15:00 " , " 20:20:00 " , 5510 , 1111 , 2000   , 9005);
INSERT INTO tickets values( 11021 , 9005-9 , " AV 9005-9 " , " 2020-05-15 07:55:00 " , " 2020-05-16 09:15:00 " , " 20:20:00 " , 5511 , 3333 , 1800   , 9005);

INSERT INTO tickets values( 11025 , 9006-15 , " AV 9006-15 " , " 2020-07-20 07:30:00 " , " 2020-07-20 23:25:00 " , " 15:55:00 " , 5515 , 1111 , 1000 , 9006);
INSERT INTO tickets values( 11026 , 9006-40 , " AV 9006-40 " , " 2020-07-20 07:30:00 " , " 2020-07-20 23:25:00 " , " 15:55:00 " , 5516 , 1111 , 1000 , 9006);
INSERT INTO tickets values( 11027 , 9006-40 , " AV 9006-40 " , " 2020-07-20 07:30:00 " , " 2020-07-20 23:25:00 " , " 15:55:00 " , 5517 , 1111 , 1000 , 9006);

INSERT INTO tickets values( 11030 , 9007-10 , " AV 9007-10 " , " 2021-01-28 09:55:00 " , " 2021-01-29 11:15:00 " , " 20:20:00 " , 5512 , 3333 , 1800 , 9007);
INSERT INTO tickets values( 11031 , 9007-19 , " AV 9007-19 " , " 2021-01-28 09:55:00 " , " 2021-01-29 11:15:00 " , " 20:20:00 " , 5513 , 3333 , 1800 , 9007);
INSERT INTO tickets values( 11032 , 9007-39 , " AV 9007-39 " , " 2021-01-28 09:55:00 " , " 2021-01-29 11:15:00 " , " 20:20:00 " , 5514 , 1111 , 2000 , 9007);
INSERT INTO tickets values( 11028 , 9007-6 , " AV 9007-6 " , " 2021-01-28 09:55:00 " , " 2021-01-29 11:15:00 " , " 20:20:00 " , 5510 , 1111 , 2000   , 9007);
INSERT INTO tickets values( 11029 , 9007-9 , " AV 9007-9 " , " 2021-01-28 09:55:00 " , " 2021-01-29 11:15:00 " , " 20:20:00 " , 5511 , 3333 , 1800   , 9007);

INSERT INTO tickets values( 11033 , 9008-15 , " AV 9008-15 " , " 2021-02-20 07:30:00 " , " 2021-02-20 23:25:00 " , " 15:55:00 " , 5515 , 1111 , 1000 , 9008);
INSERT INTO tickets values( 11034 , 9008-30 , " AV 9008-30 " , " 2021-02-20 07:30:00 " , " 2021-02-20 23:25:00 " , " 15:55:00 " , 5516 , 1111 , 1000 , 9008);
INSERT INTO tickets values( 11035 , 9008-40 , " AV 9008-40 " , " 2021-02-20 07:30:00 " , " 2021-02-20 23:25:00 " , " 15:55:00 " , 5517 , 1111 , 1000 , 9008);

INSERT INTO tickets values( 11036 , 9009-1 , " AV 9009-1 " , " 2021-03-01 11:57:00 " , " 2021-03-01 23:10:00 " , " 10:13:00 " , 5518 , 4444 , 450,   9009);
INSERT INTO tickets values( 11038 , 9009-11 , " AV 9009-11 " , " 2021-03-01 11:57:00 " , " 2021-03-01 23:10:00 " , " 10:13:00 " , 5520 , 4444 , 450, 9009);
INSERT INTO tickets values( 11039 , 9009-20 , " AV 9009-20 " , " 2021-03-01 11:57:00 " , " 2021-03-01 23:10:00 " , " 10:13:00 " , 5521 , 2222 , 600, 9009);
INSERT INTO tickets values( 11040 , 9009-24 , " AV 9009-24 " , " 2021-03-01 11:57:00 " , " 2021-03-01 23:10:00 " , " 10:13:00 " , 5522 , 4444 , 450, 9009);
INSERT INTO tickets values( 11037 , 9009-7 , " AV 9009-7 " , " 2021-03-01 11:57:00 " , " 2021-03-01 23:10:00 " , " 10:13:00 " , 5519 , 2222 , 600  , 9009);

INSERT INTO tickets values( 11041 , 9010-1 , " AV 9010-1 " , " 2021-03-15 10:00:00 " , " 2021-03-16 12:15:00 " , " 20:15:00 " , 5523 , 1111 , 1700,   9010);
INSERT INTO tickets values( 11044 , 9010-10 , " AV 9010-10 " , " 2021-03-15 10:00:00 " , " 2021-03-16 12:15:00 " , " 20:15:00 " , 5526 , 3333 , 1500, 9010);
INSERT INTO tickets values( 11045 , 9010-16 , " AV 9010-16 " , " 2021-03-15 10:00:00 " , " 2021-03-16 12:15:00 " , " 20:15:00 " , 5527 , 3333 , 1500, 9010);
INSERT INTO tickets values( 11046 , 9010-21 , " AV 9010-21 " , " 2021-03-15 10:00:00 " , " 2021-03-16 12:15:00 " , " 20:15:00 " , 5528 , 3333 , 1500, 9010);
INSERT INTO tickets values( 11047 , 9010-31 , " AV 9010-31 " , " 2021-03-15 10:00:00 " , " 2021-03-16 12:15:00 " , " 20:15:00 " , 5529 , 3333 , 1500, 9010);
INSERT INTO tickets values( 11048 , 9010-34 , " AV 9010-34 " , " 2021-03-15 10:00:00 " , " 2021-03-16 12:15:00 " , " 20:15:00 " , 5530 , 1111 , 1700, 9010);
INSERT INTO tickets values( 11042 , 9010-5 , " AV 9010-5 " , " 2021-03-15 10:00:00 " , " 2021-03-16 12:15:00 " , " 20:15:00 " , 5524 , 1111 , 1700  , 9010);
INSERT INTO tickets values( 11043 , 9010-8 , " AV 9010-8 " , " 2021-03-15 10:00:00 " , " 2021-03-16 12:15:00 " , " 20:15:00 " , 5525 , 1111 , 1700  , 9010);

INSERT INTO tickets values( 11049 , 9011-1 , " AV 9011-1 " , " 2021-03-21 12:57:00 " , " 2021-03-22 00:10:00 " , " 10:13:00 " , 5518 , 2222 , 600, 9011);
INSERT INTO tickets values( 11051 , 9011-11 , " AV 9011-11 " , " 2021-03-21 12:57:00 " , " 2021-03-22 00:10:00 " , " 10:13:00 " , 5520 , 4444 , 450, 9011);
INSERT INTO tickets values( 11052 , 9011-20 , " AV 9011-20 " , " 2021-03-21 12:57:00 " , " 2021-03-22 00:10:00 " , " 10:13:00 " , 5521 , 2222 , 600, 9011);
INSERT INTO tickets values( 11053 , 9011-24 , " AV 9011-24 " , " 2021-03-21 12:57:00 " , " 2021-03-22 00:10:00 " , " 10:13:00 " , 5522 , 2222 , 600, 9011);
INSERT INTO tickets values( 11050 , 9011-7 , " AV 9011-7 " , " 2021-03-21 12:57:00 " , " 2021-03-22 00:10:00 " , " 10:13:00 " , 5519 , 4444 , 450, 9011);

INSERT INTO tickets values( 11054 , 9012-1 , " AV 9012-1 " , " 2021-03-29 08:00:00 " , " 2021-03-30 10:15:00 " , " 20:15:00 " , 5523 , 1111 , 1700, 9012);
INSERT INTO tickets values( 11057 , 9012-10 , " AV 9012-10 " , " 2021-03-29 08:00:00 " , " 2021-03-30 10:15:00 " , " 20:15:00 " , 5526 , 3333 , 1500, 9012);
INSERT INTO tickets values( 11058 , 9012-16 , " AV 9012-16 " , " 2021-03-29 08:00:00 " , " 2021-03-30 10:15:00 " , " 20:15:00 " , 5527 , 3333 , 1500, 9012);
INSERT INTO tickets values( 11059 , 9012-21 , " AV 9012-21 " , " 2021-03-29 08:00:00 " , " 2021-03-30 10:15:00 " , " 20:15:00 " , 5528 , 1111 , 1700, 9012);
INSERT INTO tickets values( 11060 , 9012-31 , " AV 9012-31 " , " 2021-03-29 08:00:00 " , " 2021-03-30 10:15:00 " , " 20:15:00 " , 5529 , 1111 , 1700, 9012);
INSERT INTO tickets values( 11061 , 9012-34 , " AV 9012-34 " , " 2021-03-29 08:00:00 " , " 2021-03-30 10:15:00 " , " 20:15:00 " , 5530 , 1111 , 1700, 9012);
INSERT INTO tickets values( 11055 , 9012-5 , " AV 9012-5 " , " 2021-03-29 08:00:00 " , " 2021-03-30 10:15:00 " , " 20:15:00 " , 5524 , 3333 , 1500, 9012);
INSERT INTO tickets values( 11056 , 9012-8 , " AV 9012-8 " , " 2021-03-29 08:00:00 " , " 2021-03-30 10:15:00 " , " 20:15:00 " , 5525 , 3333 , 1500, 9012);

INSERT INTO tickets values( 11063 , 9013-11 , " AV 9013-11 " , " 2021-04-03 10:50:00 " , " 2021-04-03 00:12:00 " , " 14:31:00 " , 5532 , 4444 , 1000, 9013);
INSERT INTO tickets values( 11064 , 9013-12 , " AV 9013-12 " , " 2021-04-03 10:50:00 " , " 2021-04-03 00:12:00 " , " 14:31:00 " , 5533 , 2222 , 1200, 9013);
INSERT INTO tickets values( 11065 , 9013-25 , " AV 9013-25 " , " 2021-04-03 10:50:00 " , " 2021-04-03 00:12:00 " , " 14:31:00 " , 5534 , 2222 , 1200, 9013);
INSERT INTO tickets values( 11062 , 9013-3 , " AV 9013-3 " , " 2021-04-03 10:50:00 " , " 2021-04-03 00:12:00 " , " 14:31:00 " , 5531 , 4444 , 1000,   9013);
INSERT INTO tickets values( 11066 , 9013-35 , " AV 9013-35 " , " 2021-04-03 10:50:00 " , " 2021-04-03 00:12:00 " , " 14:31:00 " , 5535 , 4444 , 1000, 9013);

INSERT INTO tickets values( 11067 , 9014-10 , " AV 9014-10 " , " 2021-04-15 09:20:00 " , " 2021-04-15 10:24:00 " , " 01:04:00 " , 5536 , 1111 , 85, 9014);
INSERT INTO tickets values( 11068 , 9014-15 , " AV 9014-15 " , " 2021-04-15 09:20:00 " , " 2021-04-15 10:24:00 " , " 01:04:00 " , 5537 , 1111 , 85, 9014);
INSERT INTO tickets values( 11069 , 9014-17 , " AV 9014-17 " , " 2021-04-15 09:20:00 " , " 2021-04-15 10:24:00 " , " 01:04:00 " , 5538 , 3333 , 65, 9014);
INSERT INTO tickets values( 11070 , 9014-32 , " AV 9014-32 " , " 2021-04-15 09:20:00 " , " 2021-04-15 10:24:00 " , " 01:04:00 " , 5539 , 3333 , 65, 9014);
INSERT INTO tickets values( 11071 , 9014-36 , " AV 9014-36 " , " 2021-04-15 09:20:00 " , " 2021-04-15 10:24:00 " , " 01:04:00 " , 5540 , 3333 , 65, 9014);

INSERT INTO tickets values( 11073 , 9015-11 , " AV 9015-11 " , " 2021-04-20 05:50:00 " , " 2021-04-21 07:12:00 " , " 14:31:00 " , 5532 , 2222 , 1200, 9015);
INSERT INTO tickets values( 11074 , 9015-12 , " AV 9015-12 " , " 2021-04-20 05:50:00 " , " 2021-04-21 07:12:00 " , " 14:31:00 " , 5533 , 4444 , 1000, 9015);
INSERT INTO tickets values( 11075 , 9015-25 , " AV 9015-25 " , " 2021-04-20 05:50:00 " , " 2021-04-21 07:12:00 " , " 14:31:00 " , 5534 , 4444 , 1000, 9015);
INSERT INTO tickets values( 11072 , 9015-3 , " AV 9015-3 " , " 2021-04-20 05:50:00 " , " 2021-04-21 07:12:00 " , " 14:31:00 " , 5531 , 2222 , 1200  , 9015);
INSERT INTO tickets values( 11076 , 9015-35 , " AV 9015-35 " , " 2021-04-20 05:50:00 " , " 2021-04-21 07:12:00 " , " 14:31:00 " , 5535 , 2222 , 1200, 9015);

INSERT INTO tickets values( 11077 , 9016-10 , " AV 9016-10 " , " 2021-05-25 07:20:00 " , " 2021-05-25 08:24:00 " , " 01:04:00 " , 5536 , 1111 , 84, 9016);
INSERT INTO tickets values( 11078 , 9016-15 , " AV 9016-15 " , " 2021-05-25 07:20:00 " , " 2021-05-25 08:24:00 " , " 01:04:00 " , 5537 , 1111 , 84, 9016);
INSERT INTO tickets values( 11079 , 9016-17 , " AV 9016-17 " , " 2021-05-25 07:20:00 " , " 2021-05-25 08:24:00 " , " 01:04:00 " , 5538 , 3333 , 65, 9016);
INSERT INTO tickets values( 11080 , 9016-32 , " AV 9016-32 " , " 2021-05-25 07:20:00 " , " 2021-05-25 08:24:00 " , " 01:04:00 " , 5539 , 3333 , 65, 9016);
INSERT INTO tickets values( 11081 , 9016-36 , " AV 9016-36 " , " 2021-05-25 07:20:00 " , " 2021-05-25 08:24:00 " , " 01:04:00 " , 5540 , 3333 , 65, 9016 );

INSERT INTO tickets values( 11082 , 9017-1 , " AV 9017-1 " , " 2021-06-05 05:11:00 " , " 2021-06-05 06:19:00 " , " 01:30:00 " , 5541 , 4444 , 75, 9017 );
INSERT INTO tickets values( 11083 , 9017-23 , " AV 9017-23 " , " 2021-06-05 05:11:00 " , " 2021-06-05 06:19:00 " , " 01:30:00 " , 5542 , 4444 , 75, 9017 );

INSERT INTO tickets values( 11085 , 9018-13 , " AV 9018-13 " , " 2021-06-15 07:20:00 " , " 2021-06-15 09:05:00 " , " 01:45:00 " , 5544 , 1111 , 400, 9018 );
INSERT INTO tickets values( 11086 , 9018-14 , " AV 9018-14 " , " 2021-06-15 07:20:00 " , " 2021-06-15 09:05:00 " , " 01:45:00 " , 5545 , 1111 , 400, 9018 );
INSERT INTO tickets values( 11087 , 9018-18 , " AV 9018-18 " , " 2021-06-15 07:20:00 " , " 2021-06-15 09:05:00 " , " 01:45:00 " , 5546 , 3333 , 300, 9018 );
INSERT INTO tickets values( 11088 , 9018-26 , " AV 9018-26 " , " 2021-06-15 07:20:00 " , " 2021-06-15 09:05:00 " , " 01:45:00 " , 5547 , 3333 , 300, 9018 );
INSERT INTO tickets values( 11089 , 9018-28 , " AV 9018-28 " , " 2021-06-15 07:20:00 " , " 2021-06-15 09:05:00 " , " 01:45:00 " , 5548 , 3333 , 300, 9018 );
INSERT INTO tickets values( 11090 , 9018-33 , " AV 9018-33 " , " 2021-06-15 07:20:00 " , " 2021-06-15 09:05:00 " , " 01:45:00 " , 5549 , 3333 , 300, 9018 );
INSERT INTO tickets values( 11084 , 9018-4 , " AV 9018-4 " , " 2021-06-15 07:20:00 " , " 2021-06-15 09:05:00 " , " 01:45:00 " , 5543 , 1111 , 400, 9018 );

INSERT INTO tickets values( 11091 , 9019-1 , " AV 9019-1 " , " 2021-07-25 05:01:00 " , " 2021-07-25 06:04:00 " , " 01:30:00 " , 5541 , 4444 , 72, 9019);
INSERT INTO tickets values( 11092 , 9019-23 , " AV 9019-23 " , " 2021-07-25 05:01:00 " , " 2021-07-25 06:04:00 " , " 01:30:00 " , 5542 , 4444 , 72, 9019);

INSERT INTO tickets values( 11094 , 9020-13 , " AV 9020-13 " , " 2021-08-15 07:20:00 " , " 2021-08-15 09:05:00 " , " 01:45:00 " , 5544 , 3333 , 300, 9020);
INSERT INTO tickets values( 11095 , 9020-14 , " AV 9020-14 " , " 2021-08-15 07:20:00 " , " 2021-08-15 09:05:00 " , " 01:45:00 " , 5545 , 3333 , 300, 9020);
INSERT INTO tickets values( 11096 , 9020-18 , " AV 9020-18 " , " 2021-08-15 07:20:00 " , " 2021-08-15 09:05:00 " , " 01:45:00 " , 5546 , 3333 , 300, 9020);
INSERT INTO tickets values( 11097 , 9020-26 , " AV 9020-26 " , " 2021-08-15 07:20:00 " , " 2021-08-15 09:05:00 " , " 01:45:00 " , 5547 , 1111 , 400, 9020);
INSERT INTO tickets values( 11098 , 9020-28 , " AV 9020-28 " , " 2021-08-15 07:20:00 " , " 2021-08-15 09:05:00 " , " 01:45:00 " , 5548 , 1111 , 400, 9020);
INSERT INTO tickets values( 11099 , 9020-33 , " AV 9020-33 " , " 2021-08-15 07:20:00 " , " 2021-08-15 09:05:00 " , " 01:45:00 " , 5549 , 3333 , 300, 9020);
INSERT INTO tickets values( 11093 , 9020-4 , " AV 9020-4 " , " 2021-08-15 07:20:00 " , " 2021-08-15 09:05:00 " , " 01:45:00 " , 5543 , 1111 , 400, 9020);




-- cargando datos de millas 

INSERT INTO millas values( 7700 , 2 , 2435.0 , 11000 );
INSERT INTO millas values( 7701 , 4 , 2435.0 , 11001 );
INSERT INTO millas values( 7702 , 9 , 2435.0 , 11002 );
INSERT INTO millas values( 7703 , 22 , 2435.0 , 11003 );
INSERT INTO millas values( 7704 , 37 , 2435.0 , 11004 );
INSERT INTO millas values( 7705 , 5 , 233.0 , 11005 );
INSERT INTO millas values( 7706 , 14 , 233.0 , 11006 );
INSERT INTO millas values( 7707 , 27 , 233.0 , 11007 );
INSERT INTO millas values( 7708 , 29 , 233.0 , 11008 );
INSERT INTO millas values( 7709 , 38 , 233.0 , 11009 );
INSERT INTO millas values( 7710 , 2 , 2435.0 , 11010 );
INSERT INTO millas values( 7711 , 4 , 2435.0 , 11011 );
INSERT INTO millas values( 7712 , 9 , 2435.0 , 11012 );
INSERT INTO millas values( 7713 , 22 , 2435.0 , 11013 );
INSERT INTO millas values( 7714 , 37 , 2435.0 , 11014 );
INSERT INTO millas values( 7715 , 5 , 233.0 , 11015 );
INSERT INTO millas values( 7716 , 14 , 233.0 , 11016 );
INSERT INTO millas values( 7717 , 27 , 233.0 , 11017 );
INSERT INTO millas values( 7718 , 29 , 233.0 , 11018 );
INSERT INTO millas values( 7719 , 38 , 233.0 , 11019 );
INSERT INTO millas values( 7720 , 6 , 9500.0 , 11020 );
INSERT INTO millas values( 7721 , 9 , 9500.0 , 11021 );
INSERT INTO millas values( 7722 , 10 , 9500.0 , 11022 );
INSERT INTO millas values( 7723 , 19 , 9500.0 , 11023 );
INSERT INTO millas values( 7724 , 39 , 9500.0 , 11024 );
INSERT INTO millas values( 7725 , 15 , 4173.0 , 11025 );
INSERT INTO millas values( 7726 , 30 , 4173.0 , 11026 );
INSERT INTO millas values( 7727 , 40 , 4173.0 , 11027 );
INSERT INTO millas values( 7728 , 6 , 9500.0 , 11028 );
INSERT INTO millas values( 7729 , 9 , 9500.0 , 11029 );
INSERT INTO millas values( 7730 , 10 , 9500.0 , 11030 );
INSERT INTO millas values( 7731 , 19 , 9500.0 , 11031 );
INSERT INTO millas values( 7732 , 39 , 9500.0 , 11032 );
INSERT INTO millas values( 7733 , 15 , 4173.0 , 11033 );
INSERT INTO millas values( 7734 , 30 , 4173.0 , 11034 );
INSERT INTO millas values( 7735 , 40 , 4173.0 , 11035 );
INSERT INTO millas values( 7736 , 1 , 3623.0 , 11036 );
INSERT INTO millas values( 7737 , 7 , 3623.0 , 11037 );
INSERT INTO millas values( 7738 , 11 , 3623.0 , 11038 );
INSERT INTO millas values( 7739 , 20 , 3623.0 , 11039 );
INSERT INTO millas values( 7740 , 24 , 3623.0 , 11040 );
INSERT INTO millas values( 7741 , 1 , 9000.0 , 11041 );
INSERT INTO millas values( 7742 , 5 , 9000.0 , 11042 );
INSERT INTO millas values( 7743 , 8 , 9000.0 , 11043 );
INSERT INTO millas values( 7744 , 10 , 9000.0 , 11044 );
INSERT INTO millas values( 7745 , 16 , 9000.0 , 11045 );
INSERT INTO millas values( 7746 , 21 , 9000.0 , 11046 );
INSERT INTO millas values( 7747 , 31 , 9000.0 , 11047 );
INSERT INTO millas values( 7748 , 34 , 9000.0 , 11048 );
INSERT INTO millas values( 7749 , 1 , 3623.0 , 11049 );
INSERT INTO millas values( 7750 , 7 , 3623.0 , 11050 );
INSERT INTO millas values( 7751 , 11 , 3623.0 , 11051 );
INSERT INTO millas values( 7752 , 20 , 3623.0 , 11052 );
INSERT INTO millas values( 7753 , 24 , 3623.0 , 11053 );
INSERT INTO millas values( 7754 , 1 , 9000.0 , 11054 );
INSERT INTO millas values( 7755 , 5 , 9000.0 , 11055 );
INSERT INTO millas values( 7756 , 8 , 9000.0 , 11056 );
INSERT INTO millas values( 7757 , 10 , 9000.0 , 11057 );
INSERT INTO millas values( 7758 , 16 , 9000.0 , 11058 );
INSERT INTO millas values( 7759 , 21 , 9000.0 , 11059 );
INSERT INTO millas values( 7760 , 31 , 9000.0 , 11060 );
INSERT INTO millas values( 7761 , 34 , 9000.0 , 11061 );
INSERT INTO millas values( 7762 , 3 , 2978.0 , 11062 );
INSERT INTO millas values( 7763 , 11 , 2978.0 , 11063 );
INSERT INTO millas values( 7764 , 12 , 2978.0 , 11064 );
INSERT INTO millas values( 7765 , 25 , 2978.0 , 11065 );
INSERT INTO millas values( 7766 , 35 , 2978.0 , 11066 );
INSERT INTO millas values( 7767 , 10 , 309.8 , 11067 );
INSERT INTO millas values( 7768 , 15 , 309.8 , 11068 );
INSERT INTO millas values( 7769 , 17 , 309.8 , 11069 );
INSERT INTO millas values( 7770 , 32 , 309.8 , 11070 );
INSERT INTO millas values( 7771 , 36 , 309.8 , 11071 );
INSERT INTO millas values( 7772 , 3 , 2978.0 , 11072 );
INSERT INTO millas values( 7773 , 11 , 2978.0 , 11073 );
INSERT INTO millas values( 7774 , 12 , 2978.0 , 11074 );
INSERT INTO millas values( 7775 , 25 , 2978.0 , 11075 );
INSERT INTO millas values( 7776 , 35 , 2978.0 , 11076 );
INSERT INTO millas values( 7777 , 10 , 309.8 , 11077 );
INSERT INTO millas values( 7778 , 15 , 309.8 , 11078 );
INSERT INTO millas values( 7779 , 17 , 309.8 , 11079 );
INSERT INTO millas values( 7780 , 32 , 4173.0 , 11080 );
INSERT INTO millas values( 7781 , 36 , 309.8 , 11081 );
INSERT INTO millas values( 7782 , 1 , 550.0 , 11082 );
INSERT INTO millas values( 7783 , 23 , 550.0 , 11083 );
INSERT INTO millas values( 7784 , 4 , 720.0 , 11084 );
INSERT INTO millas values( 7785 , 13 , 720.0 , 11085 );
INSERT INTO millas values( 7786 , 14 , 720.0 , 11086 );
INSERT INTO millas values( 7787 , 18 , 720.0 , 11087 );
INSERT INTO millas values( 7788 , 26 , 720.0 , 11088 );
INSERT INTO millas values( 7789 , 28 , 720.0 , 11089 );
INSERT INTO millas values( 7790 , 33 , 720.0 , 11090 );
INSERT INTO millas values( 7791 , 1 , 550.0 , 11091 );
INSERT INTO millas values( 7792 , 23 , 550.0 , 11092 );
INSERT INTO millas values( 7793 , 4 , 720.0 , 11093 );
INSERT INTO millas values( 7794 , 13 , 720.0 , 11094 );
INSERT INTO millas values( 7795 , 14 , 720.0 , 11095 );
INSERT INTO millas values( 7796 , 18 , 720.0 , 11096 );
INSERT INTO millas values( 7797 , 26 , 720.0 , 11097 );
INSERT INTO millas values( 7798 , 28 , 720.0 , 11098 );
INSERT INTO millas values( 7799 , 33 , 720.0 , 11099 );

