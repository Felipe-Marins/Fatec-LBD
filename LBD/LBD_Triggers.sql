create table logteste

(nrlog number primary key,

Dttrans date not null,

Usuario varchar2(20) not null,

Tabela varchar2(30),

Opera char(1) check (opera in('I','A','E')),

Linhas Number(5) not Null check(linhas >=0));
-----------------------------------------------------------------------------------


create sequence seqlog;

select seqlog.currval from dual;

select seqlog.nextval from dual;

insert into TB_produto values (6,'Caneta','CX', 5.00);
-----------------------------------------------------------------------------------



Create or Replace trigger EliminaProduto

before delete on tb_produto

for each row

begin

insert into logteste values(seqlog.nextval,sysdate,user,'produto','E',1);

end Eliminaproduto;
----------------------------------------------------------------------------------


delete tb_produto 
where CODPRODUTO=6;

select * from logteste;
-------------------------------

Create or Replace Trigger ChecaHora2

before update or delete on paciente

begin

if to_char(sysdate,'HH24') not between 7 and 9 then

if updating then

raise_application_error(-20400,'Update não permitido');

elsif deleting then

raise_application_error(-20410,'Delete não permitido');

end if;

end if;

end ChecaHora2;
--------------------------------------------------------------------------------------------------

update paciente

set nompaciente = 'xxx'

where codpaciente = 1;
-----------------------------------------------------------------------------------------------------


CREATE or replace TRIGGER Troca_data

BEFORE INSERT ON Tb_pedido

FOR EACH ROW

BEGIN

:NEW.prazo_entrega := SYSDATE + 15;

END; 

--TESTE--
 insert into tb_pedido values (999,'18/11/2021',31,15);
 select * from tb_pedido;
 -------------------------------------------------------------------------------------
 
 
 Create or Replace trigger EliminaProduto

before delete on tb_produto

for each row

begin

insert into logteste values(seqlog.nextval,sysdate,user,'produto '||:old.codproduto||:old.descricao,'E',1);

end Eliminaproduto;
-------------------------------------------------------------------------------------
 --TESTE--
insert into TB_produto values (6,'Caneta','CX', 5.00);

delete tb_produto
where codproduto=6;

select * from logteste;
-------------------------------------------------------------------------------------

--2. Escreva um trigger que ao alterar o prazo de entrega de um pedido. 
--Grave na tablog o prazo antigo, prazo novo e o nome do cliente

create sequence seqtablog;

create table tablog

( numLog number primary key,

datalog date,

usuario varchar2(15),

tabela varchar2(15),

oldcampo varchar2(50),

newcampo varchar2(50),

campo1 varchar2(50)); 

------------------------------

create or replace trigger TR_alteraPrazo
before update of prazo_entrega on tb_pedido
FOR EACH ROW
declare
vnomeCli varchar2(30);
begin
select nomecliente into vnomeCli
from tb_cliente where codcliente = :new.codcliente;

insert into tablog values(seqtablog.nextval,sysdate,user,
'Tb_pedido',:old.prazo_entrega,:new.prazo_entrega,vnomeCli);

end;
------------------------------------------------------------------------------------

update tb_pedido
set prazo_entrega = sysdate
where numpedido = 7;

select * from tablog;
