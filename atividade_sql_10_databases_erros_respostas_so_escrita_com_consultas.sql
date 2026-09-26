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



-- CONSULTAS PARA LOCALIZAR OS ERROS

-- PK duplicada em pacientes
SELECT id, COUNT(*) AS quantidade
FROM pacientes
GROUP BY id
HAVING COUNT(*) > 1;

-- E-mail inválido
SELECT *
FROM pacientes
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- Idade negativa
SELECT *
FROM pacientes
WHERE idade < 0;

-- Telefone nulo ou fora do padrão de 11 dígitos
SELECT *
FROM pacientes
WHERE telefone IS NULL
   OR telefone NOT REGEXP '^[0-9]{11}$';

-- Salário negativo
SELECT *
FROM medicos
WHERE salario < 0;

-- Valor de consulta negativo
SELECT *
FROM consultas
WHERE valor < 0;

-- FK para médico inexistente
SELECT c.*
FROM consultas c
LEFT JOIN medicos m ON c.id_medico = m.id
WHERE m.id IS NULL;

-- Data de consulta futura
SELECT *
FROM consultas
WHERE data_consulta > CURDATE();

-- Data de consulta nula
SELECT *
FROM consultas
WHERE data_consulta IS NULL;

-- Status de consulta inválido
SELECT *
FROM consultas
WHERE status NOT IN ('Realizada', 'Confirmada', 'Pendente', 'Cancelada');

-- Nota fora da escala de 0 a 5
SELECT *
FROM avaliacoes
WHERE nota < 0 OR nota > 5;

-- FK para consulta inexistente
SELECT a.*
FROM avaliacoes a
LEFT JOIN consultas c ON a.id_consulta = c.id
WHERE c.id IS NULL;

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



-- CONSULTAS PARA LOCALIZAR OS ERROS

-- PK duplicada em alunos
SELECT id, COUNT(*) AS quantidade
FROM alunos
GROUP BY id
HAVING COUNT(*) > 1;

-- Idade negativa
SELECT *
FROM alunos
WHERE idade < 0;

-- E-mail inválido
SELECT *
FROM alunos
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- E-mail nulo
SELECT *
FROM alunos
WHERE email IS NULL;

-- Salário negativo
SELECT *
FROM professores
WHERE salario < 0;

-- FK para professor inexistente
SELECT t.*
FROM turmas t
LEFT JOIN professores p ON t.id_professor = p.id
WHERE p.id IS NULL;

-- Ano futuro/inconsistente
SELECT *
FROM turmas
WHERE ano > YEAR(CURDATE());

-- Nota negativa ou acima da escala de 0 a 10
SELECT *
FROM notas
WHERE nota < 0 OR nota > 10;

-- FK para turma inexistente
SELECT n.*
FROM notas n
LEFT JOIN turmas t ON n.id_turma = t.id
WHERE t.id IS NULL;

-- FK para aluno inexistente
SELECT n.*
FROM notas n
LEFT JOIN alunos a ON n.id_aluno = a.id
WHERE a.id IS NULL;

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



-- CONSULTAS PARA LOCALIZAR OS ERROS

-- PK duplicada em leitores
SELECT id, COUNT(*) AS quantidade
FROM leitores
GROUP BY id
HAVING COUNT(*) > 1;

-- PK duplicada em autores
SELECT id, COUNT(*) AS quantidade
FROM autores
GROUP BY id
HAVING COUNT(*) > 1;

-- E-mail inválido
SELECT *
FROM leitores
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- E-mail nulo
SELECT *
FROM leitores
WHERE email IS NULL;

-- Ano futuro
SELECT *
FROM livros
WHERE ano > YEAR(CURDATE());

-- Ano nulo
SELECT *
FROM livros
WHERE ano IS NULL;

-- Quantidade negativa
SELECT *
FROM livros
WHERE quantidade < 0;

-- Relacionamento com autor inexistente
SELECT l.*
FROM livros l
LEFT JOIN autores a ON l.id_autor = a.id
WHERE a.id IS NULL;

-- Data de devolução anterior à data do empréstimo
SELECT *
FROM emprestimos
WHERE data_devolucao IS NOT NULL
  AND data_devolucao < data_emprestimo;

-- Leitor inexistente
SELECT e.*
FROM emprestimos e
LEFT JOIN leitores l ON e.id_leitor = l.id
WHERE l.id IS NULL;

-- Livro inexistente
SELECT e.*
FROM emprestimos e
LEFT JOIN livros l ON e.id_livro = l.id
WHERE l.id IS NULL;

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



-- CONSULTAS PARA LOCALIZAR OS ERROS

-- PK duplicada em clientes
SELECT id, COUNT(*) AS quantidade
FROM clientes
GROUP BY id
HAVING COUNT(*) > 1;

-- E-mail inválido
SELECT *
FROM clientes
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- E-mail nulo
SELECT *
FROM clientes
WHERE email IS NULL;

-- Status inválido em clientes
SELECT *
FROM clientes
WHERE status NOT IN ('Ativo', 'Inativo');

-- Categoria inconsistente em produtos
SELECT *
FROM produtos
WHERE categoria NOT IN ('Categoria 1', 'Categoria 2');

-- Valor negativo ou zerado em produtos
SELECT *
FROM produtos
WHERE valor <= 0;

-- Valor muito acima dos demais em produtos
SELECT *
FROM produtos
WHERE valor = (SELECT MAX(valor) FROM produtos);

-- Quantidade negativa em pedidos
SELECT *
FROM pedidos
WHERE quantidade < 0;

-- Cliente inexistente em pedidos
SELECT t.*
FROM pedidos t
LEFT JOIN clientes e ON t.id_cliente = e.id
WHERE e.id IS NULL;

-- Produto inexistente em pedidos
SELECT t.*
FROM pedidos t
LEFT JOIN produtos i ON t.id_produto = i.id
WHERE i.id IS NULL;

-- Data futura em pedidos
SELECT *
FROM pedidos
WHERE data_registro > CURDATE();

-- Data nula em pedidos
SELECT *
FROM pedidos
WHERE data_registro IS NULL;

-- Status inválido em pedidos
SELECT *
FROM pedidos
WHERE status NOT IN ('Concluido', 'Pendente', 'Cancelado');

-- Valor negativo em itens_pedido
SELECT *
FROM itens_pedido
WHERE valor < 0;

-- Pedido inexistente em itens_pedido
SELECT c.*
FROM itens_pedido c
LEFT JOIN pedidos t ON c.id_pedido = t.id
WHERE t.id IS NULL;

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



-- CONSULTAS PARA LOCALIZAR OS ERROS

-- PK duplicada em hospedes
SELECT id, COUNT(*) AS quantidade
FROM hospedes
GROUP BY id
HAVING COUNT(*) > 1;

-- E-mail inválido
SELECT *
FROM hospedes
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- E-mail nulo
SELECT *
FROM hospedes
WHERE email IS NULL;

-- Status inválido em hospedes
SELECT *
FROM hospedes
WHERE status NOT IN ('Ativo', 'Inativo');

-- Categoria inconsistente em quartos
SELECT *
FROM quartos
WHERE categoria NOT IN ('Categoria 1', 'Categoria 2');

-- Valor negativo ou zerado em quartos
SELECT *
FROM quartos
WHERE valor <= 0;

-- Valor muito acima dos demais em quartos
SELECT *
FROM quartos
WHERE valor = (SELECT MAX(valor) FROM quartos);

-- Quantidade negativa em reservas
SELECT *
FROM reservas
WHERE quantidade < 0;

-- Hóspede inexistente em reservas
SELECT t.*
FROM reservas t
LEFT JOIN hospedes e ON t.id_hospede = e.id
WHERE e.id IS NULL;

-- Quarto inexistente em reservas
SELECT t.*
FROM reservas t
LEFT JOIN quartos i ON t.id_quarto = i.id
WHERE i.id IS NULL;

-- Data futura em reservas
SELECT *
FROM reservas
WHERE data_registro > CURDATE();

-- Data nula em reservas
SELECT *
FROM reservas
WHERE data_registro IS NULL;

-- Status inválido em reservas
SELECT *
FROM reservas
WHERE status NOT IN ('Concluido', 'Pendente', 'Cancelado');

-- Valor negativo em pagamentos
SELECT *
FROM pagamentos
WHERE valor < 0;

-- Reserva inexistente em pagamentos
SELECT c.*
FROM pagamentos c
LEFT JOIN reservas t ON c.id_reserva = t.id
WHERE t.id IS NULL;

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



-- CONSULTAS PARA LOCALIZAR OS ERROS

-- PK duplicada em alunos
SELECT id, COUNT(*) AS quantidade
FROM alunos
GROUP BY id
HAVING COUNT(*) > 1;

-- E-mail inválido
SELECT *
FROM alunos
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- E-mail nulo
SELECT *
FROM alunos
WHERE email IS NULL;

-- Status inválido em alunos
SELECT *
FROM alunos
WHERE status NOT IN ('Ativo', 'Inativo');

-- Categoria inconsistente em planos
SELECT *
FROM planos
WHERE categoria NOT IN ('Categoria 1', 'Categoria 2');

-- Valor negativo ou zerado em planos
SELECT *
FROM planos
WHERE valor <= 0;

-- Valor muito acima dos demais em planos
SELECT *
FROM planos
WHERE valor = (SELECT MAX(valor) FROM planos);

-- Quantidade negativa em matriculas
SELECT *
FROM matriculas
WHERE quantidade < 0;

-- Aluno inexistente em matriculas
SELECT t.*
FROM matriculas t
LEFT JOIN alunos e ON t.id_aluno = e.id
WHERE e.id IS NULL;

-- Plano inexistente em matriculas
SELECT t.*
FROM matriculas t
LEFT JOIN planos i ON t.id_plano = i.id
WHERE i.id IS NULL;

-- Data futura em matriculas
SELECT *
FROM matriculas
WHERE data_registro > CURDATE();

-- Data nula em matriculas
SELECT *
FROM matriculas
WHERE data_registro IS NULL;

-- Status inválido em matriculas
SELECT *
FROM matriculas
WHERE status NOT IN ('Concluido', 'Pendente', 'Cancelado');

-- Valor negativo em treinos
SELECT *
FROM treinos
WHERE valor < 0;

-- Matrícula inexistente em treinos
SELECT c.*
FROM treinos c
LEFT JOIN matriculas t ON c.id_matricula = t.id
WHERE t.id IS NULL;

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



-- CONSULTAS PARA LOCALIZAR OS ERROS

-- PK duplicada em clientes
SELECT id, COUNT(*) AS quantidade
FROM clientes
GROUP BY id
HAVING COUNT(*) > 1;

-- E-mail inválido
SELECT *
FROM clientes
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- E-mail nulo
SELECT *
FROM clientes
WHERE email IS NULL;

-- Status inválido em clientes
SELECT *
FROM clientes
WHERE status NOT IN ('Ativo', 'Inativo');

-- Categoria inconsistente em mesas
SELECT *
FROM mesas
WHERE categoria NOT IN ('Categoria 1', 'Categoria 2');

-- Valor negativo ou zerado em mesas
SELECT *
FROM mesas
WHERE valor <= 0;

-- Valor muito acima dos demais em mesas
SELECT *
FROM mesas
WHERE valor = (SELECT MAX(valor) FROM mesas);

-- Quantidade negativa em reservas
SELECT *
FROM reservas
WHERE quantidade < 0;

-- Cliente inexistente em reservas
SELECT t.*
FROM reservas t
LEFT JOIN clientes e ON t.id_cliente = e.id
WHERE e.id IS NULL;

-- Mesa inexistente em reservas
SELECT t.*
FROM reservas t
LEFT JOIN mesas i ON t.id_mesa = i.id
WHERE i.id IS NULL;

-- Data futura em reservas
SELECT *
FROM reservas
WHERE data_registro > CURDATE();

-- Data nula em reservas
SELECT *
FROM reservas
WHERE data_registro IS NULL;

-- Status inválido em reservas
SELECT *
FROM reservas
WHERE status NOT IN ('Concluido', 'Pendente', 'Cancelado');

-- Valor negativo em pedidos
SELECT *
FROM pedidos
WHERE valor < 0;

-- Reserva inexistente em pedidos
SELECT c.*
FROM pedidos c
LEFT JOIN reservas t ON c.id_reserva = t.id
WHERE t.id IS NULL;

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



-- CONSULTAS PARA LOCALIZAR OS ERROS

-- PK duplicada em clientes
SELECT id, COUNT(*) AS quantidade
FROM clientes
GROUP BY id
HAVING COUNT(*) > 1;

-- E-mail inválido
SELECT *
FROM clientes
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- E-mail nulo
SELECT *
FROM clientes
WHERE email IS NULL;

-- Status inválido em clientes
SELECT *
FROM clientes
WHERE status NOT IN ('Ativo', 'Inativo');

-- Categoria inconsistente em filmes
SELECT *
FROM filmes
WHERE categoria NOT IN ('Categoria 1', 'Categoria 2');

-- Valor negativo ou zerado em filmes
SELECT *
FROM filmes
WHERE valor <= 0;

-- Valor muito acima dos demais em filmes
SELECT *
FROM filmes
WHERE valor = (SELECT MAX(valor) FROM filmes);

-- Quantidade negativa em sessoes
SELECT *
FROM sessoes
WHERE quantidade < 0;

-- Cliente inexistente em sessoes
SELECT t.*
FROM sessoes t
LEFT JOIN clientes e ON t.id_cliente = e.id
WHERE e.id IS NULL;

-- Filme inexistente em sessoes
SELECT t.*
FROM sessoes t
LEFT JOIN filmes i ON t.id_filme = i.id
WHERE i.id IS NULL;

-- Data futura em sessoes
SELECT *
FROM sessoes
WHERE data_registro > CURDATE();

-- Data nula em sessoes
SELECT *
FROM sessoes
WHERE data_registro IS NULL;

-- Status inválido em sessoes
SELECT *
FROM sessoes
WHERE status NOT IN ('Concluido', 'Pendente', 'Cancelado');

-- Valor negativo em ingressos
SELECT *
FROM ingressos
WHERE valor < 0;

-- Sessão inexistente em ingressos
SELECT c.*
FROM ingressos c
LEFT JOIN sessoes t ON c.id_sessoe = t.id
WHERE t.id IS NULL;


-- Nome de coluna inconsistente na tabela ingressos (id_sessoe)
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'ingressos'
  AND COLUMN_NAME LIKE 'id_sess%';

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



-- CONSULTAS PARA LOCALIZAR OS ERROS

-- PK duplicada em clientes
SELECT id, COUNT(*) AS quantidade
FROM clientes
GROUP BY id
HAVING COUNT(*) > 1;

-- E-mail inválido
SELECT *
FROM clientes
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- E-mail nulo
SELECT *
FROM clientes
WHERE email IS NULL;

-- Status inválido em clientes
SELECT *
FROM clientes
WHERE status NOT IN ('Ativo', 'Inativo');

-- Categoria inconsistente em pets
SELECT *
FROM pets
WHERE categoria NOT IN ('Categoria 1', 'Categoria 2');

-- Valor negativo ou zerado em pets
SELECT *
FROM pets
WHERE valor <= 0;

-- Valor muito acima dos demais em pets
SELECT *
FROM pets
WHERE valor = (SELECT MAX(valor) FROM pets);

-- Quantidade negativa em servicos
SELECT *
FROM servicos
WHERE quantidade < 0;

-- Cliente inexistente em servicos
SELECT t.*
FROM servicos t
LEFT JOIN clientes e ON t.id_cliente = e.id
WHERE e.id IS NULL;

-- Pet inexistente em servicos
SELECT t.*
FROM servicos t
LEFT JOIN pets i ON t.id_pet = i.id
WHERE i.id IS NULL;

-- Data futura em servicos
SELECT *
FROM servicos
WHERE data_registro > CURDATE();

-- Data nula em servicos
SELECT *
FROM servicos
WHERE data_registro IS NULL;

-- Status inválido em servicos
SELECT *
FROM servicos
WHERE status NOT IN ('Concluido', 'Pendente', 'Cancelado');

-- Valor negativo em agendamentos
SELECT *
FROM agendamentos
WHERE valor < 0;

-- Serviço inexistente em agendamentos
SELECT c.*
FROM agendamentos c
LEFT JOIN servicos t ON c.id_servico = t.id
WHERE t.id IS NULL;

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



-- CONSULTAS PARA LOCALIZAR OS ERROS

-- PK duplicada em clientes
SELECT id, COUNT(*) AS quantidade
FROM clientes
GROUP BY id
HAVING COUNT(*) > 1;

-- E-mail inválido
SELECT *
FROM clientes
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';

-- E-mail nulo
SELECT *
FROM clientes
WHERE email IS NULL;

-- Status inválido em clientes
SELECT *
FROM clientes
WHERE status NOT IN ('Ativo', 'Inativo');

-- Categoria inconsistente em veiculos
SELECT *
FROM veiculos
WHERE categoria NOT IN ('Categoria 1', 'Categoria 2');

-- Valor negativo ou zerado em veiculos
SELECT *
FROM veiculos
WHERE valor <= 0;

-- Valor muito acima dos demais em veiculos
SELECT *
FROM veiculos
WHERE valor = (SELECT MAX(valor) FROM veiculos);

-- Quantidade negativa em servicos
SELECT *
FROM servicos
WHERE quantidade < 0;

-- Cliente inexistente em servicos
SELECT t.*
FROM servicos t
LEFT JOIN clientes e ON t.id_cliente = e.id
WHERE e.id IS NULL;

-- Veículo inexistente em servicos
SELECT t.*
FROM servicos t
LEFT JOIN veiculos i ON t.id_veiculo = i.id
WHERE i.id IS NULL;

-- Data futura em servicos
SELECT *
FROM servicos
WHERE data_registro > CURDATE();

-- Data nula em servicos
SELECT *
FROM servicos
WHERE data_registro IS NULL;

-- Status inválido em servicos
SELECT *
FROM servicos
WHERE status NOT IN ('Concluido', 'Pendente', 'Cancelado');

-- Valor negativo em ordens
SELECT *
FROM ordens
WHERE valor < 0;

-- Serviço inexistente em ordens
SELECT c.*
FROM ordens c
LEFT JOIN servicos t ON c.id_servico = t.id
WHERE t.id IS NULL;

/*
1. Para que serve o ping?
O ping serve para verificar se existe comunicação entre dois dispositivos em uma rede. Ele envia mensagens ICMP ao destino e verifica se recebe uma resposta.
2. Qual a função do gateway?
O gateway é o dispositivo responsável por encaminhar dados para outras redes. Nesta atividade, o roteador 192.168.10.1 funciona como gateway dos computadores.
3. O que pode causar uma falha de comunicação?
Uma falha pode ser causada por IP incorreto, máscara de rede errada, gateway incorreto, cabos ou portas mal conectados, interfaces desativadas ou dispositivos configurados em redes diferentes.
4. Por que proteger o acesso ao roteador?
Porque o roteador controla a comunicação da rede. Uma pessoa sem autorização poderia alterar configurações, interromper a comunicação ou comprometer a segurança da rede.
