-- DESAFIO: Plataforma de Streaming
DROP TABLE filmes;
CREATE TABLE filmes (
	id_filmes INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	titulo VARCHAR(500) NOT NULL, 
	genero VARCHAR(50), 
	ano_lancamento INT, 
	duracao INT, 
	classificacao VARCHAR(2), 
	avaliacao DECIMAL(3,1) CHECK (avaliacao >= 1.0 AND avaliacao <= 10.0),
	visualizacoes INT, 
	disponivel VARCHAR(3) NOT NULL
);

DESCRIBE filmes;

SELECT * FROM filmes;

-- Crie uma tabela chamada FILMES
INSERT INTO filmes 
(titulo, genero, ano_lancamento, duracao, classificacao, avaliacao, visualizacoes, disponivel)
VALUES
('Interestelar', 'Ficção', 2014, 169, '10', 8.7, 15420, 'Sim'),
('Oppenheimer', 'Drama', 2023, 180, '16', 8.6, 12350, 'Sim'),
('Divertida Mente 2', 'Animação', 2024, 100, 'L', 8.0, 18900, 'Sim'),
('Matrix', 'Ficção', 1999, 136, '14', 8.7, 21000, 'Não'),
('Batman: O Cavaleiro das Trevas', 'Ação', 2008, 152, '12', 9.0, 25000, 'Sim'),
('Toy Story', 'Animação', 1995, 81, 'L', 8.3, 17500, 'Sim'),
('O Poderoso Chefão', 'Drama', 1972, 175, '16', 9.2, 19800, 'Não'),
('Homem-Aranha', 'Ação', 2002, 121, '12', 7.4, 11200, 'Sim'),
('Interestelar 2', 'Ficção', 2025, 155, '12', 7.9, 9800, 'Sim'),
('Corra!', 'Terror', 2017, 104, '16', 8.0, 8700, 'Sim'),
('Invocação do Mal', 'Terror', 2013, 112, '16', 7.5, 9200, 'Não'),
('Super Mario Bros.', 'Animação', 2023, 92, 'L', 7.0, 22100, 'Sim'),
('Duna', 'Ficção', 2021, 155, '14', 8.0, 14300, 'Sim'),
('As Branquelas', 'Comédia', 2004, 109, '12', 7.1, 16000, 'Sim'),
('Se Beber, Não Case!', 'Comédia', 2009, 100, '16', 7.7, 13500, 'Não');

DROP TABLE assinantes;

DESCRIBE assinantes;

SELECT * FROM assinantes;

CREATE TABLE assinantes (
	id_assinantes INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nome VARCHAR(500) NOT NULL,
    email VARCHAR(100) NULL,
    cidade VARCHAR(100) NOT NULL,
    plano VARCHAR(7) NOT NULL,
    valor_mensal DECIMAL(5,2) NOT NULL,
    idade INT NOT NULL,
    status VARCHAR(7) NOT NULL
);

-- Crie uma tabela chamada ASSINANTES
INSERT INTO assinantes
(nome, email, cidade, plano, valor_mensal, idade, status)
VALUES
('Ana Silva', 'ana@email.com', 'Ourinhos', 'Premium', 39.90, 28, 'Ativo'),
('Carlos Souza', 'carlos@email.com', 'Marília', 'Básico', 19.90, 35, 'Ativo'),
('Beatriz Lima', 'beatriz@email.com', 'Ourinhos', 'Premium', 39.90, 22, 'Ativo'),
('João Santos', NULL, 'Assis', 'Padrão', 29.90, 41, 'Inativo'),
('Mariana Oliveira', 'mariana@email.com', 'Marília', 'Premium', 39.90, 31, 'Ativo'),
('Pedro Costa', 'pedro@email.com', 'Ourinhos', 'Básico', 19.90, 19, 'Ativo'),
('Lucas Almeida', 'lucas@email.com', 'Assis', 'Padrão', 29.90, 27, 'Ativo'),
('Juliana Martins', 'juliana@email.com', 'Ourinhos', 'Premium', 39.90, 24, 'Inativo'),
('Rafael Mendes', 'rafael@email.com', 'Salto Grande', 'Básico', 19.90, 52, 'Ativo'),
('Camila Rodrigues', NULL, 'Ourinhos', 'Padrão', 29.90, 17, 'Ativo');


-- 1. Liste os filmes que possuem mais de 15.000 visualizações, possuem avaliação maior que 8.0 e estão disponíveis.
SELECT * FROM filmes
WHERE visualizacoes > 15000
AND avaliacao > 8.0
AND disponivel = 'sim';

-- 2. Liste os filmes do gênero Ficção ou Ação, lançados a partir de 2010, ordenando pela avaliação do maior para o menor.
SELECT * FROM filmes
WHERE genero IN ('Ficção', 'Ação')
AND ano_lancamento > 2010
ORDER BY avaliacao DESC;

-- 3. Mostre os 5 filmes com maior número de visualizações, do maior para o menor.
SELECT * FROM filmes
ORDER BY avaliacao ASC
LIMIT 5;

-- 4. Encontre filmes lançados entre 2000 e 2020, com duração entre 90 e 150 minutos, avaliação maior que 7.5 e que estejam disponíveis.
SELECT * FROM filmes
WHERE ano_lancamento BETWEEN 2000 AND 2020
AND duracao BETWEEN 90 AND 150
AND avaliacao > 7.5
AND disponivel = 'sim';

-- 5. O setor de relacionamento quer localizar assinantes cujos nomes: terminem com "Silva", "Souza" ou "Santos"; 
-- morem em Ourinhos, Marília ou Assis; estejam ativos.
SELECT * FROM assinantes
WHERE (nome LIKE '%Silva' OR nome LIKE '%Souza' OR nome LIKE '%Santos')
AND cidade IN ('Ourinhos', 'Marília', 'Assis');


-- 6. O departamento de marketing possui uma lista de cidades que não participará da campanha: Ourinhos e Assis.
-- Liste os assinantes que: não moram nessas cidades; são Premium ou Padrão; possuem entre 20 e 50 anos; estão ativos.
SELECT * FROM assinantes
WHERE cidade NOT IN ('Ourinhos', 'Assis')
AND plano IN ('Premium', 'Padrâo')
AND idade BETWEEN 20 AND 50
AND status = 'Ativo';

-- 7. A plataforma decidiu oferecer um novo plano apenas para assinantes que não possuem os planos Básico ou Padrão.
-- Liste o nome, plano e cidade dos assinantes que podem receber a oferta. (REGRA: Usar o NOT IN)
SELECT nome, plano, cidade FROM assinantes
WHERE plano NOT IN ('Básico', 'Padrão');

-- 8. A plataforma quer identificar assinantes que não possuem os planos Básico ou Padrão e que não possuem e-mail cadastrado.
-- Liste o nome, plano e e-mail desses assinantes.
SELECT nome, plano, email FROM assinantes
WHERE plano NOT IN ('Básico', 'Padrão')
AND email IS NULL;
