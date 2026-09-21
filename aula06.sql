use clinica;

CREATE TABLE medicos
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    nome          VARCHAR(100),
    especialidade VARCHAR(50),
    crm           VARCHAR(20)
);

-- Inserir os médicos
INSERT INTO medicos (nome, especialidade, crm)
VALUES ('Dr. Carlos', 'Cardiologia', 'CRM-12345'),
       ('Dra. Fernanda', 'Dermatologia', 'CRM-23456'),
       ('Dra. Juliana', 'Pediatria', 'CRM-34567'),
       ('Dr. Ricardo', 'Ortopedia', 'CRM-45678'),
       ('Dra. Mariana', 'Cardiologia', 'CRM-56789');

ALTER TABLE consultas
    ADD COLUMN id_medico INT;

ALTER TABLE consultas
    ADD CONSTRAINT fk_consultas_medicos
        FOREIGN KEY (id_medico)
            REFERENCES medicos (id);

select *
from medicos;
select *
from consultas;
select *
from pacientes;

UPDATE consultas
SET consultas.id_medico = CASE id
                              WHEN 1 THEN 1
                              WHEN 2 THEN 2
                              WHEN 3 THEN 3
                              WHEN 4 THEN 1
                              WHEN 5 THEN 4
                              WHEN 6 THEN 2
                              WHEN 7 THEN 3
                              WHEN 8 THEN 4
                              WHEN 9 THEN 5
                              WHEN 10 THEN 3
    END;

-- quais pacientes realizaram consultas e em qua especialidade
SELECT pacientes.nome,
       consultas.especialidade
FROM pacientes
         INNER JOIN consultas
                    ON pacientes.id = consultas.id_paciente;

-- qual paciente foi atendido por qual medico
SELECT pacientes.nome AS paciente,
       consultas.especialidade,
       medicos.nome   AS medico
FROM pacientes
         INNER JOIN consultas ON pacientes.id = consultas.id_paciente
         INNER JOIN medicos ON consultas.id_medico = medicos.id;

-- LEFT JOIN: quero lista todos os pacientes, mesmo aqueles que nunca fizeram consultas.
SELECT pacientes.nome AS paciente,
       consultas.especialidade,
       medicos.nome   AS medico
FROM pacientes
         LEFT JOIN consultas ON pacientes.id = consultas.id_paciente
         LEFT JOIN medicos ON consultas.id_medico = medicos.id;

-- quantas consultas cada paciente realizou? LEFT JOIN + COUNT
SELECT pacientes.nome,
       COUNT(consultas.id) AS quantidade_consultas
FROM pacientes
         LEFT JOIN consultas ON pacientes.id = consultas.id_paciente
group by pacientes.id, pacientes.nome;

SELECT medicos.nome AS medico,
       COUNT(consultas.id) AS quantidade_consultas
FROM medicos
         LEFT JOIN consultas ON medicos.id = consultas.id_paciente
group by medicos.id, medicos.nome;










