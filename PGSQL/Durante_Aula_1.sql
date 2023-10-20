-- Um comentário
/*
CREATE TABLE public.Produtos(
  IDProduto int PRIMARY KEY,
  Produto Varchar(100),
  Preco Numeric(10,2) -- numerico com 10 dígitos sendo dois decimais 
);*/


-- SELECT * FROM produtos

-- INSERT INTO produtos(idproduto, produto, preco) VALUES (3, 'Bicicleta Aro 3333 Mountain Bike Endorphine 6.3 - 24 Marchas - Shimano - Alumínio', 8852.00);



/* CREATE SEQUENCE IDVendedor;
CREATE TABLE Vendedores(
	-- PostgreSQL preencher automaticamente a chave primária
  IDVendedor int default nextval('IDVendedor'::regclass) PRIMARY KEY,
  Nome Varchar(50)
);*/

INSERT INTO vendedores(nome) VALUES ('Thomas Vilches');

