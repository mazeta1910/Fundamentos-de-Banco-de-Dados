/*Rela��o contendo title, length e rating dos filmes (film) em ordem alfab�tica de t�tulo.
Rela��o de filmes (film), contendo todos os atributos, que foram lan�ados entre 2006 e 2009 (release_year).
Rela��o de categorias (category) em ordem alfab�tica.
Rela��o de clientes (customer) contendo o primeiro nome, �ltimo nome e email de todos os clientes inativos. Dica: Active = 0;
Rela��o dos filmes (title, rating, release_year) da categoria (Sci-Fi). Dica: fa�a uma consulta � tabela de categorias e localize o c�digo da categoria Sci-Fi para resolver o exerc�cio.
Listar os atores em ordem de sobrenome (last_name).
Rela��o dos pagamentos (payment), com todos os atributos, que foram realizados entre '2007-02-01' e '2007-02-15'
Rela��o dos clientes (customer_id, first_name, last_name, active) em ordem de sobrenome + nome.
Rela��o de cidades em ordem alfab�tica.
Rela��o de atores em ordem de nome cujos sobrenomes comecem com 'Kil%'. Pesquise sobre a cl�sula LIKE do Postgresql para resolver o exerc�cio.*/

-- 1) 
SELECT title, length, rating
FROM film
ORDER BY title;

-- 2)
SELECT *
FROM film
WHERE release_year BETWEEN 2006 AND 2009;

-- 3)
SELECT *
FROM category
ORDER BY name;

-- 4)
SELECT first_name, last_name, email
FROM customer
WHERE active = 0;

-- 5)
SELECT F.title, F.rating, F.release_year
FROM film F
JOIN film_category FC ON F.film_id = FC.film_id
JOIN category C ON FC.category_id = C.category_id
WHERE C.name = 'Sci-Fi';

-- 6)
SELECT first_name, last_name
FROM actor
ORDER BY last_name;

-- 7)
SELECT *
FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

-- 8)
SELECT customer_id, first_name, last_name, active
FROM customer
ORDER BY last_name, first_name;

-- 9)
SELECT city
FROM city
ORDER BY city;

-- 10)
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'Kil%'
ORDER BY first_name;