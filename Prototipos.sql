-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Prototipos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Prototipos` ;

-- -----------------------------------------------------
-- Schema Prototipos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Prototipos` DEFAULT CHARACTER SET utf8 ;
USE `Prototipos` ;

-- -----------------------------------------------------
-- Table `Prototipos`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prototipos`.`alumno` (
  `idAlumno` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Telefono` INT(11) NOT NULL,
  `Fecha/nacimiento` DATE NOT NULL,
  `Curp` VARCHAR(45) NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  `Alumnocol` VARCHAR(45) NOT NULL,
  `PerfilPsico` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`idAlumno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Prototipos`.`tutores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prototipos`.`tutores` (
  `idTutores` INT(11) NOT NULL AUTO_INCREMENT,
  `Cedula` VARCHAR(45) NOT NULL,
  `Telefono` INT(11) NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTutores`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Prototipos`.`psicologo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prototipos`.`psicologo` (
  `idPsicologo` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Cedula` INT(11) NOT NULL,
  `Telefono` INT(11) NOT NULL,
  `RFC` VARCHAR(100) NOT NULL,
  `Curp` VARCHAR(45) NOT NULL,
  `Especialidad` VARCHAR(45) NOT NULL,
  `Correo` VARCHAR(100) NOT NULL,
  `Tutores_idTutores` INT(11) NOT NULL,
  PRIMARY KEY (`idPsicologo`, `Tutores_idTutores`),
  INDEX `fk_Psicologo_Tutores_idx` (`Tutores_idTutores` ),
  CONSTRAINT `fk_Psicologo_Tutores`
    FOREIGN KEY (`Tutores_idTutores`)
    REFERENCES `Prototipos`.`tutores` (`idTutores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Prototipos`.`consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prototipos`.`consulta` (
  `idConsulta` INT(11) NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Tiempo` VARCHAR(45) NOT NULL,
  `Anotaciones` VARCHAR(45) NOT NULL,
  `Psicologo_idPsicologo` INT(11) NOT NULL,
  `Psicologo_Tutores_idTutores` INT(11) NOT NULL,
  `Alumno_idAlumno` INT(11) NOT NULL,
  PRIMARY KEY (`idConsulta`, `Psicologo_idPsicologo`, `Psicologo_Tutores_idTutores`, `Alumno_idAlumno`),
  INDEX `fk_Consulta_Psicologo1_idx` (`Psicologo_idPsicologo` , `Psicologo_Tutores_idTutores` ),
  INDEX `fk_Consulta_Alumno1_idx` (`Alumno_idAlumno` ),
  CONSTRAINT `fk_Consulta_Alumno1`
    FOREIGN KEY (`Alumno_idAlumno`)
    REFERENCES `Prototipos`.`alumno` (`idAlumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Psicologo1`
    FOREIGN KEY (`Psicologo_idPsicologo` , `Psicologo_Tutores_idTutores`)
    REFERENCES `Prototipos`.`psicologo` (`idPsicologo` , `Tutores_idTutores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
