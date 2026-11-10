use cafeteria;

-- 1.Crie uma procedure chamada listar_clientes que apresente todos os clientes.
-- Execute a procedure.
delimiter //
    create procedure listar_clientes()
    begin
        select * from clientes;
    end //
delimiter ;

call listar_clientes();

-- 2.Crie uma procedure chamada buscar_produto que receba o código de um produto
-- por parâmetro e apresente seus dados.
-- Execute a procedure buscando o produto de código 11.

delimiter //
    create procedure buscar_produto(
        in p_id int
    )
    begin
        select * from produtos where id_produto = p_id;
    end //
delimiter ;

call buscar_produto(11);

-- 3.Atualize o estoque do produto 12, acrescentando 5 unidades.
-- Consulte a tabela de histórico.
start transaction;
update produtos
set estoque = estoque + 12
where id_produto = 12;
commit;

select * from historico_estoque;

-- 4.O funcionário precisa corrigir o estoque de alguns produtos.
-- a. Inicie uma transação.
-- b. Acrescente 5 unidades ao produto 11.
-- c. Diminua 3 unidades do produto 12.
-- d. Confirme as alterações com COMMIT.
-- e. Inicie uma nova transação.
-- f. Diminua 10 unidades do produto 13.
-- g. Desfaça a operação com ROLLBACK.
-- h. Consulte o estoque dos três produtos e compare os resultados.
start transaction;
update produtos
set estoque = estoque + 5
where id_produto = 11;
update produtos
set estoque = estoque + 5
where id_produto = 11;
