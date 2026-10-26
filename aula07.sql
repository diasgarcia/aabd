create database clinica;

use clinica;

create table paciente
(
    id_paciente int          not null primary key,
    nome        varchar(100) not null,
    cidade      varchar(100) not null
);

create table consulta
(
    id_consulta int  not null primary key,
    data        date not null,
    id_paciente int  not null,
    foreign key (id_paciente) references paciente (id_paciente)
);

insert into paciente (id_paciente, nome, cidade) value
    (1, 'Ana', 'Ourinhos'),
    (2, 'Bruno', 'Chavantes'),
    (3, 'Carla', 'Ourinhos');

insert into consulta (id_consulta, data, id_paciente)
values (101, '2026-10-10', 1),
       (102, '2026-10-12', 2),
       (103, '2026-10-15', 1);

-- ----- //----- //----- //----- //----- //----- //----- //----- //-----

-- 1- Criar uma tabela MEDICO com id_medico como chave primária, nome e especialidade.
create table medico
(
    id_medico     int          not null primary key,
    nome          varchar(100) not null,
    especialidade varchar(100) not null
);

-- 2- Inserir um médico chamado Pedro, especialista em Cardiologia.
insert into medico (id_medico, nome, especialidade)
values ('1', 'Pedro', 'Cardiologia');

-- 3- Consultar todos os médicos da especialidade Cardiologia.
select *
from medico
where especialidade = 'Cardiologia';

-- 4- Ordenar os médicos pelo nome em ordem crescente.
select *
from medico
order by nome asc;

-- 5- Exibir o nome dos pacientes e as datas de suas consultas usando INNER JOIN.
select paciente.nome,
       consulta.data as data_consulta
from paciente
         inner join clinica.consulta on paciente.id_paciente = consulta.id_paciente;

-- 6- Alterar a cidade da paciente Ana para Chavantes.
update paciente
set cidade = 'Cavantes'
where id_paciente = 1;

select * from paciente
where id_paciente = 1;

-- 7- Excluir a consulta de código 102.
delete from consulta
where id_consulta = 102;

select * from consulta;

-- 8- Qual comando cadastra um paciente chamado Diego, de Salto Grande, com ID 4?
insert into paciente (id_paciente, nome, cidade)
values ('4', 'Diego', 'Salto Grande');

select * from paciente;
