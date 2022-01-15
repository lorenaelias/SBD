/*  INTEGRANTES 
    LORENA DA SILVA ELIAS 11721BCC19
    VICTOR HUGO EUSTAQUIO 11721BCC011
    YAGO VINICIUS FERREIRA DE CASTRO 11721BCC020  */ 

--1
select distinct (cliente.nome), cliente.endereco
from cliente inner join notafiscal on cliente.codcliente = notafiscal.codcliente
where notafiscal.codloja = 2

--"Computec Ltda"	"Av.São Carlos, 186"
--"MicroMédia SA"	"R.José Bonifácio, 70"

--2
select loja.nome
from loja inner join notafiscal on loja.codloja = notafiscal.codloja
where notafiscal.data > '20/05/1999' and notafiscal.data < '30/05/1999'
group by loja.nome
having count(notafiscal.codloja) >= all (select count(notafiscal.codloja)
										 from notafiscal
										where notafiscal.data > '20/05/1999' and notafiscal.data < '30/05/1999'
										group by notafiscal.codloja)
										
--"Papelândia 5"


--3
SELECT CLIENTE.NOME, SUM(NOTAFISCAL.VALORTOTAL), notafiscal.codloja
FROM NOTAFISCAL INNER JOIN CLIENTE
ON NOTAFISCAL.CODCLIENTE = CLIENTE.CODCLIENTE 
group by rollup(cliente.nome, notafiscal.codloja)
order by (cliente.nome, notafiscal.codloja)

--"Computec Ltda"	"66.50"	1
--"Computec Ltda"	"143.90"	2
--"Computec Ltda"	"210.40"	
--"MicroMédia SA"	"66.00"	2
--"MicroMédia SA"	"54.50"	5
--"MicroMédia SA"	"120.50"	
--"ProvTecno"	"31.50"	5
--"ProvTecno"	"31.50"	
--"TecnoCom Ltda"	"14.90"	4
--"TecnoCom Ltda"	"14.90"	
--	"377.30"	


--4
SELECT CLIENTE.NOME, SUM(NOTAFISCAL.VALORTOTAL), notafiscal.codloja
FROM NOTAFISCAL INNER JOIN CLIENTE
ON NOTAFISCAL.CODCLIENTE = CLIENTE.CODCLIENTE 
group by cube(cliente.nome, notafiscal.codloja)
order by (cliente.nome, notafiscal.codloja)

-- "Computec Ltda"	"66.50"	1
-- "Computec Ltda"	"143.90"	2
-- "Computec Ltda"	"210.40"	
-- "MicroMédia SA"	"66.00"	2
-- "MicroMédia SA"	"54.50"	5
-- "MicroMédia SA"	"120.50"	
-- "ProvTecno"	"31.50"	5
-- "ProvTecno"	"31.50"	
-- "TecnoCom Ltda"	"14.90"	4
-- "TecnoCom Ltda"	"14.90"	
-- 	"66.50"	1
-- 	"209.90"	2
-- 	"14.90"	4
-- 	"86.00"	5
-- 	"377.30"	


--5 
select codcliente, codloja, Count(notafiscal.codcliente)
from notafiscal
group by rollup (codcliente,codloja)
order by (codcliente,codloja)

-- 111	 1	 "3"
-- 111	 2	 "2"
-- 111		 "5"
-- 112	 2	 "1"
-- 112	 5	 "1"
-- 112		 "2"
-- 113	 4	 "2"
-- 113		 "2"
-- 115	 5	 "1"
-- 115		 "1"
-- 		         "10"

--6
select codcliente, codloja, Count(notafiscal.codcliente)
from notafiscal
group by cube (codcliente,codloja)
order by (codcliente,codloja)

-- 111	1	"3"
-- 111	2	"2"
-- 111		"5"
-- 112	2	"1"
-- 112	5	"1"
-- 112		"2"
-- 113	4	"2"
-- 113		"2"
-- 115	5	"1"
-- 115		"1"
-- 		1	"3"
-- 		2	"3"
-- 		4	"2"
-- 		5	"2"
-- 			"10"


b)

INSERT INTO LOJA VALUES(7, 'Papelândia 7', 'Av. João Naves', 'Uberlândia - MG', '232.456.666/0007-20');
INSERT INTO NOTAFISCAL VALUES(2160,'16/05/2019',115,7,NULL,9.80);

-- left outer join
SELECT *
FROM LOJA LEFT OUTER JOIN NOTAFISCAL 
               ON LOJA.CODLOJA = NOTAFISCAL.CODLOJA

1	"Papelândia 1"	"Av.São Carlos, 870"	"São Carlos - SP"	"232.456.666/0001-89"	2142	"1999-04-01"	111	1	45675	"17.50"
2	"Papelândia 2"	"R. XV Novembro, 121"	"São Carlos - SP"	"232.456.666/0002-34"	2143	"1999-04-10"	111	2	45675	"84.00"
1	"Papelândia 1"	"Av.São Carlos, 870"	"São Carlos - SP"	"232.456.666/0001-89"	2144	"1999-05-17"	111	1	45675	"13.00"
1	"Papelândia 1"	"Av.São Carlos, 870"	"São Carlos - SP"	"232.456.666/0001-89"	2145	"1999-05-05"	111	1	45690	"36.00"
2	"Papelândia 2"	"R. XV Novembro, 121"	"São Carlos - SP"	"232.456.666/0002-34"	2146	"1999-05-22"	111	2	45690	"59.90"
2	"Papelândia 2"	"R. XV Novembro, 121"	"São Carlos - SP"	"232.456.666/0002-34"	2147	"1999-05-18"	112	2	45691	"66.00"
5	"Papelândia 5"	"R. Tiradentes 432"	"São Carlos - SP"	"232.456.666/0005-19"	2148	"1999-05-27"	112	5	45691	"54.50"
4	"Papelândia 4"	"Av. Independência, 567"	"São Carlos - SP"	"232.456.666/0004-22"	2149	"1999-05-01"	113	4	45692	"14.10"
4	"Papelândia 4"	"Av. Independência, 567"	"São Carlos - SP"	"232.456.666/0004-22"	2150	"1999-05-30"	113	4	45692	"0.80"
5	"Papelândia 5"	"R. Tiradentes 432"	"São Carlos - SP"	"232.456.666/0005-19"	2151	"1999-05-26"	115	5	45693	"31.50"
7	"Papelândia 7"	"Av. João Naves"	"Uberlândia - MG"	"232.456.666/0007-20"	2160	"2019-05-16"	115	7		"9.80"			
3	"Papelândia 3"	"R. 7 Setembro, 1823"	"São Carlos - SP"	"232.456.666/0003-92"						


-- right outer join
SELECT *
FROM LOJA RIGHT OUTER JOIN NOTAFISCAL 
               ON LOJA.CODLOJA = NOTAFISCAL.CODLOJA

1	"Papelândia 1"	"Av.São Carlos, 870"	"São Carlos - SP"	"232.456.666/0001-89"	2142	"1999-04-01"	111	1	45675	"17.50"
2	"Papelândia 2"	"R. XV Novembro, 121"	"São Carlos - SP"	"232.456.666/0002-34"	2143	"1999-04-10"	111	2	45675	"84.00"
1	"Papelândia 1"	"Av.São Carlos, 870"	"São Carlos - SP"	"232.456.666/0001-89"	2144	"1999-05-17"	111	1	45675	"13.00"
1	"Papelândia 1"	"Av.São Carlos, 870"	"São Carlos - SP"	"232.456.666/0001-89"	2145	"1999-05-05"	111	1	45690	"36.00"
2	"Papelândia 2"	"R. XV Novembro, 121"	"São Carlos - SP"	"232.456.666/0002-34"	2146	"1999-05-22"	111	2	45690	"59.90"
2	"Papelândia 2"	"R. XV Novembro, 121"	"São Carlos - SP"	"232.456.666/0002-34"	2147	"1999-05-18"	112	2	45691	"66.00"
5	"Papelândia 5"	"R. Tiradentes 432"	"São Carlos - SP"	"232.456.666/0005-19"	2148	"1999-05-27"	112	5	45691	"54.50"
4	"Papelândia 4"	"Av. Independência, 567"	"São Carlos - SP"	"232.456.666/0004-22"	2149	"1999-05-01"	113	4	45692	"14.10"
4	"Papelândia 4"	"Av. Independência, 567"	"São Carlos - SP"	"232.456.666/0004-22"	2150	"1999-05-30"	113	4	45692	"0.80"
5	"Papelândia 5"	"R. Tiradentes 432"	"São Carlos - SP"	"232.456.666/0005-19"	2151	"1999-05-26"	115	5	45693	"31.50"
7	"Papelândia 7"	"Av. João Naves"	"Uberlândia - MG"	"232.456.666/0007-20"	2160	"2019-05-16"	115	7		"9.80"


-- full outer join
SELECT *
FROM LOJA FULL OUTER JOIN NOTAFISCAL 
               ON LOJA.CODLOJA = NOTAFISCAL.CODLOJA
			
1	"Papelândia 1"	"Av.São Carlos, 870"	"São Carlos - SP"	"232.456.666/0001-89"	2142	"1999-04-01"	111	1	45675	"17.50"
2	"Papelândia 2"	"R. XV Novembro, 121"	"São Carlos - SP"	"232.456.666/0002-34"	2143	"1999-04-10"	111	2	45675	"84.00"
1	"Papelândia 1"	"Av.São Carlos, 870"	"São Carlos - SP"	"232.456.666/0001-89"	2144	"1999-05-17"	111	1	45675	"13.00"
1	"Papelândia 1"	"Av.São Carlos, 870"	"São Carlos - SP"	"232.456.666/0001-89"	2145	"1999-05-05"	111	1	45690	"36.00"
2	"Papelândia 2"	"R. XV Novembro, 121"	"São Carlos - SP"	"232.456.666/0002-34"	2146	"1999-05-22"	111	2	45690	"59.90"
2	"Papelândia 2"	"R. XV Novembro, 121"	"São Carlos - SP"	"232.456.666/0002-34"	2147	"1999-05-18"	112	2	45691	"66.00"
5	"Papelândia 5"	"R. Tiradentes 432"	"São Carlos - SP"	"232.456.666/0005-19"	2148	"1999-05-27"	112	5	45691	"54.50"
4	"Papelândia 4"	"Av. Independência, 567"	"São Carlos - SP"	"232.456.666/0004-22"	2149	"1999-05-01"	113	4	45692	"14.10"
4	"Papelândia 4"	"Av. Independência, 567"	"São Carlos - SP"	"232.456.666/0004-22"	2150	"1999-05-30"	113	4	45692	"0.80"
5	"Papelândia 5"	"R. Tiradentes 432"	"São Carlos - SP"	"232.456.666/0005-19"	2151	"1999-05-26"	115	5	45693	"31.50"
7	"Papelândia 7"	"Av. João Naves"	"Uberlândia - MG"	"232.456.666/0007-20"	2160	"2019-05-16"	115	7		"9.80"				
3	"Papelândia 3"	"R. 7 Setembro, 1823"	"São Carlos - SP"	"232.456.666/0003-92"						


--C


--1
CREATE VIEW vFATURAS AS
SELECT FATURA.NUMFATURA AS FATURA,
	   NOTAFISCAL.NUMNFISCAL AS NOTA_FISCAL,				 
	   NOTAFISCAL.VALORTOTAL AS VT_NOTA_FISCAL
FROM FATURA, NOTAFISCAL
					 
SELECT * 
FROM vFATURAS
GROUP BY (VFATURAs.FATURA, VFATURAS.NOTA_FISCAL, VFATURAS.VT_NOTA_FISCAL)					 
					 
45675	2142	"17.50"
45675	2143	"84.00"
45675	2144	"13.00"
45675	2145	"36.00"
45675	2146	"59.90"
45675	2147	"66.00"
45675	2148	"54.50"
45675	2149	"14.10"
45675	2150	"0.80"
45675	2151	"31.50"
45690	2142	"17.50"
45690	2143	"84.00"
45690	2144	"13.00"
45690	2145	"36.00"
45690	2146	"59.90"
45690	2147	"66.00"
45690	2148	"54.50"
45690	2149	"14.10"
45690	2150	"0.80"
45690	2151	"31.50"
45691	2142	"17.50"
45691	2143	"84.00"
45691	2144	"13.00"
45691	2145	"36.00"
45691	2146	"59.90"
45691	2147	"66.00"
45691	2148	"54.50"
45691	2149	"14.10"
45691	2150	"0.80"
45691	2151	"31.50"
45692	2142	"17.50"
45692	2143	"84.00"
45692	2144	"13.00"
45692	2145	"36.00"
45692	2146	"59.90"
45692	2147	"66.00"
45692	2148	"54.50"
45692	2149	"14.10"
45692	2150	"0.80"
45692	2151	"31.50"
45693	2142	"17.50"
45693	2143	"84.00"
45693	2144	"13.00"
45693	2145	"36.00"
45693	2146	"59.90"
45693	2147	"66.00"
45693	2148	"54.50"
45693	2149	"14.10"
45693	2150	"0.80"
45693	2151	"31.50"


-- 2
CREATE MATERIALIZED VIEW COMPRAS AS
SELECT DISTINCT(CLIENTE.NOME),
			    NOTAFISCAL.CODLOJA
FROM CLIENTE INNER JOIN NOTAFISCAL ON (CLIENTE.CODCLIENTE = NOTAFISCAL.CODCLIENTE)
WITH NO DATA;

SELECT *
FROM COMPRAS
GROUP BY (NOME,CODLOJA)

"TecnoCom Ltda"	4
"MicroMédia SA"	2
"Computec Ltda"	2
"Computec Ltda"	1
"MicroMédia SA"	5
"ProvTecno"		5
"ProvTecno"		7


--3
CREATE VIEW COMPRAS2 AS
SELECT CLIENTE.NOME AS NOMECLIENTE,
       LOJA.NOME AS LOJANOME
FROM CLIENTE INNER JOIN (NOTAFISCAL INNER JOIN LOJA ON(LOJA.CODLOJA = NOTAFISCAL.CODLOJA)) ON CLIENTE.CODCLIENTE = NOTAFISCAL.CODCLIENTE
													   
				
SELECT *
FROM COMPRAS2
GROUP BY NOMECLIENTE, LOJANOME
ORDER BY LOJANOME

"Computec Ltda"	"Papelândia 1"
"Computec Ltda"	"Papelândia 2"
"MicroMédia SA"	"Papelândia 2"
"TecnoCom Ltda"	"Papelândia 4"
"MicroMédia SA"	"Papelândia 5"
"ProvTecno"	"Papelândia 5"
"ProvTecno"	"Papelândia 7"


--4
CREATE VIEW PRODUTOSMAISVENDIDOS AS												   
SELECT PRODUTO.CODPRODUTO, DESCRICAO, SUM(ITEMNOTAFISCAL.QUANTIDADE)
FROM PRODUTO INNER JOIN ITEMNOTAFISCAL ON PRODUTO.CODPRODUTO = ITEMNOTAFISCAL.CODPRODUTO
GROUP BY PRODUTO.CODPRODUTO, DESCRICAO
ORDER BY SUM (ITEMNOTAFISCAL.QUANTIDADE) DESC
LIMIT 3;
					
SELECT *
FROM PRODUTOSMAISVENDIDOS
													   
86480	"Grampo para Grampeador"	"24"
86479	"Clips nº 10"	"13"
86483	"Caderno 10 matérias 150 fls"	"11"

--5				 
CREATE VIEW NOTAFISCALDETALHADA AS
SELECT	NOTAFISCAL.NUMNFISCAL,
		NOTAFISCAL.DATA,
		NOTAFISCAL.CODCLIENTE,
		NOTAFISCAL.CODLOJA,
		NOTAFISCAL.NUMFATURA,
		NOTAFISCAL.VALORTOTAL,
		PRODUTO.DESCRICAO			 
FROM NOTAFISCAL INNER JOIN(ITEMNOTAFISCAL INNER JOIN PRODUTO ON(ITEMNOTAFISCAL.CODPRODUTO = PRODUTO.CODPRODUTO)) ON ITEMNOTAFISCAL.NUMNFISCAL = NOTAFISCAL.NUMNFISCAL
																
SELECT *																
FROM NOTAFISCALDETALHADA
																
2142	"1999-04-01"	111	1	45675	"17.50"	"Resma papel sufite"
2142	"1999-04-01"	111	1	45675	"17.50"	"Caneta vermelha bic"
2143	"1999-04-10"	111	2	45675	"84.00"	"Clips nº 10"
2143	"1999-04-10"	111	2	45675	"84.00"	"Grampo para Grampeador"
2144	"1999-05-17"	111	1	45675	"13.00"	"Caderno 12 matérias 150 fls"
2144	"1999-05-17"	111	1	45675	"13.00"	"Clips nº 5"
2145	"1999-05-05"	111	1	45690	"36.00"	"Grampo para Grampeador"
2146	"1999-05-22"	111	2	45690	"59.90"	"Caderno 10 matérias 150 fls"
2146	"1999-05-22"	111	2	45690	"59.90"	"Grampeador"
2146	"1999-05-22"	111	2	45690	"59.90"	"Lapis preto nº 5"
2147	"1999-05-18"	112	2	45691	"66.00"	"Caneta azul bic"
2147	"1999-05-18"	112	2	45691	"66.00"	"Resma papel sufite"
2148	"1999-05-27"	112	5	45691	"54.50"	"Caderno 10 matérias 150 fls"
2148	"1999-05-27"	112	5	45691	"54.50"	"Clips nº 10"
2149	"1999-05-01"	113	4	45692	"14.10"	"Grampo para Grampeador"
2149	"1999-05-01"	113	4	45692	"14.10"	"Lapis preto nº 5"
2149	"1999-05-01"	113	4	45692	"14.10"	"Caderno 10 matérias 150 fls"
2150	"1999-05-30"	113	4	45692	"0.80"	"Lapis preto nº 5"
2151	"1999-05-26"	115	5	45693	"31.50"	"Grampo para Grampeador"
2151	"1999-05-26"	115	5	45693	"31.50"	"Caneta vermelha bic"	

--6																
CREATE VIEW CLIENTESIMPORTANTES AS
SELECT CLIENTE.NOME,
	   CLIENTE.CONTATO,
	   CLIENTE.TELEFONE,			 
	   SUM(NOTAFISCAL.VALORTOTAL)
FROM NOTAFISCAL LEFT JOIN CLIENTE ON NOTAFISCAL.CODCLIENTE = CLIENTE.CODCLIENTE
GROUP BY CLIENTE.NOME, CLIENTE.CONTATO, CLIENTE.TELEFONE																
HAVING SUM(NOTAFISCAL.VALORTOTAL) > 100
																
"Computec Ltda"	"José da Silva"	"(017) 276-9999"	"210.40"
"MicroMédia SA"	"João da Silva"	"(017) 273-8974"	"120.50"