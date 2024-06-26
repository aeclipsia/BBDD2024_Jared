--PROCEDIMIENTO QUE RECIBE 2 NUMEROS Y MUESTRA EL CUADRADO DE LOS N�MEROS QUE AY ENTRE ELLOS

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE BUCLE_5(PNUM1 NUMBER, PNUM2 NUMBER)
AS
MAXI NUMBER;
MINI NUMBER;
BEGIN
  IF PNUM1>=PNUM2 THEN
    MAXI:=PNUM1;
    MINI:=PNUM2;
  ELSE
    MAXI:=PNUM2;
    MINI:=PNUM1;
  END IF;

  FOR CONTADOR IN MINI..MAXI LOOP
    DBMS_OUTPUT.PUT_LINE(CONTADOR*CONTADOR);
  END LOOP;
END;

EXECUTE BUCLE_5(7,4);
EXECUTE BUCLE_5(4,7);
EXECUTE BUCLE_5(4,4);

--PROCEDIMIENTO QUE RECIBE UN NUMERO Y VA SUMANDO 10 HASTA LLEGAR AL 100, MOSTRAR LO CALCULADO HASTA PASAR EL 100

create or replace PROCEDURE BUCLE_6(PNUM1 NUMBER)
AS
ACUMULADOR NUMBER:=PNUM1;
BEGIN
  WHILE ACUMULADOR<100 LOOP
    ACUMULADOR:=ACUMULADOR+10;
    DBMS_OUTPUT.PUT_LINE(ACUMULADOR);
  END LOOP;
END;

EXECUTE BUCLE_6(10);
EXECUTE BUCLE_6(57);