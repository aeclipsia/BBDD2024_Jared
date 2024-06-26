--TABLA DE EMPLE Y DEPART

--CUANTOS APELLIDOS EMPIEZAN POR LA LETRA A
SELECT COUNT(APELLIDO)
  FROM EMPLE
    WHERE APELLIDO LIKE 'A%';
    
--SUELDO MEDIO, EL NÚMERO DE COMISION NO NULAS, EL MÁXIMO SUELDO Y EL MÍNIMO SUELDO DE LOS EMPLEADOS DEL DEPARTAMENTO 30
SELECT AVG(SALARIO)"SALARIO MEDIO", COUNT(COMISION)"COMISION NO NULAS",MAX(SALARIO)"SALARIO MÁXIMO",MIN(SALARIO)"SALARIO MÍNIMO"
  FROM EMPLE
    WHERE DEPT_NO=30;
    
--EMPLEADOS Y OFICIOS DISTINTOS EN VENTAS
SELECT COUNT(DISTINCT APELLIDO)"NOMBRES DISTINTOS",COUNT(DISTINCT OFICIO)"OFICIOS DISTINTOS"
  FROM EMPLE JOIN DEPART ON EMPLE.DEPT_NO = DEPART.DEPT_NO
    WHERE DEPART.DNOMBRE='VENTAS';
    
--POR CADA EMPLEADO DE VENTAS, EL APELLIDO, EL SALARIO INCREMENTADO EN 3.21%, AÑOS EN LA EMPRESA
SELECT APELLIDO, ROUND(SALARIO*1.321,1)"SALARIO INCREMENTADO EN 3.21%",TO_CHAR(SYSDATE,'YYYY')-TO_CHAR(EMPLE.FECHA_ALTA,'YYYY')"AÑOS EN LA EMPRESA"
  FROM EMPLE JOIN DEPART ON EMPLE.DEPT_NO = DEPART.DEPT_NO
    WHERE DEPART.DNOMBRE='VENTAS';
    
--MOSTRAR APELLIDO DE EMPLEADOS QUE GANAN MÁS DEL SALARIO MEDIO
SELECT APELLIDO, SALARIO
  FROM EMPLE
    WHERE SALARIO>(SELECT AVG(SALARIO) FROM EMPLE);
    
--MOSTRAR EL APELLIDO DEL EMPLEADO CON PEOR SALARIO DE LA EMPRESA SIN TENER EN CUENTA A LOS ADMINISTRATIVOS
SELECT APELLIDO, SALARIO
  FROM EMPLE
    WHERE SALARIO=(SELECT MIN(SALARIO) FROM EMPLE WHERE OFICIO != 'ADMINISTRATIVO');
    
--MOSTRAR DATOS DE EMPLEADO CON MAYOR SALARIO DE ADMINISTRATIVO
SELECT APELLIDO, SALARIO
  FROM EMPLE
    WHERE SALARIO=(SELECT MAX(SALARIO) FROM EMPLE WHERE OFICIO='ADMINISTRATIVO');
    
--TABLA DE ALUMNOS, ASIGNATURAS Y NOTAS

--NOTA MEDIA DE ELENA REDONDEADO A UN DECIMAL
SELECT APENOM, ROUND(AVG(NOTAS.NOTA),1)"NOTA MEDIA"
  FROM ALUMNOS JOIN NOTAS ON NOTAS.DNI = ALUMNOS.DNI
    WHERE APENOM = 'Alcalde García, Elena'
      GROUP BY APENOM;
      
--MEJOR NOTA ENTRE ALUMNOS DE MADRID
SELECT MAX(NOTA)
  FROM ALUMNOS JOIN NOTAS ON NOTAS.DNI = ALUMNOS.DNI
    WHERE ALUMNOS.POBLA='Madrid';
    
--MOSTRAR EL NOMBRE DE ALUMNO CON MEJOR NOTA DE MADRID
SELECT APENOM
  FROM ALUMNOS JOIN NOTAS ON NOTAS.DNI = ALUMNOS.DNI
    WHERE NOTA=(SELECT MAX(NOTA) FROM NOTAS JOIN ALUMNOS ON NOTAS.DNI = ALUMNOS.DNI WHERE POBLA='Madrid')
      AND POBLA='Madrid';
      
--MOSTRAR EL NOMBRE DEL ALUMNO QUE PEOR NOTA HA SACADO EN BBDD
SELECT APENOM, NOTA
  FROM ALUMNOS, ASIGNATURAS, NOTAS
    WHERE NOTAS.COD = ASIGNATURAS.COD AND NOTAS.DNI = ALUMNOS.DNI
      AND NOTA=(SELECT MIN(NOTA) FROM NOTAS JOIN ASIGNATURAS ON NOTAS.COD=ASIGNATURAS.COD WHERE NOMBRE='BBDD');
      
--MOSTRAR CUANTAS NOTAS DISTINTAS EN MARCAS O BBDD
SELECT COUNT(DISTINCT NOTA)"NOTAS DISTINTAS"
  FROM NOTAS JOIN ASIGNATURAS ON NOTAS.COD = ASIGNATURAS.COD
    WHERE NOMBRE='BBDD' OR NOMBRE='Marcas';
    
--TABLA ZONAS, EMPLE_PARQUE, ATRACCIONES, AVERIAS_PARQUE

--MOSTRAR CUANTOS ARREGLOS HA TERMINADO IGNACIO PEÑA Y CUANTOS TIENE PENDIENTES
SELECT COUNT(FECHA_ARREGLO)"NÚMERO DE ARREGLOS", COUNT(*)-COUNT(AVERIAS_PARQUE.FECHA_ARREGLO)"ARREGLOS PENDIENTES"
  FROM AVERIAS_PARQUE JOIN EMPLE_PARQUE ON EMPLE_PARQUE.DNI_EMPLE = AVERIAS_PARQUE.DNI_EMPLE
    WHERE NOM_EMPLEADO='Ignacio Peña';
      
--MOSTRAR CUANTAS AVERÍAS HA HABIDO EN LA ZONA GRAN MAQUINARIA
SELECT COUNT(*)"AVERÍAS EN GRAN MAQUINARIA"
  FROM AVERIAS_PARQUE JOIN ATRACCIONES ON AVERIAS_PARQUE.COD_ATRACCION = ATRACCIONES.COD_ATRACCION
    WHERE NOM_ZONA='Gran Maquinaria';
    
--MOSTRAR EL CODIGO DE LA ULTIMA ATRACCIÓN QUE SE HA AVERIADO
SELECT AVERIAS_PARQUE.COD_ATRACCION
  FROM AVERIAS_PARQUE
    WHERE FECHA_FALLA=(SELECT MAX(FECHA_FALLA) FROM AVERIAS_PARQUE);
    
--MOSTRAR EL CODIGO Y EL NOMBRE DE LA ATRACCIÓN QUE MÁS TIEMPO HA ESTADO SIN FUNCIONAR
SELECT AVERIAS_PARQUE.COD_ATRACCION, NOM_ATRACCION
  FROM AVERIAS_PARQUE JOIN ATRACCIONES ON AVERIAS_PARQUE.COD_ATRACCION = ATRACCIONES.COD_ATRACCION
    WHERE FECHA_ARREGLO-FECHA_FALLA=(SELECT MAX(FECHA_ARREGLO-FECHA_FALLA) FROM AVERIAS_PARQUE WHERE FECHA_ARREGLO IS NOT NULL);
    
--MOSTRAR CUANTAS AVERÍAS HAN SIDO ASIGNADAS A EMPLEADOS QUE SON ENCARGADOS DE LA ZONA DE LA ATRACCIÓN AVERIADA
SELECT COUNT(DISTINCT(COD_ATRACCION))"AVERÍAS"
  FROM ZONAS JOIN AVERIAS_PARQUE ON ZONAS.DNI_ENCARGADO=AVERIAS_PARQUE.DNI_EMPLE
    WHERE AVERIAS_PARQUE.DNI_EMPLE IN (SELECT DNI_ENCARGADO FROM ZONAS);