-- Matheus C. P. Santos
--Fátima Zahraa Bassam Esser

CREATE DATABASE Avaliacao01BD42S_GrupoL;
GO

USE Avaliacao01BD42S_GrupoL;
GO

-- Criar a tabela Cidades
CREATE TABLE Cidades (
    id INT PRIMARY KEY IDENTITY,
    Cidade VARCHAR(255) NOT NULL,
    UF CHAR(2) NOT NULL
);

-- Inserir registros na tabela Cidades
INSERT INTO Cidades (Cidade, UF) VALUES ('Cidade A', 'SP');
INSERT INTO Cidades (Cidade, UF) VALUES ('Cidade B', 'RJ');
INSERT INTO Cidades (Cidade, UF) VALUES ('Cidade C', 'MG');

-- Criar a tabela Finalidades
CREATE TABLE Finalidades (
    id INT PRIMARY KEY IDENTITY,
    descricao VARCHAR(255) NOT NULL
);

-- Criar a tabela Fases
CREATE TABLE Fases (
    id INT PRIMARY KEY IDENTITY,
    descricao VARCHAR(50) NOT NULL
);

-- Criar a tabela Transformadores
CREATE TABLE Transformadores (
    id INT PRIMARY KEY IDENTITY,
    Nome VARCHAR(255) NOT NULL,
    TensaoEntrada FLOAT NOT NULL,
    TensaoSaida FLOAT NOT NULL,
    Custo MONEY NOT NULL,
    FaseId INT,
    FinalidadeId INT
);

-- Adicionar as restrições de chave estrangeira
ALTER TABLE Transformadores ADD CONSTRAINT FK_Transformadores_Fases
FOREIGN KEY (FaseId) REFERENCES Fases(id);

ALTER TABLE Transformadores ADD CONSTRAINT FK_Transformadores_Finalidades
FOREIGN KEY (FinalidadeId) REFERENCES Finalidades(id);

-- Inserir registros na tabela Finalidades
INSERT INTO Finalidades (descricao) VALUES ('Elevar tensão');
INSERT INTO Finalidades (descricao) VALUES ('Abaixar tensão');
INSERT INTO Finalidades (descricao) VALUES ('Transformador de Corrente');

-- Inserir registros na tabela Fases
INSERT INTO Fases (descricao) VALUES ('Monofásico');
INSERT INTO Fases (descricao) VALUES ('Bifásico');
INSERT INTO Fases (descricao) VALUES ('Trifásico');
INSERT INTO Fases (descricao) VALUES ('Polifásico');

-- Criar a tabela Unidades
CREATE TABLE Unidades (
    id INT PRIMARY KEY IDENTITY,
    Nome VARCHAR(100) NOT NULL,
    Rua VARCHAR(255) NOT NULL,
    Numero INT NOT NULL,
    CEP VARCHAR(10) NOT NULL,
    CidadeID INT,
    FOREIGN KEY (CidadeID) REFERENCES Cidades(id)
);

-- Inserir registros na tabela Unidades
INSERT INTO Unidades (Nome, Rua, Numero, CEP, CidadeID) VALUES ('Unidade A', 'Rua A', 123, '12345-678', 1);
INSERT INTO Unidades (Nome, Rua, Numero, CEP, CidadeID) VALUES ('Unidade B', 'Rua B', 456, '98765-432', 2);
INSERT INTO Unidades (Nome, Rua, Numero, CEP, CidadeID) VALUES ('Unidade C', 'Rua C', 789, '54321-876', 3);

-- Criar a tabela Transformadores
INSERT INTO Transformadores (Nome, TensaoEntrada, TensaoSaida, Custo, FaseId, FinalidadeId)
VALUES ('Transformador 1', 220, 110, 1000.00, 1, 1);
INSERT INTO Transformadores (Nome, TensaoEntrada, TensaoSaida, Custo, FaseId, FinalidadeId)
VALUES ('Transformador 2', 220, 110, 1200.00, 2, 2);
INSERT INTO Transformadores (Nome, TensaoEntrada, TensaoSaida, Custo, FaseId, FinalidadeId)
VALUES ('Transformador 3', 220, 110, 1500.00, 3, 3);
INSERT INTO Transformadores (Nome, TensaoEntrada, TensaoSaida, Custo, FaseId, FinalidadeId)
VALUES ('Transformador 4', 220, 110, 1800.00, 4, 1);

-- Adicionar a coluna UnidadeId na tabela Transformadores
ALTER TABLE Transformadores ADD UnidadeId INT;

-- Atualizar os registros existentes
-- Atribuindo os 2 primeiros registros à Unidade A (id = 1)
UPDATE Transformadores
SET UnidadeId = 1
WHERE id IN (1, 2);

-- Atribuindo os 2 últimos registros à Unidade B (id = 2)
UPDATE Transformadores
SET UnidadeId = 2
WHERE id IN (3, 4);

-- Listar todos os dados dos transformadores da unidade 1 com custo > R$ 50.000,00
SELECT T.Nome, T.TensaoEntrada, T.TensaoSaida, T.Custo, F.descricao AS Fase, Fin.descricao AS Finalidade
FROM Transformadores T
INNER JOIN Fases F ON T.FaseId = F.id
INNER JOIN Finalidades Fin ON T.FinalidadeId = Fin.id
WHERE T.Custo > 50000.00;

-- Contar o número de transformadores em cada cidade:
SELECT C.id AS CidadeID, C.Cidade, C.UF, COUNT(T.id) AS Contagem
FROM Cidades C
LEFT JOIN Unidades U ON C.id = U.CidadeID
LEFT JOIN Transformadores T ON U.id = T.UnidadeId
GROUP BY C.id, C.Cidade, C.UF;

-- Listar a média de custo dos transformadores por fase:
SELECT F.descricao AS Fase, AVG(T.Custo) AS MediaCusto
FROM Transformadores T
INNER JOIN Fases F ON T.FaseId = F.id
GROUP BY F.descricao;

-- Listar os dados do transformador com maior valor de custo:
SELECT T.Nome, T.TensaoEntrada, T.TensaoSaida, T.Custo, F.descricao AS Fase, Fin.descricao AS Finalidade
FROM Transformadores T
INNER JOIN Fases F ON T.FaseId = F.id
INNER JOIN Finalidades Fin ON T.FinalidadeId = Fin.id
WHERE T.Custo = (SELECT MAX(Custo) FROM Transformadores);

-- Listar o nome das unidades que não tem transformadores registrados:*/
SELECT Nome FROM Unidades WHERE id NOT IN (SELECT UnidadeId FROM Transformadores);

-- Listar os dados dos transformadores bifásicos que estão efetivamente instalados cuja finalidade seja elevar a tensão:
SELECT T.Nome, T.TensaoEntrada, T.TensaoSaida, T.Custo, F.descricao AS Fase, Fin.descricao AS Finalidade
FROM Transformadores T
INNER JOIN Fases F ON T.FaseId = F.id
INNER JOIN Finalidades Fin ON T.FinalidadeId = Fin.id
WHERE F.descricao = 'Bifásico' AND Fin.descricao = 'Elevar tensão' AND T.UnidadeId IS NOT NULL;