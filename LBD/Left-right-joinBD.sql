 ---- Script Autor-Livro (da Lista01 de revisão)
    ----
    drop table autorlivro;
    drop table livro;
    drop table autor;
    drop table assunto;
    
    create table Autor
(CodAutor 		number(5) primary key, 
 Nomeautor	 	varchar2(20),
 datanascimento date,
 CidadeNasc  	varchar2(20),
 sexo 			char(1) );
 
 create table Assunto
(CodAssunto		    number(5) primary key,
 descricao  		varchar2(40),
 descontopromocao	 number(4,2));

create table Livro 
(CodigoLivro 	number(5) primary key,
 Titulo			varchar2(30),
 Editora		varchar2(20),
 Cidade		    varchar2(30), 
 DataEdicao		date, 
 Versao		    number(3),
 CodAssunto		number(5),
 Preco		    number(5,2),
 DataCadastro	date,
 lancamento     	Char(1) );

create table AutorLivro
( codigoLivro  number(5) not NULL,
  codAutor 	   number(5) not NULL); 

select * from user_constraints;

-- CRIAR AS CHAVES QUE FALTAM

ALTER TABLE AUTORLIVRO ADD CONSTRAINT PK_AUTORLIVRO_CODLIAUTOR PRIMARY KEY(CODIGOLIVRO,CODAUTOR);

ALTER TABLE AUTORLIVRO ADD CONSTRAINT FK_AUTORLIVRO_CODIGOLIVRO FOREIGN KEY (CODIGOLIVRO) REFERENCES LIVRO;

ALTER TABLE AUTORLIVRO ADD CONSTRAINT FK_AUTORLIVRO_CODAUTOR FOREIGN KEY (CODAUTOR) REFERENCES AUTOR;

-- CRIANDO FK  PARA ASSUNTO

ALTER TABLE LIVRO ADD CONSTRAINT FK_LIVRO_CODASSUNTO FOREIGN KEY (CODASSUNTO) REFERENCES ASSUNTO;

-- 3-	Adicionar uma nova coluna de nome Nacionalidade na tabela Autor.  (inverti a ordem para já cadastrar a nacionalidade)

ALTER TABLE AUTOR ADD NACIONALIDADE VARCHAR2(25);

    
  
    INSERT INTO ASSUNTO VALUES(10,'LITERATURA',2.5);
    INSERT INTO ASSUNTO VALUES(20,'PROGRAMACAO',5);
    INSERT INTO AUTOR VALUES(111,'CLARISSE LISPECTOR','10/12/1920','CHECHELNYK','F','Ucraniana');
    INSERT INTO AUTOR VALUES(222,'JOEL GRUS','31/12/1970','SEATTLE','M', 'Americano');
    INSERT INTO LIVRO VALUES(888,'A HORA DA ESTRELA','ROCCO','RIO DE JANEIRO','04/08/1998','3',10,11.9,'21/08/2020','L');
    INSERT INTO LIVRO VALUES(999,'DATA SCIENCE DO ZERO','ALTA BOOKS','RIO DE JANEIRO','27/06/2016','1',20,43.4,'21/08/2020','L');
    INSERT INTO AUTORLIVRO VALUES(888,111);
    INSERT INTO AUTORLIVRO VALUES(999,222);
    
    INSERT INTO Assunto VALUES(30, 'Estudos Contabilidade', 2.99);
    
    INSERT INTO LIVRO VALUES(555,'A HORA DA ESTRELA','ROCCO','RIO DE JANEIRO','04/08/1998','3',10,11.9,'21/08/2020','L');

    INSERT INTO Livro VALUES(777, 'Contabilidade para ADS', 'Editora OK','Sorocaba','20/01/2011', 1, 30,25.99, 
           TO_DATE('15/08/2018', 'DD/MM/YYYY'), 'N');
           
    INSERT INTO Livro VALUES(1010, 'Contabilidade ADS - Parte II ', 'Editora OK','Sorocaba','20/01/2011', 1, 30,25.99, 
           TO_DATE('15/08/2018', 'DD/MM/YYYY'), 'N');


    INSERT INTO Autor  VALUES(333, 'Marina Souza', TO_DATE('20/01/2000:16:30', 'DD/MM/YYYY:hh24:MI'),'Sorocaba', 'F', 'Brasileira');
    
    INSERT INTO AutorLivro VALUES(777, 333);
    INSERT INTO AutorLivro VALUES(1010, 333);

----- até aqui ????

select * from livro;
select * from autorlivro;
select * from autor;
select * from assunto;

commit;
----------------------------------------------------------------------------------------------------------------------------------------

insert into livro values(750,'Inferno', 'Editora Arqueiro','São Paulo','01/01/2013',1,null,67.00,sysdate,'N');
insert into autor values(300,'Dan Brown','22/06/1964','Exeter','M','Estados Unidos');
insert into autorlivro values (750,300);
insert into assunto values(40,'Ficção Científica',10.99);


select l.codigolivro,l.titulo,l.codassunto as livro_codassunto ,a.codassunto, a.descricao
from livro l full outer join assunto a
on l.codassunto = a.codassunto;

---------------------------------------------------------------------------------------------------------------------------------------
--Sobre o modelo de dados Paciente-consulta-medico escreva comando para:
--(usar left join, righ join, inner join, etc)

--1- Listar o código do paciente, nome do paciente, código da consulta e dataconsulta
   --para todos os pacientes que tem consultas realizadas.
   
   select P.codpaciente, P.nompaciente, C.codconsulta, C.dataconsulta
   from consulta C inner join paciente P on P.CODPACIENTE = C.CODPACIENTE;
   
--2- Listar o código do paciente, nome do paciente, código da consulta e dataconsulta
--   para todos os pacientes que tem consultas realizadas e para os que não tem.
  select P.codpaciente, P.nompaciente, C.codconsulta, C.dataconsulta 
  from paciente P left join consulta C on P.codpaciente = C.codpaciente
  order by C.CODCONSULTA;
   
--3-  Listar somente os códigos e nomes dos pacientes que não tem consultas.
  select P.codpaciente, P.nompaciente 
  from paciente P left join consulta C on P.codpaciente = C.CODPACIENTE 
  where C.codpaciente is null;
  
   
--4- Listar o código das consultas, data consulta e nome do médico para todos os médicos que tem 
--   consultas que para os que não tem.
  select C.codconsulta, C.dataconsulta, M.nommedico
  from consulta C right join medico M on M.CODMEDICO = C.CODMEDICO
  order by C.CODCONSULTA;
  
  commit;