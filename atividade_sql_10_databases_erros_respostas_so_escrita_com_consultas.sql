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
(2,'Bruno Lima','bruno@email.com',35,'14999990002'),
(3,'Carla Mendes','carla@email.com',30,'14999990003'),
(4,'Diego Alves','diego@email.com',42,'14999990004');

INSERT INTO medicos VALUES
(1,'Dra. Paula','Cardiologia',15000),
(2,'Dr. Marcos','Ortopedia',8000),
(3,'Dra. Renata','Pediatria',12000),
(4,'Dr. João','Cardiologia',12000);

INSERT INTO consultas VALUES
(1,1,1,'2026-09-01',300,'Realizada'),
(2,2,2,'2026-09-02',150,'Realizada'),
(3,3,3,'2026-09-03',500,'Confirmada'),
(4,1,1,'2026-09-04',300,'Pendente');

INSERT INTO avaliacoes VALUES
(1,1,5.0,'Ótimo atendimento'),
(2,2,5.0,'Nota corrigida'),
(3,3,4.0,'Consulta corrigida');

-- O QUE ESTAVA ERRADO:
-- pacientes: telefone com formato inconsistente, e-mail inválido, idade negativa,
-- telefone NULL e registro duplicado com a mesma chave primária.
-- medicos: salário negativo.
-- consultas: valor negativo, médico inexistente, data inconsistente, data NULL e status inválido.
-- avaliacoes: nota acima de 5 e referência para consulta inexistente.

-- SELECTS PARA CONFERIR:
SELECT * FROM pacientes;
SELECT * FROM medicos;
SELECT * FROM consultas;
SELECT * FROM avaliacoes;

-- Os SELECTs abaixo devem retornar 0 registros:
SELECT * FROM pacientes
WHERE idade < 0 OR email IS NULL OR email NOT LIKE '%@%.%' OR telefone IS NULL;

SELECT nome, email, COUNT(*) AS quantidade
FROM pacientes
GROUP BY nome, email
HAVING COUNT(*) > 1;

SELECT * FROM medicos WHERE salario < 0;

SELECT c.*
FROM consultas c
LEFT JOIN pacientes p ON p.id = c.id_paciente
LEFT JOIN medicos m ON m.id = c.id_medico
WHERE p.id IS NULL OR m.id IS NULL OR c.valor < 0 OR c.data_consulta IS NULL
   OR c.status NOT IN ('Realizada','Confirmada','Pendente','Cancelada');

SELECT a.*
FROM avaliacoes a
LEFT JOIN consultas c ON c.id = a.id_consulta
WHERE c.id IS NULL OR a.nota < 0 OR a.nota > 5;

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
(3,'Carla',17,'carla@email.com'),(4,'Daniel',18,'daniel@email.com');

INSERT INTO professores VALUES
(1,'Prof. Ana','Matemática',5000),(2,'Prof. Bia','História',3000),
(3,'Prof. Carlos','Física',4500);

INSERT INTO turmas VALUES
(1,1,'3A',2026),(2,2,'3B',2026),(3,3,'3C',2026),(4,1,'3A',2026);

INSERT INTO notas VALUES
(1,1,1,8.5),(2,2,2,0),(3,3,3,10),(4,4,1,7);

-- O QUE ESTAVA ERRADO:
-- alunos: idade negativa, e-mail inválido, e-mail NULL e registro duplicado.
-- professores: salário negativo.
-- turmas: professor inexistente e ano inconsistente.
-- notas: nota negativa, nota acima de 10, turma inexistente e aluno inexistente.

-- SELECTS PARA CONFERIR:
SELECT * FROM alunos;
SELECT * FROM professores;
SELECT * FROM turmas;
SELECT * FROM notas;

-- Os SELECTs abaixo devem retornar 0 registros:
SELECT * FROM alunos
WHERE idade < 0 OR email IS NULL OR email NOT LIKE '%@%.%';

SELECT nome, email, COUNT(*) AS quantidade
FROM alunos
GROUP BY nome, email
HAVING COUNT(*) > 1;

SELECT * FROM professores WHERE salario < 0;

SELECT t.*
FROM turmas t
LEFT JOIN professores p ON p.id = t.id_professor
WHERE p.id IS NULL OR t.ano <> 2026;

SELECT n.*
FROM notas n
LEFT JOIN alunos a ON a.id = n.id_aluno
LEFT JOIN turmas t ON t.id = n.id_turma
WHERE a.id IS NULL OR t.id IS NULL OR n.nota < 0 OR n.nota > 10;

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
(3,'Carla','carla@email.com'),(4,'Diego','diego@email.com');

INSERT INTO livros VALUES
(1,'SQL para Iniciantes',2024,10,1),(2,'Banco de Dados',2025,3,2),
(3,'Algoritmos',2023,5,1),(4,'Redes',2022,0,2);

INSERT INTO emprestimos VALUES
(1,1,1,'2026-09-01','2026-09-10'),(2,2,2,'2026-09-02','2026-09-12'),
(3,3,3,'2026-09-03',NULL),(4,1,4,'2026-09-04',NULL);

INSERT INTO autores VALUES (1,'Machado de Assis'),(2,'Clarice Lispector');

-- O QUE ESTAVA ERRADO:
-- leitores: e-mail inválido, e-mail NULL e registro duplicado.
-- livros: ano futuro, quantidade negativa, ano NULL e autor inexistente.
-- emprestimos: devolução anterior ao empréstimo, leitor inexistente e livro inexistente.
-- autores: registro duplicado com a mesma chave primária.

-- SELECTS PARA CONFERIR:
SELECT * FROM leitores;
SELECT * FROM livros;
SELECT * FROM emprestimos;
SELECT * FROM autores;

-- Os SELECTs abaixo devem retornar 0 registros:
SELECT * FROM leitores
WHERE email IS NULL OR email NOT LIKE '%@%.%';

SELECT nome, email, COUNT(*) AS quantidade
FROM leitores
GROUP BY nome, email
HAVING COUNT(*) > 1;

SELECT l.*
FROM livros l
LEFT JOIN autores a ON a.id = l.id_autor
WHERE l.ano IS NULL OR l.ano > 2026 OR l.quantidade < 0 OR a.id IS NULL;

SELECT e.*
FROM emprestimos e
LEFT JOIN leitores l ON l.id = e.id_leitor
LEFT JOIN livros li ON li.id = e.id_livro
WHERE l.id IS NULL OR li.id IS NULL
   OR (e.data_devolucao IS NOT NULL AND e.data_devolucao < e.data_emprestimo);

SELECT nome, COUNT(*) AS quantidade
FROM autores
GROUP BY nome
HAVING COUNT(*) > 1;

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
(3,'Carla Souza','carla@email.com','Ativo'),
(4,'Diego Alves','diego@email.com','Ativo');

INSERT INTO produtos VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',50),
(3,'Item C','Categoria 3',75),
(4,'Item D','Categoria 1',200);

INSERT INTO pedidos VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',3,'Concluido'),
(3,3,3,'2026-09-03',1,'Pendente'),
(4,3,4,'2026-09-04',5,'Pendente');

INSERT INTO itens_pedido VALUES
(1,1,100,'OK'),(2,2,20,'Valor corrigido'),(3,3,50,'Registro corrigido');

-- O QUE ESTAVA ERRADO:
-- clientes: e-mail inválido/nulo, status inválido e registro duplicado.
-- produtos: valor negativo, categoria inválida, valor zerado e valor muito fora do padrão.
-- pedidos: quantidade negativa, referências inexistentes, data futura, data NULL e status inválido.
-- itens_pedido: valor negativo e referência inexistente.

-- SELECTS PARA CONFERIR:
SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;
SELECT * FROM itens_pedido;

-- Os SELECTs abaixo devem retornar 0 registros:
SELECT * FROM clientes
WHERE email IS NULL OR email NOT LIKE '%@%.%' OR status NOT IN ('Ativo','Inativo');

SELECT nome, email, COUNT(*) AS quantidade
FROM clientes
GROUP BY nome, email
HAVING COUNT(*) > 1;

SELECT * FROM produtos
WHERE valor <= 0 OR valor > 10000
   OR categoria NOT IN ('Categoria 1','Categoria 2','Categoria 3');

SELECT r.*
FROM pedidos r
LEFT JOIN clientes e ON e.id = r.id_cliente
LEFT JOIN produtos m ON m.id = r.id_produto
WHERE e.id IS NULL OR m.id IS NULL OR r.quantidade <= 0
   OR r.data_registro IS NULL OR r.data_registro > '2026-09-30'
   OR r.status NOT IN ('Concluido','Pendente','Cancelado');

SELECT c.*
FROM itens_pedido c
LEFT JOIN pedidos r ON r.id = c.id_pedido
WHERE r.id IS NULL OR c.valor < 0;

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
(3,'Carla Souza','carla@email.com','Ativo'),
(4,'Diego Alves','diego@email.com','Ativo');

INSERT INTO quartos VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',50),
(3,'Item C','Categoria 3',75),
(4,'Item D','Categoria 1',200);

INSERT INTO reservas VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',3,'Concluido'),
(3,3,3,'2026-09-03',1,'Pendente'),
(4,3,4,'2026-09-04',5,'Pendente');

INSERT INTO pagamentos VALUES
(1,1,100,'OK'),(2,2,20,'Valor corrigido'),(3,3,50,'Registro corrigido');

-- O QUE ESTAVA ERRADO:
-- hóspedes: e-mail inválido/nulo, status inválido e registro duplicado.
-- quartos: valor negativo, categoria inválida, valor zerado e valor muito fora do padrão.
-- reservas: quantidade negativa, referências inexistentes, data futura, data NULL e status inválido.
-- pagamentos: valor negativo e referência inexistente.

-- SELECTS PARA CONFERIR:
SELECT * FROM hospedes;
SELECT * FROM quartos;
SELECT * FROM reservas;
SELECT * FROM pagamentos;

-- Os SELECTs abaixo devem retornar 0 registros:
SELECT * FROM hospedes
WHERE email IS NULL OR email NOT LIKE '%@%.%' OR status NOT IN ('Ativo','Inativo');

SELECT nome, email, COUNT(*) AS quantidade
FROM hospedes
GROUP BY nome, email
HAVING COUNT(*) > 1;

SELECT * FROM quartos
WHERE valor <= 0 OR valor > 10000
   OR categoria NOT IN ('Categoria 1','Categoria 2','Categoria 3');

SELECT r.*
FROM reservas r
LEFT JOIN hospedes e ON e.id = r.id_hospede
LEFT JOIN quartos m ON m.id = r.id_quarto
WHERE e.id IS NULL OR m.id IS NULL OR r.quantidade <= 0
   OR r.data_registro IS NULL OR r.data_registro > '2026-09-30'
   OR r.status NOT IN ('Concluido','Pendente','Cancelado');

SELECT c.*
FROM pagamentos c
LEFT JOIN reservas r ON r.id = c.id_reserva
WHERE r.id IS NULL OR c.valor < 0;

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
(3,'Carla Souza','carla@email.com','Ativo'),
(4,'Diego Alves','diego@email.com','Ativo');

INSERT INTO planos VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',50),
(3,'Item C','Categoria 3',75),
(4,'Item D','Categoria 1',200);

INSERT INTO matriculas VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',3,'Concluido'),
(3,3,3,'2026-09-03',1,'Pendente'),
(4,3,4,'2026-09-04',5,'Pendente');

INSERT INTO treinos VALUES
(1,1,100,'OK'),(2,2,20,'Valor corrigido'),(3,3,50,'Registro corrigido');

-- O QUE ESTAVA ERRADO:
-- alunos: e-mail inválido/nulo, status inválido e registro duplicado.
-- planos: valor negativo, categoria inválida, valor zerado e valor muito fora do padrão.
-- matrículas: quantidade negativa, referências inexistentes, data futura, data NULL e status inválido.
-- treinos: valor negativo e referência inexistente.

-- SELECTS PARA CONFERIR:
SELECT * FROM alunos;
SELECT * FROM planos;
SELECT * FROM matriculas;
SELECT * FROM treinos;

-- Os SELECTs abaixo devem retornar 0 registros:
SELECT * FROM alunos
WHERE email IS NULL OR email NOT LIKE '%@%.%' OR status NOT IN ('Ativo','Inativo');

SELECT nome, email, COUNT(*) AS quantidade
FROM alunos
GROUP BY nome, email
HAVING COUNT(*) > 1;

SELECT * FROM planos
WHERE valor <= 0 OR valor > 10000
   OR categoria NOT IN ('Categoria 1','Categoria 2','Categoria 3');

SELECT r.*
FROM matriculas r
LEFT JOIN alunos e ON e.id = r.id_aluno
LEFT JOIN planos m ON m.id = r.id_plano
WHERE e.id IS NULL OR m.id IS NULL OR r.quantidade <= 0
   OR r.data_registro IS NULL OR r.data_registro > '2026-09-30'
   OR r.status NOT IN ('Concluido','Pendente','Cancelado');

SELECT c.*
FROM treinos c
LEFT JOIN matriculas r ON r.id = c.id_matricula
WHERE r.id IS NULL OR c.valor < 0;

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
(3,'Carla Souza','carla@email.com','Ativo'),
(4,'Diego Alves','diego@email.com','Ativo');

INSERT INTO mesas VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',50),
(3,'Item C','Categoria 3',75),
(4,'Item D','Categoria 1',200);

INSERT INTO reservas VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',3,'Concluido'),
(3,3,3,'2026-09-03',1,'Pendente'),
(4,3,4,'2026-09-04',5,'Pendente');

INSERT INTO pedidos VALUES
(1,1,100,'OK'),(2,2,20,'Valor corrigido'),(3,3,50,'Registro corrigido');

-- O QUE ESTAVA ERRADO:
-- clientes: e-mail inválido/nulo, status inválido e registro duplicado.
-- mesas: valor negativo, categoria inválida, valor zerado e valor muito fora do padrão.
-- reservas: quantidade negativa, referências inexistentes, data futura, data NULL e status inválido.
-- pedidos: valor negativo e referência inexistente.

-- SELECTS PARA CONFERIR:
SELECT * FROM clientes;
SELECT * FROM mesas;
SELECT * FROM reservas;
SELECT * FROM pedidos;

-- Os SELECTs abaixo devem retornar 0 registros:
SELECT * FROM clientes
WHERE email IS NULL OR email NOT LIKE '%@%.%' OR status NOT IN ('Ativo','Inativo');

SELECT nome, email, COUNT(*) AS quantidade
FROM clientes
GROUP BY nome, email
HAVING COUNT(*) > 1;

SELECT * FROM mesas
WHERE valor <= 0 OR valor > 10000
   OR categoria NOT IN ('Categoria 1','Categoria 2','Categoria 3');

SELECT r.*
FROM reservas r
LEFT JOIN clientes e ON e.id = r.id_cliente
LEFT JOIN mesas m ON m.id = r.id_mesa
WHERE e.id IS NULL OR m.id IS NULL OR r.quantidade <= 0
   OR r.data_registro IS NULL OR r.data_registro > '2026-09-30'
   OR r.status NOT IN ('Concluido','Pendente','Cancelado');

SELECT c.*
FROM pedidos c
LEFT JOIN reservas r ON r.id = c.id_reserva
WHERE r.id IS NULL OR c.valor < 0;

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
(3,'Carla Souza','carla@email.com','Ativo'),
(4,'Diego Alves','diego@email.com','Ativo');

INSERT INTO filmes VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',50),
(3,'Item C','Categoria 3',75),
(4,'Item D','Categoria 1',200);

INSERT INTO sessoes VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',3,'Concluido'),
(3,3,3,'2026-09-03',1,'Pendente'),
(4,3,4,'2026-09-04',5,'Pendente');

INSERT INTO ingressos VALUES
(1,1,100,'OK'),(2,2,20,'Valor corrigido'),(3,3,50,'Registro corrigido');

-- O QUE ESTAVA ERRADO:
-- clientes: e-mail inválido/nulo, status inválido e registro duplicado.
-- filmes: valor negativo, categoria inválida, valor zerado e valor muito fora do padrão.
-- sessões: quantidade negativa, referências inexistentes, data futura, data NULL e status inválido.
-- ingressos: valor negativo e referência inexistente.

-- SELECTS PARA CONFERIR:
SELECT * FROM clientes;
SELECT * FROM filmes;
SELECT * FROM sessoes;
SELECT * FROM ingressos;

-- Os SELECTs abaixo devem retornar 0 registros:
SELECT * FROM clientes
WHERE email IS NULL OR email NOT LIKE '%@%.%' OR status NOT IN ('Ativo','Inativo');

SELECT nome, email, COUNT(*) AS quantidade
FROM clientes
GROUP BY nome, email
HAVING COUNT(*) > 1;

SELECT * FROM filmes
WHERE valor <= 0 OR valor > 10000
   OR categoria NOT IN ('Categoria 1','Categoria 2','Categoria 3');

SELECT r.*
FROM sessoes r
LEFT JOIN clientes e ON e.id = r.id_cliente
LEFT JOIN filmes m ON m.id = r.id_filme
WHERE e.id IS NULL OR m.id IS NULL OR r.quantidade <= 0
   OR r.data_registro IS NULL OR r.data_registro > '2026-09-30'
   OR r.status NOT IN ('Concluido','Pendente','Cancelado');

SELECT c.*
FROM ingressos c
LEFT JOIN sessoes r ON r.id = c.id_sessoe
WHERE r.id IS NULL OR c.valor < 0;

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
(3,'Carla Souza','carla@email.com','Ativo'),
(4,'Diego Alves','diego@email.com','Ativo');

INSERT INTO pets VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',50),
(3,'Item C','Categoria 3',75),
(4,'Item D','Categoria 1',200);

INSERT INTO servicos VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',3,'Concluido'),
(3,3,3,'2026-09-03',1,'Pendente'),
(4,3,4,'2026-09-04',5,'Pendente');

INSERT INTO agendamentos VALUES
(1,1,100,'OK'),(2,2,20,'Valor corrigido'),(3,3,50,'Registro corrigido');

-- O QUE ESTAVA ERRADO:
-- clientes: e-mail inválido/nulo, status inválido e registro duplicado.
-- pets: valor negativo, categoria inválida, valor zerado e valor muito fora do padrão.
-- serviços: quantidade negativa, referências inexistentes, data futura, data NULL e status inválido.
-- agendamentos: valor negativo e referência inexistente.

-- SELECTS PARA CONFERIR:
SELECT * FROM clientes;
SELECT * FROM pets;
SELECT * FROM servicos;
SELECT * FROM agendamentos;

-- Os SELECTs abaixo devem retornar 0 registros:
SELECT * FROM clientes
WHERE email IS NULL OR email NOT LIKE '%@%.%' OR status NOT IN ('Ativo','Inativo');

SELECT nome, email, COUNT(*) AS quantidade
FROM clientes
GROUP BY nome, email
HAVING COUNT(*) > 1;

SELECT * FROM pets
WHERE valor <= 0 OR valor > 10000
   OR categoria NOT IN ('Categoria 1','Categoria 2','Categoria 3');

SELECT r.*
FROM servicos r
LEFT JOIN clientes e ON e.id = r.id_cliente
LEFT JOIN pets m ON m.id = r.id_pet
WHERE e.id IS NULL OR m.id IS NULL OR r.quantidade <= 0
   OR r.data_registro IS NULL OR r.data_registro > '2026-09-30'
   OR r.status NOT IN ('Concluido','Pendente','Cancelado');

SELECT c.*
FROM agendamentos c
LEFT JOIN servicos r ON r.id = c.id_servico
WHERE r.id IS NULL OR c.valor < 0;

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
(3,'Carla Souza','carla@email.com','Ativo'),
(4,'Diego Alves','diego@email.com','Ativo');

INSERT INTO veiculos VALUES
(1,'Item A','Categoria 1',100),
(2,'Item B','Categoria 2',50),
(3,'Item C','Categoria 3',75),
(4,'Item D','Categoria 1',200);

INSERT INTO servicos VALUES
(1,1,1,'2026-09-01',2,'Concluido'),
(2,2,2,'2026-09-02',3,'Concluido'),
(3,3,3,'2026-09-03',1,'Pendente'),
(4,3,4,'2026-09-04',5,'Pendente');

INSERT INTO ordens VALUES
(1,1,100,'OK'),(2,2,20,'Valor corrigido'),(3,3,50,'Registro corrigido');

-- O QUE ESTAVA ERRADO:
-- clientes: e-mail inválido/nulo, status inválido e registro duplicado.
-- veículos: valor negativo, categoria inválida, valor zerado e valor muito fora do padrão.
-- serviços: quantidade negativa, referências inexistentes, data futura, data NULL e status inválido.
-- ordens: valor negativo e referência inexistente.

-- SELECTS PARA CONFERIR:
SELECT * FROM clientes;
SELECT * FROM veiculos;
SELECT * FROM servicos;
SELECT * FROM ordens;

-- Os SELECTs abaixo devem retornar 0 registros:
SELECT * FROM clientes
WHERE email IS NULL OR email NOT LIKE '%@%.%' OR status NOT IN ('Ativo','Inativo');

SELECT nome, email, COUNT(*) AS quantidade
FROM clientes
GROUP BY nome, email
HAVING COUNT(*) > 1;

SELECT * FROM veiculos
WHERE valor <= 0 OR valor > 10000
   OR categoria NOT IN ('Categoria 1','Categoria 2','Categoria 3');

SELECT r.*
FROM servicos r
LEFT JOIN clientes e ON e.id = r.id_cliente
LEFT JOIN veiculos m ON m.id = r.id_veiculo
WHERE e.id IS NULL OR m.id IS NULL OR r.quantidade <= 0
   OR r.data_registro IS NULL OR r.data_registro > '2026-09-30'
   OR r.status NOT IN ('Concluido','Pendente','Cancelado');

SELECT c.*
FROM ordens c
LEFT JOIN servicos r ON r.id = c.id_servico
WHERE r.id IS NULL OR c.valor < 0;

