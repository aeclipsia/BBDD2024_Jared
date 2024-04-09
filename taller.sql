drop table arreglos;
drop table mecanicos;
drop table clientes_taller;
drop table coches_taller;

create table coches_taller
(matricula varchar2 (7) constraint PK_coches primary key,
modelo varchar2 (20) not null,
año_matricula varchar2(4),
ncliente number );

create table clientes_taller
(ncliente number constraint PK_clientes primary key,
nombre varchar2 (30),
direccion varchar2 (30),
telefono varchar2 (9),
fecha_alta date );

create table mecanicos
(nempleado number constraint PK_mecanicos primary key,
nombre varchar2(30) not null,
direccion varchar2(30) not null,
telefono varchar2(9),
fecha_nac date,
fecha_ing date,
función varchar2(15));

create table arreglos
(matricula varchar2(7) ,
nempleado number ,
fecha_entrada date ,
fecha_salida date,
importe number(8,2),
constraint FK_arreglos_matricula foreign key (matricula) references coches_taller,
constraint PK_arreglos primary key (matricula, fecha_entrada)
);