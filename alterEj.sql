Create table m_mecanicos
(nempleado number primary key,
nombre varchar2(30) not null,
direccion varchar2(30) not null,
telefono varchar2(9),
fecha_nacimiento date,
fecha_ingreso date,
funcion varchar2(15));

select * from m_mecanicos;

alter session set nls_date_format = 'dd/mm/yyyy';

alter table m_mecanicos
add salario number;

alter table m_mecanicos
modify fecha_ingreso date default sysdate;

alter table m_mecanicos
drop column funcion;

alter table m_mecanicos
add constraint ck_salario check (salario<1000);

alter table m_mecanicos
add constraint ck_edad check ((to_char(fecha_ingreso,'yyyy'))-(to_char(fecha_nacimiento,'yyyy'))>17);

alter table m_mecanicos
add constraint ck_telefono check (length(telefono)=9);