drop table averias_parque;
drop table ZONAS;
drop table atracciones;
drop table emple_parque;

create table emple_parque
(dni_emple varchar2(9) constraint PK_emple primary key,
Nom_Empleado varchar2(30) not null,
Alta_empresa date not null );

create table atracciones
(Cod_Atraccion char(4) constraint PK_atracciones primary key,
Nom_Atraccion varchar2(30) ,
Fecha_Inauguracion date,
Capacidad number ,
Nom_Zona varchar2(30) references ZONAS
);

create table ZONAS
(Nom_Zona varchar2(30) constraint PK_zonas primary key,
Dni_Encargado varchar2(9) references emple_parque,
Presupuesto number(10,2));

create table averias_parque
( Cod_Atraccion char (4) references atracciones,
Fecha_Falla date ,
Fecha_Arreglo date ,
Coste_Averia number(10,2),
DNI_Emple varchar2(9) references emple_parque,
constraint PK_averias primary key (Cod_Atraccion,Fecha_Falla)
);

