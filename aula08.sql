CREATE DATABASE cafeteria;
USE cafeteria;

CREATE TABLE clientes
(
    id_cliente INT PRIMARY KEY,
    nome       VARCHAR(100),
    cidade     VARCHAR(60)
);

CREATE TABLE produtos
(
    id_produto INT PRIMARY KEY,
    nome       VARCHAR(100),
    categoria  VARCHAR(50),
    preco      DECIMAL(10, 2),
    estoque    INT
);

CREATE TABLE pedidos
(
    id_pedido   INT PRIMARY KEY,
    id_cliente  INT,
    data_pedido DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente)
        REFERENCES clientes (id_cliente)
);

CREATE TABLE itens_pedido
(
    id_item        INT PRIMARY KEY,
    id_pedido      INT,
    id_produto     INT,
    quantidade     INT,
    preco_unitario DECIMAL(10, 2),
    FOREIGN KEY (id_pedido)
        REFERENCES pedidos (id_pedido),
    FOREIGN KEY (id_produto)
        REFERENCES produtos (id_produto)
);

INSERT INTO clientes
VALUES (1, 'Ana', 'Ourinhos'),
       (2, 'Bruno', 'Chavantes'),
       (3, 'Carla', 'Ourinhos'),
       (4, 'Diego', 'Salto Grande');

INSERT INTO produtos
VALUES (11, 'Café Expresso', 'Bebidas', 8.00, 30),
       (12, 'Cappuccino', 'Bebidas', 14.00, 20),
       (13, 'Pão de Queijo', 'Salgados', 7.00, 40),
       (14, 'Croissant', 'Salgados', 12.00, 15),
       (15, 'Brownie', 'Doces', 10.00, 25);

INSERT INTO pedidos
VALUES (101, 1, '2026-10-01', 22.00),
       (102, 1, '2026-10-03', 14.00),
       (103, 2, '2026-10-04', 19.00),
       (104, 3, '2026-10-05', 24.00);

INSERT INTO itens_pedido
VALUES (1, 101, 11, 1, 8.00),
       (2, 101, 13, 2, 7.00),
       (3, 102, 12, 1, 14.00),
       (4, 103, 11, 1, 8.00),
       (5, 103, 15, 1, 10.00),
       (6, 104, 14, 2, 12.00);

-- VIEWS - criando consultas que podem ser reutilizadas

create view vw_clientes_pedidos as
select c.nome as nome_cliente,
       p.id_pedido,
       p.data_pedido,
       p.valor_total
from clientes c
         inner join pedidos p
                    on c.id_cliente = p.id_cliente;

select *
from vw_clientes_pedidos;

select *
from vw_clientes_pedidos
where nome_cliente = 'Ana';

create or replace view vw_clientes_pedidos as
select c.nome as cliente,
       p.id_pedido,
       p.data_pedido,
       p.valor_total
from clientes c
         inner join pedidos p
                    on c.id_cliente = p.id_cliente
where p.valor_total > 15;

select *
from vw_clientes_pedidos;

drop view vw_clientes_pedidos;


-- Stored Procedure - criar rotinas

delimiter //
create procedure listar_produtos()
begin
    select * from produtos;
end //
delimiter ;

call listar_produtos();

delimiter //
create procedure
    consultar_categoria(
    in p_categoria varchar(50)
)
begin
    select * from produtos where categoria = p_categoria;
end //
delimiter ;

call consultar_categoria('Doces');
















