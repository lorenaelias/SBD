--EXERCICIO 3
ALTER TABLE CLIENTE ADD 
    CONSTRAINT CLIENTEPK 
        PRIMARY KEY(numcliente)

ALTER TABLE ATOR ADD
    CONSTRAINT ATORPK 
        PRIMARY KEY(codigo)

ALTER TABLE CLASSIFICACAO ADD
    CONSTRAINT CLASSIFICACAOPK 
        PRIMARY KEY(codigo)

ALTER TABLE FILME ADD
    CONSTRAINT FILMEPK 
        PRIMARY KEY(numfilme),
    CONSTRAINT FILMEFK 
        FOREIGN KEY(codclassificacao)
            REFERENCES  CLASSIFICACAO(codigo)

ALTER TABLE MIDIA ADD
    CONSTRAINT MIDIAPK 
        PRIMARY KEY(numfilme,numero,tipo),
    CONSTRAINT MIDIAFK
        FOREIGN KEY(numfilme)
	        REFERENCES FILME,
        FOREIGN KEY(numero)
            REFERENCES EMPRESTIMO(nummidia)

ALTER TABLE ESTRELA ADD
    CONSTRAINT ESTRELAPK 
        PRIMARY KEY(numfilme,codator),
    CONSTRAINT ESTRELAFK 
        FOREIGN KEY(numfilme)
            REFERENCES FILME(numfilme),
        FOREIGN KEY(codator)
            REFERENCES ATOR(codigo)

ALTER TABLE EMPRESTIMO ADD
    CONSTRAINT EMPRESTIMOPK 
        PRIMARY KEY (numfilme,nummidia,tipo,codcliente),
    CONSTRAINT EMPRESTIMOFK 
        FOREIGN KEY (numfilme,nummidia,tipo)
            REFERENCES MIDIA(numfilme,numero,tipo),
        FOREIGN KEY (codcliente)
            REFERENCES CLIENTE(numcliente)