-- Cria o banco de dados Uberistas
CREATE DATABASE Uberistas;

USE Uberistas;

-- Cria a tabela Funcionarios
CREATE TABLE Funcionarios (
    CPF VARCHAR(11) PRIMARY KEY,
    PrimeiroNome VARCHAR(50),
    NomeDoMeio VARCHAR(50),
    Sobrenome VARCHAR(50),
    DataDeNascimento DATE,
    Genero CHAR(1)
);

-- Cria a tabela Motorista
CREATE TABLE Motorista (
    CPF VARCHAR(11) PRIMARY KEY,
    CNH VARCHAR(20),
    Salario DECIMAL(10,2),
    CPFSupervisor VARCHAR(11),
    Departamento VARCHAR(50),
    FOREIGN KEY (CPF) REFERENCES Funcionarios(CPF),
    FOREIGN KEY (CPFSupervisor) REFERENCES Motorista(CPF)
);

-- Cria a tabela Departamento
CREATE TABLE Departamento (
    Codigo INT PRIMARY KEY,
    Nome VARCHAR(50),
    NumeroDeFuncionarios INT,
    CPFGerente VARCHAR(11),
    FOREIGN KEY (CPFGerente) REFERENCES Funcionarios(CPF)
);

-- Cria a tabela Marca
CREATE TABLE Marca (
    Codigo INT PRIMARY KEY,
    Nome VARCHAR(50)
);

-- Cria a tabela Modelo
CREATE TABLE Modelo (
    Codigo INT PRIMARY KEY,
    Nome VARCHAR(50),
    Marca INT,
    FOREIGN KEY (Marca) REFERENCES Marca(Codigo)
);

-- Cria a tabela Veiculo
CREATE TABLE Veiculo (
    Placa VARCHAR(7) PRIMARY KEY,
    Renavam VARCHAR(11),
    AnoModelo INT,
    AnoDeFabricacao INT,
    Modelo INT,
    Kilometragem INT,
    Chassi VARCHAR(20),
    FOREIGN KEY (Modelo) REFERENCES Modelo(Codigo)
);

-- Altera a tabela Motorista adicionando os atributos Email e Celular
ALTER TABLE Motorista ADD Email VARCHAR(100), Celular VARCHAR(20);

-- Altera a tabela Funcionarios removendo o atributo NomeDoMeio
ALTER TABLE Funcionarios DROP COLUMN NomeDoMeio;