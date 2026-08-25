USE loja;

-- Liste os clientes que moram em Marília ou Assis.
SELECT * FROM clientes
WHERE cidade IN('Marília', 'Assis');

-- Encontre o cliente chamado Carlos Souza.
SELECT * FROM clientes
WHERE nome = 'Carlos Souza';

-- O departamento técnico precisa recolher equipamentos caros ou esgotados. Busque o nome e o preço dos produtos que custam mais de R$ 1.500,00 OU que estão com estoque igual a 0.
SELECT * FROM produtos
WHERE preco > 1500.00 
OR estoque = 0;

-- Listar itens com preço maior ou igual a R$ 200,00 E menor ou igual a R$ 500,00.
SELECT * FROM produtos
WHERE preco > 200.00
AND preco <= 500.00;

-- Liste todos os clientes cujo nome termina com a letra 's'.
SELECT * FROM clientes
WHERE nome LIKE '%s';

-- Busque os clientes cujo nome começa com 'M' E que moram em Marília.
SELECT * FROM clientes
WHERE NOME LIKE 'M%'
AND cidade = 'marília';

-- O suporte precisa contatar clientes de Ourinhos que tenham a palavra "Lima" ou "Martins" no nome.
SELECT * FROM clientes
WHERE cidade = 'Ourinhos'
AND (nome LIKE '%Lima' OR nome LIKE '%Martins');

-- A loja quer fazer uma queima de estoque. Liste os produtos que possuem 'Gamer' OU 'Ergonômica' no nome E que tenham estoque maior que 0.
SELECT * FROM produtos
WHERE estoque > 0
AND (nome LIKE '%Gamer' OR nome LIKE '%Ergônomica');

-- - A loja quer excluir clientes que: moram em Marília ou Assis; ou cujo nome contém "Souza". Liste os clientes que não se enquadram nessas condições.
SELECT * FROM clientes
WHERE cidade NOT IN('Marília', 'Assis')
AND nome NOT LIKE '%Souza';

-- Liste os produtos que: custam entre R$ 300,00 e R$ 2.000,00; possuem estoque maior que 5; e tenham no nome "Pro" ou "Gamer".
SELECT * FROM produtos
WHERE (preco >= 300.00 AND preco <= 2000.00)
AND estoque > 5
AND nome IN('Pro', 'Gamer');

-- Liste os clientes cujo nome começa com "A", "C" ou "M" e que não moram em Ourinhos.
SELECT * FROM clientes
WHERE cidade <> 'Ourinhos'
AND (nome LIKE 'A%' OR nome LIKE 'C%' OR nome LIKE 'M%');

-- A loja quer identificar produtos específicos para uma promoção. Liste os produtos cuja categoria seja Notebook, Monitor ou Teclado, utilizando IN.
SELECT * FROM produtos
WHERE nome IN('Notebook', 'Monitor', 'Teclado');


