CREATE DATABASE loja;
USE loja; 

CREATE TABLE produtos (
	id_produto INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT
);

SHOW TABLES;

CREATE TABLE clientes (
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    cidade VARCHAR(100)
);

INSERT INTO produtos (nome, preco, estoque) VALUES
("Notebook", 3500.00, 10),
("Mouse", 88.00, 50),
("Teclado", 150.00, 30),
("Monitor", 1200.00, 35);

SELECT nome, preco FROM produtos;

DESCRIBE produtos;

INSERT INTO produtos (nome, preco, estoque) VALUES
("Celular", 4500.00, 100);
