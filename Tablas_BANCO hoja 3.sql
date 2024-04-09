drop table MOVIMIENTOS;
drop table CUENTAS;
drop table CLIENTES;
drop table SUCURSALES;

ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY HH24:MI DAY';

create table SUCURSALES
(
Num_Sucursal number(3) primary key,
Direccion varchar2(30),
Director Varchar2(20),
constraint ck_num_sucursal check (regexp_like(num_sucursal,'^[1-9]{1}[0-9]{2}')),
constraint ck_direccion_sucursal check (Direccion=upper(Direccion)),
constraint ck_director_sucursal check (Director=upper(Director))
);

create table CLIENTES
(NIF varchar2(9),
 Nombre varchar2(30) ,
 Direccion varchar2 (30) ,
 Telefono varchar2(9),
 constraint pk_clientes_banco primary key (NIF),
 constraint ck_nif_clientes check (substr(nif,-1)=upper(substr(nif,-1))),
 constraint ck_telefono_clientes check (regexp_like(Telefono,'^[^8]{1}[0-9]{8}$'))
 );

create table CUENTAS
(Num_Cuenta number primary key,
 NIF_Titular varchar2(9) references CLIENTES not null,
 NIF_Cotitular varchar2(9) references CLIENTES,
 Fecha_Abierta date default sysdate,
 Num_Sucursal number references SUCURSALES,
 Tipo char(1),
 Saldo number(*,2),
 Control char(1) not null,
 constraint ck_fecha_abierta check (to_char(fecha_abierta,'d')!='6' AND to_char(fecha_abierta,'d')!='7'),
 constraint ck_tipo check (tipo='C' or tipo='P' or tipo='F'),
 constraint ck_saldo check (saldo>-100000),
 constraint ck_control check (control='B' or control='A')
 );

create table MOVIMIENTOS
(Num_Cuenta number references CUENTAS,
 FechaHora date default sysdate unique,
 Importe number not null,
 Concepto varchar2(30) default 'falta concepto',
 constraint pk_mov primary key (num_cuenta,fechahora),
 constraint ck_concepto_cargo check ((lower(concepto) like '%cargo%' AND importe < 0)
                                      or (lower(concepto) like '%abono%' AND importe > 0)
                                        or (lower(concepto) not like '%cargo%' and lower(concepto) not like '%abono%'))
 ); 

INSERT INTO SUCURSALES VALUES
(208,'VALMOJADO 89', 'ANTONIO CUENCA');

INSERT INTO SUCURSALES VALUES
(209,'ILLESCAS 211', 'ESTHER GONZALEZ');

INSERT INTO SUCURSALES VALUES
(210,'SESEÑA 80', 'ERNESTO PUESTO');
 
INSERT INTO CLIENTES VALUES
('12341234H', 'MARIANO MORENO','VALMOJADO 45',615302021);

INSERT INTO CLIENTES VALUES
('24242424K', 'LUCIA SALVADOR','CAMARENA 201',615302314);

INSERT INTO CLIENTES VALUES
('50070488U', 'ALBERTO MOTOROLA','SANTIGO 201',686133231);

INSERT INTO CLIENTES VALUES
('83838383H', 'ELVIRA MARTINEZ','YEBENES 45',616232323);

INSERT INTO CLIENTES VALUES
('21111111T', 'BENITO REYES','CANAL 49',615301000);

INSERT INTO CLIENTES VALUES
('56565656R', 'ALBA REYES','CANAL 49',615301012);


INSERT INTO CUENTAS VALUES
(11000, '24242424K', '56565656R','10/09/2008',208,'C',3500,'A');
INSERT INTO CUENTAS VALUES
(41000, '56565656R','24242424K', '10/03/2008',208,'P',-14567,'A');
INSERT INTO CUENTAS VALUES
(13000, '21111111T' ,NULL,'11/09/2009',210,'C',1500,'A');
INSERT INTO CUENTAS VALUES
(12000, '24242424K', NULL,'1/06/2012',208,'C',3500,'A');
INSERT INTO CUENTAS VALUES
(17000,'56565656R',NULL,'12/09/2011',209,'C',3230,'A');
INSERT INTO CUENTAS VALUES
(11200, '83838383H' ,NULL,'21/03/2012',210,'C',0,'A');
INSERT INTO CUENTAS VALUES
(30000,'83838383H',NULL,'21/04/2009',208,'F',12000,'A');


INSERT INTO MOVIMIENTOS VALUES
(17000,'29/09/2022 23:50',-75,'RESTAURANT LUNA');

INSERT INTO MOVIMIENTOS VALUES
(17000,'28/09/2022 13:30',-60,'GASOLINERA REPSOL');

INSERT INTO MOVIMIENTOS VALUES
(17000,'30/09/2022 12:50',2200,'ABONO HABERES');

INSERT INTO MOVIMIENTOS VALUES
(17000,'3/10/2022 23:30',-95,'RESTAURANT LUNA');

INSERT INTO MOVIMIENTOS VALUES
(17000,'30/09/2022 12:30',-60,'GASOLINERA REPSOL');

INSERT INTO MOVIMIENTOS VALUES
(17000,'2/10/2022 20:00',-63,'JAZZTEL');

INSERT INTO MOVIMIENTOS VALUES
(17000,'5/10/2022 17:34',-257,'CARREFOUR');

INSERT INTO MOVIMIENTOS VALUES
(17000,'30/10/2022 12:50',2120,'ABONO HABERES');

INSERT INTO MOVIMIENTOS VALUES
(12000,'21/10/2022 12:30',-30,'GASOLINERA REPSOL');

INSERT INTO MOVIMIENTOS VALUES
(12000,'22/10/2022 20:00',-29,'TELEFONICA');

INSERT INTO MOVIMIENTOS VALUES
(12000,'15/10/2022 17:34',-257,'CARREFOUR');

INSERT INTO MOVIMIENTOS VALUES
(12000,'30/10/2022 13:50',2320,'ABONO HABERES');

INSERT INTO MOVIMIENTOS VALUES
(12000,'28/10/2022 12:50',2320,'ABONO HABERES');

INSERT INTO MOVIMIENTOS VALUES
(11000,'24/10/2022 13:30',-220,'REINTEGRO CAJERO');

INSERT INTO MOVIMIENTOS VALUES
(11000,'29/10/2022 23:50',-175,'ROPITA PITA');

INSERT INTO MOVIMIENTOS VALUES
(11000,'28/10/2022 13:30',-65,'GASOLINERA REPSOL');

INSERT INTO MOVIMIENTOS VALUES
(11000,'30/10/2022 14:50',2500,'ABONO HABERES');

INSERT INTO MOVIMIENTOS VALUES
(11000,'3/10/2022 13:30',-55,'ZAPATOS CHAROL');

INSERT INTO MOVIMIENTOS VALUES
(41000,'1/09/2022 10:00',-850,'AMORT. PREST');

INSERT INTO MOVIMIENTOS VALUES
(41000,'1/10/2022 10:00',-850,'AMORT. PREST');

INSERT INTO MOVIMIENTOS VALUES
(41000,'1/11/2022 10:00',-850,'AMORT. PREST');

INSERT INTO MOVIMIENTOS VALUES
(11000,'03/11/2022 13:30',-65,'GASOLINERA REPSOL');

COMMIT;

SELECT * FROM SUCURSALES;
SELECT * FROM MOVIMIENTOS;
SELECT * FROM CLIENTES;
SELECT * FROM CUENTAS;