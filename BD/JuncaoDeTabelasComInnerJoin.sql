select C.codconsulta, C.DATACONSULTA, P.codpaciente, P.nompaciente
from paciente P inner join consulta C
on P.CODPACIENTE = C.CODPACIENTE
where C.DATACONSULTA between '01/01/2021' and '31/12/2021';


select  C.dataconsulta, M.codmedico, M.nommedico, P.nompaciente
from paciente P inner join consulta C
on P.codpaciente = C.codpaciente  
inner join medico M
on C.codmedico = M.codmedico 
where P.sexo = 'M';