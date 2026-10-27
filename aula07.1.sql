CREATE DATABASE BarbeariaUrbana;

USE BarbeariaUrbana;

CREATE TABLE clientes
(
    id_cliente    INT PRIMARY KEY AUTO_INCREMENT,
    nome          VARCHAR(100) NOT NULL,
    cidade        VARCHAR(60),
    data_cadastro DATE
);

CREATE TABLE barbeiros
(
    id_barbeiro   INT PRIMARY KEY AUTO_INCREMENT,
    nome          VARCHAR(100) NOT NULL,
    especialidade VARCHAR(80),
    salario       DECIMAL(10, 2)
);

CREATE TABLE servicos
(
    id_servico      INT PRIMARY KEY AUTO_INCREMENT,
    nome            VARCHAR(100)   NOT NULL,
    preco           DECIMAL(10, 2) NOT NULL,
    duracao_minutos INT
);

CREATE TABLE agendamentos
(
    id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente     INT         NOT NULL,
    id_barbeiro    INT         NOT NULL,
    id_servico     INT         NOT NULL,
    data_hora      DATETIME    NOT NULL,
    status         VARCHAR(20) NOT NULL,
    valor_pago     DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_barbeiro) REFERENCES barbeiros (id_barbeiro),
    FOREIGN KEY (id_servico) REFERENCES servicos (id_servico)
);


INSERT INTO clientes (nome, cidade, data_cadastro)
VALUES ('Lucas Mendes', 'Ourinhos', '2026-01-10'),
       ('Rafael Souza', 'Chavantes', '2026-01-15'),
       ('Pedro Henrique', 'Ourinhos', '2026-02-02'),
       ('Gabriel Lima', 'Salto Grande', '2026-02-18'),
       ('Matheus Costa', 'Ourinhos', '2026-03-05'),
       ('Bruno Alves', 'Chavantes', '2026-03-12'),
       ('Felipe Rocha', 'Salto Grande', '2026-04-01'),
       ('Thiago Martins', 'Ourinhos', '2026-04-20');

INSERT INTO barbeiros (nome, especialidade, salario)
VALUES ('André Silva', 'Corte degradê', 2800.00),
       ('Marcos Oliveira', 'Barba', 2500.00),
       ('Diego Santos', 'Cortes clássicos', 2600.00),
       ('João Pedro', 'Cortes modernos', 3000.00);

INSERT INTO servicos (nome, preco, duracao_minutos)
VALUES ('Corte masculino', 45.00, 40),
       ('Barba completa', 30.00, 25),
       ('Corte + barba', 65.00, 60),
       ('Sobrancelha', 15.00, 10),
       ('Pigmentação capilar', 80.00, 50),
       ('Platinado', 150.00, 120);

INSERT INTO agendamentos
    (id_cliente, id_barbeiro, id_servico, data_hora, status, valor_pago)
VALUES (1, 1, 1, '2026-05-02 09:00:00', 'Concluido', 45.00),
       (2, 2, 2, '2026-05-02 10:00:00', 'Concluido', 30.00),
       (3, 1, 3, '2026-05-03 14:00:00', 'Concluido', 65.00),
       (4, 3, 1, '2026-05-04 15:00:00', 'Cancelado', 0.00),
       (5, 4, 6, '2026-05-05 13:00:00', 'Concluido', 150.00),
       (1, 2, 3, '2026-05-10 10:00:00', 'Concluido', 65.00),
       (6, 3, 4, '2026-05-11 11:00:00', 'Concluido', 15.00),
       (7, 4, 5, '2026-05-12 16:00:00', 'Concluido', 80.00),
       (3, 1, 1, '2026-05-15 09:00:00', 'Concluido', 45.00),
       (8, 2, 2, '2026-05-16 14:00:00', 'Faltou', 0.00),
       (2, 4, 3, '2026-05-18 10:00:00', 'Concluido', 65.00),
       (5, 1, 5, '2026-05-20 15:00:00', 'Concluido', 80.00),
       (6, 2, 1, '2026-05-22 09:00:00', 'Concluido', 45.00),
       (7, 3, 2, '2026-05-25 11:00:00', 'Cancelado', 0.00),
       (8, 4, 1, '2026-05-28 14:00:00', 'Concluido', 45.00);


-- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----

select nome, cidade
from clientes;

select nome, preco
from servicos
where preco > 50;

select id_cliente, id_barbeiro, valor_pago
from agendamentos
where status = 'Concluido';

select s.nome, s.preco
from servicos s
where s.preco > 50;

-- nome cliente e data agendamento
select c.nome, a.data_hora
from clientes c
         inner join agendamentos a
                    on c.id_cliente = a.id_cliente;

-- cliente, barbeiro e servico de cada atendimento
select c.nome       nome_cliente,
       b.nome       nome_barbeiro,
       s.nome       servico,
       a.valor_pago valor
from agendamentos a
         inner join clientes c on a.id_cliente = c.id_cliente
         inner join barbeiros b on a.id_barbeiro = b.id_barbeiro
         inner join servicos s on a.id_servico = s.id_servico
where a.status = 'Concluido';

-- preco medio dos servicos
select avg(s.preco) preco_medio
from servicos s;

-- faturamento de cada barbeiro
select b.nome,
       sum(a.valor_pago)
from agendamentos a
         inner join barbeiros b on a.id_barbeiro = b.id_barbeiro
where a.status = 'Concluido'
group by b.id_barbeiro, b.nome;

-- mostrar os servicos acima dopreco medio -- subqueries
select s.nome, s.preco
from servicos s
where s.preco > (select avg(preco) from servicos);

-- barbeiros que resebem acima do salario medio
select b.nome, b.salario
from barbeiros b
where b.salario > (select avg(salario) from barbeiros);

-- clientes que fizeram agendamentos
select c.nome
from clientes c
         inner join agendamentos a on c.id_cliente = a.id_cliente
where a.id_cliente in (select a.id_cliente from agendamentos a)
group by c.nome, c.id_cliente;
