-- 1) Rela��o de filmes (incluir todos os atributos da tabela film apenas) de nacionalidade inglesa, espanhola ou americana (language);
SELECT  *
FROM film AS f
INNER JOIN language AS l
ON f.language_id = l.language_id
WHERE l.name IN ('English', 'Spanish', 'American');

-- 2) Faturamento total (amount) agrupado por cliente do filme (mostrar c�digo da cliente, nome do cliente e valor total)
-- em ordem descendente do valor total;
SELECT 
    c.customer_id AS "C�digo da Cliente",
    c.first_name + ' ' + c.last_name AS "Nome da Cliente",
    SUM(p.amount) AS "Valor Total"
FROM 
    customer AS c
INNER JOIN 
    payment AS p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    "Valor Total" DESC;

-- 3) Rela��o dos 5 filmes mais locados (quantas vezes) (mostrar film_id e title e a quantidade de loca��es realizadas por filme no ano de 2005.
SELECT TOP 5
    f.film_id AS "Film ID",
    f.title AS "T�tulo",
    COUNT(r.rental_id) AS "Quantidade de Loca��es"
FROM 
    film AS f
INNER JOIN 
    inventory AS i ON f.film_id = i.film_id
INNER JOIN 
    rental AS r ON i.inventory_id = r.inventory_id � 

WHERE 
    YEAR(r.rental_date) = 2005
GROUP BY 
    f.film_id, f.title
ORDER BY 
    "Quantidade de Loca��es" DESC;

	-- 4) Mostrar o n�mero de filmes locados por cada funcion�rio (staff) e o total faturado por funcion�rio.
	-- A consulta deve mostrar o id do funcion�rio, o nome e a contagem de filmes que realizou a loca��o.
SELECT 
	s.staff_id AS "ID do Funcion�rio",
    s.first_name + ' ' + s.last_name AS "Nome do Funcion�rio",
    COUNT(r.rental_id) AS "N�mero de Filmes Locados",
    SUM(p.amount) AS "Total Faturado"
FROM 
    staff AS s
INNER JOIN 
    rental AS r ON s.staff_id = r.staff_id
INNER JOIN 
    payment AS p ON r.rental_id = p.rental_id
GROUP BY 
    s.staff_id, s.first_name, s.last_name;

-- 5) Usando jun��o natural � esquerda, verificar se existe algum filme que n�o foi locado em 07/2006
-- (customer x rental). Listar o c�digo e o nome dos filmes.
SELECT f.film_id, f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE � 
 r.rental_date BETWEEN '20060701' AND '20060731'
AND r.rental_id IS NULL;

-- 6) Rela��o de c�pias (inventory) existentes por filme. 
-- Mostrar o id do filme, o t�tulo e a contagem de c�pias em ordem de t�tulo.
SELECT
    f.film_id AS "ID do Filme",
    f.title AS "T�tulo",
    COUNT(i.inventory_id) AS "N�mero de C�pias"
FROM
    film AS f
INNER JOIN
    inventory AS i ON f.film_id = i.film_id
GROUP BY
    f.film_id, f.title
ORDER BY
    f.title;

-- 7) Rela��o de clientes que moram em outros pa�ses, menos os EUA, que alugaram filmes de nacionalidade americana
-- (mostrar todos os campos da tabela customers em ordem de nome).
SELECT c.*
FROM customer AS c
INNER JOIN address AS a
ON c.address_id = a.address_id
INNER JOIN city AS ci
ON a.city_id = ci.city_id
INNER JOIN country AS co
ON ci.country_id = co.country_id
WHERE co.country � 
 <> 'United States'
INTERSECT
SELECT c.*
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id
INNER JOIN inventory AS i
ON r.inventory_id = i.inventory_id
INNER JOIN film � 
 AS f
ON i.film_id = f.film_id
INNER � 
 JOIN language AS l
ON f.language_id = l.language_id
WHERE l.name = 'English'
ORDER BY c.first_name

-- 8) Mostrar o nome de todos os clientes que fizeram mais de 2 loca��es em ordem alfab�tica em cada m�s de 2005. 
-- Dica: pesquise sobre a cl�usula having.
SELECT 
    c.first_name + ' ' + c.last_name AS "Nome do Cliente", 
    MONTH(r.rental_date) AS "M�s"
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
WHERE 
    YEAR(r.rental_date) = 2005
GROUP BY 
    c.first_name + ' ' + c.last_name, MONTH(r.rental_date)
HAVING 
    COUNT(r.rental_id) > 2
ORDER BY 
    MONTH(r.rental_date), c.first_name + ' ' + c.last_name;

-- 9) Mostrar o n�mero de c�pias de filmes por loja (inventory e store) em ordem crescente da contagem.]
SELECT 
    s.store_id AS "ID da Loja", 
    COUNT(i.inventory_id) AS "N�mero de C�pias"
FROM 
    store s
LEFT JOIN 
    inventory i ON s.store_id = i.store_id
GROUP BY 
    s.store_id
ORDER BY 
    "N�mero de C�pias" ASC;

--10) Escreva uma senten�a em T-SQL que responda a seguinte pergunta: 
-- quantos porcento dos clientes alugaram filmes em 2005, e quantos porcento alugaram filmes em 2006.
SELECT 
CAST(COUNT(CASE WHEN YEAR(rental_date) = 2005 THEN 1 END) AS DECIMAL) * 100 / COUNT(*) AS Percent2005,
CAST(COUNT(CASE WHEN YEAR(rental_date) = 2006 THEN 1 END) AS DECIMAL) * 100 / COUNT(*) AS Percent2006
FROM rental;