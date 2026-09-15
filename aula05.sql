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

SELECT * FROM consultas;

ALTER TABLE consultas
ADD COLUMN id_paciente INT;

ALTER TABLE consultas
ADD CONSTRAINT fk_consultas_pacientes
FOREIGN KEY (id_paciente)
REFERENCES pacientes(id);

UPDATE consultas
SET id_paciente = 1
WHERE  id = 1;

UPDATE consultas
SET id_paciente = 1
WHERE  id = 3;

UPDATE consultas
SET id_paciente = 1
WHERE  id = 6;

UPDATE consultas
SET id_paciente = 2
WHERE  id = 2;

UPDATE consultas
SET id_paciente = 2
WHERE  id = 9;

UPDATE consultas
SET id_paciente = 3
WHERE id = 4 AND 10;

UPDATE consultas
SET id_paciente = 3
WHERE id = 10;

UPDATE consultas
SET id_paciente = 4
WHERE id = 5;

UPDATE consultas
SET id_paciente = 5
WHERE id = 7;

UPDATE consultas
SET id_paciente = 6
WHERE id = 8;

SELECT * FROM consultas;

SELECT *
FROM pacientes INNER JOIN consultas
ON pacientes.id = consultas.id_paciente;

# quero saber apenas quem foi atendido e em que especialidade
SELECT
    pacientes.nome,
    consultas.especialidade
FROM pacientes INNER JOIN consultas
ON pacientes.id = consultas.id_paciente;

# e se a clinica quiser saber de qual cidade é o paciente e qual consulta ele fez

SELECT
    pacientes.nome,
    pacientes.cidade,
    consultas.especialidade
FROM pacientes INNER JOIN consultas
ON pacientes.id = consultas.id_paciente;

# quais pacientes fizeram ocnsulta maior ouigual 250 reais, nome, espcialidade e valor

SELECT
    pacientes.nome,
    consultas.especialidade,
    consultas.valor
FROM pacientes INNER JOIN consultas
ON pacientes.id = consultas.id_paciente
WHERE valor >= 250.00;

select * from consultas;
