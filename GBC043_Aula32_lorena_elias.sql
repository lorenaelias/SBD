/*  INTEGRANTES 
    LORENA DA SILVA ELIAS 11721BCC19
    VICTOR HUGO EUSTAQUIO 11721BCC011
    YAGO VINICIUS FERREIRA DE CASTRO 11721BCC020  */ 

-- 1)

select *
from itemped

create or replace function checkquant() 
returns trigger as $$ begin
	raise notice 'numped = %, old_quant = %, new_quant = %', new.numped, old.quant, new.quant;
	raise notice 'valor inserido menor que 0';
return null;
end $$ language 'plpgsql';

create trigger before_quant_update
before insert or update of quant on itemped
for each row when (new.quant < 0)
execute procedure checkquant();


insert into itemped values (300, 22, -666)

-- NOTICE:  numped = 300, old_quant = <NULL>, new_quant = -666
-- NOTICE:  valor inserido menor que 0
-- INSERT 0 0

update itemped set quant = -666 where quant = 229 and codprod = 22 and numped = 300

-- NOTICE:  numped = 300, old_quant = 229, new_quant = -666
-- NOTICE:  valor inserido menor que 0
-- UPDATE 0


select *
from produto


create function checkprod() returns trigger as $$
begin 
	if new.codprod is NULL then 
		raise exception 'codprod nao pode ser null';
	end if;

	if new.valunit <= 0  or  new.valunit is null then 
		raise exception 'valor abaixo do permitido'; 
	end if;
return null;
end $$ language 'plpgsql';


create trigger checkprod before insert or update on produto 
for each row  execute procedure checkprod();


insert into produto values (300,'G','gabriel',0)
-- ERROR:  valor abaixo do permitido
-- CONTEXT:  PL/pgSQL function checkprod() line 8 at RAISE
-- SQL state: P0001

insert into produto values (null,'G','gabriel',0)
-- ERROR:  codprod nao pode ser null
-- CONTEXT:  PL/pgSQL function checkprod() line 4 at RAISE
-- SQL state: P0001

update produto set valunit = -6 where codprod =13
-- ERROR:  valor abaixo do permitido
-- CONTEXT:  PL/pgSQL function checkprod() line 8 at RAISE
-- SQL state: P0001

----------------------------------------------------------------------------------------------------------------------------------------

-- 2a)

create table auditoria_salarios (
	cod_vendedor SMALLINT NOT NULL REFERENCES vendedor(codvend),
	salario_anterior NUMERIC(6,2), 
	salario_atual NUMERIC(6,2), 
	data_alteracao TIMESTAMP,
	CONSTRAINT audipfk PRIMARY KEY (cod_vendedor)
);

create or replace function audit_salario()
returns trigger as $$
begin
	raise notice 'codvend = %, nomevend = %, salfixo =  %,  new salfixo = %' , old.codvend, old.nomevend, old.salfixo, new.salfixo;
	
	if old.faixacomis = 'A' then 
		new.salfixo = old.salfixo * 1.05;
	end if;
	
		if old.faixacomis = 'B' then 
		new.salfixo = old.salfixo * 1.10;
	end if;
	
		if old.faixacomis != 'A' or old.faixacomis != 'B' then 
		new.salfixo = old.salfixo * 1.05;
	end if;
	
	insert into auditoria_salarios (cod_vendedor,salario_anterior, salario_atual, data_alteracao) values (old.codvend, old.salfixo, new.salfixo, '01/01/2000');
	
	new.codvend = old.codvend;
	new.nomevend = old.nomevend;
	return new;
end $$ language 'plpgsql';


create trigger insere_audit_trigger 
after update of salfixo on vendedor
for each row 
execute procedure audit_salario();

create or replace function altera()
returns trigger as $$
begin 
	raise notice 'codvend = %, nomevend = %, salfixo =  %,  new salfixo = %' , old.codvend, old.nomevend, old.salfixo, new.salfixo;
	
	if old.faixacomis = 'A' then 
		new.salfixo = old.salfixo * 1.05;
	end if;
	
		if old.faixacomis = 'B' then 
		new.salfixo = old.salfixo * 1.10;
	end if;
	
		if old.faixacomis != 'A' or old.faixacomis != 'B' then 
		new.salfixo = old.salfixo * 1.05;
	end if;
	
	new.codvend = old.codvend;
	new.nomevend = old.nomevend;
	new.faixacomis = old.faixacomis;
	return new;
end $$ language 'plpgsql';

create trigger altera_salario_trigger
before update of salfixo on vendedor
for each row 
execute procedure altera();

update vendedor
set salfixo = 2780
where codvend = 11;

select * from vendedor

select * from auditoria_salarios

----------------------------------------------------------------------------------------------------------------------------------------

-- 2b)

ALTER TABLE CLIENTE
	ADD TOTALCOMPRAS INTEGER;

SELECT * FROM CLIENTE

CREATE OR REPLACE FUNCTION AtualizaCliente() RETURNS VOID AS $$
DECLARE AUX cliente%rowtype;
BEGIN
	FOR AUX IN SELECT CODCLI FROM CLIENTE
	LOOP
		UPDATE CLIENTE SET TOTALCOMPRAS = (SELECT COUNT(NUMPED) FROM PEDIDO
											WHERE CODCLI = AUX.CODCLI)
		WHERE CODCLI = AUX.CODCLI;
	END LOOP;
END $$ LANGUAGE 'plpgsql';

SELECT * FROM AtualizaCliente()

create or replace function check_() returns trigger as $$
DECLARE AUX record;
begin
	FOR AUX IN SELECT * FROM cliente
	LOOP
		IF NEW.TOTALCOMPRAS != (SELECT COUNT(NUMPED) 
							    FROM PEDIDO
				                WHERE PEDIDO.CODCLI = NEW.CODCLI)
			THEN 
				raise notice 'nao corresponde ao numero real de itens cadastrados';
		END IF;
	END LOOP;
	return NEW;
end $$ language 'plpgsql';

create trigger check_pedido
before insert or update of totalcompras on CLIENTE
FOR STATEMENT
execute procedure check_();

SELECT * FROM CLIENTE

-- o total de compras de 31 e 42 é 0!

update cliente set totalcompras = 310 where codcli = 20
INSERT INTO CLIENTE VALUES (31,'LORENA','RUA ITAGUAÇU, 1074','RIBEIRÃO PRETO','14060030','SP','42424242424242',60)
-- NOTICE:  nao corresponde ao numero real de itens cadastrados
-- INSERT 0 0
INSERT INTO CLIENTE VALUES (42,'LORENA','RUA ITAGUAÇU, 1074','RIBEIRÃO PRETO','14060030','SP','42424242424242',0)
-- INSERT 0 1
update cliente set totalcompras = 10 where codcli = 31
-- NOTICE:  nao corresponde ao numero real de itens cadastrados
-- UPDATE 0


----------------------------------------------------------------------------------------------------------------------------------------

-- 2c)

CREATE OR REPLACE FUNCTION ITENS10()
RETURNS TRIGGER AS $$
BEGIN
	IF (SELECT COUNT(itemped.CODPROD)
			  FROM PEDIDO, ITEMPED
			  WHERE PEDIDO.NUMPED = ITEMPED.NUMPED
			        AND ITEMPED.NUMPED = NEW.NUMPED) >= 10
		THEN
			RAISE NOTICE 'UM PEDIDO NAO PODE CONTER MAIS DO QUE 10 ITENS';
	END IF;
	RETURN NEW;
END $$ LANGUAGE 'plpgsql';

CREATE TRIGGER CHECKNUMITENS
BEFORE INSERT OR UPDATE OF CODPROD ON ITEMPED
FOR EACH ROW
EXECUTE PROCEDURE ITENS10();

SELECT * FROM PEDIDO
SELECT * FROM ITEMPED
SELECT * FROM PRODUTO

INSERT INTO PRODUTO VALUES (79,'KG','ABOBORA',3.99)

INSERT INTO ITEMPED VALUES (300,13,10)
INSERT INTO ITEMPED VALUES (300,30,30)
INSERT INTO ITEMPED VALUES (300,78,20)
INSERT INTO ITEMPED VALUES (300,79,100)
-- NOTICE:  UM PEDIDO NAO PODE CONTER MAIS DO QUE 10 ITENS