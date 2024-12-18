-- Criando o banco de dados Esportes
CREATE DATABASE Esportes;
GO

USE Esportes;
GO

-- Criando a tabela Ufs
CREATE TABLE Ufs (
    id INT PRIMARY KEY IDENTITY(1,1),
    NomeEstado VARCHAR(255) NOT NULL,
    Sigla CHAR(2) NOT NULL UNIQUE,
    CONSTRAINT CK_Sigla CHECK (Sigla LIKE '[A-Z][A-Z]')
);
GO

-- Criando a tabela Cidades
CREATE TABLE Cidades (
    id INT PRIMARY KEY IDENTITY(1,1),
    NomeCidade VARCHAR(255) NOT NULL,
    idUF INT NOT NULL,
    FOREIGN KEY (idUF) REFERENCES Ufs(id)
);
GO

-- Criando a tabela Posicoes
CREATE TABLE Posicoes (
    id INT PRIMARY KEY IDENTITY(1,1),
    NomePosicao VARCHAR(255) NOT NULL UNIQUE
);
GO

-- Criando a tabela Jogadores
CREATE TABLE Jogadores (
    id INT PRIMARY KEY IDENTITY(1,1),
    NomeJogador VARCHAR(255) NOT NULL,
    idPosicao INT NOT NULL,
    Salario DECIMAL(10,2) NOT NULL CHECK (Salario >= 0),
    DataNascimento DATE NOT NULL,
    FOREIGN KEY (idPosicao) REFERENCES Posicoes(id)
);
GO

-- Criando a tabela Times
CREATE TABLE Times (
    id INT PRIMARY KEY IDENTITY(1,1),
    NomeTime VARCHAR(255) NOT NULL UNIQUE,
    idCidade INT NOT NULL,
    FOREIGN KEY (idCidade) REFERENCES Cidades(id)
);
GO

-- Criando a tabela Partidas
CREATE TABLE Partidas (
    id INT PRIMARY KEY IDENTITY(1,1),
    idCidade INT NOT NULL,
    NomeJuiz VARCHAR(255) NOT NULL,
    DataPartida DATE NOT NULL,
    FOREIGN KEY (idCidade) REFERENCES Cidades(id)
);
GO

-- Criando a tabela Escalacoes
CREATE TABLE Escalacoes (
    idPartida INT NOT NULL,
    idJogador INT NOT NULL,
    idPosicao INT NOT NULL,
    NumeroGolsJogador INT NOT NULL CHECK (NumeroGolsJogador >= 0),
    PRIMARY KEY (idPartida, idJogador),
    FOREIGN KEY (idPartida) REFERENCES Partidas(id),
    FOREIGN KEY (idJogador) REFERENCES Jogadores(id),
    FOREIGN KEY (idPosicao) REFERENCES Posicoes(id)
);
GO

-- Criando a tabela Resultados
CREATE TABLE Resultados (
    idTime INT NOT NULL,
    idPartida INT NOT NULL,
    NumeroGolsPartida INT NOT NULL CHECK (NumeroGolsPartida >= 0),
    PRIMARY KEY (idTime, idPartida),
    FOREIGN KEY (idTime) REFERENCES Times(id),
    FOREIGN KEY (idPartida) REFERENCES Partidas(id)
);
GO