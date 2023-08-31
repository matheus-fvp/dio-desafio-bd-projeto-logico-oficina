-- Script de criação das tabelas da oficina

-- tabela clientes
CREATE TABLE clientes (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    endereco VARCHAR(100) NOT NULL
);

-- Tabela veiculos
CREATE TABLE veiculos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    numero_chassi CHAR(17) COMMENT "representa o número de chassi de um veículo",
    marca VARCHAR(20) NOT NULL COMMENT "representa a marca de um veiculo",
    modelo VARCHAR(20) NOT NULL COMMENT "representa o modelo de um veículo",
    ano_de_fabricacao INT NOT NULL COMMENT "representa o ano em que o veículo foi fabricado",
    proprietario_id INT NOT NULL COMMENT "representa o id de um cliente que é dono do veículo",
    CONSTRAINT fk_cliente_id FOREIGN KEY (proprietario_id) REFERENCES clientes (id) ON DELETE CASCADE
);

-- Tabela funcionarios
CREATE TABLE funcionarios (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    data_de_nasciemnto DATE NOT NULL,
    salario DECIMAL(7, 2) DEFAULT 0.00
);

-- tabela  cargos
CREATE TABLE cargos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL UNIQUE
);

-- tabela servicos
CREATE TABLE servicos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL UNIQUE,
    valor DECIMAL(10, 2) DEFAULT 0.00
);

