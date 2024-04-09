REM ******** TABLAS ALUMNOS, ASIGNATURAS, NOTAS: ***********

DROP TABLE ALUMNOS cascade constraints;

CREATE TABLE ALUMNOS
(
  DNI VARCHAR2(9) PRIMARY KEY,
  APENOM VARCHAR2(30),
  DIREC VARCHAR2(30),
  POBLA  VARCHAR2(15),
  TELEF  VARCHAR2(9)  
) ;

DROP TABLE ASIGNATURAS cascade constraints;

CREATE TABLE ASIGNATURAS
(
  COD NUMBER(2) PRIMARY KEY,
  NOMBRE VARCHAR2(25)
) ;

DROP TABLE NOTAS cascade constraints;

CREATE TABLE NOTAS
(
  DNI VARCHAR2(9) NOT NULL REFERENCES ALUMNOS,
  COD NUMBER(2) NOT NULL REFERENCES ASIGNATURAS,
  NOTA NUMBER(2),
  CONSTRAINT PK_NOTAS PRIMARY KEY (DNI,COD)
) ;

INSERT INTO ASIGNATURAS VALUES (1,'Programación');
INSERT INTO ASIGNATURAS VALUES (2,'BBDD');
INSERT INTO ASIGNATURAS VALUES (3,'Marcas');
INSERT INTO ASIGNATURAS VALUES (4,'Sistemas');



INSERT INTO ALUMNOS VALUES
('12344345H','Alcalde García, Elena', 'C/Las Matas, 24','Madrid','617766545');

INSERT INTO ALUMNOS VALUES
('04448242F','Cerrato Vela, Luis', 'C/Mina 28 - 3A', 'Madrid','616566545');

INSERT INTO ALUMNOS VALUES
('56882942G','Díaz Fernández, María', 'C/Luis Vives 25', 'Móstoles','615577545');

INSERT INTO ALUMNOS VALUES
('02112212H','Sanz Martín, Roberto', 'C/Espronceda 89', 'Madrid','614431211');

INSERT INTO NOTAS VALUES('12344345H', 1,6);
INSERT INTO NOTAS VALUES('12344345H', 2,5);
INSERT INTO NOTAS VALUES('12344345H', 3,6);
INSERT INTO NOTAS VALUES('12344345H', 4,6);

INSERT INTO NOTAS VALUES('04448242F', 1,6);
INSERT INTO NOTAS VALUES('04448242F', 2,8);
INSERT INTO NOTAS VALUES('04448242F', 3,4);
INSERT INTO NOTAS VALUES('04448242F', 4,5);

INSERT INTO NOTAS VALUES('56882942G', 1,8);
INSERT INTO NOTAS VALUES('56882942G', 2,7);
INSERT INTO NOTAS VALUES('56882942G', 3,8);
INSERT INTO NOTAS VALUES('56882942G', 4,9);

INSERT INTO NOTAS VALUES('02112212H', 1,3);
INSERT INTO NOTAS VALUES('02112212H', 2,3);
INSERT INTO NOTAS VALUES('02112212H', 3,2);
INSERT INTO NOTAS VALUES('02112212H', 4,6);
COMMIT;

REM ******** FIN ***********************

