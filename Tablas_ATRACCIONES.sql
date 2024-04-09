drop table averias_parque ;
drop table atracciones ;
drop table zonas ;
drop table emple_parque ;

 create table emple_parque
 (dni_emple varchar2(9) PRIMARY KEY,
 Nom_Empleado varchar2(30) NOT NULL,
 Alta_empresa date  not null );
  
alter session set nls_date_format = 'dd/mm/yyyy'  ;

insert into emple_parque values
('6664321M','Ignacio Peña','12/10/2016');
insert into emple_parque values
('3455344J','Luis Pérez','10/05/2012');
insert into emple_parque values
('23552335I','Alvaro Martín','19/05/2015');
insert into emple_parque values
('11111111I','Ana Gil','19/05/2014');
insert into emple_parque values
('33333333I','Chus Sabio','10/05/2013');


create table ZONAS
(Nom_Zona varchar2(30) PRIMARY KEY,
 Dni_Encargado varchar2(9) references emple_parque,
 Presupuesto number(10,2));

insert into Zonas values
('Infantil','3455344J',40000);
insert into Zonas values
('Agua','33333333I',50000);
insert into Zonas values
('Gran Maquinaria','33333333I',12000);
insert into Zonas values
('Familiares','3455344J',21000);



 create table atracciones
 (Cod_Atraccion char(4) PRIMARY KEY,  
  Nom_Atraccion varchar2(30) ,
  Fecha_Inauguracion date,
  Capacidad number ,
  Nom_Zona varchar2(30) references Zonas );

insert into atracciones values
('A100','Los Vikingos','01/05/2009',90,'Infantil');
insert into atracciones values
('A110','Lejano Oeste','01/09/2009',80,'Infantil');
insert into atracciones values
('A120','Tío Vivo','01/05/2009',120,'Infantil');
insert into atracciones values
('A130','La Peque Montaña','01/09/2009',60,'Infantil');
insert into atracciones values
('B100','Los Rápidos','01/05/2009',40,'Agua');
insert into atracciones values
('B110','Cataratas Locas','01/09/2009',40,'Agua');
insert into atracciones values
('C100','Dragón Chiflado','01/05/2010',100, 'Gran Maquinaria');
insert into atracciones values
('C110','Enterprise', '01/09/2010',90,'Gran Maquinaria');
insert into atracciones values
('C120','Los 7 Picos','01/05/2016', 110,'Gran Maquinaria');
insert into atracciones values
('C130','Montaña Rusa','01/05/2009',80, 'Gran Maquinaria');
insert into atracciones values
('C200','La Noria', '01/05/2009',40,'Familiares');
insert into atracciones values
('C210','El Ferrocarril', '01/05/2009',60,'Familiares');
insert into atracciones values
('C220','Tunel Terrorífico', '01/05/2012',70,'Familiares');


 create table averias_parque
 ( Cod_Atraccion char (4) references atracciones,
 Fecha_Falla date ,
 Fecha_Arreglo date ,
 Coste_Averia number(10,2),
 DNI_Emple varchar2(9) references emple_parque,
  constraint pk_aver  primary key (Cod_atraccion,fecha_falla));

alter session set nls_date_format = 'dd/mm/yyyy hh24:mi';
insert into averias_parque values
('A100','10/07/2023 16:30','17/09/2023 17:45',300,'6664321M');
insert into averias_parque values
('B110','10/07/2023 16:30','18/07/2023 12:00',300,'6664321M');
insert into averias_parque values
('A110','15/06/2022 16:35','17/06/2022 19:45',5000,'6664321M');
insert into averias_parque values
('A120','17/12/2022 18:30','22/02/2023 20:30',1600,'3455344J');
insert into averias_parque values
('B110','15/08/2022 18:30','16/08/2022 18:30',9000,'3455344J');
insert into averias_parque values
('C120','12/03/2023 13:30','16/03/2023 11:30',7000,'3455344J');
insert into averias_parque values
('A100','12/05/2023 11:30','15/05/2023 13:30',400,'33333333I');
insert into averias_parque values
('C100','25/09/2023 13:30',null,null,'33333333I');
insert into averias_parque values
('A110','11/09/2023 18:30',null,null,'3455344J');
insert into averias_parque values
('A100','06/09/2023 12:30',null,null,'6664321M');

COMMIT;