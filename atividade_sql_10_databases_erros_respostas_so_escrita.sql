-- ATIVIDADE SQL: 30 DATABASES COM DADOS PROBLEMÁTICOS
-- Compatível com MySQL / MySQL Workbench.
-- Objetivo: diagnóstico, correção, consultas, JOINs, agregações,
-- alterações de estrutura e comandos DROP.

-- ============================================================
-- BANCO 01 — CLINICA
-- ============================================================
DROP DATABASE IF EXISTS atividade_01_clinica;
CREATE DATABASE atividade_01_clinica;
USE atividade_01_clinica;

CREATE TABLE pacientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(120),
    idade INT,
    telefone VARCHAR(30)
);
CREATE TABLE medicos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    especialidade VARCHAR(80),
    salario DECIMAL(10,2)
);
CREATE TABLE consultas (
    id INT PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    data_consulta DATE,
    valor DECIMAL(10,2),
    status VARCHAR(30),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id),
    FOREIGN KEY (id_medico) REFERENCES medicos(id)
);
CREATE TABLE avaliacoes (
    id INT PRIMARY KEY,
    id_consulta INT,
    nota DECIMAL(3,1),
    comentario VARCHAR(255),
    FOREIGN KEY (id_consulta) REFERENCES consultas(id)
);

INSERT INTO pacientes VALUES
(1,'Ana Souza','ana@email.com',28,'14999990001'),
(2,'Bruno Lima','bruno@email.com',35,'14 99999-0002'),
(3,'Carla Mendes','carla@email',-4,NULL),
(4,'Diego Alves','diego@email.com',42,'14999990004'),
(4,'Diego Alves','diego@email.com',42,'14999990004');

INSERT INTO medicos VALUES
(1,'Dra. Paula','Cardiologia',15000),
(2,'Dr. Marcos','Ortopedia',-8000),
(3,'Dra. Renata','Pediatria',12000),
(4,'Dr. João','Cardiologia',12000);

INSERT INTO consultas VALUES
(1,1,1,'2026-09-01',300,'Realizada'),
(2,2,2,'2026-09-02',-150,'Realizada'),
(3,3,99,'2026-12-30',500,'Confirmada'),
(4,1,1,NULL,300,'X');

INSERT INTO avaliacoes VALUES
(1,1,5.0,'Ótimo atendimento'),
(2,2,9.0,'Nota impossível'),
(3,99,4.0,'Consulta inexistente');


-- SUGESTÃO:
-- 1. Corrija os dados errados com UPDATE.
-- 2. Remova duplicidades com DELETE, preservando o registro correto.
-- 3. Corrija relacionamentos quebrados.
-- 4. Normalize valores de status/categorias inconsistentes.
-- 5. Corrija datas e valores inválidos.

-- --------------------------------------------------------------------

-- PK duplicada, e-mail inválido, idade negativa, telefone fora do padrão,
-- salário negativo, valor de consulta negativo, FK para médico inexistente,
-- data problemática, data nula, status inválido, nota acima da escala e FK
-- para consulta inexistente

-- ============================================================
-- BANCO 02 — ESCOLA
-- ============================================================
DROP DATABASE IF EXISTS atividade_02_escola;
CREATE DATABASE atividade_02_escola;
USE atividade_02_escola;

CREATE TABLE alunos (id INT PRIMARY KEY, nome VARCHAR(100), idade INT, email VARCHAR(120));
CREATE TABLE professores (id INT PRIMARY KEY, nome VARCHAR(100), disciplina VARCHAR(80), salario DECIMAL(10,2));
CREATE TABLE turmas (id INT PRIMARY KEY, id_professor INT, turma VARCHAR(30), ano INT,
FOREIGN KEY (id_professor) REFERENCES professores(id));
CREATE TABLE notas (id INT PRIMARY KEY, id_aluno INT, id_turma INT, nota DECIMAL(4,2),
FOREIGN KEY (id_aluno) REFERENCES alunos(id), FOREIGN KEY (id_turma) REFERENCES turmas(id));

INSERT INTO alunos VALUES
(1,'Alice',16,'alice@email.com'),(2,'Bruno',17,'bruno@email.com'),
(3,'Carla',-2,'carla@email'),(4,'Daniel',18,NULL),(4,'Daniel',18,NULL);

INSERT INTO professores VALUES
(1,'Prof. Ana','Matemática',5000),(2,'Prof. Bia','História',-3000),
(3,'Prof. Carlos','Física',4500);

INSERT INTO turmas VALUES
(1,1,'3A',2026),(2,2,'3B',2026),(3,99,'3C',2026),(4,1,'3A',2035);

INSERT INTO notas VALUES
(1,1,1,8.5),(2,2,2,-1),(3,3,99,11),(4,99,1,7);

-- REGRA: não apagar e recriar todo o banco para "resolver" o exercício.
-- O objetivo é praticar SELECT, INSERT, UPDATE, DELETE, ALTER e DROP.

-- --------------------------------------------------------------------

-- PK duplicada, idade negativa, e-mail inválido, e-mail nulo, salário negativo,
-- FK para professor inexistente, ano futuro/inconsistente, nota negativa, nota
-- acima da escala, FK para turma inexistente e FK para aluno inexistente

-- ============================================================
-- BANCO 03 — BIBLIOTECA
-- ============================================================
DROP DATABASE IF EXISTS atividade_03_biblioteca;
CREATE DATABASE atividade_03_biblioteca;
USE atividade_03_biblioteca;

CREATE TABLE leitores (id INT PRIMARY KEY, nome VARCHAR(100), email VARCHAR(120));
CREATE TABLE livros (id INT PRIMARY KEY, titulo VARCHAR(150), ano INT, quantidade INT, id_autor INT);
CREATE TABLE emprestimos (id INT PRIMARY KEY, id_leitor INT, id_livro INT, data_emprestimo DATE, data_devolucao DATE);
CREATE TABLE autores (id INT PRIMARY KEY, nome VARCHAR(100));

INSERT INTO leitores VALUES
(1,'Ana','ana@email.com'),(2,'Bruno','bruno@email.com'),
(3,'Carla','carla@email'),(4,'Diego',NULL),(4,'Diego',NULL);

INSERT INTO livros VALUES
(1,'SQL para Iniciantes',2024,10,1),(2,'Banco de Dados',2035,-3,2),
(3,'Algoritmos',NULL,5,99),(4,'Redes',2022,0,2);

INSERT INTO emprestimos VALUES
(1,1,1,'2026-09-01','2026-09-10'),(2,2,2,'2026-09-02','2026-08-01'),
(3,99,3,'2026-09-03',NULL),(4,1,99,'2026-09-04',NULL);

INSERT INTO autores VALUES (1,'Machado de Assis'),(2,'Clarice Lispector'),(2,'Clarice Lispector');

-- Spoiler: telefone em formato inconsistente, idade impossível, registro órfão, campo vazio

-- --------------------------------------------------------------------

-- PK duplicada em leitores e autores, e-mail inválido, e-mail nulo, ano futuro,
-- ano nulo, quantidade negativa, relacionamento com autor inexistente, data de
-- devolução anterior ao empréstimo, leitor inexistente e livro inexistente

-- ============================================================
-- BANCO 04 — LOJA
-- ============================================================
DROP DATABASE IF EXISTS atividade_04_loja;
CREATE DATABASE atividade_04_loja;
USE atividade_04_loja;

CREATE TABLE clientes (id INT PRIMARY KEY, nome VARCHAR(100), email VARCHAR(120), status VARCHAR(30));
CREATE TABLE produtos (id INT PRIMARY KEY, nome VARCHAR(100), categoria VARCHAR(80), valor DECIMAL(10,2));
CREATE TABLE pedidos (id INT PRIMARY KEY, id_cliente INT, id_produto INT, data_registro DATE, quantidade INT, status VARCHAR(30));
CREATE TABLE itens_pedido (id INT PRIMARY KEY, id_pedido INT, valor DECIMAL(10,2), observacao VARCHAR(255));

INSERT INTO clientes VALUES
(1,'Ana Silva','ana@email.com','Ativo'),
(2,'Bruno Lima','bruno@email.com','Ativo'),
(3,'Carla Souza','carla@email','X'),
(4,'Diego Alves',NULL,'Ativo'),
(4,'Diego Alves',NULL,'Ativo');

INSERT INTO produtos VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',-50),
(3,'Item C','Categoria X',0),
(4,'Item D','Categoria 1',99999);

INSERT INTO pedidos VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',-3,'Concluido'),
(3,99,3,'2035-12-30',1,'X'),
(4,3,99,NULL,5,'Pendente');

INSERT INTO itens_pedido VALUES
(1,1,100,'OK'),(2,2,-20,'Valor inválido'),(3,99,50,'Registro órfão');

-- SUGESTÃO:
-- 1. Faça consultas com WHERE, BETWEEN, IN, LIKE, IS NULL e IS NOT NULL.
-- 2. Use ORDER BY com mais de uma coluna.
-- 3. Faça consultas com INNER JOIN, LEFT JOIN e RIGHT JOIN.

-- --------------------------------------------------------------------

-- PK duplicada, e-mail inválido, e-mail nulo, status inválido, categoria
-- inconsistente, valor negativo, valor zerado ou fora do padrão, quantidade
-- negativa, cliente inexistente, produto inexistente, data futura, data nula,
-- valor de item negativo e pedido inexistente

-- ============================================================
-- BANCO 05 — HOTEL
-- ============================================================
DROP DATABASE IF EXISTS atividade_05_hotel;
CREATE DATABASE atividade_05_hotel;
USE atividade_05_hotel;

CREATE TABLE hospedes (id INT PRIMARY KEY, nome VARCHAR(100), email VARCHAR(120), status VARCHAR(30));
CREATE TABLE quartos (id INT PRIMARY KEY, nome VARCHAR(100), categoria VARCHAR(80), valor DECIMAL(10,2));
CREATE TABLE reservas (id INT PRIMARY KEY, id_hospede INT, id_quarto INT, data_registro DATE, quantidade INT, status VARCHAR(30));
CREATE TABLE pagamentos (id INT PRIMARY KEY, id_reserva INT, valor DECIMAL(10,2), observacao VARCHAR(255));

INSERT INTO hospedes VALUES
(1,'Ana Silva','ana@email.com','Ativo'),
(2,'Bruno Lima','bruno@email.com','Ativo'),
(3,'Carla Souza','carla@email','X'),
(4,'Diego Alves',NULL,'Ativo'),
(4,'Diego Alves',NULL,'Ativo');

INSERT INTO quartos VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',-50),
(3,'Item C','Categoria X',0),
(4,'Item D','Categoria 1',99999);

INSERT INTO reservas VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',-3,'Concluido'),
(3,99,3,'2035-12-30',1,'X'),
(4,3,99,NULL,5,'Pendente');

INSERT INTO pagamentos VALUES
(1,1,100,'OK'),(2,2,-20,'Valor inválido'),(3,99,50,'Registro órfão');

-- SUGESTÃO:
-- 1. Faça uma consulta que compare a média geral com a média por grupo.
-- 2. Renomeie uma coluna ou tabela e adapte suas consultas.
-- 3. Crie um índice em uma coluna que seja frequentemente pesquisada.
-- 4. Crie uma coluna temporária para uma correção e depois remova-a.

-- --------------------------------------------------------------------

-- PK duplicada, e-mail inválido, e-mail nulo, status inválido, categoria
-- inconsistente, valor de quarto negativo, valor zerado ou fora do padrão,
-- quantidade negativa, hóspede inexistente, quarto inexistente, data futura,
-- data nula, pagamento negativo e reserva inexistente

-- ============================================================
-- BANCO 06 — ACADEMIA
-- ============================================================
DROP DATABASE IF EXISTS atividade_06_academia;
CREATE DATABASE atividade_06_academia;
USE atividade_06_academia;

CREATE TABLE alunos (id INT PRIMARY KEY, nome VARCHAR(100), email VARCHAR(120), status VARCHAR(30));
CREATE TABLE planos (id INT PRIMARY KEY, nome VARCHAR(100), categoria VARCHAR(80), valor DECIMAL(10,2));
CREATE TABLE matriculas (id INT PRIMARY KEY, id_aluno INT, id_plano INT, data_registro DATE, quantidade INT, status VARCHAR(30));
CREATE TABLE treinos (id INT PRIMARY KEY, id_matricula INT, valor DECIMAL(10,2), observacao VARCHAR(255));

INSERT INTO alunos VALUES
(1,'Ana Silva','ana@email.com','Ativo'),
(2,'Bruno Lima','bruno@email.com','Ativo'),
(3,'Carla Souza','carla@email','X'),
(4,'Diego Alves',NULL,'Ativo'),
(4,'Diego Alves',NULL,'Ativo');

INSERT INTO planos VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',-50),
(3,'Item C','Categoria X',0),
(4,'Item D','Categoria 1',99999);

INSERT INTO matriculas VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',-3,'Concluido'),
(3,99,3,'2035-12-30',1,'X'),
(4,3,99,NULL,5,'Pendente');

INSERT INTO treinos VALUES
(1,1,100,'OK'),(2,2,-20,'Valor inválido'),(3,99,50,'Registro órfão');

-- SPOILER:
-- Erros planejados: duplicidade, NULL indevido, preço negativo, data inconsistente

-- --------------------------------------------------------------------

-- PK duplicada, e-mail inválido, e-mail nulo, status inválido, categoria
-- inconsistente, valor de plano negativo, valor zerado ou fora do padrão,
-- quantidade negativa, aluno inexistente, plano inexistente, data futura,
-- data nula, valor de treino negativo e matrícula inexistente

-- ============================================================
-- BANCO 07 — RESTAURANTE
-- ============================================================
DROP DATABASE IF EXISTS atividade_07_restaurante;
CREATE DATABASE atividade_07_restaurante;
USE atividade_07_restaurante;

CREATE TABLE clientes (id INT PRIMARY KEY, nome VARCHAR(100), email VARCHAR(120), status VARCHAR(30));
CREATE TABLE mesas (id INT PRIMARY KEY, nome VARCHAR(100), categoria VARCHAR(80), valor DECIMAL(10,2));
CREATE TABLE reservas (id INT PRIMARY KEY, id_cliente INT, id_mesa INT, data_registro DATE, quantidade INT, status VARCHAR(30));
CREATE TABLE pedidos (id INT PRIMARY KEY, id_reserva INT, valor DECIMAL(10,2), observacao VARCHAR(255));

INSERT INTO clientes VALUES
(1,'Ana Silva','ana@email.com','Ativo'),
(2,'Bruno Lima','bruno@email.com','Ativo'),
(3,'Carla Souza','carla@email','X'),
(4,'Diego Alves',NULL,'Ativo'),
(4,'Diego Alves',NULL,'Ativo');

INSERT INTO mesas VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',-50),
(3,'Item C','Categoria X',0),
(4,'Item D','Categoria 1',99999);

INSERT INTO reservas VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',-3,'Concluido'),
(3,99,3,'2035-12-30',1,'X'),
(4,3,99,NULL,5,'Pendente');

INSERT INTO pedidos VALUES
(1,1,100,'OK'),(2,2,-20,'Valor inválido'),(3,99,50,'Registro órfão');


-- SUGESTÃO:
-- 1. Corrija os dados errados com UPDATE.
-- 2. Remova duplicidades com DELETE, preservando o registro correto.
-- 3. Corrija relacionamentos quebrados.

-- --------------------------------------------------------------------

-- PK duplicada, e-mail inválido, e-mail nulo, status inválido, categoria
-- inconsistente, valor negativo, valor zerado ou fora do padrão, quantidade
-- negativa, cliente inexistente, mesa inexistente, data futura, data nula,
-- valor de pedido negativo e reserva inexistente

-- ============================================================
-- BANCO 08 — CINEMA
-- ============================================================
DROP DATABASE IF EXISTS atividade_08_cinema;
CREATE DATABASE atividade_08_cinema;
USE atividade_08_cinema;

CREATE TABLE clientes (id INT PRIMARY KEY, nome VARCHAR(100), email VARCHAR(120), status VARCHAR(30));
CREATE TABLE filmes (id INT PRIMARY KEY, nome VARCHAR(100), categoria VARCHAR(80), valor DECIMAL(10,2));
CREATE TABLE sessoes (id INT PRIMARY KEY, id_cliente INT, id_filme INT, data_registro DATE, quantidade INT, status VARCHAR(30));
CREATE TABLE ingressos (id INT PRIMARY KEY, id_sessoe INT, valor DECIMAL(10,2), observacao VARCHAR(255));

INSERT INTO clientes VALUES
(1,'Ana Silva','ana@email.com','Ativo'),
(2,'Bruno Lima','bruno@email.com','Ativo'),
(3,'Carla Souza','carla@email','X'),
(4,'Diego Alves',NULL,'Ativo'),
(4,'Diego Alves',NULL,'Ativo');

INSERT INTO filmes VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',-50),
(3,'Item C','Categoria X',0),
(4,'Item D','Categoria 1',99999);

INSERT INTO sessoes VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',-3,'Concluido'),
(3,99,3,'2035-12-30',1,'X'),
(4,3,99,NULL,5,'Pendente');

INSERT INTO ingressos VALUES
(1,1,100,'OK'),(2,2,-20,'Valor inválido'),(3,99,50,'Registro órfão');


-- SUGESTÃO
-- 1. Encontre NULLs que não deveriam existir.
-- 2. Identifique datas inconsistentes.
-- 3. Faça pelo menos uma consulta que mostre registros sem correspondência.

-- --------------------------------------------------------------------

-- PK duplicada, e-mail inválido, e-mail nulo, status inválido, categoria
-- inconsistente, valor negativo, valor zerado ou fora do padrão, quantidade
-- negativa, cliente inexistente, filme inexistente, data futura, data nula,
-- valor de ingresso negativo, sessão inexistente e nome de coluna inconsistente
-- (id_sessoe)

-- ============================================================
-- BANCO 09 — PETSHOP
-- ============================================================
DROP DATABASE IF EXISTS atividade_09_petshop;
CREATE DATABASE atividade_09_petshop;
USE atividade_09_petshop;

CREATE TABLE clientes (id INT PRIMARY KEY, nome VARCHAR(100), email VARCHAR(120), status VARCHAR(30));
CREATE TABLE pets (id INT PRIMARY KEY, nome VARCHAR(100), categoria VARCHAR(80), valor DECIMAL(10,2));
CREATE TABLE servicos (id INT PRIMARY KEY, id_cliente INT, id_pet INT, data_registro DATE, quantidade INT, status VARCHAR(30));
CREATE TABLE agendamentos (id INT PRIMARY KEY, id_servico INT, valor DECIMAL(10,2), observacao VARCHAR(255));

INSERT INTO clientes VALUES
(1,'Ana Silva','ana@email.com','Ativo'),
(2,'Bruno Lima','bruno@email.com','Ativo'),
(3,'Carla Souza','carla@email','X'),
(4,'Diego Alves',NULL,'Ativo'),
(4,'Diego Alves',NULL,'Ativo');

INSERT INTO pets VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',-50),
(3,'Item C','Categoria X',0),
(4,'Item D','Categoria 1',99999);

INSERT INTO servicos VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',-3,'Concluido'),
(3,99,3,'2035-12-30',1,'X'),
(4,3,99,NULL,5,'Pendente');

INSERT INTO agendamentos VALUES
(1,1,100,'OK'),(2,2,-20,'Valor inválido'),(3,99,50,'Registro órfão');


-- SUGESTÃO:
-- 1. Encontre registros duplicados.
-- 2. Localize valores negativos, impossíveis ou fora do domínio.
-- 3. Identifique datas inconsistentes.
-- 4. Corrija os dados errados com UPDATE.
-- 5. Remova duplicidades com DELETE, preservando o registro correto.
-- 6. Corrija datas e valores inválidos.

-- --------------------------------------------------------------------

-- PK duplicada, e-mail inválido, e-mail nulo, status inválido, categoria
-- inconsistente, valor negativo, valor zerado ou fora do padrão, quantidade
-- negativa, cliente inexistente, pet inexistente, data futura, data nula,
-- valor de agendamento negativo e serviço inexistente

-- ============================================================
-- BANCO 10 — OFICINA
-- ============================================================
DROP DATABASE IF EXISTS atividade_10_oficina;
CREATE DATABASE atividade_10_oficina;
USE atividade_10_oficina;

CREATE TABLE clientes (id INT PRIMARY KEY, nome VARCHAR(100), email VARCHAR(120), status VARCHAR(30));
CREATE TABLE veiculos (id INT PRIMARY KEY, nome VARCHAR(100), categoria VARCHAR(80), valor DECIMAL(10,2));
CREATE TABLE servicos (id INT PRIMARY KEY, id_cliente INT, id_veiculo INT, data_registro DATE, quantidade INT, status VARCHAR(30));
CREATE TABLE ordens (id INT PRIMARY KEY, id_servico INT, valor DECIMAL(10,2), observacao VARCHAR(255));

INSERT INTO clientes VALUES
(1,'Ana Silva','ana@email.com','Ativo'),
(2,'Bruno Lima','bruno@email.com','Ativo'),
(3,'Carla Souza','carla@email','X'),
(4,'Diego Alves',NULL,'Ativo'),
(4,'Diego Alves',NULL,'Ativo');

INSERT INTO veiculos VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',-50),
(3,'Item C','Categoria X',0),
(4,'Item D','Categoria 1',99999);

INSERT INTO servicos VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',-3,'Concluido'),
(3,99,3,'2035-12-30',1,'X'),
(4,3,99,NULL,5,'Pendente');

INSERT INTO ordens VALUES
(1,1,100,'OK'),(2,2,-20,'Valor inválido'),(3,99,50,'Registro órfão');

-- SUGESTÃO:
-- 1. Encontre registros duplicados.
-- 2. Identifique datas inconsistentes.
-- 3. Remova duplicidades com DELETE, preservando o registro correto.
-- 4. Corrija datas e valores inválidos.

-- --------------------------------------------------------------------

-- PK duplicada, e-mail inválido, e-mail nulo, status inválido, categoria
-- inconsistente, valor negativo, valor zerado ou fora do padrão, quantidade
-- negativa, cliente inexistente, veículo inexistente, data futura, data nula,
-- valor de ordem negativo e serviço inexistente

