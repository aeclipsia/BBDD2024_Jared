--TABLA DE DEPART Y EMPLE
--MOSTRAR POR CADA OFICIO CUÁNTOS EMPLEADOS TIENE, CUÁL ES EL MEJOR SALARIO, LA SUMA TOTAL DE LOS SALARIOS Y CUÁNTOS EMPLEADOS TIENEN COMISIÓN
SELECT OFICIO, COUNT(APELLIDO)"EMPLEADOS", MAX(SALARIO)"MEJOR SALARIO", SUM(SALARIO)"SALARIO TOTAL", COUNT(COMISION)"COMISION"
  FROM EMPLE
    GROUP BY OFICIO;

--MOSTRAR EL CÓDIGO Y NOMBRE DEL DEPT DE LOS DEPT CUYO SALARIO SUPERA 9000
SELECT DEPART.DEPT_NO, DEPART.DNOMBRE, SUM(SALARIO)
  FROM EMPLE JOIN DEPART ON EMPLE.DEPT_NO = DEPART.DEPT_NO
    GROUP BY DEPART.DEPT_NO, DEPART.DNOMBRE
      HAVING SUM(SALARIO)>9000;

--MOSTRAR LA MEDIA DEL SALARIO DE LOS DEPARTAMENTOS QUE TIENEN MÁS DE 3 EMPLEADOS SIN TENER EN CUENTA NI A LOS PRESIDENTES NI A LOS DIRECTORES
SELECT DNOMBRE, AVG(SALARIO)
  FROM EMPLE JOIN DEPART ON EMPLE.DEPT_NO = DEPART.DEPT_NO
    WHERE OFICIO != 'PRESIDENTE' AND OFICIO != 'DIRECTOR'
      GROUP BY DNOMBRE
       HAVING COUNT(*) > 3;

--MOSTRAR POR CADA MES Y AÑO CUANTOS EMPLEADOS HAN ENTRADO EN LA EMPRESA
SELECT TO_CHAR(FECHA_ALTA,'YYYY')"AÑO", TO_CHAR(FECHA_ALTA,'MM')"MES", COUNT(*)"Nº EMPLEADOS"
  FROM EMPLE
   GROUP BY TO_CHAR(FECHA_ALTA,'YYYY'), TO_CHAR(FECHA_ALTA,'MM')
     ORDER BY TO_CHAR(FECHA_ALTA,'YYYY'), TO_CHAR(FECHA_ALTA,'MM');

--MOSTRAR EL AÑO EN EL QUE HAN ENTRADO MÁS EMPLEADOS
SELECT TO_CHAR(FECHA_ALTA, 'YYYY'), COUNT(*)
  FROM EMPLE
    GROUP BY TO_CHAR(FECHA_ALTA, 'YYYY')
      HAVING COUNT(APELLIDO)= (SELECT MAX(COUNT(APELLIDO)) FROM EMPLE GROUP BY TO_CHAR(FECHA_ALTA, 'YYYY'));
      
--MOSTRAR EL AÑO EN EL QUE HAN ENTRADO MÁS EMPLEADOS SIN CONTAR CON LOS DIRECTORES
SELECT TO_CHAR(FECHA_ALTA, 'YYYY'), COUNT(*)
  FROM EMPLE
    WHERE OFICIO <> 'DIRECTOR'
      GROUP BY TO_CHAR(FECHA_ALTA, 'YYYY')
        HAVING COUNT(APELLIDO)= (SELECT MAX(COUNT(APELLIDO)) FROM EMPLE GROUP BY TO_CHAR(FECHA_ALTA, 'YYYY'));

--TABLAS ALUMNOS, ASIGNATURAS Y NOTAS
--MOSTRAR LA MEJOR Y PEOR NOTA EN CADA ASIGNATURA JUNTO CON EL NOMBRE DE LA ASIGNATURA
SELECT NOMBRE "ASIGNATURA", MAX(NOTA) "NOTA MÁXIMA", MIN(NOTA) "NOTA MÍNIMA"
  FROM ASIGNATURAS JOIN NOTAS ON NOTAS.COD = ASIGNATURAS.COD
    GROUP BY NOMBRE;
    
--MOSTRAR LAS ASIGNATURAS QUE TIENEN MÁS DE UN ALUMNO SUSPENSO
SELECT NOMBRE "ASIGNATURA", COUNT(NOTA)
  FROM ASIGNATURAS JOIN NOTAS ON NOTAS.COD = ASIGNATURAS.COD
    WHERE NOTA < 5
      GROUP BY NOMBRE;
      
--MOSTRAR POR CADA ALUMNO SU NOMBRE JUNTO A LA MEDIA DE SUS NOTAS PERO SOLO PARA ALUMNOS QUE ESTA MEDIA SEA AL MENOS 6
SELECT APENOM, AVG(NOTA)"MEDIA"
  FROM ALUMNOS JOIN NOTAS ON NOTAS.DNI = ALUMNOS.DNI
    GROUP BY APENOM
      HAVING AVG(NOTA)>=6;
      
--MOSTRAR EL CÓDIGO Y EL NOMBRE DE LA ASIGNATURA EN LA QUE SE HAN OBTENIDO MÁS SUSPENSOS
SELECT NOTAS.COD, NOMBRE"ASIGNATURA", COUNT(*)"NÚMERO DE SUSPENSOS"
  FROM NOTAS JOIN ASIGNATURAS ON NOTAS.COD = ASIGNATURAS.COD
    WHERE NOTA<5
      GROUP BY NOTAS.COD, NOMBRE
        HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM NOTAS WHERE NOTA<5 GROUP BY COD);
      
--TABLA DE PARQUE DE ATRACCIONES
--MOSTRAR CUANTAS AVERIÁS TERMINADAS HAY EN CADA ZONA
SELECT NOM_ZONA, COUNT(FECHA_ARREGLO)
  FROM AVERIAS_PARQUE JOIN ATRACCIONES ON AVERIAS_PARQUE.COD_ATRACCION = ATRACCIONES.COD_ATRACCION
    GROUP BY ATRACCIONES.NOM_ZONA;
    
--MOSTRAR CUAL ES LA ZONA CON MÁS AVERÍAS YA TERMINADAS
SELECT NOM_ZONA
  FROM AVERIAS_PARQUE JOIN ATRACCIONES ON AVERIAS_PARQUE.COD_ATRACCION = ATRACCIONES.COD_ATRACCION
    WHERE FECHA_ARREGLO IS NOT NULL
        GROUP BY NOM_ZONA
         HAVING COUNT(FECHA_ARREGLO)=(SELECT MAX(COUNT(FECHA_ARREGLO)) 
                                        FROM AVERIAS_PARQUE JOIN ATRACCIONES ON AVERIAS_PARQUE.COD_ATRACCION = ATRACCIONES.COD_ATRACCION
                                          WHERE FECHA_ARREGLO IS NOT NULL
                                            GROUP BY NOM_ZONA);
                                            
--MOSTRAR POR CADA EMPLEADO CUANTAS AVERÍAS TIENE
SELECT DNI_EMPLE, COUNT(*)"AVERÍAS"
  FROM AVERIAS_PARQUE
    GROUP BY DNI_EMPLE;
    
--MOSTRAR EL DNI Y NOMBRE DEL EMPLEADO QUE MÁS AVERÍAS TIENE
SELECT EMPLE_PARQUE.DNI_EMPLE, EMPLE_PARQUE.NOM_EMPLEADO, COUNT(FECHA_FALLA)
  FROM AVERIAS_PARQUE JOIN EMPLE_PARQUE ON EMPLE_PARQUE.DNI_EMPLE = AVERIAS_PARQUE.DNI_EMPLE
    GROUP BY EMPLE_PARQUE.DNI_EMPLE, NOM_EMPLEADO
      HAVING COUNT(FECHA_FALLA)=(SELECT MAX(COUNT(FECHA_FALLA)) FROM AVERIAS_PARQUE JOIN EMPLE_PARQUE ON EMPLE_PARQUE.DNI_EMPLE = AVERIAS_PARQUE.DNI_EMPLE
                                                                  GROUP BY EMPLE_PARQUE.DNI_EMPLE, NOM_EMPLEADO);
                                                                  
--MOSTRAR EL MES Y EL AÑO EN EL QUE MÁS SE HA GASTADO EN AVERÍAS
SELECT TO_CHAR(FECHA_FALLA, 'MM')"MES",TO_CHAR(FECHA_FALLA, 'YYYY')"AÑO"
  FROM AVERIAS_PARQUE
    WHERE COSTE_AVERIA=(SELECT MAX(COSTE_AVERIA) FROM AVERIAS_PARQUE)
      GROUP BY TO_CHAR(FECHA_FALLA, 'MM'),TO_CHAR(FECHA_FALLA, 'YYYY');