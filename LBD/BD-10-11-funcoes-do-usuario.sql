Create table TB_Depto

( codDepto number(3) primary key,

nomeDepto varchar2(30));

Create Table TB_Projeto

( codProjeto number(3) primary key,

Descricao varchar2(30));

Create table TB_Funcionario

( codFunc number(5) primary key,

nomeFunc varchar2(30),

sexo char(1),

dataAdmissao date,

codDepto number(3) references TB_Depto,

salario number(7,2),

cidade varchar2(25)

);

Create table tb_Funcproj

(CodFunc number(5),

Codprojeto number(3),

Tempoalocacao number(3),

Bonus_sal number(7,2));

alter table tb_funcproj add constraint PK_funcproj primary key (codfunc,codprojeto);

alter table tb_funcproj add constraint FK_funcproj_codproj foreign key (codfunc) references tb_projeto; 





insert into TB_Depto values (500,'Depto TI');

insert into TB_Depto values (510,'Depto de RH');

insert into TB_Depto values (520,'Depto de Logistica');

insert into TB_Projeto values(100,'App de Compras');

insert into TB_Projeto values(110,'Sistema de Logística');

insert into TB_Projeto values(120,'App de Recrutamento');

insert into TB_Funcionario values (1111,'Maria Silva','F','03/05/2010',510, 6000.00, 'Sorocaba');

insert into TB_Funcionario values(2222,'Antonio Paulo','M','02/09/2021',500, 2000.00, 'Sorocaba');

insert into TB_Funcionario values (3333,'Carolina Pereira','F','01/05/2016',520, 850.00, 'Itu');

insert into TB_Funcionario values (4444,'Felipe Moura','M','01/09/2021',500, 5200.00, 'Campinas');

insert into TB_Funcionario values(5555,'Carlos Augusto','M','08/05/2011',510, 4000.00, 'Sorocaba');

---------------------------insert projeto

alter table tb_funcproj
drop constraint FK_funcproj_codfunc;

Alter table tb_funcproj add constraint pk_funcproj 
primary key (codfunc, codprojeto);

 

alter table tb_funcproj add constraint FK_Funcproj_codfunc  
foreign key (codfunc)  references tb_funcionario;

 

alter table tb_funcproj add constraint FK_Funcproj_codproj  
foreign key (codprojeto)  references tb_projeto;

---------------------------------------------

alter table tb_funcproj
drop constraint pk_funcproj;


insert into tb_funcproj values(2222,100,3,100.00);
insert into tb_funcproj values (1111,100,3,100.00);
insert into tb_funcproj values (1111,120,3,100.00);
insert into tb_funcproj values (2222,120,3,100.00);
insert into tb_funcproj values (2222,100,3,100.00);
insert into tb_funcproj values (5555,100,3,100.00);

select F.codfunc, F.nomefunc, count(*)
from tb_funcionario F inner join tb_funcproj FP
on F.codfunc = FP.codfunc
group by F.codfunc, F.nomefunc
having COUNT(*) < 2;

select codprojeto from tb_projeto
where codprojeto not in (select codprojeto from TB_FUNCPROJ);


select codprojeto from tb_projeto
where not exists(select codprojeto from TB_FUNCPROJ
                  where tb_funcproj.codprojeto = tb_projeto.codprojeto);
                  
                  
--1. Listar o código do funcionário, nome do funcionário e a qtde de projetos que ele está alocado, mas só para os funcionários alocados em mais de 2 projetos. (0,75)

--2. Alterar o campo Bônus_sal para 200,00 para todos os funcionarios que trabalham no projeto de descricao = “APP Carona”. (0,75)

--3. Listar o codigo do projeto que não tem funcionários alocados criando comandos nas 3 formas: (1,25)

--- Usando o operador not in
select codprojeto from tb_projeto
where codprojeto not in (select codprojeto from TB_FUNCPROJ);


--b- Usando o operador not exists
select codprojeto from tb_projeto
where not exists(select codprojeto from TB_FUNCPROJ
                  where tb_funcproj.codprojeto = tb_projeto.codprojeto);

--c- Usando o operador Minus (ou except)

select codprojeto from tb_projeto
minus
select codprojeto from tb_funcproj;


------------------------------------------------------------------

Create or replace Function CalcDobro (p1 in number) return number 
  as
    p2 number;
 BEGIN
    p2 := p1* 2;
    Return p2;
 END;
 
 alter table medico add (vrhonor NUMBER(7,2));

Insert into medico values (888,'dr. João Marcos',CalcDobro(50));
SELECT CODPRODUTO, CalcDobro(valor_unit) from tb_produto;

SELECT nommedico, CalcDobro(VrHonor) from medico;

--

Create or replace Function  
          Fn_devolve_descricao(pcodprod  TB_produto.codproduto%type)
return varchar2
as
Vdesc TB_produto.descricao%type;
Begin
    Select descricao into vdesc
    From TB_produto
    Where TB_produto.codproduto = pcodprod;
    Return (vdesc);
End Fn_devolve_descricao;

---

Select numpedido, codproduto, Fn_devolve_descricao(codproduto)"Descricao"
From Tb_item_pedido;


variable resultado varchar2(20)

execute :resultado := fn_devolve_descricao (11);
print :resultado;

select numpedido, codproduto,  substr(Fn_devolve_descricao(codproduto),1,15) as Descricao, pco_unit from Tb_item_pedido;

-------------------

drop function FN_verDATA;

create or replace FUNCTION FN_verData(Pdata date) return varchar2
      is
          V_returnData varchar2(50);
      BEGIN
        V_returnData := to_char(Pdata,'DD/MM/YYYY:HH24:mi:ss');
        RETURN (V_returnData);
      END FN_verData;
      
      
CREATE or replace FUNCTION FN_idoso(PcodPaciente PACIENTE.CODPACIENTE%type) 
          RETURN varchar2
          IS
              retorna varchar2(50);
              nascimento date;
              
          BEGIN
             select (sysdate-datanasc)/365.25 into nascimento from paciente where codpaciente=Pcodpaciente;
             if nascimento > 65 then
                retorna := 'Eh Idoso';
              else
                  retorna := 'Nao eh Idoso';
             return (retorna);   
          END FN_idoso;
          
select FN_idoso(1) from paciente;          
    
CREATE or replace FUNCTION FN_consultaEstoque
           (PcodProd tb_produto.codproduto%type) 
          RETURN number
          IS
              declaration_section
          BEGIN
              ...
          END FN_consultaEstoque;
                  
            
select FN_verData(sysdate) from dual;            