-- Alteracoes.sql

USE Esportes;
GO

-- Adicionando atributos à tabela Escalacoes
ALTER TABLE Escalacoes
ADD NumeroFaltas INT NULL
CHECK (NumeroFaltas >= 0);
GO

ALTER TABLE Escalacoes
ADD NumeroCartoesAmarelos INT NULL
CHECK (NumeroCartoesAmarelos >= 0);
GO

-- Criando a tabela Estadios
CREATE TABLE Estadios (
    id INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(255) NOT NULL,
    idCidade INT NOT NULL,
    Localizacao VARCHAR(255) NULL,
    EnderecoCompleto VARCHAR(255) NULL,
    Contato VARCHAR(255) NULL,
    Responsavel VARCHAR(255) NULL,
    FOREIGN KEY (idCidade) REFERENCES Cidades(id)
);
GO

-- Alterando a tabela Partidas
ALTER TABLE Partidas
ADD DataHora DATETIME NOT NULL;
GO

ALTER TABLE Partidas
ADD idEstadio INT NULL;
GO

ALTER TABLE Partidas
ADD CONSTRAINT FK_Partidas_Estadios
FOREIGN KEY (idEstadio) REFERENCES Estadios(id);
GO

-- Criação de uma tabela CAMPEONATOS
CREATE TABLE Campeonatos (
    id INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(255) NOT NULL,
    Ano INT NOT NULL,
    Tipo VARCHAR(255) NULL,
    DataInicio DATE NULL,
    DataFim DATE NULL,
    Premiacao DECIMAL(10,2) NULL
);
GO

-- Criando tabela intermediária para o relacionamento N:N entre Campeonatos e Times
CREATE TABLE CampeonatosTimes (
    idCampeonato INT NOT NULL,
    idTime INT NOT NULL,
    PRIMARY KEY (idCampeonato, idTime),
    FOREIGN KEY (idCampeonato) REFERENCES Campeonatos(id),
    FOREIGN KEY (idTime) REFERENCES Times(id)
);
GO


-- Criando tabela para registrar penalidades (cartões)
CREATE TABLE Penalidades (
    id INT PRIMARY KEY IDENTITY(1,1),
    idJogador INT NOT NULL,
    idPartida INT NOT NULL,
    TipoPenalidade VARCHAR(255) NOT NULL,
    Descricao VARCHAR(255) NULL,
    DataPenalidade DATE NOT NULL,
    FOREIGN KEY (idJogador) REFERENCES Jogadores(id),
    FOREIGN KEY (idPartida) REFERENCES Partidas(id)
);
GO