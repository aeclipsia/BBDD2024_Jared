REM ******** TABLA DEPART: ***********

DROP TABLE DEPART cascade constraints; 

CREATE TABLE DEPART (
 DEPT_NO  NUMBER(2) PRIMARY KEY,
 DNOMBRE  VARCHAR2(14), 
 LOC      VARCHAR2(14) ) ;

INSERT INTO DEPART VALUES (10,'CONTABILIDAD','SEVILLA');
INSERT INTO DEPART VALUES (20,'INVESTIGACION','MADRID');
INSERT INTO DEPART VALUES (30,'VENTAS','BARCELONA');
INSERT INTO DEPART VALUES (40,'PRODUCCION','BILBAO');
COMMIT;


REM ******** TABLA EMPLE: *************

ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

DROP TABLE EMPLE cascade constraints; 

CREATE TABLE EMPLE (
 EMP_NO      NUMBER(4) PRIMARY KEY,
 APELLIDO    VARCHAR2(15)  ,
 OFICIO      VARCHAR2(15)  ,
 RESPONSABLE NUMBER(4) ,
 FECHA_ALTA  DATE      ,
 SALARIO     NUMBER(9,2),
 COMISION    NUMBER(9,2),
 DEPT_NO     NUMBER(2) NOT NULL REFERENCES DEPART) ;

INSERT INTO EMPLE VALUES (7369,'SANCHEZ','ADMINISTRATIVO',7902,'17/12/2010',
                        1040,NULL,20);
INSERT INTO EMPLE VALUES (7499,'ARROYO','VENDEDOR',7698,'20/02/2012',
                        1500,390,30);
INSERT INTO EMPLE VALUES (7521,'SALA','VENDEDOR',7698,'22/02/2013',
                        1625,650,30);
INSERT INTO EMPLE VALUES (7566,'JIMENEZ','DIRECTOR',7839,'02/04/2013',
                        2900,NULL,20);
INSERT INTO EMPLE VALUES (7654,'MARTIN','VENDEDOR',7698,'29/09/2017',
                        1600,1020,30);
INSERT INTO EMPLE VALUES (7698,'ROJO','DIRECTOR',7839,'10/05/2017',
                        3005,NULL,30);
INSERT INTO EMPLE VALUES (7782,'CEREZO','DIRECTOR',7839,'09/06/2010',
                        2885,NULL,10);
INSERT INTO EMPLE VALUES (7788,'GIL','ANALISTA',7566,'09/11/2012',
                        3000,NULL,20);
INSERT INTO EMPLE VALUES (7839,'REY','PRESIDENTE',NULL,'17/11/2017',
                        4100,NULL,10);
INSERT INTO EMPLE VALUES (7844,'TOVAR','VENDEDOR',7698,'08/09/2012',
                        1350,0,30);
INSERT INTO EMPLE VALUES (7876,'ALONSO','ADMINISTRATIVO',7788,'23/09/2013',
                        1335,NULL,20);
INSERT INTO EMPLE VALUES (7900,'JIMENO','ADMINISTRATIVO',7698,'03/12/2013',
                        1335,NULL,30);
INSERT INTO EMPLE VALUES (7902,'FERNANDEZ','ANALISTA',7566,'03/12/2012',
                        3000,NULL,20);
INSERT INTO EMPLE VALUES (7934,'MU�OZ','ADMINISTRATIVO',7782,'23/01/2014',
                        1690,NULL,10);

COMMIT;
