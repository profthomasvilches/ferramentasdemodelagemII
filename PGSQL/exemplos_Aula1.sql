-- Tabela funnel
/*SELECT *
FROM sales.funnel*/

/* SELECT *
FROM sales.customers*/


SELECT *
FROM sales.products


/*SELECT store_name
FROM sales.stores*/

-- LEFT JOIN

/*SELECT *
FROM sales.funnel LEFT JOIN sales.customers
ON sales.funnel.customer_id = sales.customers.customer_id
WHERE sales.customers.state = 'SP' -- Filtro do estado SP*/


/*SELECT COUNT(*), sales.customers.state
FROM sales.funnel LEFT JOIN sales.customers
ON sales.funnel.customer_id = sales.customers.customer_id
GROUP BY sales.customers.state*/

/*SELECT COUNT(*), sales.customers.state
FROM sales.funnel LEFT JOIN sales.customers
ON sales.funnel.customer_id = sales.customers.customer_id
GROUP BY sales.customers.state*/

/*SELECT MAX(visit_page_date), MIN(visit_page_date)
FROM sales.funnel*/

/* SELECT COUNT(*), sales.customers.state -- tudo
FROM 
(	SELECT *, DATE_PART('Year', sales.funnel.visit_page_date) AS ano 
	FROM sales.funnel -- cria uma tabela secundaria
) AS tab_sub -- nome da tabela nova
LEFT JOIN sales.customers -- junta com a customers
ON tab_sub.customer_id = sales.customers.customer_id
WHERE tab_sub.ano = 2020
GROUP BY sales.customers.state*/

-- SELECT COUNT(*), sales.customers.state
-- FROM sales.funnel LEFT JOIN sales.customers
-- ON sales.funnel.customer_id = sales.customers.customer_id
-- GROUP BY sales.customers.state
-- HAVING sales.customers.state IN ('SP', 'MG')



CREATE TABLE temp_tables.profissoes (
	professional_status VARCHAR,
	status_profissional VARCHAR
)

-- Deleta tabela
DROP TABLE temp_tables.profissoes

-- update da linha
UPDATE temp_tables.profissoes
SET professional_status = 'intern'
WHERE status_profissional = 'estagiário'

-- DELETA linha
DELETE FROM temp_tables.profissoes
WHERE status_profissional = 'desempregado'
OR status_profissional = 'estagiário'

SELECT * FROM temp_tables.profissoes

-- SELECIONAR colunas e distinguir
SELECT DISTINCT brand
FROM sales.products
ORDER BY brand DESC -- ordena em ordem decrescente


SELECT * FROM sales.products
-- SELECIONAR colunas e distinguir
SELECT DISTINCT brand
FROM sales.products
ORDER BY brand DESC -- ordena em ordem decrescente


-- 10 produtos com maior valor
SELECT *
FROM sales.products
ORDER BY price DESC -- ordena em ordem decrescente
LIMIT 10


SELECT *
FROM sales.funnel
WHERE visit_page_date < '20210101' -- dados de 2020

SELECT *
FROM sales.funnel
WHERE visit_page_date < '20210101' AND
paid_date IS NOT NULL -- nao nulo (houve pagamento)

-- criando uma tabelinha chamada tab_nova
WITH tab_nova AS (SELECT product_id, COUNT(*) AS cc
FROM sales.funnel
GROUP BY product_id)

SELECT * -- selecionando os que tem mais de 500 acessos
FROM tab_nova
WHERE cc > 500


-- JOIN
-- criando uma tabelinha chamada tab_nova
WITH tab_nova AS (SELECT product_id, COUNT(*) AS cc
FROM sales.funnel
GROUP BY product_id)

SELECT tab_nova.product_id, brand, model, cc  
FROM tab_nova LEFT JOIN
(
  SELECT product_id, brand, model
  FROM sales.products
) AS tab_prod ON
tab_nova.product_id = tab_prod.product_id
WHERE cc > 500
-- selecionando os que tem mais de 500 acessos


 SELECT product_id, brand, model, price, price/1000 AS milhar
  FROM sales.products
  
-- juntar strings


SELECT
	first_name,
	last_name,
	(first_name || ' ' || last_name) as nome_completo
FROM sales.customers

-- achar valores que contém algo
SELECT DISTINCT first_name
FROM sales.customers
WHERE first_name LIKE 'ANA%'

-- diferente
SELECT DISTINCT first_name
FROM sales.customers
WHERE first_name = 'ANA'



SELECT DISTINCT first_name
FROM sales.customers
WHERE first_name <> 'ANA' -- diferente de


-- SUBQUERY


SELECT * 
FROM sales.products LEFT JOIN
(SELECT product_id, COUNT(*) AS cc
FROM sales.funnel
GROUP BY product_id) AS tab_nova
ON sales.products.product_id = tab_nova.product_id
