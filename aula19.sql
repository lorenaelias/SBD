--EXERCICIO 1
CREATE SCHEMA locadora;
SET search_path TO locadora;

CREATE TABLE CLIENTE(
    numcliente  SMALLINT            NOT NULL,
    nome        VARCHAR(50)         NOT NULL,
    endereco    VARCHAR(50)         NOT NULL,
    foneres     VARCHAR(15)         NOT NULL,
    fonecel     VARCHAR(15)         NOT NULL,

    CONSTRAINT CLIENTEPK 
        PRIMARY KEY(numcliente)
);

CREATE TABLE ATOR(
    codigo              SMALLINT            NOT NULL,
    datanasc            DATE                NOT NULL,
    nacionalidade       VARCHAR(30)         NOT NULL,
    nomereal            VARCHAR(50)         NOT NULL,
    nomeartistico       VARCHAR(50)         NOT NULL,

    CONSTRAINT ATORPK 
        PRIMARY KEY(codigo)
);

CREATE TABLE CLASSIFICACAO(
    codigo            SMALLINT            NOT NULL,
    nome              VARCHAR(50)         NOT NULL,
    preco             NUMERIC(7,2)        NOT NULL,

    check(nome in('super lancamento','lancamento', 'acervo')),
    CONSTRAINT CLASSIFICACAOPK 
        PRIMARY KEY(codigo)
);

CREATE TABLE FILME(
    numfilme            SMALLINT            NOT NULL,
    titulo_original     VARCHAR(50)         NOT NULL,
    titulo_pt           VARCHAR(50)         NOT NULL,
    duracao             SMALLINT            NOT NULL,
    data_lancamento     DATE                NOT NULL,
    direcao             VARCHAR(50)         NOT NULL,
    categoria           VARCHAR(30)         NOT NULL,
    codclassificacao    SMALLINT            NOT NULL,   

    check(categoria in ('drama','romance','acao','comedia')),    
    CONSTRAINT FILMEPK 
        PRIMARY KEY(numfilme),
    CONSTRAINT FILMEFK 
        FOREIGN KEY(codclassificacao)
            REFERENCES  CLASSIFICACAO(codigo)
);

CREATE TABLE MIDIA(
    numfilme        SMALLINT        NOT NULL UNIQUE,
    numero          SMALLINT        NOT NULL,
    tipo            VARCHAR(30)     NOT NULL,

    check(tipo in('DVD', 'BLURAY')),
    CONSTRAINT MIDIAPK 
        PRIMARY KEY(numfilme,numero,tipo),
    CONSTRAINT MIDIAFK
        FOREIGN KEY(numfilme)
	        REFERENCES FILME,
        FOREIGN KEY(numero)
            REFERENCES EMPRESTIMO(nummidia)
);

CREATE TABLE ESTRELA(
    numfilme        SMALLINT        NOT NULL,
    codator         SMALLINT        NOT NULL,

    CONSTRAINT ESTRELAPK 
        PRIMARY KEY(numfilme,codator),
    CONSTRAINT ESTRELAFK 
        FOREIGN KEY(numfilme)
            REFERENCES FILME(numfilme),
        FOREIGN KEY(codator)
            REFERENCES ATOR(codigo)
);

CREATE TABLE EMPRESTIMO(
    numfilme        SMALLINT        NOT NULL,
    nummidia        SMALLINT        NOT NULL,
    tipo            VARCHAR(30)     NOT NULL,
    codcliente      SMALLINT        NOT NULL,
    dataret         DATE            NOT NULL,
    datadev         DATE            NOT NULL,
    valor_pg        NUMERIC(7,2)    NOT NULL,

    CONSTRAINT EMPRESTIMOPK 
        PRIMARY KEY (numfilme,nummidia,tipo,codcliente),
    CONSTRAINT EMPRESTIMOFK 
        FOREIGN KEY (numfilme,nummidia,tipo)
            REFERENCES MIDIA(numfilme,numero,tipo),
        FOREIGN KEY (codcliente)
            REFERENCES CLIENTE(numcliente)
);