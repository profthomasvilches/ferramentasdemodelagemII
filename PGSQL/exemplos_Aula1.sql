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