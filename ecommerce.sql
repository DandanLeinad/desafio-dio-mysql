-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Table `ecommerce`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL DEFAULT NULL,
  `Identificacao` VARCHAR(45) NULL DEFAULT NULL,
  `Endereco` VARCHAR(100) NULL DEFAULT NULL,
  `Tipo` ENUM('PJ', 'PF') NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Identificacao` (`Identificacao` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`cliente_pf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`cliente_pf` (
  `idCliente` INT NOT NULL,
  `Data_Nascimento` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`cliente_pj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`cliente_pj` (
  `idCliente` INT NOT NULL,
  `Razao_Social` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Status` ENUM('Pendente', 'Processando', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
  `Descricao` VARCHAR(100) NULL DEFAULT NULL,
  `Cliente_idCliente` INT NULL DEFAULT NULL,
  `Frete` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `Cliente_idCliente` (`Cliente_idCliente` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`entrega` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT,
  `Pedido_idPedido` INT NULL DEFAULT NULL,
  `Status` ENUM('Aguardando Envio', 'Em Transporte', 'Entregue', 'Extraviado') NOT NULL,
  `Codigo_Rastreio` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`idEntrega`),
  INDEX `Pedido_idPedido` (`Pedido_idPedido` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `Metodo` ENUM('Cartão de Crédito', 'Boleto', 'PIX', 'Transferência') NOT NULL,
  `Pedido_idPedido` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `Pedido_idPedido` (`Pedido_idPedido` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(45) NULL DEFAULT NULL,
  `Descricao` VARCHAR(100) NULL DEFAULT NULL,
  `Valor` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`relacao_produto_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`relacao_produto_pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `Pedido_idPedido` (`Pedido_idPedido` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
