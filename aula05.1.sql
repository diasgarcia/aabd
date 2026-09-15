USE clinica;

-- Quais pacientes de Ourinhos fizeram consultas?
SELECT DISTINCT nome
FROM pacientes
INNER JOIN consultas
	ON pacientes.id = consultas.id_paciente
WHERE cidade LIKE 'Ourinhos';

-- Quais pacientes fizeram consultas com duração superior a 40 minutos?
SELECT DISTINCT 
	nome,
    duracao
FROM pacientes
INNER JOIN consultas
	ON pacientes.id = consultas.id_paciente
WHERE duracao > 40;

-- Quais convênios estão associados às consultas de Cardiologia?
SELECT DISTINCT 
	convenio,
    especialidade
FROM consultas
INNER JOIN pacientes
	ON pacientes.id = consultas.id_paciente
WHERE especialidade LIKE 'Cardiologia';

-- Qual foi o valor das consultas realizadas por pacientes de Chavantes?
SELECT *
FROM pacientes
INNER JOIN consultas
	ON consultas.id_paciente = pacientes.id
WHERE cidade = 'Chavantes';

-- Quais especialidades tiveram consultas com avaliação maior que 9.0?
SELECT 
	especialidade,
	avaliacao
FROM consultas
INNER JOIN pacientes
	ON consultas.id_paciente = pacientes.id
WHERE avaliacao > 9.0;

-- Liste as consultas da maior avaliação para a menor.
SELECT *
FROM consultas
INNER JOIN pacientes
	ON consultas.id_paciente = pacientes.id
ORDER BY avaliacao DESC;

-- Se eu quiser saber apenas quais pacientes já fizeram consulta, sem repetir o nome, como faço?
SELECT nome
FROM pacientes
INNER JOIN consultas
    ON consultas.id_paciente = pacientes.id
GROUP BY pacientes.id, pacientes.nome;

-- Qual o valor total gasto por cada paciente?
SELECT
    nome,
    SUM(consultas.valor) AS total_gasto
FROM pacientes
INNER JOIN consultas
    ON consultas.id_paciente = pacientes.id
GROUP BY pacientes.id, pacientes.nome;

-- Qual o valor médio das consultas?
SELECT AVG(valor) AS valor_medio
FROM consultas;

-- Quantas consultas cada paciente realizou?
SELECT
    pacientes.nome,
    COUNT(consultas.id) AS qnt_de_consultas
FROM pacientes
LEFT JOIN consultas
    ON pacientes.id = consultas.id_paciente
GROUP BY pacientes.id, pacientes.nome;
