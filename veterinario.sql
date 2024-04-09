drop table visitas;
drop table veterinarios;
drop table animales;
drop table dueños;

create table dueños
(dni varchar2(9) constraint PK_dueños primary key,
nombre varchar2(30),
direccion varchar2(35),
tfno_contacto number(9),
alta_clinica varchar(7),
cuota_mensual char(1));

create table animales
(ident_animal number constraint PK_animales primary key,
nombre varchar2(30),
especie varchar2(20),
raza varchar2(20),
fecha_nacimiento date,
peso number (5,2),
sexo char(1),
dni_dueño varchar2(9),
constraint FK_dni_dueño foreign key (dni_dueño) references dueños
);

create table veterinarios
(numcolegiado number constraint PK_veterinarios primary key,
nombre varchar(20),
telefono number(9));

create table visitas
(ident_animal number,
fh_visita date,
numcolegiado number,
Motivo varchar(30),
Diagnostico varchar(30),
precio number(*,2),
constraint FK_visitas_ident foreign key (ident_animal) references animales,
constraint FK_numcolegiado foreign key (numcolegiado) references veterinarios,
constraint PK_visitas primary key (ident_animal,fh_visita)
);