CREATE SCHEMA IF NOT EXISTS `M_TIENDA` DEFAULT CHARACTER SET utf8 ;
USE `M_TIENDA` ;

-- -----------------------------------------------------
-- Table `M_TIENDA`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M_TIENDA`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `saldo` FLOAT NULL,
  `descuento` FLOAT NULL,
  `limnite_credito` FLOAT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M_TIENDA`.`DIRECCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M_TIENDA`.`DIRECCION` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_direccion`),
  INDEX `fk_DIRECCION_cliente_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_DIRECCION_cliente`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `M_TIENDA`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M_TIENDA`.`PEDIDO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M_TIENDA`.`PEDIDO` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_PEDIDO_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_PEDIDO_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `M_TIENDA`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M_TIENDA`.`ARTICULO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M_TIENDA`.`ARTICULO` (
  `id_artoculo` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(200) NULL,
  PRIMARY KEY (`id_artoculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M_TIENDA`.`FABRICA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M_TIENDA`.`FABRICA` (
  `id_fabrica` INT NOT NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`id_fabrica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M_TIENDA`.`EXISTENCIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M_TIENDA`.`EXISTENCIAS` (
  `FABRICA_id_fabrica` INT NOT NULL,
  `ARTICULO_id_artoculo` INT NOT NULL,
  `cant_existencias` INT NULL,
  PRIMARY KEY (`FABRICA_id_fabrica`, `ARTICULO_id_artoculo`),
  INDEX `fk_FABRICA_has_ARTICULO_ARTICULO1_idx` (`ARTICULO_id_artoculo` ASC) VISIBLE,
  INDEX `fk_FABRICA_has_ARTICULO_FABRICA1_idx` (`FABRICA_id_fabrica` ASC) VISIBLE,
  CONSTRAINT `fk_FABRICA_has_ARTICULO_FABRICA1`
    FOREIGN KEY (`FABRICA_id_fabrica`)
    REFERENCES `M_TIENDA`.`FABRICA` (`id_fabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FABRICA_has_ARTICULO_ARTICULO1`
    FOREIGN KEY (`ARTICULO_id_artoculo`)
    REFERENCES `M_TIENDA`.`ARTICULO` (`id_artoculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `M_TIENDA`.`orden venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `M_TIENDA`.`orden venta` (
  `ARTICULO_id_artoculo` INT NOT NULL,
  `PEDIDO_id_pedido` INT NOT NULL,
  `cantidad` INT NULL,
  PRIMARY KEY (`ARTICULO_id_artoculo`, `PEDIDO_id_pedido`),
  INDEX `fk_ARTICULO_has_PEDIDO_PEDIDO1_idx` (`PEDIDO_id_pedido` ASC) VISIBLE,
  INDEX `fk_ARTICULO_has_PEDIDO_ARTICULO1_idx` (`ARTICULO_id_artoculo` ASC) VISIBLE,
  CONSTRAINT `fk_ARTICULO_has_PEDIDO_ARTICULO1`
    FOREIGN KEY (`ARTICULO_id_artoculo`)
    REFERENCES `M_TIENDA`.`ARTICULO` (`id_artoculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARTICULO_has_PEDIDO_PEDIDO1`
    FOREIGN KEY (`PEDIDO_id_pedido`)
    REFERENCES `M_TIENDA`.`PEDIDO` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)