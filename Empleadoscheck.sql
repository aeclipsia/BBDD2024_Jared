drop table EMPLEADOS_CHECK;

create table EMPLEADOS_CHECK
(numero number(5) not null primary key,
nombre varchar2(30) not null unique,
direccion varchar2(30) not null,
distancia number(10,3),
oficio varchar2(30),
telefono_fijo number,
telefono_movil number not null,
fecha_nacimiento date,
fecha_alta date default sysdate,
departamento number(3),
num_hijo number(2) default '0',
titulado char default 'N',
salario number (10,2),

constraint limit_numero check (numero between 1 and 10000),
constraint start_telefono_fijo check (telefono_fijo like '91%'),
constraint start_telefono_movil check (telefono_movil like '6%' or telefono_movil like '7%'),
constraint option_oficio check (oficio='VENDEDOR' or oficio='GERENTE' or oficio='OTROS'),
constraint year_fecha_nac check (to_char(fecha_nacimiento,'yyyy')<1990),
constraint option_dep check (departamento in (10,20,30)),
constraint option_num_hijo check (num_hijo >= 0 and num_hijo <= 10),
constraint option_titulado check (titulado = 'S' or titulado ='N')
);

