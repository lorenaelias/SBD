/* INTEGRANTES
	LORENA DA SILVA ELIAS 11721BCC019	
	VICTOR HUGO EUSTAQUIO LOPES 11721BCC011
	YAGO VINICIUS FERREIRA DE CASTRO 11721BCC020
*/ 

-- 01)
SELECT COUNT(numfilme)
FROM EMPRESTIMO
WHERE DATARET < '01/04/2013'
-- "12"

-- 02)
SELECT CATEGORIA, COUNT(CATEGORIA)
FROM FILME
GROUP BY CATEGORIA
-- "Biografia/Drama/História"	"1"
-- "Drama"	"1"
-- "Comédia"	"1"
-- "Drama/Mistério"	"1"
-- "Aventura/Velho-Oeste"	"1"
-- "Ação"	"1"
-- "Terror/Mistério"	"1"
-- "Drama/Musical/Romance"	"1"
-- "Crime/Drama"	"1"
-- "Ação/Drama/Terror"	"1"
-- "Crime/Drama/Thriller"	"2"
-- "Ação/Aventura/Mistério"	"1"
-- "Mistério/Thriller"	"1"
-- "Crime/Drama/Ficção Científica"	"1"

-- 03)
SELECT COUNT(ESTRELA.NUMFILME), ATOR.NOMEARTISTICO
FROM ESTRELA, ATOR
WHERE ESTRELA.CODATOR = ATOR.COD
GROUP BY ATOR.NOMEARTISTICO
ORDER BY ATOR.NOMEARTISTICO
-- "1"	"Adrien Brody"
-- "1"	"Adrienne Corri"
-- "1"	"Agnes Moorehead"
-- "1"	"Al Pacino"
-- "1"	"Amanda Seyfried"
-- "1"	"Anthony Heald"
-- "1"	"Anthony Hopkins"
-- "1"	"Brad Pitt"
-- "1"	"Bradley Cooper"
-- "1"	"Bruce Willis"
-- "1"	"Carrie-Anne Moss"
-- "1"	"Christoph Waltz"
-- "1"	"Christopher Lloyd"
-- "1"	"Danny DeVito"
-- "1"	"Dorothy Comingore"
-- "1"	"Ed Helms"
-- "1"	"Ellen Page"
-- "1"	"Emilia Fox"
-- "1"	"Frank Finlay"
-- "1"	"Guy Pearce"
-- "1"	"Hugh Jackman"
-- "2"	"Jack Nicholson"
-- "1"	"James Caan"
-- "1"	"Jamie Foxx"
-- "1"	"Jodie Foster"
-- "1"	"Joe Pantoliano"
-- "1"	"John Travolta"
-- "1"	"Joseph Cotten"
-- "1"	"Joseph Gordon-Levitt"
-- "2"	"Leonardo DiCaprio"
-- "1"	"Malcolm McDowell"
-- "1"	"Mark Ruffalo"
-- "1"	"Marlon Brando"
-- "1"	"Matthew Fox"
-- "1"	"Mireille Enos"
-- "1"	"Robert Downey Jr."
-- "1"	"Russel Crowe"
-- "1"	"Samuel L. Jackson"
-- "1"	"Scarlett Johansson"
-- "1"	"Scatman Crothers"
-- "1"	"Shelley Duvall"
-- "1"	"Warren Clarke"
-- "1"	"Zach Galifianakis"

-- 04)
SELECT MAX(DATA_LANCAMENTO)
FROM FILME
-- "2013-06-21"

-- 05)
SELECT TITULO_ORIGINAL, CATEGORIA
FROM FILME
WHERE FILME.DATA_LANCAMENTO = ( SELECT MIN(F.DATA_LANCAMENTO) 
	                            FROM FILME F)
-- "Citizen Kane"	"Drama/Mistério"

-- 06)
SELECT SUM(VALOR_PG)
FROM EMPRESTIMO, CLIENTE
WHERE EMPRESTIMO.CLIENTE = CLIENTE.NUMCLIENTE AND
      CLIENTE.NOME LIKE 'João José da Silva'
-- "63735"

-- 07)
SELECT AVG(FILME.DURACAO)
FROM FILME, CLASSIFICACAO
WHERE FILME.CLASSIFICACAO = CLASSIFICACAO.COD AND
      CLASSIFICACAO.NOME LIKE 'Acervo'
-- "140.7500000000000000"

-- 08)
SELECT CLASSIFICACAO.NOME
FROM CLASSIFICACAO, FILME
WHERE CLASSIFICACAO.COD = FILME.CLASSIFICACAO
GROUP BY CLASSIFICACAO.NOME
HAVING COUNT(NUMFILME) > 5
-- "Acervo"

-- 09)
SELECT NOMEARTISTICO
FROM ATOR, ESTRELA
WHERE ATOR.COD = ESTRELA.CODATOR
GROUP BY NOMEARTISTICO
HAVING COUNT(ATOR.NOMEARTISTICO) > 3
-- VAZIO

-- 10)
SELECT NOMEARTISTICO
FROM ATOR, ESTRELA, CLASSIFICACAO
WHERE ATOR.COD = ESTRELA.CODATOR AND
      CLASSIFICACAO.NOME LIKE 'Lançamento'
GROUP BY NOMEARTISTICO
HAVING COUNT(ATOR.NOMEARTISTICO) > 2
-- VAZIO

-- 11)
SELECT COUNT(DISTINCT NACIONALIDADE)
FROM ATOR
-- "7"

--12)
SELECT ATOR.NACIONALIDADE
FROM ATOR
GROUP BY ATOR.NACIONALIDADE
HAVING MAX(COUNT(ATOR.NACIONALIDADE))

-- 13)
SELECT COUNT(emprestimo.NUMFILME)
FROM EMPRESTIMO, CLIENTE
WHERE CLIENTE.NUMCLIENTE = EMPRESTIMO.CLIENTE AND
      EMPRESTIMO.datedev < '10/05/2019'
GROUP BY EMPRESTIMO.NUMFILME