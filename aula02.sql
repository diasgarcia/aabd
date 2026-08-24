CREATE DATABASE loja;  
USE loja;
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    cidade VARCHAR(50)
);

SHOW TABLES;

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2),
    estoque INT
);

SHOW TABLES;

INSERT INTO produtos (nome, preco, estoque) VALUES
('Headset Gamer', 250.00, 20),
('Cadeira Ergonômica', 1200.00, 5),
('Webcam Full HD', 180.00, 0),
('Placa de Vídeo', 2500.00, 3),
('Carregador Universal', 45.00, 50),
('Suporte para Notebook', 80.00, 25),
('Mesa Digitalizadora', 400.00, 0),
('Cabo HDMI 2m', 25.00, 100);

SELECT * FROM produtos;

INSERT INTO produtos (nome, preco, estoque)
VALUES ('Celular', 1800.00, 20);

SELECT * FROM produtos;

SELECT nome FROM produtos;

SELECT nome, preco FROM produtos;

DESCRIBE produtos;

INSERT INTO clientes (nome, email, cidade)
VALUES
('Ana Silva', 'ana@email.com', 'Ourinhos'),
('Carlos Souza', 'carlos@email.com', 'Marília'),
('Beatriz Lima', 'beatriz@email.com', 'Ourinhos'),
('João Santos', 'joao@email.com', 'Assis'),
('Mariana Oliveira', 'mariana@email.com', 'Marília'),
('Pedro Costa', 'pedro@email.com', 'Ourinhos'),
('Lucas Almeida', 'lucas@email.com', 'Assis'),
('Juliana Martins', 'juliana@email.com', 'Ourinhos'),
('Rafael Mendes', 'rafael@email.com', 'Salto Grande'),
('Camila Rodrigues', 'camila@email.com', 'Ourinhos');

SELECT * FROM produtos
WHERE preco > 1000.00;

SELECT * FROM produtos 
WHERE estoque = 0;

SELECT * FROM clientes 
WHERE cidade = 'Ourinhos';

SELECT *
FROM clientes
WHERE cidade = 'Ourinhos'
AND nome = 'Ana Silva';

SELECT *
FROM clientes
WHERE cidade = 'Ourinhos'
AND email LIKE '%@email.com';

SELECT * FROM produtos 
WHERE preco > 1000.00 OR estoque = 0;
