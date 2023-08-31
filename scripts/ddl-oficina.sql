-- Script de criação das tabelas da oficina

CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- tabela clientes
CREATE TABLE IF NOT EXISTS clientes (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL COMMENT "representa o primeiro nome do cliente",
    last_name VARCHAR(20) NOT NULL COMMENT "representa o ultimo nome do cliente", 
    CPF CHAR(11) NOT NULL UNIQUE COMMENT "representa o cpf do cliente",
    email VARCHAR(50) NOT NULL UNIQUE COMMENT "representa o email do cliente",
    phone VARCHAR(15) NOT NULL COMMENT "representa o número telefone de contato do cliente",
    endereco VARCHAR(100) NOT NULL COMMENT "representa o endereço do cliente"
);

-- Tabela veiculos
CREATE TABLE IF NOT EXISTS veiculos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    numero_chassi CHAR(17) COMMENT "representa o número de chassi de um veículo",
    marca VARCHAR(20) NOT NULL COMMENT "representa a marca de um veiculo",
    modelo VARCHAR(20) NOT NULL COMMENT "representa o modelo de um veículo",
    ano_de_fabricacao INT NOT NULL COMMENT "representa o ano em que o veículo foi fabricado",
    proprietario_id INT NOT NULL COMMENT "representa o id de um cliente que é dono do veículo",
    CONSTRAINT fk_cliente_id FOREIGN KEY (proprietario_id) REFERENCES clientes (id) ON DELETE CASCADE
);

-- Tabela funcionarios
CREATE TABLE IF NOT EXISTS funcionarios (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL COMMENT "representa o primeiro nome do funcionario",
    last_name VARCHAR(20) NOT NULL COMMENT "representa o ultimo nome do funcionario",
    CPF CHAR(11) NOT NULL UNIQUE COMMENT "representa o cpf do funcionario",
    email VARCHAR(50) NOT NULL UNIQUE COMMENT "representa o email do funcionario",
    data_de_nasciemnto DATE NOT NULL COMMENT "representa a data de nascimento do funcionario",
    salario DECIMAL(7, 2) DEFAULT 0.00 COMMENT "representa o salário do funcionario"
);

-- tabela  cargos
CREATE TABLE IF NOT EXISTS cargos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL UNIQUE COMMENT "nome do cargo (eletricista, mecânico, etc)"
);

-- tabela servicos
CREATE TABLE IF NOT EXISTS servicos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL UNIQUE COMMENT "representa o nome do serviço (pintura, calibragem de pneu, troca de oleo, etc)",
    valor DECIMAL(10, 2) DEFAULT 0.00 COMMENT "representa o valor do servico"
);

-- Tabela que ralaciona funcionarios com cargos
CREATE TABLE IF NOT EXISTS funcionarios_cargos (
	funcionario_id INT COMMENT "faz referencia ao funcionario que  possui um determinado cargo",
    cargo_id INT COMMENT "faz referencia ao cargo que o funcionario possui",
    data_inicio DATE NOT NULL COMMENT "data em que o funcionario assumiu o cargo",
    PRIMARY KEY (funcionario_id, cargo_id),
    CONSTRAINT fc_fk_funcionario_id FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id) ON DELETE CASCADE,
    CONSTRAINT fc_fk_cargo_id FOREIGN KEY (cargo_id) REFERENCES cargos (id) ON DELETE CASCADE
);

-- Tabela que relaciona funcionarios com servicos
CREATE TABLE IF NOT EXISTS funcionarios_servicos (
	funcionario_id INT COMMENT "referencia o funcionario que realiza um determinado serviço",
    servico_id INT COMMENT "referencia o servico que é realizado por um determinado funcionário",
    PRIMARY KEY (funcionario_id, servico_id),
    CONSTRAINT fs_fk_funcionario_id FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id) ON DELETE CASCADE,
    CONSTRAINT fs_fk_servico_id FOREIGN KEY (servico_id) REFERENCES servicos (id) ON DELETE CASCADE
);

-- tabela que representa um servico contratado por um cliente para um determinado carro
CREATE TABLE IF NOT EXISTS contrato_servico (
	cliente_id INT COMMENT "referencia o cliente que solicitou o serviço",
    veiculo_id INT COMMENT "referencia o veiculo no qual será realizado o serviço",
    servico_id INT COMMENT "referencia o servico que foi contratado pelo cliente",
    data_inicio DATE NOT NULL COMMENT "a data em que o serviço foi/será inciado",
    data_termino DATE NOT NULL COMMENT "a data em que o serviço foi/será finalizado",
    funcionario_responsavel INT NOT NULL COMMENT "referencia o funcionario responsável pelo serviço",
    cs_status ENUM ('Pendente', 'Concluido', 'Cancelado') DEFAULT 'Pendente' COMMENT "O status do serviço contratado pelo cliente (Pendente, Concluido, Cancelado)",
    PRIMARY KEY(cliente_id, veiculo_id, servico_id),
    CONSTRAINT cs_fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes (id) ON DELETE CASCADE,
    CONSTRAINT cs_fk_veiculo_id FOREIGN KEY (veiculo_id) REFERENCES veiculos (id) ON DELETE CASCADE,
    CONSTRAINT cs_fk_servico_id FOREIGN KEY (servico_id) REFERENCES servicos (id) ON DELETE CASCADE,
    CONSTRAINT cs_fk_funcionario_id FOREIGN KEY (funcionario_responsavel) REFERENCES funcionarios (id)
);

