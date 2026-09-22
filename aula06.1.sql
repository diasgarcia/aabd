INSERT INTO consultas (especialidade, valor, duracao, avaliacao, id_paciente) VALUE (
                                                                                     'Ortopedia', 300.00, 45, 5.5, NULL
    );

SELECT pacientes.nome,
       consultas.especialidade
FROM pacientes
         LEFT JOIN consultas
                   ON pacientes.id = consultas.id_paciente;

SELECT pacientes.nome AS paciente,
       medicos.nome   AS medico
FROM pacientes
         CROSS JOIN medicos;

SELECT pacientes.id AS paciente,
       consultas.id AS medico
FROM pacientes
         CROSS JOIN consultas;

-- selects
SELECT *
FROM consultas;
SELECT *
FROM pacientes;
SELECT *
FROM medicos;

-- 1. Liste os pacientes em ordem alfabética e mostre, quando houver, suas consultas e seus médicos.
SELECT *
FROM consultas
         INNER JOIN pacientes ON pacientes.id = consultas.id_paciente
         INNER JOIN medicos ON medicos.id = consultas.id_medico
ORDER BY pacientes.nome ASC;

-- 2. Qual foi a avaliação média recebida por cada médico?
SELECT medicos.nome,
       AVG(consultas.avaliacao) AS avaliacao_media
FROM medicos
         LEFT JOIN consultas ON consultas.id_medico = medicos.id
GROUP BY medicos.id, medicos.nome;

-- 3. Liste os pacientes cujo gasto total com consultas foi superior a R$ 500.
SELECT pacientes.nome,
       SUM(consultas.valor) AS gasto_total
FROM consultas
         INNER JOIN pacientes ON consultas.id_paciente = pacientes.id
GROUP BY pacientes.id, pacientes.nome
HAVING SUM(consultas.valor) > 500.00;

-- 4. Mostre a cidade e a quantidade de consultas realizadas por pacientes daquela cidade.
SELECT pacientes.cidade,
       COUNT(consultas.id) AS qtd_consultas
from consultas
         INNER JOIN pacientes ON consultas.id_paciente = pacientes.id
group by pacientes.cidade;

-- 5. Liste todas as consultas ordenadas da maior avaliação para a menor.
SELECT consultas.id,
       consultas.avaliacao
FROM consultas
ORDER BY avaliacao DESC;

-- 6. Encontre os pacientes que realizaram consultas com dois ou mais médicos diferentes.
SELECT pacientes.nome,
       COUNT(DISTINCT consultas.id_medico) AS qtd_medicos
FROM consultas
         INNER JOIN pacientes ON consultas.id_paciente = pacientes.id
GROUP BY pacientes.id, pacientes.nome
HAVING COUNT(DISTINCT consultas.id_medico) >= 2;

-- 7. Liste todos os pacientes que não possuem nenhuma consulta cadastrada.
SELECT pacientes.nome
FROM pacientes
         LEFT JOIN consultas ON pacientes.id = consultas.id_paciente
WHERE consultas.id IS NULL;

-- 8. Descubra qual paciente possui o maior valor total gasto em consultas.
SELECT pacientes.nome,
       SUM(consultas.valor) AS gasto_total
FROM consultas
         INNER JOIN pacientes ON consultas.id_paciente = pacientes.id
GROUP BY pacientes.id, pacientes.nome
ORDER BY gasto_total DESC
LIMIT 1;
