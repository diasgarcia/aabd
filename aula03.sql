SELECT * FROM produtos;
SELECT * FROM clientes;

INSERT INTO produtos (nome, preco, estoque) 
VALUES ('Celular', 900.00, 10);

SELECT * FROM produtos
WHERE nome IN ('Celular', 'Headset Gamer', 'Webcam');

SELECT * FROM produtos
WHERE nome NOT IN ('Celular', 'Headset Gamer');

SELECT * FROM produtos
WHERE preco BETWEEN 5 AND 30;

SELECT * FROM produtos
WHERE nome LIKE  'C%';

SELECT * FROM produtos
WHERE nome LIKE  '%er';

INSERT INTO clientes (nome, cidade) 
VALUES ('Fernanda Alvaes', 'Ourinhos');

SELECT * FROM clientes
WHERE email IS NULL;

SELECT * FROM clientes
WHERE email IS NOT NULL;

SELECT * FROM produtos
ORDER BY estoque;

SELECT * FROM produtos
ORDER BY nome ASC;

SELECT * FROM produtos
ORDER BY estoque DESC
LIMIT 3;

SELECT * FROM produtos
WHERE estoque > 0 AND nome LIKE '%a%'
ORDER BY estoque DESC
LIMIT 2;
