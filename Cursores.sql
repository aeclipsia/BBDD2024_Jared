CREATE OR REPLACE PROCEDURE MUESTRA_EMPLE(PDEPT_NO NUMBER)
AS
  CURSOR CUR_EMPLE IS
    SELECT APELLIDO, SALARIO, OFICIO
    FROM EMPLE
      WHERE DEPT_NO = PDEPT_NO;
  VAPELLIDO EMPLE.APELLIDO%TYPE;
  VSALARIO EMPLE.SALARIO%TYPE;
  VOFICIO EMPLE.OFICIO%TYPE;
  VCOUNT2K NUMBER;
BEGIN
  VCOUNT2K:=0;
  OPEN CUR_EMPLE;
  LOOP
    FETCH CUR_EMPLE INTO VAPELLIDO, VSALARIO, VOFICIO;
    EXIT WHEN CUR_EMPLE%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(VAPELLIDO ||','||VSALARIO||','||VOFICIO);
    
    IF VSALARIO>2000 THEN
      VCOUNT2K:=VCOUNT2K+1;
    END IF;
  END LOOP;
    DBMS_OUTPUT.PUT_LINE('SE HA ENCONTRADO '||CUR_EMPLE%ROWCOUNT||' EMPLEADOS');
    DBMS_OUTPUT.PUT_LINE(VCOUNT2K||' EMPLEADO(S) GANAN M�S DE 2000 EUROS');
  CLOSE CUR_EMPLE;
END;

EXECUTE MUESTRA_EMPLE(40);
EXECUTE MUESTRA_EMPLE(30);

CREATE OR REPLACE PROCEDURE MUESTRA_ANIMALES
AS
  CURSOR CUR_ANIMALES IS
    SELECT *
      FROM ANIMALES;
  VANIMALES ANIMALES%ROWTYPE;
  VPERRO NUMBER;
  VGATO NUMBER;
  VM NUMBER;
  VH NUMBER;
  VDUE�O DUE�OS.NOMBRE%TYPE;
BEGIN
  VPERRO:=0;
  VGATO:=0;
  VM:=0;
  VH:=0;
  OPEN CUR_ANIMALES;
  LOOP
    FETCH CUR_ANIMALES INTO VANIMALES;
    EXIT WHEN CUR_ANIMALES%NOTFOUND;
    
    SELECT NOMBRE INTO VDUE�O
      FROM DUE�OS
        WHERE DNI=VANIMALES.DNI_DUE�O;
    
    IF VANIMALES.SEXO='M' THEN
      DBMS_OUTPUT.PUT_LINE(VANIMALES.IDENT_ANIMAL ||','||VANIMALES.NOMBRE||','||VANIMALES.ESPECIE||', MACHO, '||VDUE�O);
      VM:=VM+1;
    ELSIF VANIMALES.SEXO='H' THEN
      DBMS_OUTPUT.PUT_LINE(VANIMALES.IDENT_ANIMAL ||','||VANIMALES.NOMBRE||','||VANIMALES.ESPECIE||', HEMBRA, '||VDUE�O);
      VH:=VH+1;
    END IF;
    
    IF VANIMALES.ESPECIE='PERRO' THEN
      VPERRO:=VPERRO+1;
    ELSIF VANIMALES.ESPECIE='GATO' THEN
      VGATO:=VGATO+1;
    END IF;
    
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE(VPERRO||' PERROS');
  DBMS_OUTPUT.PUT_LINE(VGATO||' GATOS');
  
  IF VM>VH THEN
    DBMS_OUTPUT.PUT_LINE('HAY MAS MACHOS QUE HEMBRAS');
  ELSE
    DBMS_OUTPUT.PUT_LINE('HAY MAS HEMBRAS QUE MACHOS');
  END IF;
  CLOSE CUR_ANIMALES;
END;

EXECUTE MUESTRA_ANIMALES;

select decode (sexo,'M','MACHO','H','HEMBRA','OTROS')
  from animales;
  
--Ejercicio 1
CREATE OR REPLACE PROCEDURE EJ_1_CURSORES (PDEPT_NO NUMBER)
AS
  CURSOR CUR_EMPLE IS
    SELECT *
      FROM EMPLE
      WHERE DEPT_NO = PDEPT_NO;
  VEMPLE EMPLE%ROWTYPE;
  VSALARIOTOTAL EMPLE.SALARIO%TYPE;
BEGIN
  VSALARIOTOTAL:=0;
  OPEN CUR_EMPLE;
  LOOP
    FETCH CUR_EMPLE INTO VEMPLE;
    EXIT WHEN CUR_EMPLE%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(VEMPLE.APELLIDO||', '||VEMPLE.SALARIO||', '||VEMPLE.OFICIO);
    VSALARIOTOTAL:=VSALARIOTOTAL+VEMPLE.SALARIO;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('SE HA MOSTRADO '||CUR_EMPLE%ROWCOUNT||' EMPLEADOS CON UN SALARIO TOTAL DE '||VSALARIOTOTAL);
  CLOSE CUR_EMPLE;
END;

EXECUTE EJ_1_CURSORES(40);
EXECUTE EJ_1_CURSORES(10);

--EJERCICIO 2
CREATE OR REPLACE PROCEDURE EJ_2_CURSORES(POFICIO VARCHAR2, PPORCENTAJE NUMBER)
AS
  CURSOR CUR_EMPLE IS
    SELECT *
    FROM EMPLE
      WHERE OFICIO=POFICIO;
  VEMPLE EMPLE%ROWTYPE;
  NULLPOINTEREXCEPTION EXCEPTION;
  PERCENTAGEINVALID EXCEPTION;
BEGIN
  IF POFICIO IS NULL OR PPORCENTAJE IS NULL THEN
    RAISE NULLPOINTEREXCEPTION;
  END IF;
  IF PPORCENTAJE < 0 OR PPORCENTAJE > 100 THEN
    RAISE PERCENTAGEINVALID;
  END IF;
  
  OPEN CUR_EMPLE;
  
  LOOP
    FETCH CUR_EMPLE INTO VEMPLE;
    EXIT WHEN CUR_EMPLE%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(VEMPLE.APELLIDO||', '||VEMPLE.SALARIO||', '||(VEMPLE.SALARIO*(1+(PPORCENTAJE/100))));
  END LOOP;
  
  CLOSE CUR_EMPLE;
EXCEPTION
  WHEN NULLPOINTEREXCEPTION THEN
    DBMS_OUTPUT.PUT_LINE('LOS PARAMETROS NO PUEDEN SER NULOS');
  WHEN PERCENTAGEINVALID THEN
    DBMS_OUTPUT.PUT_LINE('EL PORCENTAJE TIENE QUE ESTAR ENTRE 0 Y 100 INCLUIDOS');
END;

EXECUTE EJ_2_CURSORES('ADMINISTRATIVO',NULL);
EXECUTE EJ_2_CURSORES('ADMINISTRATIVO',120);
EXECUTE EJ_2_CURSORES('ADMINISTRATIVO',100);

--EJERCICIO 3
CREATE OR REPLACE PROCEDURE EJ_3_CURSORES
AS
  CURSOR CUR_VISITAS IS
    SELECT *
      FROM VISITAS
      ORDER BY MOTIVO, FH_VISITA;
  VVISITAS VISITAS%ROWTYPE;
  VNOMBRE ANIMALES.NOMBRE%TYPE;
  VDNI ANIMALES.DNI_DUE�O%TYPE;
BEGIN
  OPEN CUR_VISITAS;
  LOOP
    FETCH CUR_VISITAS INTO VVISITAS;
    EXIT WHEN CUR_VISITAS%NOTFOUND;
    
    SELECT NOMBRE INTO VNOMBRE 
      FROM ANIMALES
      WHERE IDENT_ANIMAL = VVISITAS.IDENT_ANIMAL;
      
    SELECT DNI_DUE�O INTO VDNI
      FROM ANIMALES
      WHERE IDENT_ANIMAL = VVISITAS.IDENT_ANIMAL; 
    
    DBMS_OUTPUT.PUT_LINE(VVISITAS.MOTIVO||', '||VVISITAS.FH_VISITA||', '||VNOMBRE||', '||VDNI||', '||VVISITAS.PRECIO);
  END LOOP;
END;

EXECUTE EJ_3_CURSORES;

--PROCEDIMIENTO QUE MUESTRA EL NOMBRE DE CADA ALUMNO JUNTO A SU NOTA MEDIA
CREATE OR REPLACE PROCEDURE MUESTRA_NOTA_MEDIA
AS
  CURSOR CUR_AL IS
    SELECT APENOM, AVG(NOTA) MEDIA
      FROM ALUMNOS JOIN NOTAS ON ALUMNOS.DNI = NOTAS.DNI
        GROUP BY APENOM;
BEGIN
  FOR I IN CUR_AL LOOP
    DBMS_OUTPUT.PUT_LINE(I.APENOM||': '||I.MEDIA);
  END LOOP;
END;

EXECUTE MUESTRA_NOTA_MEDIA;

--EJEMPLO 4

--INFO DE DEPART ESPECIFICO--
--INFO DE EMPLEADOS DE ESE DEPART--
--INFO DE OTRO DEPART--
--INFO DE EMPLEADOS DE ESE DEPARTAMENTO

CREATE OR REPLACE PROCEDURE MUESTRA_INFORME
AS
  CURSOR CUR_DEPART IS
    SELECT *
      FROM DEPART;
  VDEPT_NO DEPART.DEPT_NO%TYPE;
  CURSOR CUR_EMPLE IS
    SELECT *
      FROM EMPLE
        WHERE DEPT_NO = VDEPT_NO;
BEGIN
  FOR DEP IN CUR_DEPART LOOP
    DBMS_OUTPUT.PUT_LINE(DEP.DEPT_NO||' '||DEP.DNOMBRE||' '||DEP.LOC);
    VDEPT_NO:=DEP.DEPT_NO;
      FOR EMP IN CUR_EMPLE LOOP
        DBMS_OUTPUT.PUT_LINE('    '||EMP.APELLIDO||'  '||EMP.OFICIO);
      END LOOP;
  END LOOP;
END;

EXECUTE MUESTRA_INFORME;

--UN CURSOR QUE SAQUE CADA UNO DE LOS ALUMNOS: NOMBRE DEL ALUMNO
--CADA ASIGNATURA CON SUS NOTAS PARA CADA UNO DE SUS ALUMNOS

CREATE OR REPLACE PROCEDURE MUESTRA_NOTAS_INFORME
AS
  CURSOR CUR_ALUMNOS IS
    SELECT *
      FROM ALUMNOS;
  VDNI ALUMNOS.DNI%TYPE;
  CURSOR CUR_ASIGNATURAS IS
    SELECT *
      FROM NOTAS
        WHERE DNI=VDNI;
  VCOD NOTAS.COD%TYPE;
  VASIGNATURA ASIGNATURAS.NOMBRE%TYPE;
BEGIN
  FOR I IN CUR_ALUMNOS LOOP
    DBMS_OUTPUT.PUT_LINE(I.APENOM);
    VDNI:=I.DNI;
      FOR J IN CUR_ASIGNATURAS LOOP
        VCOD:=J.COD;
        SELECT NOMBRE INTO VASIGNATURA FROM ASIGNATURAS WHERE COD=VCOD; --select para convertir codigo de asignatura a su nombre
        DBMS_OUTPUT.PUT_LINE(' '||RPAD(VASIGNATURA,20,'-')||J.NOTA);
      END LOOP;
    DBMS_OUTPUT.PUT_LINE('--------------------------');
  END LOOP;
  
  SELECT APENOM
    FROM ALUMNOS
      WHERE DNI = (SELECT DNI
                    FROM NOTAS
                      GROUP BY DNI
                        HAVING AVG(NOTA) = (SELECT MAX(AVG(NOTA))
                                              FROM NOTAS
                                                GROUP BY DNI));
  
END;

EXECUTE MUESTRA_NOTAS_INFORME;

SELECT * FROM NOTAS JOIN ASIGNATURAS ON NOTAS.COD = ASIGNATURAS.COD;

--EJERCICIO 6
--Procedimiento que muestra para cada departamento su nombre y mejor y peor salario y n�mero de empleados que tiene.

CREATE OR REPLACE PROCEDURE EJ_6_CURSORES
AS
  CURSOR CUR_DEPART IS
    SELECT DNOMBRE, MAX(SALARIO) MAXIMO, MIN(SALARIO) MINIMO, COUNT(*) N_EMPLEADOS
    FROM DEPART JOIN EMPLE ON DEPART.DEPT_NO=EMPLE.DEPT_NO
    GROUP BY DNOMBRE;
BEGIN
  DBMS_OUTPUT.PUT_LINE(RPAD('DNOMBRE',20)||RPAD('M�XIMO',10)||RPAD('M�NIMO',10)||RPAD('N_EMPLEADOS',10));
  FOR I IN CUR_DEPART LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD(I.DNOMBRE,20)||RPAD(I.MAXIMO,10)||RPAD(I.MINIMO,10)||RPAD(I.N_EMPLEADOS,10));
  END LOOP;
END;

SET SERVEROUTPUT ON;

EXECUTE EJ_6_CURSORES;

--EJERCICIO 7
--Procedimiento que recibe el nombre de un due�o y lo env�a a una funci�n que devolver� el dni si existe o null si no existe.

CREATE OR REPLACE PROCEDURE EJ_7_CURSORES (PNOMBRE VARCHAR2)
AS
  CURSOR CUR_OWNERS IS
    SELECT DNI, NOMBRE, DIRECCION
      FROM DUE�OS;
  VDNI DUE�OS.DNI%TYPE;
  CURSOR CUR_ANIMALES IS
    SELECT IDENT_ANIMAL ID, NOMBRE, ESPECIE, RAZA
      FROM ANIMALES
        WHERE DNI_DUE�O=VDNI;
  VID ANIMALES.IDENT_ANIMAL%TYPE;
  CURSOR CUR_VISITAS IS
    SELECT FH_VISITA, VETERINARIOS.NOMBRE NOMBRE_VET, MOTIVO
      FROM VETERINARIOS JOIN VISITAS ON VISITAS.NUMCOLEGIADO=VETERINARIOS.NUMCOLEGIADO
        WHERE VISITAS.IDENT_ANIMAL=VID;
BEGIN
  VDNI:=BUSCAR_DNI(PNOMBRE);
  IF (VDNI IS NOT NULL) THEN --SI SE HA ENCONTRADO
    DBMS_OUTPUT.PUT_LINE(RPAD('ID',3)||RPAD('NOMBRE',10)||RPAD('ESPECIE',20)||RPAD('RAZA',30));
    FOR K IN CUR_ANIMALES LOOP
      DBMS_OUTPUT.PUT_LINE(RPAD(K.ID,3)||RPAD(K.NOMBRE,10)||RPAD(K.ESPECIE,20)||RPAD(K.RAZA,30));
      VID:=K.ID;
      DBMS_OUTPUT.PUT_LINE(LPAD(' ',5)||RPAD('FH_VISITA',10)||RPAD('NOMBRE_VET',22)||RPAD('MOTIVO',12));
      FOR L IN CUR_VISITAS LOOP
        DBMS_OUTPUT.PUT_LINE(LPAD(' ',5)||RPAD(L.FH_VISITA,10)||RPAD(L.NOMBRE_VET,22)||RPAD(L.MOTIVO,12));
      END LOOP;
      DBMS_OUTPUT.PUT_LINE(L.ROWCOUNT);
    END LOOP;
  ELSE --SI NO SE HA ENCONTRADO
    DBMS_OUTPUT.PUT_LINE(RPAD('DNI',10)||RPAD('NOMBRE',20)||RPAD('DIRECCION',20));
    FOR I IN CUR_OWNERS LOOP
      DBMS_OUTPUT.PUT_LINE(RPAD(I.DNI,10)||RPAD(I.NOMBRE,20)||RPAD(I.DIRECCION,20));
      VDNI:=I.DNI;
      DBMS_OUTPUT.PUT_LINE(LPAD(' ',5)||RPAD('ID',3)||RPAD('NOMBRE',10)||RPAD('ESPECIE',20));
      FOR J IN CUR_ANIMALES LOOP
        DBMS_OUTPUT.PUT_LINE(LPAD(' ',5)||RPAD(J.ID,3)||RPAD(J.NOMBRE,10)||RPAD(J.ESPECIE,20));
      END LOOP;
    END LOOP;
  END IF;
END;

CREATE OR REPLACE FUNCTION BUSCAR_DNI(PNOMBRE VARCHAR2)
RETURN DUE�OS.DNI%TYPE
IS
  VDNI DUE�OS.DNI%TYPE;
BEGIN
  SELECT DNI INTO VDNI
    FROM DUE�OS
      WHERE NOMBRE=PNOMBRE;
  RETURN VDNI;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;

EXECUTE EJ_7_CURSORES('Angel Manzano');

--EJERCICIO 8
--Por cada funci�n de mec�nico mostrar nombre y tel�fono de cada uno de sus mec�nicos y por cada mec�nico mostrar los tres �ltimos arreglos que ha hecho
--(matr�cula del coche, nombre del due�o, importe, fecha de entrada y d�as que ha estado o que lleva en el taller).

CREATE OR REPLACE PROCEDURE EJ_8_CURSORES
AS
  CURSOR CUR_FUNCION IS
    SELECT FUNCION
      FROM MECANICOS
      GROUP BY FUNCION;
  VFUNCION MECANICOS.FUNCION%TYPE;
  CURSOR CUR_MECANICOS IS
    SELECT *
      FROM MECANICOS
      WHERE VFUNCION=FUNCION;
  VNEMPLEADO MECANICOS.NEMPLEADO%TYPE;
  CURSOR CUR_ARREGLOS IS
SELECT A.MATRICULA MATRICULA, B.NOMBRE NOMBRE, A.IMPORTE IMPORTE, A.FECHA_ENTRADA ENTRADA, TRUNC(A.FECHA_SALIDA-A.FECHA_ENTRADA) DIAS
      FROM ARREGLOS A, CLIENTES_TALLER B, COCHES_TALLER C
      WHERE A.MATRICULA=C.MATRICULA AND B.NCLIENTE=C.NCLIENTE AND VNEMPLEADO=A.NEMPLEADO;
BEGIN
  FOR I IN CUR_FUNCION LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD('-',40,'-'));
    DBMS_OUTPUT.PUT_LINE(RPAD(I.FUNCION,40,'*'));
    DBMS_OUTPUT.PUT_LINE(RPAD('-',40,'-'));
    VFUNCION:=I.FUNCION;
    DBMS_OUTPUT.PUT_LINE(RPAD('NOMBRE',30)||RPAD('TELEFONO',12));
    FOR J IN CUR_MECANICOS LOOP
      DBMS_OUTPUT.PUT_LINE(RPAD(J.NOMBRE,30)||RPAD(J.TELEFONO,12));
      DBMS_OUTPUT.PUT_LINE(RPAD(' ',5)||RPAD('MATRICULA',10)||RPAD('NOMBRE',30)||RPAD('IMPORTE',10)||RPAD('ENTRADA',15)||RPAD('DIAS',6));
      VNEMPLEADO:=J.NEMPLEADO;
      FOR K IN CUR_ARREGLOS LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(' ',5)||RPAD(K.MATRICULA,10)||RPAD(K.NOMBRE,30)||RPAD(K.IMPORTE,10)||RPAD(K.ENTRADA,15)||RPAD(K.DIAS,6));
      END LOOP;
    END LOOP;
  END LOOP;
END;

SELECT * FROM COCHES_TALLER;
SELECT * FROM CLIENTES_TALLER;
SELECT * FROM ARREGLOS;

EXECUTE EJ_8_CURSORES;