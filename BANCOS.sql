alter session set nls_date_format ='dd/mm/yyyy hh24:mi';
drop table visitas;
drop table animales;
drop table dueños;
drop table veterinarios;
create table dueños
(dni varchar2(9) primary key,
 nombre varchar2(30),
 direccion varchar2(35),
 tfno_contacto number(9),
 alta_clinica varchar(7),
 cuota_mensual char(1));

create table animales
(ident_animal number primary key,
 nombre varchar2(30),
 especie varchar2(20),
 raza varchar2(20),
 fecha_nacimiento date,
 peso number (5,2),
 sexo char(1),
 dni_dueño varchar2(9));

create table veterinarios
(numcolegiado number primary key,
 nombre varchar(20),
telefono number(9));

create table visitas
(ident_animal number references animales,
 fh_visita date,
numcolegiado number references veterinarios,
 Motivo varchar(30), 
 Diagnostico varchar(30),
 precio number(*,2),
 constraint pk_visitas primary key (ident_animal, fh_visita)
);

insert into dueños values ('221221P','Angel Manzano','c/Estación 9',623453456,'10-2018','S');
insert into dueños values ('342545L','Nuria Aguilera','c/Estrecho 49',661221125,'11-2018','S');
insert into dueños values ('132123K','Lucía Gómez','c/Estación 19',637178989,'11-2018','N');
insert into dueños values ('231239S','Antonio Pedrosa','c/Illescas 176',613154664,'01-2020','N');
insert into dueños values ('231121J','Esther Flores','c/Maderuelo 20',618908998,'02-2020','N');
insert into dueños values ('453445J','María Carrasco','c/Estrecho 23',671232342,'03-2020','N');
insert into dueños values ('323422H','Alba Carrillo',null,null,'01-2023','N');

 
insert into animales values (1,'JUK','PERRO','Affenpinscher','11/10/2019',10,'M','221221P');
insert into animales values (2,'SOL','PERRO','Affenpinscher','21/06/2016',15,'M','132123K');
insert into animales values (3,'JAS','PERRO','Alaskan Malamute','16/02/2021',35,'M','342545L');
insert into animales values (4,'GRESCA','PERRO','Boxer','17/10/2017',20,'H','231239S');
insert into animales values (5,'TRITON','PERRO','Dobermann','01/01/2020',40,'H','132123K');
insert into animales values (6,'CHUSCHUS','GATO','Persa','12/12/2017',6,'M','231121J');
insert into animales values (7,'FILOMENA','GATO','Abisinio','14/02/2020',10,'H','132123K');
insert into animales values (8,'GRESCA','GATO','Abisinio','14/02/2021',12,'H','231121J');
insert into animales values (9,'PITBULL','GATO',null,'19/02/2023',6,'H','323422H');

insert into veterinarios values (1234,'ANA GIL', 686145232);
insert into veterinarios values (3443,'ELENA MORAGA', 686989766);
insert into veterinarios values (3888,'MARIA ELENA RUIZ', 626912436);

insert into visitas values (1,'2/6/2023 10:30',1234,'VACUNA','OK' ,20);
insert into visitas values (2,'5/6/2023 12:30',1234,'REVISION',NULL,20);
insert into visitas values (1,'5/6/2023 12:30',3443,'FIEBRE',NULL,20);
insert into visitas values (1,'23/6/2023 17:40',3443,'GASTRITIS',NULL,30);
insert into visitas values (3,'26/6/2023 13:00',1234,'VACUNA','OK',22);
insert into visitas values (4,'23/6/2023 9:45',3443,'REVISION','OK',20);
insert into visitas values (5,'2/7/2023 18:35',3443,'DENTADURA','VOLVER PARA LIMPIEZA',45);
insert into visitas values (4,'12/7/2023 12:45',3443,'PARASITOS','REVISAR EN UN MES',25);
insert into visitas values (5,'16/7/2023 11:30',1234,'VACUNA','OK',20);
insert into visitas values (6,'24/7/2023 18:30',3443,'REVISION',NULL,20);
insert into visitas values (2,'27/7/2023 19:20',3443,'VACUNA','OK',20);
insert into visitas values (7,'2/9/2023 19:20',1234,'VISITA',NULL,25);
insert into visitas values (1,'2/9/2023 09:30',1234,'GASTRITIS',NULL,30);
insert into visitas values (2,'5/9/2023 17:30',3443,'DOLORES','ECOGRAFIA',24);
insert into visitas values (5,'5/9/2023 10:30',1234,'NO COME',NULL,25);
insert into visitas values (2,'16/9/2023 17:30',3443,'GASTRITIS',NULL,24);
insert into visitas values (5,'16/9/2023 10:30',1234,'VACUNA','OK',25);
insert into visitas values (4,'16/9/2023 12:30',1234,'VACUNA','OK',25);
insert into visitas values (8,'3/10/2023 16:00',1234,'REVISION',NULL,25);
insert into visitas values (6,'6/10/2023 16:00',1234,'OTITIS','VOLVER EN TRES MESES',25);
insert into visitas values (2,'30/10/2023 16:00',3443,'REVISION',NULL,25);

commit;