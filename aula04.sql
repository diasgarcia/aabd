CREATE DATABASE clinica;

USE clinica;

DROP TABLE pacientes;

DROP TABLE consultas;

-- Crie uma base de dados chamada 'CLINICA' e 2 tabelas com as respectivas colunas: 
CREATE TABLE pacientes (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nome VARCHAR(50) NOT NULL,
    idade INT NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    convenio VARCHAR(50) NOT NULL
    );
    
CREATE TABLE consultas (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    especialidade VARCHAR(50) NOT NULL,
    valor DECIMAL(6,2) NOT NULL,
    duracao INT NOT NULL,
    avaliacao DECIMAL(3,1) NOT NULL
);

INSERT INTO pacientes (nome, idade, cidade, convenio) VALUES
('Ana', 25, 'Ourinhos', 'Unimed'),
('Bruno', 40, 'Ourinhos', 'Particular'),
('Carla', 32, 'Chavantes', 'Unimed'),
('Daniel', 55, 'Ourinhos', 'SulAmérica'),
('Eduarda', 28, 'Salto Grande', 'Particular'),
('Felipe', 62, 'Ourinhos', 'Unimed'),
('Gabriela', 35, 'Chavantes', 'Bradesco Saúde'),
('Henrique', 48, 'Ourinhos', 'Unimed');

INSERT INTO consultas (especialidade, valor, duracao, avaliacao) VALUES
('Cardiologia', 350.00, 45, 9.2),
('Dermatologia', 250.00, 30, 8.5),
('Pediatria', 200.00, 40, 9.0),
('Cardiologia', 400.00, 60, 9.5),
('Ortopedia', 300.00, 50, 8.8),
('Dermatologia', 280.00, 35, 9.1),
('Pediatria', 180.00, 30, 8.2),
('Ortopedia', 320.00, 55, 9.3),
('Cardiologia', 380.00, 50, 9.0),
('Pediatria', 220.00, 40, 8.7);

SELECT * FROM pacientes;
SELECT * FROM consultas;

-- COUNT(): conta quantas linhas registradas existem
SELECT 
	COUNT(*) AS total_pacientes,
    COUNT(*) AS total_consultas
FROM pacientes;

-- SUM(): soma
SELECT 
	SUM(valor) AS valor_total 
FROM consultas;

-- AVG(): valor medio
SELECT 
	AVG(valor) AS valor_medio 
FROM consultas;

SELECT 
	AVG(duracao) AS duracao_media
FROM consultas;

-- MAX(): maior valor
SELECT 
	MAX(valor) AS maior_valor
FROM consultas;

-- MIN(): menor valor
SELECT 
	MIN(valor) AS menor_valor
FROM consultas;

-- GROUP BY: agrupa por especialidade
SELECT
	especialidade,
    COUNT(*) AS quantidade
FROM consultas
GROUP BY especialidade;

SELECT
	especialidade,
    AVG(valor) AS valor_medio
FROM consultas
GROUP BY especialidade;

SELECT
	especialidade,
    SUM(valor) AS valor_total
FROM consultas
GROUP BY especialidade;

-- HAVING: dado que...
SELECT *
FROM consultas
WHERE valor > 300;

SELECT 
	especialidade,
    SUM(valor) AS faturamento
FROM consultas
GROUP BY especialidade
HAVING sum(valor) > 700;

-- DISTINCT
SELECT 
	DISTINCT cidade
FROM pacientes;


-- reajustando valor em 10%
SELECT
	especialidade,
    valor,
    valor * 1.10 AS valor_reajustado
FROM consultas;

-- extrutura condicional
SELECT
	nome,
    idade,
    CASE 
		WHEN idade < 30 THEN 'Jovem'
        WHEN idade < 60 THEN 'Adulto'
        ELSE 'Idoso'
	END AS faixa_etaria
FROM pacientes
ORDER BY faixa_etaria;
