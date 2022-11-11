---------------------------------------------------
--1. Listar o cÃ³digo e o nome dos vendedores que efetuaram vendas para o cliente com cÃ³digo 30.
select V.codvendedor, V.nomevendedor from tb_vendedor V
inner join tb_pedido P on V.codvendedor=P.codvendedor
where P.codcliente = 30;


--2. Listar o nÃºmero do pedido, prazo de entrega, a quantidade e a descriÃ§Ã£o do produto com cÃ³digo 11.
select P.numpedido, P.prazo_entrega, I.qtde, PR.descricao from tb_item_pedido I
inner join tb_pedido P on I.numpedido=P.numpedido
inner join tb_produto PR on I.codproduto=PR.codproduto
where I.codproduto = 11;



--3. Quais os vendedores (cÃ³digo e nome) fizeram pedidos para o cliente 'JoÃ£o da Silva'.
select distinct V.codvendedor, V.nomevendedor from tb_pedido P
inner join tb_vendedor V on P.codvendedor=V.codvendedor
inner join tb_cliente C on P.codcliente=C.codcliente
where C.nomecliente='João da Silva';


--4. Listar o nÃºmero do pedido, o cÃ³digo do produto, a descriÃ§Ã£o do produto, o cÃ³digo do vendedor, o nome do vendedor , o nome do cliente, para todos os clientes que moram em Sorocaba.
select P.numpedido, PR.codproduto, PR.descricao, V.codvendedor, V.nomevendedor, C.nomecliente

from tb_pedido P 
inner join Tb_cliente C on P.codcliente=C.codcliente
inner join tb_vendedor V on P.codvendedor=V.codvendedor
inner join tb_item_pedido I on P.numpedido=I.numpedido
inner join tb_produto PR on I.codproduto=PR.codproduto
where C.cidade='Sorocaba';


--5. Listar o cÃ³digo do produto, a descriÃ§Ã£o, a quantidade pedida e o prazo de entrega para o pedido nÃºmero 123.
SELECT PR.codproduto, PR.descricao, I.qtde, P.prazo_entrega
from tb_pedido P
inner join tb_item_pedido I on P.numpedido=I.numpedido
inner join tb_produto PR on I.codproduto=PR.codproduto
where P.numpedido=7;


--6. Quais os cliente ( nome e endereÃ§o) da cidade de Itu ou Sorocaba tiveram seus pedidos tirados com o vendedor de cÃ³digo igual a 10.
Select distinct C.nomecliente, C.endereco 
from tb_cliente C
inner join Tb_pedido P on C.codcliente=P.codcliente
where P.codvendedor=15 and (C.cidade='Sorocaba' or C.cidade='ITU');

insert into tb_pedido values(44,'11/11/2022',39,15);

--7. Listar o cÃ³digo do cliente, nome do cliente e o total de pedidos que cada um realizou.
select C.codcliente, C.nomecliente, count(*) as total 
from tb_cliente C
inner join tb_pedido P on C.codcliente=P.codcliente
group by C.CODCLIENTE, C.NOMECLIENTE;

