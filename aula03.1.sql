-- Consultar
SELECT * FROM produtos;

-- Adicionar
INSERT INTO produtos (nome, preco, estoque)
VALUES ('Mouse', 80.00, 15);

-- Alterar
UPDATE produtos
SET preco = 90.00
WHERE nome = 'Mouse';

-- Alterar
UPDATE produtos
SET preco = 90.00
WHERE id_produto = 10;

-- Remove o produto inteiro
DELETE FROM produtos
WHERE id_produto = 11;

-- Remove apenas o valor do preço
UPDATE produtos
SET preco = NULL
WHERE nome = 'Mouse';

-- E se a intenção fosse excluir a coluna preco da tabela inteira, aí sim seria ALTER TABLE:
ALTER TABLE produtos
DROP COLUMN preco;

-- Alterar a estrutura
ALTER TABLE produtos
ADD marca VARCHAR(50);

--Adicionar telefone aos clientes:
ALTER TABLE clientes
ADD telefone VARCHAR(20);

DESCRIBE clientes;

-- Com OR
WHERE cidade = 'Ourinhos'
   OR cidade = 'Marília';

-- Com IN
WHERE cidade IN ('Ourinhos', 'Marília');

SELECT * FROM produtos
WHERE nome IN ('Celular', 'Headset Gamer', 'Webcam Full HD');

SELECT * FROM clientes
WHERE cidade IN ('Ourinhos', 'Marília');

-- NOT IN 
SELECT * FROM clientes
WHERE cidade NOT IN ('Ourinhos', 'Marília');

SELECT * FROM produtos
WHERE nome NOT IN ('Celular', 'Headset Gamer');


-- BETWEEN verifica se o valor está dentro de um intervalo, incluindo os limites.
SELECT * FROM produtos
WHERE preco BETWEEN 300 AND 2000;

SELECT * FROM produtos
WHERE estoque BETWEEN 5 AND 30;

-- LIKE: Começa com:
SELECT * FROM produtos
WHERE nome LIKE 'C%';

-- LIKE: Termina com:
SELECT * FROM produtos
WHERE nome LIKE '%er';


-- atualmente nenhuma coluna de vocês possui valores NULL nos registros inseridos.
NULL não significa vazio (''). Significa que não existe informação armazenada.
Então, para ensinar isso, seria interessante inserir um cliente sem e-mail:

INSERT INTO clientes (nome, cidade)
VALUES ('Fernanda Alves', 'Ourinhos');

SELECT * FROM clientes
WHERE email IS NULL;

SELECT * FROM clientes
WHERE email IS NULL;

SELECT * FROM clientes
WHERE email IS NOT NULL;


-- ORDER BY: não serve apenas para "buscar", mas também para organizar os resultados.
Preço do menor para o maior:
SELECT * FROM produtos
ORDER BY preco ASC;

Preço do maior para o menor:
SELECT * FROM produtos
ORDER BY preco DESC;

SELECT * FROM clientes
ORDER BY nome ASC;

-- LIMIT: limita a quantidade de resultados exibidos.

Quais são os 3 produtos mais caros?
SELECT * FROM produtos
ORDER BY preco DESC
LIMIT 3;

Decrescendo: maior para menor 
SELECT * FROM produtos
ORDER BY estoque DESC
LIMIT 3;


--MISTURANDO TUDO
SELECT * FROM produtos
WHERE preco BETWEEN 300 AND 2000
AND estoque > 0
ORDER BY preco DESC;

SELECT * FROM produtos
AND estoque > 0
AND nome LIKE '%a%'
ORDER BY estoque DESC
LIMIT 2;
