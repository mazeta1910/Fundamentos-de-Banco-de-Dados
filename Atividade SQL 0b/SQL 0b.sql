-- 1) Criando o banco de dados "Concessionarias"
CREATE DATABASE Concessionarias;
GO

USE Concessionarias;
GO

-- 2) Criando as tabelas com os relacionamentos
-- Tabela Marca
CREATE TABLE Marca (
    Cod_Marca INT PRIMARY KEY,
    Nome_Marca VARCHAR(50) NOT NULL,
    PaísOrigem VARCHAR(50)
);

-- Tabela Cidade
CREATE TABLE Cidade (
    Cod_cidade INT PRIMARY KEY,
    Nome_cidade VARCHAR(50) NOT NULL,
    UF VARCHAR(2),
    País VARCHAR(50)
);

-- Tabela Modelo
CREATE TABLE Modelo (
    Cod_modelo INT PRIMARY KEY,
    Nome_modelo VARCHAR(50) NOT NULL,
    Tipo_modelo VARCHAR(50),
    Cor_modelo VARCHAR(50),
    Cod_Marca INT,
    FOREIGN KEY (Cod_Marca) REFERENCES Marca(Cod_Marca)
);

-- Tabela Filial
CREATE TABLE Filial (
    Cod_filial INT PRIMARY KEY,
    Nome_filial VARCHAR(50) NOT NULL,
    Cidade_filial INT,
    FOREIGN KEY (Cidade_filial) REFERENCES Cidade(Cod_cidade)
);

-- Tabela Disponível
CREATE TABLE Disponível (
    Cod_modelo INT,
    Cod_filial INT,
    data DATE,
    Qtde INT,
    valor_venda DECIMAL(10,2),
    PRIMARY KEY (Cod_modelo, Cod_filial),
    FOREIGN KEY (Cod_modelo) REFERENCES Modelo(Cod_modelo),
    FOREIGN KEY (Cod_filial) REFERENCES Filial(Cod_filial)
);

-- Tabela Veiculos
CREATE TABLE Veiculos (
    Cod_veiculo INT PRIMARY KEY,
    Cod_Modelo INT,
    Ano_Fab INT,
    Ano_Modelo INT,
    FOREIGN KEY (Cod_Modelo) REFERENCES Modelo(Cod_modelo)
);

-- 3) Adicionando o atributo Chassi à tabela Modelo
ALTER TABLE Modelo
ADD Chassi VARCHAR(50);

-- 4) Adicionando os atributos E-mail e Telefone à tabela Filial
ALTER TABLE Filial
ADD Email VARCHAR(100),
    Telefone VARCHAR(20);

-- 5) Adicionando restrição de chave única para Cidade_filial na tabela Filial
ALTER TABLE Filial
ADD CONSTRAINT UQ_Cidade_filial UNIQUE (Cidade_filial);

-- 7) Sugestões para reduzir a redundância de dados (implementação)
-- Criando a tabela TipoModelo
CREATE TABLE TipoModelo (
    Cod_TipoModelo INT PRIMARY KEY,
    Descricao_TipoModelo VARCHAR(50)
);

-- Alterando a tabela Modelo para referenciar TipoModelo
ALTER TABLE Modelo
ADD Cod_TipoModelo INT,
    FOREIGN KEY (Cod_TipoModelo) REFERENCES TipoModelo(Cod_TipoModelo);

-- Criando a tabela VeiculoModelo
CREATE TABLE VeiculoModelo (
    Cod_VeiculoModelo INT PRIMARY KEY,
    Cod_modelo INT,
    Num_Motor VARCHAR(50),
    -- Outros atributos relevantes
    FOREIGN KEY (Cod_modelo) REFERENCES Modelo(Cod_modelo)
);

-- Alterando a tabela Disponível para referenciar VeiculoModelo
-- REMOVIDA A LINHA ABAIXO:
--ALTER TABLE Disponível
--DROP CONSTRAINT PK_Disponível; -- Remove a chave primária composta existente

ALTER TABLE Disponível
ADD Cod_VeiculoModelo INT,
    PRIMARY KEY (Cod_VeiculoModelo, Cod_filial),
    FOREIGN KEY (Cod_VeiculoModelo) REFERENCES VeiculoModelo(Cod_VeiculoModelo);


-- 8) Restrições de checagem (exemplos)
-- Tabela Marca
ALTER TABLE Marca
ADD CONSTRAINT CK_PaisOrigem CHECK (PaísOrigem IN ('Brasil', 'Alemanha', 'Japão', 'Estados Unidos', 'França')); -- Lista de países válida

-- Tabela Veiculos
ALTER TABLE Veiculos
ADD CONSTRAINT CK_Ano_Fab CHECK (Ano_Fab BETWEEN 1900 AND YEAR(GETDATE())),
    CONSTRAINT CK_Ano_Modelo CHECK (Ano_Modelo BETWEEN 1900 AND YEAR(GETDATE()));

-- Tabela Disponível
ALTER TABLE Disponível
ADD CONSTRAINT CK_Qtde CHECK (Qtde >= 0),
    CONSTRAINT CK_valor_venda CHECK (valor_venda >= 0);