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

-- Atividade: Clínica médica

-- Crie uma tabela chamada PACIENTES
INSERT INTO pacientes (nome, idade, cidade, convenio) VALUES
('Ana', 25, 'Ourinhos', 'Unimed'),
('Bruno', 40, 'Ourinhos', 'Particular'),
('Carla', 32, 'Chavantes', 'Unimed'),
('Daniel', 55, 'Ourinhos', 'SulAmérica'),
('Eduarda', 28, 'Salto Grande', 'Particular'),
('Felipe', 62, 'Ourinhos', 'Unimed'),
('Gabriela', 35, 'Chavantes', 'Bradesco Saúde'),
('Henrique', 48, 'Ourinhos', 'Unimed');

-- Crie uma tabela chamada CONSULTAS
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

-- 1. Descubra quantos pacientes possuem cada convênio.
SELECT 
	convenio,
    COUNT(convenio) AS quantidade
FROM pacientes
GROUP BY convenio;

-- 2. Calcule a idade média dos pacientes de cada cidade.
SELECT 
	cidade,
	AVG(idade) AS idade_media
FROM pacientes
GROUP BY cidade;

/*
3. Cadastre um novo paciente na tabela pacientes. 
Nome: Isabela
Idade: 29
Cidade: Ourinhos
Convênio: Unimed
Depois consulte a tabela e confirme se o registro foi inserido.
*/
INSERT INTO pacientes (nome, idade, cidade, convenio) VALUES (
	'Isabela',
    29,
    'Ourinhos',
    'Unimed'
);

SELECT *
FROM pacientes
WHERE nome LIKE 'isabela';

/*
4. O paciente Bruno mudou de convênio. Altere o cadastro dele para:Unimed.
Depois consulte a quantidade de pacientes por convênio novamente
*/
SELECT *
FROM pacientes
WHERE nome LIKE 'Bruno';

UPDATE pacientes
set convenio = 'Unimed'
WHERE id = 2;

SELECT 
	convenio,
    COUNT(convenio) AS quantidade
FROM pacientes
GROUP BY convenio;

/*
5. A consulta de Dermatologia de R$ 250 passou para R$ 290. Altere o valor correspondente.
Depois execute novamente a consulta que calcula o valor médio por especialidade.
*/
UPDATE consultas
SET valor = 290
WHERE especialidade LIKE 'Dermatologia';

SELECT 
	especialidade,
    AVG(valor) AS valor_medio
FROM consultas
GROUP BY especialidade;

/*
6. Calcule a avaliação média de cada especialidade. 
Depois mostre somente as especialidades cuja avaliação média seja maior que 9.
*/
SELECT
	especialidade,
    AVG(avaliacao) AS avaliacao_media
FROM consultas
GROUP BY especialidade
HAVING avaliacao_media > 9;

/*
7. Crie uma classificação para o valor das consultas:
Até R$ 200 → Baixo
De R$ 201 até R$ 300 → Médio
Acima de R$ 300 → Alto
Mostre: especialidade, valor, classificação.
*/
SELECT
	especialidade,
    valor,
    CASE 
		WHEN valor < 200 THEN 'Baixo'
        WHEN valor < 300 THEN 'Médio'
        ELSE 'Alto'
	END as classificacao
FROM consultas;

-- 8. Qual paciente tem a consulta mais próxima?


