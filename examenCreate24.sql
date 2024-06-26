DROP TABLE BIBLIOTECARIOS;
DROP TABLE PRESTAMOS;
DROP TABLE EJEMPLARES;
DROP TABLE USUARIOS;
DROP TABLE LIBROS;


CREATE TABLE LIBROS
(
CODIGO VARCHAR2(6),
TITULO VARCHAR2(120) NOT NULL,
EDITORIAL VARCHAR2(30),
AUTOR VARCHAR2(30),
GENERO VARCHAR2(30),
NUM_PAGINAS NUMBER,
PRECIO NUMBER(5,2),

CONSTRAINT PK_LIBROS PRIMARY KEY (CODIGO),
CONSTRAINT CK_LIBROS_CODIGO CHECK (REGEXP_LIKE(CODIGO,'[A-Z]{2}-[0-9]{3}')),
CONSTRAINT CK_LIBROS_TITULO CHECK (TITULO=INITCAP(TITULO)),
CONSTRAINT CK_LIBROS_GENERO CHECK (GENERO IN ('NOVELA','POESIA','TEATRO','ENSAYO','CUENTOS')),
CONSTRAINT CK_LIBROS_PRECIO CHECK (PRECIO>0 AND PRECIO<=200)
);

CREATE TABLE USUARIOS
(
NUM_CARNET VARCHAR2(30), --HE PUESTO VARCHAR2 YA QUE NO VAMOS A HACER OPERACIONES MATEM�TICAS CON ELLO--
NOMBRE VARCHAR2(30) NOT NULL,
DNI VARCHAR2(9) NOT NULL UNIQUE,
DOMICILIO VARCHAR2(30),
POBLACION VARCHAR2(30) NOT NULL,
PROVINCIA VARCHAR2(30) NOT NULL,
F_NACIMIENTO VARCHAR2(6) NOT NULL,

CONSTRAINT PK_USUARIOS PRIMARY KEY (NUM_CARNET),
CONSTRAINT CK_USUARIOS_F_NACIMIENTO CHECK (REGEXP_LIKE(F_NACIMIENTO,'[0-9]{4}-[0-9]{2}'))
);

CREATE TABLE EJEMPLARES
(
ID_EJEMPLAR VARCHAR2(8),
COD_LIBRO VARCHAR2(6) REFERENCES LIBROS,
ESTADO CHAR(1),

CONSTRAINT PK_EJEMPLARES PRIMARY KEY (ID_EJEMPLAR),
CONSTRAINT CK_EJEMPLARES_COD_LIBRO CHECK ((SUBSTR(ID_EJEMPLAR,1,6)=COD_LIBRO) AND REGEXP_LIKE(SUBSTR(ID_EJEMPLAR,7),'-[0-9]')),
CONSTRAINT CK_EJEMPLARES_ESTADO CHECK (ESTADO IN ('P','X','D'))
);

CREATE TABLE PRESTAMOS
(
ID_EJEMPLAR VARCHAR2(8) REFERENCES EJEMPLARES,
NUM_CARNET VARCHAR2(30) REFERENCES USUARIOS,
F_PRESTAMO DATE DEFAULT SYSDATE,
F_DEVOLUCION DATE DEFAULT SYSDATE+30,
COMENTARIOS VARCHAR2(30),

CONSTRAINT PK_PRESTAMOS PRIMARY KEY (ID_EJEMPLAR,F_PRESTAMO),
CONSTRAINT CK_PRESTAMOS_FECHAS CHECK (((F_DEVOLUCION-F_PRESTAMO))>=1 AND ((F_DEVOLUCION-F_PRESTAMO))<=30)
);

--APARTADO 7
ALTER TABLE USUARIOS
ADD CORREO VARCHAR2(30);

ALTER TABLE USUARIOS
ADD CONSTRAINT CK_USUARIOS_CORREO CHECK (CORREO LIKE '%@%' AND CORREO NOT LIKE '%@%@%');

--APARTADO 8
--ALTER NECESARIOS PARA LA CREACI�N DE LA TABLA DE BIBLIOTECARIOS
ALTER TABLE PRESTAMOS
ADD NUM_PRESTAMO VARCHAR2(30);

ALTER TABLE PRESTAMOS
DROP CONSTRAINT PK_PRESTAMOS;

ALTER TABLE PRESTAMOS
ADD CONSTRAINT PK_PRESTAMOS PRIMARY KEY (NUM_PRESTAMO);

--CREACI�N DE LA TABLA DE BIBLIOTECARIOS

CREATE TABLE BIBLIOTECARIOS
(
NUM_BIBLIOTECARIO VARCHAR2(30),
NOMBRE_BIBLIOTECARIO VARCHAR2(30),
NUM_PRESTAMO VARCHAR2(30),

CONSTRAINT PK_BIBLIOTECARIOS PRIMARY KEY (NUM_BIBLIOTECARIO),
CONSTRAINT FK_BIBLIOTECARIOS FOREIGN KEY (NUM_PRESTAMO) REFERENCES PRESTAMOS
);