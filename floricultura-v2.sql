-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Floricultura
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Floricultura` ;

-- -----------------------------------------------------
-- Schema Floricultura
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Floricultura` DEFAULT CHARACTER SET utf8 ;
USE `Floricultura` ;

-- -----------------------------------------------------
-- Table `Cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cidade` (
  `idCidade` INT NOT NULL,
  `nomCidade` VARCHAR(45) NOT NULL,
  `idUF` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`idCidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bairro` (
  `idBairro` INT NOT NULL,
  `nomBairro` VARCHAR(45) NOT NULL,
  `idCidade` INT NOT NULL,
  PRIMARY KEY (`idBairro`),
  INDEX `fk_Bairro_Cidade1_idx` (`idCidade` ASC) VISIBLE,
  CONSTRAINT `fk_Bairro_Cidade1`
    FOREIGN KEY (`idCidade`)
    REFERENCES `Cidade` (`idCidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Endereço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Endereço` (
  `idEnd` INT NOT NULL,
  `dscLogrEnd` VARCHAR(45) NOT NULL,
  `numLocEnd` INT NOT NULL,
  `dscComplEnd` VARCHAR(45) NULL,
  `numCEPEnd` VARCHAR(20) NOT NULL,
  `idBairro` INT NOT NULL,
  PRIMARY KEY (`idEnd`),
  INDEX `fk_Endereço_Bairro1_idx` (`idBairro` ASC) VISIBLE,
  CONSTRAINT `fk_Endereço_Bairro1`
    FOREIGN KEY (`idBairro`)
    REFERENCES `Bairro` (`idBairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idClien` INT NOT NULL,
  `idCnpjClien` VARCHAR(30) NOT NULL,
  `dscRazSocClien` VARCHAR(45) NOT NULL,
  `nomFantClien` VARCHAR(45) NOT NULL,
  `numTelClien` VARCHAR(20) NOT NULL,
  `idEnd` INT NOT NULL,
  PRIMARY KEY (`idClien`),
  INDEX `fk_Cliente_Endereço1_idx` (`idEnd` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Endereço1`
    FOREIGN KEY (`idEnd`)
    REFERENCES `Endereço` (`idEnd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TipoTurno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TipoTurno` (
  `idTipoTurno` INT NOT NULL,
  `dscTipoTurno` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoTurno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Turno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Turno` (
  `idTurno` INT NOT NULL,
  `hrMinInicio` TIME NOT NULL,
  `hrMinFim` TIME NOT NULL,
  `idTipoTurno` INT NOT NULL,
  PRIMARY KEY (`idTurno`),
  INDEX `fk_Turno_TipoTurno1_idx` (`idTipoTurno` ASC) VISIBLE,
  CONSTRAINT `fk_Turno_TipoTurno1`
    FOREIGN KEY (`idTipoTurno`)
    REFERENCES `TipoTurno` (`idTipoTurno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Especialidade` (
  `codEspec` INT NOT NULL,
  `NomEspec` VARCHAR(45) NOT NULL,
  `valCustHrEspec` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`codEspec`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Funcionário`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Funcionário` (
  `MatrFunc` INT NOT NULL,
  `numCPFFunc` VARCHAR(20) NOT NULL,
  `nomFunc` VARCHAR(45) NOT NULL,
  `numTelFunc` VARCHAR(20) NOT NULL,
  `idEnd` INT NOT NULL,
  `idTurno` INT NOT NULL,
  `codEspec` INT NOT NULL,
  PRIMARY KEY (`MatrFunc`),
  INDEX `fk_Funcionário_Endereço1_idx` (`idEnd` ASC) VISIBLE,
  INDEX `fk_Funcionário_Turno1_idx` (`idTurno` ASC) VISIBLE,
  INDEX `fk_Funcionário_Especialidade1_idx` (`codEspec` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionário_Endereço1`
    FOREIGN KEY (`idEnd`)
    REFERENCES `Endereço` (`idEnd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionário_Turno1`
    FOREIGN KEY (`idTurno`)
    REFERENCES `Turno` (`idTurno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionário_Especialidade1`
    FOREIGN KEY (`codEspec`)
    REFERENCES `Especialidade` (`codEspec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fornecedor` (
  `idForn` INT NOT NULL,
  `idCnpjForn` VARCHAR(30) NOT NULL,
  `dscRazaoSocialForn` VARCHAR(45) NOT NULL,
  `nomFantForn` VARCHAR(45) NOT NULL,
  `numTelForn` VARCHAR(20) NOT NULL,
  `dscMaterForn` VARCHAR(45) NULL,
  `idEnd` INT NOT NULL,
  PRIMARY KEY (`idForn`),
  INDEX `fk_Fornecedor_Endereço1_idx` (`idEnd` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_Endereço1`
    FOREIGN KEY (`idEnd`)
    REFERENCES `Endereço` (`idEnd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TipoMat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TipoMat` (
  `idTipoMat` INT NOT NULL,
  `dscTipoMat` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoMat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Materiais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Materiais` (
  `idCodMat` INT NOT NULL,
  `nomMat` VARCHAR(45) NOT NULL,
  `valPrcUnitMat` DECIMAL(10,2) NOT NULL,
  `pctDescMat` DECIMAL(10,2) NULL,
  `idTipoMat` INT NOT NULL,
  PRIMARY KEY (`idCodMat`),
  INDEX `fk_Materiais_TipoMat1_idx` (`idTipoMat` ASC) VISIBLE,
  CONSTRAINT `fk_Materiais_TipoMat1`
    FOREIGN KEY (`idTipoMat`)
    REFERENCES `TipoMat` (`idTipoMat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FornMat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FornMat` (
  `idFornMat` INT NOT NULL,
  `idForn` INT NOT NULL,
  `idCodMat` INT NOT NULL,
  `datFornMat` DATETIME NOT NULL,
  `qtdUnidFornMat` INT NOT NULL,
  `valPrecoCustoFornMat` DECIMAL(10,2) NOT NULL,
  INDEX `fk_FornMat_Fornecedor1_idx` (`idForn` ASC) VISIBLE,
  PRIMARY KEY (`idFornMat`, `idForn`),
  INDEX `fk_FornMat_Materiais1_idx` (`idCodMat` ASC) VISIBLE,
  CONSTRAINT `fk_FornMat_Fornecedor1`
    FOREIGN KEY (`idForn`)
    REFERENCES `Fornecedor` (`idForn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FornMat_Materiais1`
    FOREIGN KEY (`idCodMat`)
    REFERENCES `Materiais` (`idCodMat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas` (
  `idVendas` INT NOT NULL,
  `qtdVendas` INT NOT NULL,
  `valTotVendas` DECIMAL(10,2) NULL,
  `datVendas` DATETIME NULL,
  `idClien` INT NOT NULL,
  `idCodMat` INT NOT NULL,
  PRIMARY KEY (`idVendas`),
  INDEX `fk_Vendas_Cliente1_idx` (`idClien` ASC) VISIBLE,
  INDEX `fk_Vendas_Materiais1_idx` (`idCodMat` ASC) VISIBLE,
  CONSTRAINT `fk_Vendas_Cliente1`
    FOREIGN KEY (`idClien`)
    REFERENCES `Cliente` (`idClien`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vendas_Materiais1`
    FOREIGN KEY (`idCodMat`)
    REFERENCES `Materiais` (`idCodMat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ContrFuncCli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ContrFuncCli` (
  `idContrFuncCli` INT NOT NULL,
  `qtdHorasContrFuncCli` INT NOT NULL,
  `datContrFuncCli` DATETIME NOT NULL,
  `MatrFunc` INT NOT NULL,
  `idClien` INT NOT NULL,
  PRIMARY KEY (`idContrFuncCli`),
  INDEX `fk_ContrFuncCli_Funcionário1_idx` (`MatrFunc` ASC) VISIBLE,
  INDEX `fk_ContrFuncCli_Cliente1_idx` (`idClien` ASC) VISIBLE,
  CONSTRAINT `fk_ContrFuncCli_Funcionário1`
    FOREIGN KEY (`MatrFunc`)
    REFERENCES `Funcionário` (`MatrFunc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ContrFuncCli_Cliente1`
    FOREIGN KEY (`idClien`)
    REFERENCES `Cliente` (`idClien`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Cidade`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `Cidade` (`idCidade`, `nomCidade`, `idUF`) VALUES (1, 'Guarapari', 'ES');
INSERT INTO `Cidade` (`idCidade`, `nomCidade`, `idUF`) VALUES (2, 'Aracruz', 'ES');
INSERT INTO `Cidade` (`idCidade`, `nomCidade`, `idUF`) VALUES (3, 'Vila Velha', 'ES');
INSERT INTO `Cidade` (`idCidade`, `nomCidade`, `idUF`) VALUES (4, 'Serra', 'ES');
INSERT INTO `Cidade` (`idCidade`, `nomCidade`, `idUF`) VALUES (5, 'Poços de Caldas', 'MG');
INSERT INTO `Cidade` (`idCidade`, `nomCidade`, `idUF`) VALUES (6, 'São Paulo', 'SP');
INSERT INTO `Cidade` (`idCidade`, `nomCidade`, `idUF`) VALUES (7, 'Vitoria', 'ES');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Bairro`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (1, 'Praia do Morro', 1);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (2, 'Vila Rica', 2);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (3, 'Santa Mônica', 3);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (4, 'Interlagos', 2);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (5, 'Centro da Serra', 4);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (6, 'Vila Cruz', 5);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (7, 'Itapuã', 3);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (8, 'Jardim das Laranjeiras', 6);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (9, 'Bairro do Cabral', 7);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (10, 'Morada de Laranjeiras', 4);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (11, 'Maruípe', 7);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (12, 'Jardim Camburi', 7);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (13, 'Bento Ferreira', 7);
INSERT INTO `Bairro` (`idBairro`, `nomBairro`, `idCidade`) VALUES (14, 'Mata da Praia', 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Endereço`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (1, 'Rua Adelina Teixeira', 153, 'Casa', '29216-870', 1);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (2, 'Rua Elizabeth Pontin', 813, 'AP 101 B8', '29194-124', 2);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (3, 'Rua Oito', 1563, 'Casa 2And', '29105-280', 3);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (4, 'Rua Doutor Paulo Sérgio Reis', 465, NULL, '29129-663', 4);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (5, 'Rua Sepupira', 82, '', '29179-366', 5);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (6, 'Rua Olegário Maciel', 34, '', '37701-412', 6);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (7, 'Avenida Fortaleza', 952, NULL, '29101-573', 7);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (8, 'Rua Marechal Xavier da Câmara', 1177, NULL, '02517-190', 8);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (9, 'Avenida Pedro Baião', 556, NULL, '68900-116', 9);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (10, 'Avenida Francisco Carlos Jansen', 78, 'Casa', '29166946', 10);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (11, 'Escadaria Paulo Vieira da Silva', 878, NULL, '29027-304', 9);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (12, 'Avenida Carlos Moreira Lima', 565, NULL, '29065-420', 14);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (13, 'Rua Genserico Encarnação', 55, NULL, '29065-420', 14);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (14, 'Avenida Adolpho Cassoli', 59, NULL, '29043-040', 12);
INSERT INTO `Endereço` (`idEnd`, `dscLogrEnd`, `numLocEnd`, `dscComplEnd`, `numCEPEnd`, `idBairro`) VALUES (15, 'Av. Doutor Herwan Modenese Wanderley', 393, 'Ap 304', '29090-910', 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Cliente`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `Cliente` (`idClien`, `idCnpjClien`, `dscRazSocClien`, `nomFantClien`, `numTelClien`, `idEnd`) VALUES (1, '86.849.930/0001-30', 'FloreSilva Ltda', 'FloreSilva', '(28) 25353-4745', 4);
INSERT INTO `Cliente` (`idClien`, `idCnpjClien`, `dscRazSocClien`, `nomFantClien`, `numTelClien`, `idEnd`) VALUES (2, '11.776.619/0001-09', 'ToqueVerde Ltda', 'Toque Verde', '(27) 38947-7417', 7);
INSERT INTO `Cliente` (`idClien`, `idCnpjClien`, `dscRazSocClien`, `nomFantClien`, `numTelClien`, `idEnd`) VALUES (3, '75.938.048/0001-44', 'Adubos Agro Ltda', 'Adubos Agro', '(27) 47150-9558', 11);
INSERT INTO `Cliente` (`idClien`, `idCnpjClien`, `dscRazSocClien`, `nomFantClien`, `numTelClien`, `idEnd`) VALUES (4, '78.577.527/0001-70', 'Flores da Linda Ltda', 'Flores Da Linda', '(32) 28414-8866', 6);
INSERT INTO `Cliente` (`idClien`, `idCnpjClien`, `dscRazSocClien`, `nomFantClien`, `numTelClien`, `idEnd`) VALUES (5, '12.039.651/0001-74', 'Terras do Jeff Ltda', 'Terras do Jeff', '(27) 55958-2851', 12);
INSERT INTO `Cliente` (`idClien`, `idCnpjClien`, `dscRazSocClien`, `nomFantClien`, `numTelClien`, `idEnd`) VALUES (6, '43.247.518/0001-37', 'Jardins do Vale do Fim do Mundo', 'Fim & Cia', '(32) 98414-8866', 8);
INSERT INTO `Cliente` (`idClien`, `idCnpjClien`, `dscRazSocClien`, `nomFantClien`, `numTelClien`, `idEnd`) VALUES (7, '89.849.937/0001-22', 'Flores Jardim da Paz', 'Paz & Cia', '(27) 38966-7465', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `TipoTurno`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `TipoTurno` (`idTipoTurno`, `dscTipoTurno`) VALUES (1, 'Manhã');
INSERT INTO `TipoTurno` (`idTipoTurno`, `dscTipoTurno`) VALUES (2, 'Tarde');
INSERT INTO `TipoTurno` (`idTipoTurno`, `dscTipoTurno`) VALUES (3, 'Noite');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Turno`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `Turno` (`idTurno`, `hrMinInicio`, `hrMinFim`, `idTipoTurno`) VALUES (1, '08:00', '12:00', 1);
INSERT INTO `Turno` (`idTurno`, `hrMinInicio`, `hrMinFim`, `idTipoTurno`) VALUES (2, '12:00', '16:00', 2);
INSERT INTO `Turno` (`idTurno`, `hrMinInicio`, `hrMinFim`, `idTipoTurno`) VALUES (3, '16:00', '20', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Especialidade`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `Especialidade` (`codEspec`, `NomEspec`, `valCustHrEspec`) VALUES (1, 'Balconista', 12.00);
INSERT INTO `Especialidade` (`codEspec`, `NomEspec`, `valCustHrEspec`) VALUES (2, 'Florista', 6.50);
INSERT INTO `Especialidade` (`codEspec`, `NomEspec`, `valCustHrEspec`) VALUES (3, 'Motorista', 35);
INSERT INTO `Especialidade` (`codEspec`, `NomEspec`, `valCustHrEspec`) VALUES (4, 'Jardineiro', 21);
INSERT INTO `Especialidade` (`codEspec`, `NomEspec`, `valCustHrEspec`) VALUES (5, 'Consultor de Jardins', 67);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Funcionário`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `Funcionário` (`MatrFunc`, `numCPFFunc`, `nomFunc`, `numTelFunc`, `idEnd`, `idTurno`, `codEspec`) VALUES (1, '411.099.765-85', 'Clara Martins Correia', '(27) 3154-2783', 1, 3, 1);
INSERT INTO `Funcionário` (`MatrFunc`, `numCPFFunc`, `nomFunc`, `numTelFunc`, `idEnd`, `idTurno`, `codEspec`) VALUES (2, '234.567.890-12', 'Antônio Sousa Cardoso', '(27) 99349-6528', 2, 2, 1);
INSERT INTO `Funcionário` (`MatrFunc`, `numCPFFunc`, `nomFunc`, `numTelFunc`, `idEnd`, `idTurno`, `codEspec`) VALUES (3, '342.658.574-00', 'Beatriz Castro Ferreira', '(27) 98640-9788', 3, 2, 3);
INSERT INTO `Funcionário` (`MatrFunc`, `numCPFFunc`, `nomFunc`, `numTelFunc`, `idEnd`, `idTurno`, `codEspec`) VALUES (4, '456.789.012-34', 'Enzo Souza Almeida', '(27) 98027-9882', 15, 1, 1);
INSERT INTO `Funcionário` (`MatrFunc`, `numCPFFunc`, `nomFunc`, `numTelFunc`, `idEnd`, `idTurno`, `codEspec`) VALUES (5, '567.890.123-45', 'Kauê Rodrigues Ribeiro', '(27) 99497-5561', 10, 1, 2);
INSERT INTO `Funcionário` (`MatrFunc`, `numCPFFunc`, `nomFunc`, `numTelFunc`, `idEnd`, `idTurno`, `codEspec`) VALUES (6, '732.552.200-25', 'Elza Boehi Fuoxu', '(27) 99875-5462', 12, 2, 3);
INSERT INTO `Funcionário` (`MatrFunc`, `numCPFFunc`, `nomFunc`, `numTelFunc`, `idEnd`, `idTurno`, `codEspec`) VALUES (7, '578.854.000-34', 'Helrim Falzo', '(27) 96572-9874', 11, 2, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Fornecedor`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `Fornecedor` (`idForn`, `idCnpjForn`, `dscRazaoSocialForn`, `nomFantForn`, `numTelForn`, `dscMaterForn`, `idEnd`) VALUES (1, '16.696.388/0001-47', 'João e Maria Jardinagem Ltda', 'Jardim Paraíso', '(27) 1636-9904', 'Materiais para Jardinagem', 9);
INSERT INTO `Fornecedor` (`idForn`, `idCnpjForn`, `dscRazaoSocialForn`, `nomFantForn`, `numTelForn`, `dscMaterForn`, `idEnd`) VALUES (2, '64.636.612/0001-58', 'Milflores Atacadão Ltda', 'Milflores Atacadão', '(11) 3633-8237', 'Plantas e flores', 8);
INSERT INTO `Fornecedor` (`idForn`, `idCnpjForn`, `dscRazaoSocialForn`, `nomFantForn`, `numTelForn`, `dscMaterForn`, `idEnd`) VALUES (3, '68.135.279/0001-54', 'Lívia e Milena Flores Ltda', 'Formosa Flor', '(27) 3295-1891', 'Plantas exotica', 5);
INSERT INTO `Fornecedor` (`idForn`, `idCnpjForn`, `dscRazaoSocialForn`, `nomFantForn`, `numTelForn`, `dscMaterForn`, `idEnd`) VALUES (4, '13.823.129/0001-41', 'NovaTerra Adubos Ltda', 'Nova Terra', '(27) 3758-3247', 'Adubos e fertilizantes', 13);
INSERT INTO `Fornecedor` (`idForn`, `idCnpjForn`, `dscRazaoSocialForn`, `nomFantForn`, `numTelForn`, `dscMaterForn`, `idEnd`) VALUES (5, '70.264.109/0001-11', 'Belas Flores Decorações Ltda', 'Belas Flores', '(27) 4395-8307', 'Itens decorativos para jardinagem', 14);

COMMIT;


-- -----------------------------------------------------
-- Data for table `TipoMat`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `TipoMat` (`idTipoMat`, `dscTipoMat`) VALUES (1, 'Plantas em geral');
INSERT INTO `TipoMat` (`idTipoMat`, `dscTipoMat`) VALUES (2, 'Sementes');
INSERT INTO `TipoMat` (`idTipoMat`, `dscTipoMat`) VALUES (3, 'Adubo / Fertilizante');
INSERT INTO `TipoMat` (`idTipoMat`, `dscTipoMat`) VALUES (4, 'Substrato');
INSERT INTO `TipoMat` (`idTipoMat`, `dscTipoMat`) VALUES (5, 'Vaso/Cachepô');
INSERT INTO `TipoMat` (`idTipoMat`, `dscTipoMat`) VALUES (6, 'Decorativo');
INSERT INTO `TipoMat` (`idTipoMat`, `dscTipoMat`) VALUES (7, 'Itens Jardinagem');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Materiais`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (1, 'Orquideas', 15.9, 10, 1);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (2, 'Rosa do Deserto', 24.9, 10, 1);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (3, 'Mini Orquídea', 39.9, 10, 1);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (4, 'Cacto Rabo de Macaco', 49.95, 10, 1);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (5, 'Rosa ', 29.9, 10, 1);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (6, 'Rosa Trepadeira', 19.9, 10, 1);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (7, 'Palmeira de Madagascar', 48.9, 10, 1);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (8, 'Cactos e suculentas diversos', 2.9, 10, 1);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (9, 'Semente de Bela da Manhã', 2.3, 10, 2);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (10, 'Semente Sempre Viva', 2.3, 10, 2);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (11, 'Semente de Pimenta Vermelha', 1.99, 10, 2);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (12, 'Semente de Couve', 1.99, 10, 2);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (13, 'Semente de Flores', 1.99, 10, 2);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (14, 'Adubo Orgânico', 19.9, 10, 3);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (15, 'Fertilizante / Adubo Químico', 34.99, 10, 3);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (16, 'Substrato de Orquídea', 9.8, 10, 4);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (17, 'Substrato de Suculenta', 14.99, 10, 4);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (18, 'Vaso Pequeno Primafer', 2.99, 10, 5);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (19, 'Vaso Médio Primafer', 3.99, 10, 5);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (20, 'Vaso Grande Primafer', 5.99, 10, 5);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (21, 'Cachepô Valemais', 15.95, 10, 5);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (22, 'Suporte para planta dobrável', 89.99, 10, 6);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (23, 'Suporte para planta ferro', 26.98, NULL, 6);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (24, 'Suporte Corda Macramê', 17.99, 10, 6);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (25, 'Pedra para Jardim', 39.9, 10, 6);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (26, 'Pedra Arenito Plantas', 16.35, 10, 6);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (27, 'Tesoura de Poda', 14.99, 10, 7);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (28, 'Luva para jardinagem', 6.99, 10, 7);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (29, 'Regador', 6.99, 10, 7);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (30, 'Pá Jardinagem', 6.99, 10, 7);
INSERT INTO `Materiais` (`idCodMat`, `nomMat`, `valPrcUnitMat`, `pctDescMat`, `idTipoMat`) VALUES (31, 'Pulverizador', 18.9, NULL, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `FornMat`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (1, 1, 27, '2019-02-25', 200, 7);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (2, 1, 5, '2020-05-30', 100, 15);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (3, 1, 29, '2018-12-25', 250, 3);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (4, 1, 30, '2021-02-04', 120, 3);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (5, 1, 31, '2020-12-14', 30, 9);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (6, 2, 1, '2019-10-27', 80, 7);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (7, 2, 5, '2017-05-19', 90, 15);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (8, 2, 6, '2019-02-28', 35, 10);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (9, 2, 5, '2020-09-15', 24, 15);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (10, 2, 9, '2018-10-18', 22, 1);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (11, 2, 13, '2021-02-16', 120, 1);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (12, 2, 11, '2018-11-29', 300, 1);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (13, 2, 12, '2019-12-05', 210, 1);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (14, 2, 13, '2017-10-09', 140, 1);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (15, 3, 2, '2018-10-28', 52, 12);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (16, 3, 3, '2019-09-28', 27, 20);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (17, 3, 4, '2018-07-30', 15, 25);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (18, 3, 7, '2020-10-19', 98, 25);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (19, 4, 14, '2019-02-01', 87, 10);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (20, 4, 15, '2019-09-17', 52, 15);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (21, 4, 16, '2020-02-01', 32, 5);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (22, 4, 17, '2019-05-04', 45, 7);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (23, 5, 10, '2019-03-07', 74, 1);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (24, 5, 19, '2017-10-15', 85, 2);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (25, 5, 20, '2019-06-26', 22, 2.5);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (26, 5, 21, '2017-08-18', 8, 7.9);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (27, 5, 22, '2019-10-14', 30, 40);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (28, 5, 7, '2018-10-19', 78, 25);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (29, 5, 24, '2016-05-07', 55, 8);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (30, 5, 1, '2017-09-12', 60, 7);
INSERT INTO `FornMat` (`idFornMat`, `idForn`, `idCodMat`, `datFornMat`, `qtdUnidFornMat`, `valPrecoCustoFornMat`) VALUES (31, 5, 26, '2020-02-13', 52, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Vendas`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (1, 20, 318, '2020-07-04', 1, 1);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (2, 10, 249, '2020-07-31', 1, 2);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (3, 5, 199.5, '2019-09-28', 1, 3);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (4, 3, 149.85, '2020-12-12', 2, 4);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (5, 8, 239.2, '2019-06-21', 2, 5);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (6, 12, 238.8, '2020-07-19', 2, 6);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (7, 35, 209.65, '2020-04-30', 2, 20);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (8, 4, 195.6, '2019-04-20', 3, 7);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (9, 21, 334.95, '2020-04-07', 4, 21);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (10, 17, 458.66, '2020-12-25', 5, 23);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (11, 2, 29.98, '2020-07-09', 5, 17);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (12, 4, 119.6, '2019-08-03', 5, 5);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (13, 6, 17.7, '2020-01-11', 6, 18);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (14, 8, 78.4, '2021-03-16', 6, 16);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (15, 4, 27.96, '2020-08-17', 7, 29);
INSERT INTO `Vendas` (`idVendas`, `qtdVendas`, `valTotVendas`, `datVendas`, `idClien`, `idCodMat`) VALUES (16, 25, 49.75, '2020-11-12', 7, 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ContrFuncCli`
-- -----------------------------------------------------
START TRANSACTION;
USE `Floricultura`;
INSERT INTO `ContrFuncCli` (`idContrFuncCli`, `qtdHorasContrFuncCli`, `datContrFuncCli`, `MatrFunc`, `idClien`) VALUES (1, 50, '2021/10/20', 1, 1);
INSERT INTO `ContrFuncCli` (`idContrFuncCli`, `qtdHorasContrFuncCli`, `datContrFuncCli`, `MatrFunc`, `idClien`) VALUES (2, 20, '2020/05/25', 1, 2);
INSERT INTO `ContrFuncCli` (`idContrFuncCli`, `qtdHorasContrFuncCli`, `datContrFuncCli`, `MatrFunc`, `idClien`) VALUES (3, 30, '2019/06/24', 2, 3);
INSERT INTO `ContrFuncCli` (`idContrFuncCli`, `qtdHorasContrFuncCli`, `datContrFuncCli`, `MatrFunc`, `idClien`) VALUES (4, 80, '2018/03/30', 2, 2);
INSERT INTO `ContrFuncCli` (`idContrFuncCli`, `qtdHorasContrFuncCli`, `datContrFuncCli`, `MatrFunc`, `idClien`) VALUES (5, 40, '2020/10/24', 3, 5);
INSERT INTO `ContrFuncCli` (`idContrFuncCli`, `qtdHorasContrFuncCli`, `datContrFuncCli`, `MatrFunc`, `idClien`) VALUES (6, 10, '2018/10/14', 3, 4);

COMMIT;

