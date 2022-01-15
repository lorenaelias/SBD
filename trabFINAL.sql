create schema pizzaria;

set search_path to pizzaria;

create table Pessoa(

	CPF varchar(15),
	Data_Nasc date,
	Nome varchar(50),
	Endereco varchar(50),
	Constraint PessoaPK primary key(CPF)

);

create table Dono_De_Negocio(
	
	CPF varchar(15),
	LinkedIn varchar(30),
	Constraint DonoPK primary key(CPF),
	Constraint DonoFK foreign key (CPF)
		References Pessoa 
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

create table Consumidor_Faminto(

	CPF varchar(15),
	Endereco_Entrega varchar(50),
	Constraint ConsumidorPK primary key (CPF),
	Constraint ConsumidorFK foreign key (CPF)
		References Pessoa(CPF)
		ON UPDATE CASCADE
		ON DELETE CASCADE

);

create table Animador(

	CPF varchar(15),
	Nome_Artistico varchar(50),
	Biografia varchar(500),
	Preco float,
	Constraint AnimadorPK primary key (CPF),
	Constraint AnimadorfK foreign key (CPF)	
		References Pessoa(CPF)
		ON UPDATE CASCADE
		ON DELETE CASCADE

);


create table Pedido_Normal(

	Ident varchar(10),
	CPF_Consumidor varchar(15),
	Hora time,
	Data_ date,
	Hora_entrega time,
	Qtd_Pessoas smallint,
	Custo_Total float,
	Constraint Pedido_NormalPK primary key (ident),
	Constraint Pedido_NormalFK foreign key (CPF_Consumidor)
		References Consumidor_Faminto(CPF)
		ON UPDATE CASCADE
		ON DELETE CASCADE

);

create table Pedido_Especial(

	Ident varchar(15),
	CPF_Animador varchar(15),
	Duracao time,
	Tipo varchar(30),
	Constraint EspecialPK primary key (Ident),
	
	Constraint EspecialFK1 foreign key (Ident)
		REFERENCES PEDIDO_NORMAL(Ident)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
		foreign key (CPF_Animador)
		References Animador(CPF)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);


create table Pizzaria(

	Nome varchar(20),
	CPF_Dono varchar(15),
	CEP varchar(15),
	Site varchar(50),
	Fone varchar(15),
	Endereco varchar(50),
	Hora_Abertura time,
	Hora_Fechamento time,
	Constraint PizzariaPK primary key (Nome),
	Constraint PizzariaFK foreign key (CPF_Dono)
		References Dono_De_Negocio(CPF)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);


create table Acompanhamento(

	Cod varchar(5),
	Nome_PIZZARIA varchar(20),
	NomeAcompanhamento varchar(20),
	Tipo varchar(10),
	Preco float,
	Descricao varchar(50),
	Constraint AcompanhaPK primary key (Cod,Nome_PIZZARIA),
	Constraint AcompanhaFK foreign key (Nome_PIZZARIA)
		References Pizzaria(Nome)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

create table Contratacao(

	Nome varchar(50),
	CPF varchar(15),
	Dispo varchar(15),
	Constraint ContrataPK primary key (Nome,CPF),
	Constraint ContrataFK1 foreign key (Nome)
		References Pizzaria (Nome)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	foreign key (CPF)
		References Animador (CPF)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE CATEGORIA(
	COD VARCHAR(20),
	DESCRICAO VARCHAR(50),
	COD_SUPER VARCHAR(20),
	CONSTRAINT CATEGPK PRIMARY KEY (COD),
	CONSTRAINT CATEGFK FOREIGN KEY (COD_SUPER)
		REFERENCES CATEGORIA (COD)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

create table PIZZA(
	Nome_pizza varchar(20),
	Nome varchar(20),
	COD varchar(20),
	preco float,
	CONSTRAINT PIZZAPK PRIMARY KEY (NOME_PIZZA,NOME),
	CONSTRAINT PIZZAFK FOREIGN KEY (NOME)
		REFERENCES PIZZARIA (NOME)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (COD)
		REFERENCES CATEGORIA (COD)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);


CREATE TABLE INGREDIENTE_EXTRA(
	COD VARCHAR(20),
	NOME VARCHAR(20),
	PRECO FLOAT,
	CONSTRAINT INGEXPK PRIMARY KEY (COD)
);

create table Pizza_Pedido(

	Ident varchar(15),
	Nome_Pizza varchar(20),
	Nome varchar(20),
	Massa varchar(20),
	Borda varchar(20),
	Molho varchar(20),
	Constraint Pizzape_PK primary key (Ident, Nome_Pizza, Nome),
	Constraint Pizzape_FK1 foreign key (Nome_Pizza, Nome)
		References Pizza(Nome_Pizza, Nome)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	foreign key (Ident)
		References Pedido_NORMAL(Ident)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE EXTRA_PEDIDO(
	IDENT VARCHAR(15),
	NOME_PIZZA VARCHAR(20),
	NOME VARCHAR(20),
	COD VARCHAR(20),
	CONSTRAINT EXTRAPEPK PRIMARY KEY (IDENT,NOME_PIZZA,NOME,COD),
	CONSTRAINT EXTRAPEFK1 FOREIGN KEY (IDENT,NOME_PIZZA,NOME)
		REFERENCES PIZZA_PEDIDO (IDENT,NOME_PIZZA,NOME)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (COD)
		REFERENCES INGREDIENTE_EXTRA(COD)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE PEDIDO_ACOMPANHAMENTO(
	IDENT VARCHAR(20),
	COD VARCHAR(20),
	NOME_ACOMP VARCHAR(20),
	NOME_PIZZARIA VARCHAR(20),
	QUANT INTEGER,
	CONSTRAINT PEACOMPPK PRIMARY KEY (IDENT,COD,NOME_PIZZARIA),
	CONSTRAINT PEACOMPFK1 FOREIGN KEY (COD,NOME_PIZZARIA)
		REFERENCES ACOMPANHAMENTO (COD,NOME_PIZZARIA)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (Ident)
		REFERENCES PEDIDO_NORMAL(Ident)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);



--INSERÇÕES
--pessoa (30/30) 
INSERT INTO PESSOA VALUES ('664.633.430-72','1950/07/25','LORENA ELIAS','RUA ITAGUACU, 1074');
INSERT INTO PESSOA VALUES ('300.180.960-42','1970/03/03','YAGO DE CASTRO','RUA DAS AVENCAS, 442');
INSERT INTO PESSOA VALUES ('330.045.080-28','1975/12/25','RICARDO ZAMBONI','RUA ACRE, 336');
INSERT INTO PESSOA VALUES ('896.582.210-68','1965/10/11','RONALDO TEIXEIRA','RUA AMAZONA, 456');
INSERT INTO PESSOA VALUES ('825.359.720-77','2000/01/01','JOAO NEVES','RUA JOAQUIM, 342');
INSERT INTO PESSOA VALUES ('393.295.430-06','1998/06/27','LARA MENDES','AV JOAO NAVES, 4444');
INSERT INTO PESSOA VALUES ('175.011.500-01','1998/11/16','VICTOR HUGO EUSTAQUIO','AV SEGISMUNDO, 1111');
INSERT INTO PESSOA VALUES ('407.601.740-40','1989/08/06','BRENO CALDEIRA','AV DO CONTORNO, 126');
INSERT INTO PESSOA VALUES ('305.655.970-78','1994/09/14','JULIA BIASI','RUA DOS COLIBRIS, 555');
INSERT INTO PESSOA VALUES ('764.192.800-52','2001/09/11','ALEX GARCIA','RUA CERQUEIRA CESAR, 222');
INSERT INTO PESSOA VALUES ('802.508.730-10','1980/06/24','BRUNO OLIVEIRA','AV CESAR FINOTTI, 550');
INSERT INTO PESSOA VALUES ('498.854.810-44','1990/04/14','LUCAS SANTOS PORTUGAL','RUA TIRADENTES, 789');
INSERT INTO PESSOA VALUES ('384.393.570-01','1990/08/11','LUIZ OTAVIO','RUA DAS ACACIAS, 666');
INSERT INTO PESSOA VALUES ('647.321.390-27','1994/04/06','ALEX SILVA','RUA DA BALBURDIA, 624');
INSERT INTO PESSOA VALUES ('334.429.220-03','1971/01/01','PEDRO MARMELO SILVA','RUA DA BALBURDIA, 532');
INSERT INTO PESSOA VALUES ('509.492.370-60','1972/02/02','PEDRO BARBOSA','RUA DOS BOBOS, 0');
INSERT INTO PESSOA VALUES ('145.114.170-08','1974/04/04','PEDRO MARMOTA','RUA DOS ROEDORES, 2630');
INSERT INTO PESSOA VALUES ('064.592.070-38','1976/06/06','JOAO VITOR BARBOSA','RUA DAS BRUMAS, 2511');
INSERT INTO PESSOA VALUES ('419.181.440-01','1978/08/08','JOAO VICTOR BARMI','RUA DA BALBURDIA, 6327');
INSERT INTO PESSOA VALUES ('401.160.680-43','1980/10/10','LUCAS MENDES','RUA DAS ACACIAS, 999');
INSERT INTO PESSOA VALUES ('921.571.070-10','1982/12/12','LUCAS MOMENTI','RUA DAS TULIPAS, 756');
INSERT INTO PESSOA VALUES ('001.217.070-40','1973/03/03','LUCAS GABRIEL ANDRADE','RUA DA CONCORDIA, 682');
INSERT INTO PESSOA VALUES ('094.867.270-66','1975/05/05','FABIO ANDRADE','RUA DA CONCORDIA, 682');
INSERT INTO PESSOA VALUES ('193.548.610-16','1977/07/07','MATHEUS ARDUINO','AV THAILANDIA, 3574');
INSERT INTO PESSOA VALUES ('781.656.170-95','1979/09/09','MATHEUS ALCANTRA','AV BRASIL, 456');
INSERT INTO PESSOA VALUES ('461.107.490-01','1981/11/11','TARCISIO LIMA','RUA DAS TULIPAS, 251');
INSERT INTO PESSOA VALUES ('899.380.870-86','1991/01/11','JORGE LUIZ','RUA DAS ORQUIDIAS, 444');
INSERT INTO PESSOA VALUES ('715.797.080-56','1993/03/03','LUIZ JORGE','RUA DAS ORQUIDIAS, 444');
INSERT INTO PESSOA VALUES ('121.260.860-70','1995/05/05','YGOR CASTRO','RUA CARAMELO, 123');
INSERT INTO PESSOA VALUES ('778.650.300-53','1997/07/07','MIGUEL CASPIM','RUA COLISEU, 1253');


--dono de negocio (10/10) --YAGO
INSERT INTO DONO_DE_NEGOCIO VALUES ('896.582.210-68','ronaldo-teixeira-135326753');
INSERT INTO DONO_DE_NEGOCIO VALUES ('664.633.430-72','lorena-elias-032339165');
INSERT INTO DONO_DE_NEGOCIO VALUES ('330.045.080-28','ricardo-zamboni-123431245');
INSERT INTO DONO_DE_NEGOCIO VALUES ('300.180.960-42','yago-de-castro-135357438');
INSERT INTO DONO_DE_NEGOCIO VALUES ('334.429.220-03','pedro-marmelo-silva-354862579');
INSERT INTO DONO_DE_NEGOCIO VALUES ('509.492.370-60','pedro-barbosa-369854721');
INSERT INTO DONO_DE_NEGOCIO VALUES ('145.114.170-08','pedro-marmota-657321489');
INSERT INTO DONO_DE_NEGOCIO VALUES ('064.592.070-38','joao-vitor-barbosa-842679310');
INSERT INTO DONO_DE_NEGOCIO VALUES ('419.181.440-01','joao-victor-barmi-542687931');
INSERT INTO DONO_DE_NEGOCIO VALUES ('401.160.680-43','lucas-mendes-014785692');

--consumidor faminto (10/10) 
INSERT INTO  CONSUMIDOR_FAMINTO VALUES ('825.359.720-77','RUA DAS ARAUCARIAS, 123');
INSERT INTO  CONSUMIDOR_FAMINTO VALUES ('393.295.430-06','AV JOAO NAVES, 555');
INSERT INTO  CONSUMIDOR_FAMINTO VALUES ('407.601.740-40','RUA DAS ACACIAS, 1432');
INSERT INTO  CONSUMIDOR_FAMINTO VALUES ('305.655.970-78','RUA DA BANDEIRA 3121');
INSERT INTO  CONSUMIDOR_FAMINTO VALUES ('384.393.570-01','RUA DAS ACACIAS, 666');
INSERT INTO  CONSUMIDOR_FAMINTO VALUES ('647.321.390-27','RUA DA BALBURDIA, 624');
INSERT INTO  CONSUMIDOR_FAMINTO VALUES ('921.571.070-10','RUA DAS TULIPAS, 756');
INSERT INTO  CONSUMIDOR_FAMINTO VALUES ('001.217.070-40','RUA DA CONCORDIA, 682');
INSERT INTO  CONSUMIDOR_FAMINTO VALUES ('094.867.270-66','RUA DA CONCORDIA, 682');
INSERT INTO  CONSUMIDOR_FAMINTO VALUES ('193.548.610-16','AV THAILANDIA, 3574');

--animador (10/10) --YAGO
INSERT INTO ANIMADOR VALUES ('175.011.500-01','PRINCE','Faço cover do cantor Prince', 100);
INSERT INTO ANIMADOR VALUES ('764.192.800-52','PALHACITOS','Sou engraçado haha', 70);
INSERT INTO ANIMADOR VALUES ('802.508.730-10','MAICOL JEQUISON','Faço cover do cantor Michael Jackson',150);
INSERT INTO ANIMADOR VALUES ('498.854.810-44','MALABARISTA CALIENTE','Faço malabarismo com pinos de boliche em chamas',200);
INSERT INTO ANIMADOR VALUES('781.656.170-95','ELVIS PRESLEY','Faco cover do artistica Elvis Presley', 90);
INSERT INTO ANIMADOR VALUES('461.107.490-01','POPEYE','Sou um fisiculturista que imita o personagem Popeye', 95);
INSERT INTO ANIMADOR VALUES('899.380.870-86','MALABAR FAQUITO','Faco malabarismo com facas e objetos pontiagudos',125);
INSERT INTO ANIMADOR VALUES('715.797.080-56','PICASSO GENERICO','Faco uma pintura dos clientes');
INSERT INTO ANIMADOR VALUES('121.260.860-70','NEYMAR DO FREESTYLE','Faco truques de freestyle com uma bola de futebol');
INSERT INTO ANIMADOR VALUES('778.650.300-53','MARCOS PIADISTA','Faco um show de standup para os clientes');


--pedido normal (20/20) 
INSERT INTO PEDIDO_NORMAL VALUES ('111','825.359.720-77','19:50','2019/07/01','20:30',3,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('112','393.295.430-06','19:30','2019/07/01','20:00',4,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('113','407.601.740-40','19:10','2019/07/01','20:00',2,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('114','305.655.970-78','17:00','2019/07/01','17:30',3,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('115','384.393.570-01','19:00','2019/07/01','19:30',5,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('116','647.321.390-27','21:00','2019/07/02','21:30',1,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('117','921.571.070-10','21:05','2019/07/02','21:30',2,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('118','001.217.070-40','21:40','2019/07/02','22:30',3,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('119','001.217.070-40','21:55','2019/07/02','22:30',3,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('120','094.867.270-66','22:12','2019/07/02','23:00',2,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('121','193.548.610-16','19:13','2019/07/03','20:00',1,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('122','193.548.610-16','20:15','2019/07/03','21:00',2,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('123','825.359.720-77','19:18','2019/07/03','20:00',1,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('124','407.601.740-40','19:13','2019/07/03','20:00',3,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('125','393.295.430-06','20:11','2019/07/04','21:00',2,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('126','921.571.070-10','20:23','2019/07/04','21:00',1,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('127','384.393.570-01','21:13','2019/07/04','22:00',2,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('128','305.655.970-78','21:25','2019/07/04','22:00',1,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('129','647.321.390-27','22:43','2019/07/04','23:30',1,NULL);
INSERT INTO PEDIDO_NORMAL VALUES ('130','094.867.270-66','22:50','2019/07/04','23:30',3,NULL);

--pedido especial(10/10)  -LOLA 
INSERT INTO PEDIDO_ESPECIAL VALUES('111','498.854.810-44','00:30','MALABARISMO');
INSERT INTO PEDIDO_ESPECIAL VALUES('114','802.508.730-10','01:00','MUSICAL');
INSERT INTO PEDIDO_ESPECIAL VALUES ('115','175.011.500-01','00:30','MUSICAL');
INSERT INTO PEDIDO_ESPECIAL VALUES ('116','498.854.810-44','01:30','MALABARISMO');
INSERT INTO PEDIDO_ESPECIAL VALUES ('118','764.192.800-52','00:30','PALHAÇO');
INSERT INTO PEDIDO_ESPECIAL VALUES ('120','461.107.490-01','00:30','MÍMICA');
INSERT INTO PEDIDO_ESPECIAL VALUES ('121','715.797.080-56','02:00','PINTURA');
INSERT INTO PEDIDO_ESPECIAL VALUES ('123','121.260.860-70','00:30','MÁGICA');
INSERT INTO PEDIDO_ESPECIAL VALUES ('124','778.650.300-53','01:00','STANDUP');
INSERT INTO PEDIDO_ESPECIAL VALUES ('127','899.380.870-86','00:30','MALABARISMO');

--pizzaria (10/10) -LOLA 
INSERT INTO PIZZARIA VALUES('PIZZAIOLO','896.582.210-68','38408-168','WWW.PIZZAIOLO.COM.BR',' 0800 940 0940',' Av.Belarmino Cotta Pacheco, 645',' 18:00','00:00');
INSERT INTO PIZZARIA VALUES('DISK PIZZA','664.633.430-72','38408-140','WWW.DISKPIZZA.COM.BR',' 3231-0770',' R. José Paes de Almeida, 234',' 17:00','23:30');
INSERT INTO PIZZARIA VALUES('PIZZA DA VOVO','330.045.080-28','38400-426','WWW.PIZZADAVOVO.COM.BR','3210-7079',' Av. Dr. Laérte Viêira Gonçalves',' 18:00','00:00');
INSERT INTO PIZZARIA VALUES('NONA','300.180.960-42','38408-176','WWW.PIZZANONA.COM.BR','3214-9150',' Av. Dr. Laérte Viêira Gonçalves, 1346',' 17:00','23:30');
INSERT INTO PIZZARIA VALUES('FOME ZERO','334.429.220-03','30550-600','WWW.FOMEZEROPIZZAS.COM.BR','3211-9110',' Av. dos Reis, 132',' 18:00','00:00');
INSERT INTO PIZZARIA VALUES('PIZZANDO','509.492.370-60','33065-430','WWW.PIZZANDO.COM.BR','3312-4312',' R. do Almirante, 1234',' 18:30','00:00');
INSERT INTO PIZZARIA VALUES('UAI PIZZAS','145.114.170-08','35553-043','WWW.UAIPIZZAS.COM.BR','3653-2352',' R. São José, 1035',' 18:30','23:30');
INSERT INTO PIZZARIA VALUES('LIGA LÁ','064.592.070-38','33054-64','WWW.LIGALAPIZZA.COM.BR','3387-6534',' Av. Rio Pardo, 1362',' 18:00','01:00');
INSERT INTO PIZZARIA VALUES('BORDA DA CIDADE','419.181.440-01','37048-047','WWW.BORDADACIDADE.COM.BR','3446-3212',' R. Acre, 146',' 19:00','01:00');
INSERT INTO PIZZARIA VALUES('MA CHE PIZZA','401.160.680-43','33440-525','WWW.MACHEPIZZA.COM.BR','3313-5069',' Av. Dom Pedro, 1400',' 18:00','23:30');


--acompanhamento (16/10)
INSERT INTO ACOMPANHAMENTO VALUES('01','PIZZAIOLO','MAIONESE','CONDIMENTO',0.50,'UMA UNIDADE DE SACHE DE MAIONESE');
INSERT INTO ACOMPANHAMENTO VALUES('01','DISK PIZZA','MAIONESE','CONDIMENTO',0.75,'UMA UNIDADE DE SACHE DE MAIONESE');
INSERT INTO ACOMPANHAMENTO VALUES('01','PIZZA DA VOVO','MAIONESE','CONDIMENTO',0.20,'UMA UNIDADE DE SACHE DE MAIONESE');
INSERT INTO ACOMPANHAMENTO VALUES('01','NONA','MAIONESE','CONDIMENTO',1.00,'UMA UNIDADE DE SACHE DE MAIONESE');
INSERT INTO ACOMPANHAMENTO VALUES('02','PIZZAIOLO','COCA-COLA','BEBIDA',8.00,'UMA UNIDADE DE COCA-COLA DE 2 LITROS');
INSERT INTO ACOMPANHAMENTO VALUES('02','DISK PIZZA','COCA-COLA','BEBIDA',5.00,'UMA UNIDADE DE COCA-COLA DE 2 LITROS');
INSERT INTO ACOMPANHAMENTO VALUES('02','PIZZA DA VOVO','COCA-COLA','BEBIDA',10.00,'UMA UNIDADE DE COCA-COLA DE 2 LITROS');
INSERT INTO ACOMPANHAMENTO VALUES('02','NONA','COCA-COLA','BEBIDA',7.00,'UMA UNIDADE DE COCA-COLA DE 2 LITROS');
INSERT INTO ACOMPANHAMENTO VALUES('03','PIZZAIOLO','KETCHUP','CONDIMENTO',0.50,'UMA UNIDADE DE SACHE DE KETCHUP');
INSERT INTO ACOMPANHAMENTO VALUES('03','DISK PIZZA','KETCHUP','CONDIMENTO',0.75,'UMA UNIDADE DE SACHE DE KETCHUP');
INSERT INTO ACOMPANHAMENTO VALUES('03','PIZZA DA VOVO','KETCHUP','CONDIMENTO',0.20,'UMA UNIDADE DE SACHE DE KETCHUP');
INSERT INTO ACOMPANHAMENTO VALUES('03','NONA','KETCHUP','CONDIMENTO',1.00,'UMA UNIDADE DE SACHE DE KETCHUP');
INSERT INTO ACOMPANHAMENTO VALUES('04','PIZZAIOLO','BRAHMA','BEBIDA',3.00,'UMA UNIDADE DE BRAHMA 350ml');
INSERT INTO ACOMPANHAMENTO VALUES('04','DISK PIZZA','SKOL','BEBIDA',2.50,'UMA UNIDADE DE SKOL 350ml');
INSERT INTO ACOMPANHAMENTO VALUES('04','PIZZA DA VOVO','HEINEKEN','BEBIDA',4.00,'UMA UNIDADE DE HEINEKEN 350ml');
INSERT INTO ACOMPANHAMENTO VALUES('04','NONA','BUDWEISER','BEBIDA',5.00,'UMA UNIDADE DE BUDWEISER 350ml');

--contratacao (10/10) 
INSERT INTO CONTRATACAO VALUES ('PIZZAIOLO','175.011.500-01','SEG/TER/QUA');
INSERT INTO CONTRATACAO VALUES ('PIZZAIOLO','764.192.800-52','QUI/SEX/SAB');
INSERT INTO CONTRATACAO VALUES ('DISK PIZZA','764.192.800-52','SEG/TER/QUA');
INSERT INTO CONTRATACAO VALUES ('DISK PIZZA','175.011.500-01','QUI/SEX/SAB');
INSERT INTO CONTRATACAO VALUES ('PIZZA DA VOVO','802.508.730-10','SEG/TER/QUA');
INSERT INTO CONTRATACAO VALUES ('PIZZA DA VOVO','498.854.810-44','QUI/SEX/DOM');
INSERT INTO CONTRATACAO VALUES ('NONA','802.508.730-10','QUI/SEX/SAB');
INSERT INTO CONTRATACAO VALUES ('NONA','498.854.810-44','SEG/TER/QUA');
INSERT INTO CONTRATACAO VALUES ('PIZZAIOLO','121.260.860-70','SEG/TER/QUA');
INSERT INTO CONTRATACAO VALUES ('DISK PIZZA','121.260.860-70','QUI/SEX/SAB');

--categoria (10/10)
INSERT INTO CATEGORIA VALUES ('1','PIZZA SALGADA',NULL);
INSERT INTO CATEGORIA VALUES ('2','PIZZA DOCE',NULL);
INSERT INTO CATEGORIA VALUES ('3','TRADICIONAL','1');
INSERT INTO CATEGORIA VALUES ('4','ESPECIAL','1');
INSERT INTO CATEGORIA VALUES ('5','NOVAS','1');
INSERT INTO CATEGORIA VALUES ('6','NOVAS','2');
INSERT INTO CATEGORIA VALUES ('7','PROMOCAO','3');
INSERT INTO CATEGORIA VALUES ('8','PROMOCAO','4');
INSERT INTO CATEGORIA VALUES ('9','VEGETARIANA','1');
INSERT INTO CATEGORIA VALUES ('10','VEGETARIANA','2');

--pizza (16/10) 
INSERT INTO PIZZA VALUES ('CALABRESA','NONA','3',19.99);
INSERT INTO PIZZA VALUES ('MODA DA CASA','PIZZA DA VOVO','3',24.90);
INSERT INTO PIZZA VALUES ('PEPPERONI','PIZZAIOLO','4',49.99);
INSERT INTO PIZZA VALUES ('PEPPERONI','DISK PIZZA','4',49.99);
INSERT INTO PIZZA VALUES ('CACHORRO QUENTE','NONA',26.50);
INSERT INTO PIZZA VALUES ('QUATRO QUEIJOS','NONA',24.60);
INSERT INTO PIZZA VALUES ('QUATRO QUEIJOS','PIZZA DA VOVO',26.60);
INSERT INTO PIZZA VALUES ('QUATRO QUEIJOS','PIZZAIOLO',49.99);
INSERT INTO PIZZA VALUES ('BROCOLIS','NONA',25.60);
INSERT INTO PIZZA VALUES ('BROCOLIS','PIZZA DA VOVO',26.60);
INSERT INTO PIZZA VALUES ('BROCOLIS','DISK PIZZA',49.99);
INSERT INTO PIZZA VALUES ('SORVETE','NONA',25.90);
INSERT INTO PIZZA VALUES ('SORVETE','DISK PIZZA',59.99);
INSERT INTO PIZZA VALUES ('CASADINHO','PIZZA DA VOVO',26.99);
INSERT INTO PIZZA VALUES ('BEIJINHO','PIZZAIOLO',59.90);
INSERT INTO PIZZA VALUES ('BEIJINHO','NONA',25.90);

--Ingredientes Extra (10/10)
INSERT INTO INGREDIENTE_EXTRA VALUES('0001','CATUPIRY',3.00);
INSERT INTO INGREDIENTE_EXTRA VALUES('0010','TOMATE SECO',2.00);
INSERT INTO INGREDIENTE_EXTRA VALUES('0011','COGUMELOS CHAMPIGNON',4.00);
INSERT INTO INGREDIENTE_EXTRA VALUES('0100','BATATA PALHA',1.50);
INSERT INTO INGREDIENTE_EXTRA VALUES('0101','BACON',2.55);
INSERT INTO INGREDIENTE_EXTRA VALUES('0110','CEBOLA',1.00);
INSERT INTO INGREDIENTE_EXTRA VALUES('0111','CEBOLA ROXA',1.35);
INSERT INTO INGREDIENTE_EXTRA VALUES('1000','PALMITO',2.00);
INSERT INTO INGREDIENTE_EXTRA VALUES('1001','MILHO',1.00);
INSERT INTO INGREDIENTE_EXTRA VALUES('1010','ERVILHA',1.00);

--Pizza Pedido (10/10)
INSERT INTO PIZZA_PEDIDO VALUES ('111','CACHORRO QUENTE','NONA','MEDIA','NORMAL','NORMAL');
INSERT INTO PIZZA_PEDIDO VALUES ('112','CALABRESA','NONA','FINA','NORMAL','NORMAL');
INSERT INTO PIZZA_PEDIDO VALUES ('113','MODA DA CASA','PIZZA DA VOVO','GROSSA','NORMAL','EXTRA');
INSERT INTO PIZZA_PEDIDO VALUES ('114','MODA DA CASA','PIZZA DA VOVO','MEDIA','NORMAL','POUCO');
INSERT INTO PIZZA_PEDIDO VALUES ('115','PEPPERONI','PIZZAIOLO','GROSSA','RECHEADA C CATUPIRY','POUCO');
INSERT INTO PIZZA_PEDIDO VALUES ('116','MODA DA CASA','PIZZA DA VOVO','MEDIA','NORMAL','EXTRA');
INSERT INTO PIZZA_PEDIDO VALUES ('117','PEPPERONI','DISK PIZZA','GROSSA','RECHEADA C CATUPIRY','NORMAL');
INSERT INTO PIZZA_PEDIDO VALUES ('118','BEIJINHO','PIZZAIOLO','FINA','NORMAL','NORMAL');
INSERT INTO PIZZA_PEDIDO VALUES ('119','BROCOLIS','DISK PIZZA','NORMAL','NORMAL','EXTRA');
INSERT INTO PIZZA_PEDIDO VALUES ('120','SORVETE','NONA','NORMAL','NORMAL','NORMAL');
INSERT INTO PIZZA_PEDIDO VALUES ('121','CASADINHO','PIZZA DA VOVO','NORMAL','NORMAL','NORMAL');

--Extra Pedido (10/10) 
INSERT INTO EXTRA_PEDIDO VALUES('111','CACHORRO QUENTE','NONA','0001');
INSERT INTO EXTRA_PEDIDO VALUES('112','CALABRESA','NONA','0010');
INSERT INTO EXTRA_PEDIDO VALUES('113','MODA DA CASA','PIZZA DA VOVO','0011');
INSERT INTO EXTRA_PEDIDO VALUES('114','MODA DA CASA','PIZZA DA VOVO','0100');
INSERT INTO EXTRA_PEDIDO VALUES('115','PEPPERONI','PIZZAIOLO','0101');
INSERT INTO EXTRA_PEDIDO VALUES('116','MODA DA CASA','PIZZA DA VOVO','0110');
INSERT INTO EXTRA_PEDIDO VALUES('117','PEPPERONI','DISK PIZZA','0111');
INSERT INTO EXTRA_PEDIDO VALUES('119','BROCOLIS','DISK PIZZA','1000');
INSERT INTO EXTRA_PEDIDO VALUES('113','MODA DA CASA','PIZZA DA VOVO','1001');
INSERT INTO EXTRA_PEDIDO VALUES('115','PEPPERONI','PIZZAIOLO','1010');

--Pedido_Acompanhamento (10/10)
INSERT INTO PEDIDO_ACOMPANHAMENTO VALUES ('111','01','MAIONESE','NONA',4);
INSERT INTO PEDIDO_ACOMPANHAMENTO VALUES ('111','02','COCA-COLA','NONA',1);
INSERT INTO PEDIDO_ACOMPANHAMENTO VALUES ('114','02','COCA-COLA','PIZZAIOLO',2);
INSERT INTO PEDIDO_ACOMPANHAMENTO VALUES ('114','01','MAIONESE','PIZZAIOLO',8);
INSERT INTO PEDIDO_ACOMPANHAMENTO VALUES ('116','03','KETCHUP','DISK PIZZA',10);
INSERT INTO PEDIDO_ACOMPANHAMENTO VALUES ('116','04','SKOL','DISK PIZZA',6);
INSERT INTO PEDIDO_ACOMPANHAMENTO VALUES ('111','04','HEINEKEN','NONA',12);
INSERT INTO PEDIDO_ACOMPANHAMENTO VALUES ('113','02','COCA-COLA','PIZZA DA VOVO',2);
INSERT INTO PEDIDO_ACOMPANHAMENTO VALUES ('112','02','COCA-COLA','PIZZA DA VOVO',1);
INSERT INTO PEDIDO_ACOMPANHAMENTO VALUES ('115','02','COCA-COLA','PIZZA DA VOVO',5);


--BUSCAS (8/10 pensadas) (0/10 concluidas)

--1) NOME DOS TRES USUARIOS QUE MAIS GASTAM NO APP

--2) MEDIA DE PREÇO DAS PIZZAS DE CADA PIZZARIA E DE TODAS AS PIZZARIAS JÁ CADASTRADAS

SELECT COALESCE(PIZZARIA.NOME, 'Todas as pizzarias') AS Pizzarias, AVG(PIZZA.PRECO) AS Medias_Pizzarias
FROM PIZZA,PIZZARIA
WHERE PIZZA.NOME = PIZZARIA.NOME
GROUP BY 
	ROLLUP (PIZZARIA.NOME)

--3) NRO DE PIZZAS VENDIDAS NO DIA 05/07/2019 POR CADA PIZZARIA

SELECT PIZZARIA.NOME, COUNT(PIZZA_PEDIDO.IDENT)
FROM PIZZARIA INNER JOIN (PIZZA_PEDIDO INNER JOIN PEDIDO_NORMAL 
						 	 ON (PIZZA_PEDIDO.IDENT = PEDIDO_NORMAL.IDENT)) 
						  			ON (PIZZARIA.NOME = PIZZA_PEDIDO.NOME AND PEDIDO_NORMAL.DATA_ = '2019/07/05') 
GROUP BY PIZZARIA.NOME

--4) QUANTO CADA PIZZARIA ARRECADOU NO MES 06/2019
--PRECISA DO TOTAL PARA CONTINUAR
-- SELECT PIZZARIA.NOME
-- FROM PIZZARIA INNER JOIN PIZZA_PEDIDO ON PIZZARIA.NOME = PIZZA_PEDIDO.NOME
-- WHERE PIZZA_PEDIDO.DA

--5) QUAL A PIZZA MAIS VENDIDA POR CADA PIZZARIA NO MES ATUAL
-- SELECT NOME_PIZZA, NOME 
-- FROM PIZZA
-- GROUP BY NOME_PIZZA
-- HAVING SUM(NOME_PIZZA) > (SELECT --RESTO)

--6) ANIMADOR QUE MAIS ATENDEU NO MES ATUAL
SELECT NOME_ARTISTICO
FROM ANIMADOR INNER JOIN(PEDIDO_ESPECIAL INNER JOIN PEDIDO_NORMAL ON PEDIDO_ESPECIAL.IDENT = PEDIDO_NORMAL.IDENT)
							ON ANIMADOR.CPF = PEDIDO_ESPECIAL.CPF_ANIMADOR
WHERE PEDIDO_NORMAL.DATA_ >= '2019/07/01' AND PEDIDO_NORMAL.DATA_ < '2019/08/01'
GROUP BY NOME_ARTISTICO
HAVING COUNT(NOME_ARTISTICO) >= ALL(SELECT COUNT(NOME_ARTISTICO)
								 FROM ANIMADOR INNER JOIN(PEDIDO_ESPECIAL INNER JOIN PEDIDO_NORMAL ON PEDIDO_ESPECIAL.IDENT = PEDIDO_NORMAL.IDENT)
																ON ANIMADOR.CPF = PEDIDO_ESPECIAL.CPF_ANIMADOR
								 WHERE PEDIDO_NORMAL.DATA_ >= '2019/07/01' AND PEDIDO_NORMAL.DATA_ < '2019/08/01'
								 GROUP BY NOME_ARTISTICO)

--7) QUANTO CADA PIZZARIA VENDEU DE PIZZAS E QUANTO TODAS AS PIZZARIAS VENDEM AO TOTAL DE PIZZAS NO MES ATUAL

SELECT COUNT(PIZZA_PEDIDO.IDENT) AS Quantidade_Pizzas, COALESCE(PIZZARIA.NOME, 'TODAS AS PIZZARIAS') AS PIZZARIAS
FROM PIZZARIA INNER JOIN(PIZZA_PEDIDO INNER JOIN PEDIDO_NORMAL ON PIZZA_PEDIDO.IDENT = PEDIDO_NORMAL.IDENT)
							ON PIZZARIA.NOME = PIZZA_PEDIDO.NOME
WHERE PEDIDO_NORMAL.DATA_ >= '2019/07/01' AND PEDIDO_NORMAL.DATA_ < '2019/08/01' 
GROUP BY ROLLUP(PIZZARIA.NOME)

--8)
 		--8a) NRO DE PESSOAS COM 18 A 30 ANOS QUE PEDEM PIZZA COM ENTRETENIMENTO
			SELECT COUNT(PESSOA.CPF)  AS QUANTIDADE
			FROM PESSOA INNER JOIN (PEDIDO_NORMAL INNER JOIN PEDIDO_ESPECIAL ON PEDIDO_NORMAL.IDENT = PEDIDO_ESPECIAL.IDENT) 
							ON PESSOA.CPF = PEDIDO_NORMAL.CPF_CONSUMIDOR
			WHERE PESSOA.DATA_NASC >= '1989/01/01' AND PESSOA.DATA_NASC < '2001/01/01'

		--8b) NRO DE PESSOAS COM MAIS DO QUE 30 ANOS QUE PEDEM PIZZA COM ENTRETENIMENTO ** PRECISO DE MAIS INSERCOES PARA CHECAR
			SELECT COUNT(PESSOA.CPF) AS QUANTIDADE
			FROM PESSOA INNER JOIN (PEDIDO_NORMAL INNER JOIN PEDIDO_ESPECIAL ON PEDIDO_NORMAL.IDENT = PEDIDO_ESPECIAL.IDENT) 
							ON PESSOA.CPF = PEDIDO_NORMAL.CPF_CONSUMIDOR 
			WHERE PESSOA.DATA_NASC <= '1988/01/01' 
--9) 

--10)


--TRIGGERS (1 JA ESPECIFICADO E 1 DEVE SER CRIADO DO ZERO) OBS: AQUI JA VAI ESTAR O PROCEDIMENTO ARMAZENADO

--ESPECIFICADO (ATUALIZACAO DO VALOR DE TOTAL PEDIDO)

--CRIADO(VALIDAR O CPF)



--TRIGGERS (1 JA ESPECIFICADO E 1 DEVE SER CRIADO DO ZERO) -->  EXPLICACOES

--ESPECIFICADO (ATUALIZACAO DO VALOR DE TOTAL PEDIDO) --> Explicacao:

--CRIADO(VALIDAR O CPF) --> Explicacao:

CREATE OR REPLACE FUNCTION validarCPF() RETURNS trigger AS $$
DECLARE
	cpfdado varchar(11);
	temp1 real;
	temp2 real; 
	soma integer;
	digito1 integer; 
	digito2 integer;
	tam integer;
	index integer;
	cpftemp varchar(11);

BEGIN
	cpfdado := new.CPF;

	-- Teste do tamanho da string de entrada
	IF char_length(cpfdado) != 11
	THEN
		RAISE NOTICE 'Formato inválido: %',cpfdado;
	END IF;

	-- Inicialização
	temp1 := 0;
	soma := 0;
	digito1 := 0;
	digito2 := 0;
	index := 0;
	val_par_cpf := cpfdado;
	tam := char_length(cpftemp);
	temp1 := tam-1;

	--Dígito 1
	index :=1;
	WHILE index <= (tam -2) 
	LOOP
		temp2 := CAST(substring(cpftemp from index for 1) AS NUMERIC);
		soma := soma + ( temp2 * temp1);
		temp1 := temp1 - 1;
		index := index + 1;
	END LOOP;

	digito1 := 11 - CAST((soma % 11) AS INTEGER);

	IF (digito1 = 10) THEN digito1 :=0 ; END IF;
	IF (digito1 = 11) THEN digito1 :=0 ; END IF;

	-- Dígito 2
	temp1 := 11; soma :=0;
	index :=1;
	WHILE index <= (tam -1) 
	LOOP
		soma := soma + CAST((substring(cpftemp FROM index FOR 1)) AS REAL) * temp1;
		temp1 := temp1 - 1;
		index := index + 1;
	END LOOP;

	digito2 := 11 - CAST ((soma % 11) AS INTEGER);

	IF (digito2 = 10) THEN digito2 := 0; END IF;
	IF (digito2 = 11) THEN digito2 := 0; END IF;

	--Teste do CPF
	IF ((digito1 || '' || digito2) = substring(cpftemp FROM tam-1 FOR 2)) 
		THEN RETURN NEW;
	ELSE
		RAISE EXCEPTION 'O CPF % é inválido',cpfdado;
	END IF;

END $$ language plpgsql;

CREATE TRIGGER CPFVALIDO 
BEFORE INSERT OR UPDATE OF CPF ON PESSOA
FOR EACH ROW
EXECUTE PROCEDURE validarCPF();


INSERT INTO PESSOA VALUES ('66463343076','1950/07/25','LORENA ELIAS','RUA ITAGUACU, 1074');

SELECT * FROM PESSOA