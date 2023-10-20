-- Isso é um comentário
/*
Isso é um bloco de comentário
*/

SET DATESTYLE TO PostgreSQL,European;

CREATE SEQUENCE IDVendedor;
CREATE TABLE Vendedores(
  IDVendedor int default nextval('IDVendedor'::regclass) PRIMARY KEY,
  Nome Varchar(50)
);

INSERT INTO vendedores(nome) VALUES ('Armando Lago');

-- criar

CREATE SEQUENCE IDProduto;
CREATE TABLE Produtos(
  IDProduto int default nextval('IDProduto'::regclass) PRIMARY KEY,
  Produto Varchar(100),
  Preco Numeric(10,2)
);

-- Inserir
INSERT INTO produtos(produto, preco) VALUES ('Bicicleta Aro 29 Mountain Bike Endorphine 6.3 - 24 Marchas - Shimano - Alumínio', 8852.00);
INSERT INTO produtos(produto, preco) VALUES ('Bicicleta Altools Stroll Aro 26 Freio À Disco 21 Marchas', 9201.00);


