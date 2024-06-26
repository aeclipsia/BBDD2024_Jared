SELECT * FROM SUCURSALES;
SELECT * FROM CLIENTES;
SELECT * FROM CUENTAS;
SELECT * FROM MOVIMIENTOS;

create or replace FUNCTION COMPRUEBA_CUENTAS (PNIF1 VARCHAR2, PNIF2 VARCHAR2)
RETURN VARCHAR2
IS
CONTADOR NUMBER;
VNUM_CUENTA CUENTAS.NUM_CUENTA%TYPE;
VTIPO CUENTAS.TIPO%TYPE;
VSALDO CUENTAS.SALDO%TYPE;
VCOUNTMOVIMIENTOS NUMBER;
BEGIN
  
  IF PNIF1 IS NULL THEN
    SELECT COUNT(*) INTO CONTADOR
    FROM CUENTAS
    WHERE (NIF_TITULAR=PNIF2 AND NIF_COTITULAR is NULL);
  ELSIF PNIF2 IS NULL THEN
    SELECT COUNT(*) INTO CONTADOR
    FROM CUENTAS
    WHERE (NIF_TITULAR=PNIF1 AND NIF_COTITULAR is NULL);
  ELSE
    SELECT COUNT(*) INTO CONTADOR
    FROM CUENTAS
    WHERE (NIF_TITULAR=PNIF1 AND NIF_COTITULAR=PNIF2)
      OR (NIF_TITULAR=PNIF2 AND NIF_COTITULAR=PNIF1);
  END IF;
        
  IF CONTADOR = 0 THEN
    RETURN 'NO EXISTE NINGUNA';
  ELSIF CONTADOR > 1 THEN
    RETURN 'EXISTEN VARIAS';
  ELSIF CONTADOR = 1 THEN
    IF PNIF1 IS NULL THEN
      SELECT NUM_CUENTA INTO VNUM_CUENTA
        FROM CUENTAS
        WHERE (NIF_TITULAR=PNIF2 AND NIF_COTITULAR IS NULL);
    
      SELECT TIPO INTO VTIPO
        FROM CUENTAS
        WHERE (NIF_TITULAR=PNIF2 AND NIF_COTITULAR IS NULL);
        
      SELECT SALDO INTO VSALDO
        FROM CUENTAS
        WHERE (NIF_TITULAR=PNIF2 AND NIF_COTITULAR IS NULL);
        
      SELECT COUNT(*) INTO VCOUNTMOVIMIENTOS
        FROM MOVIMIENTOS
        WHERE NUM_CUENTA = (SELECT NUM_CUENTA
                              FROM CUENTAS
                              WHERE (NIF_TITULAR=PNIF2 AND NIF_COTITULAR IS NULL));
        
    ELSIF PNIF2 IS NULL THEN
      SELECT NUM_CUENTA INTO VNUM_CUENTA
        FROM CUENTAS
        WHERE (NIF_TITULAR=PNIF1 AND NIF_COTITULAR IS NULL);
    
      SELECT TIPO INTO VTIPO
        FROM CUENTAS
        WHERE (NIF_TITULAR=PNIF1 AND NIF_COTITULAR IS NULL);
        
      SELECT SALDO INTO VSALDO
        FROM CUENTAS
        WHERE (NIF_TITULAR=PNIF1 AND NIF_COTITULAR IS NULL);
        
      SELECT COUNT(*) INTO VCOUNTMOVIMIENTOS
        FROM MOVIMIENTOS
        WHERE NUM_CUENTA = (SELECT NUM_CUENTA
                              FROM CUENTAS
                              WHERE (NIF_TITULAR=PNIF1 AND NIF_COTITULAR IS NULL));
    ELSE
      SELECT NUM_CUENTA INTO VNUM_CUENTA
      FROM CUENTAS
      WHERE (NIF_TITULAR=PNIF1 AND NIF_COTITULAR=PNIF2)
        OR (NIF_TITULAR=PNIF2 AND NIF_COTITULAR=PNIF1);
    
    SELECT TIPO INTO VTIPO
      FROM CUENTAS
      WHERE (NIF_TITULAR=PNIF1 AND NIF_COTITULAR=PNIF2)
        OR (NIF_TITULAR=PNIF2 AND NIF_COTITULAR=PNIF1);
        
    SELECT SALDO INTO VSALDO
      FROM CUENTAS
      WHERE (NIF_TITULAR=PNIF1 AND NIF_COTITULAR=PNIF2)
        OR (NIF_TITULAR=PNIF2 AND NIF_COTITULAR=PNIF1);
        
    SELECT COUNT(*) INTO VCOUNTMOVIMIENTOS
        FROM MOVIMIENTOS
        WHERE NUM_CUENTA = (SELECT NUM_CUENTA
                              FROM CUENTAS
                              WHERE (NIF_TITULAR=PNIF1 AND NIF_COTITULAR=PNIF2)
                              OR (NIF_TITULAR=PNIF2 AND NIF_COTITULAR=PNIF1));
                              
    END IF;        
    RETURN 'CUENTA '||VNUM_CUENTA||': TIPO '||VTIPO||' CON SALDO '||VSALDO||' Y '||VCOUNTMOVIMIENTOS||' MOVIMIENTOS EN TOTAL';
  END IF;
END;

EXECUTE DBMS_OUTPUT.PUT_LINE(COMPRUEBA_CUENTAS('56565656R',null)); --SOLO UNA CUENTA--
EXECUTE DBMS_OUTPUT.PUT_LINE(COMPRUEBA_CUENTAS('56565656R','24242424K')); --EXISTEN VARIAS--
EXECUTE DBMS_OUTPUT.PUT_LINE(COMPRUEBA_CUENTAS('56565656R','21111111T')); --NO EXISTE NINGUNA--

CREATE OR REPLACE FUNCTION COMPRUEBA_CLIENTE (PNOMBRE VARCHAR2)
RETURN VARCHAR2
IS
VNIF CLIENTES.NIF%TYPE;
BEGIN
  SELECT NIF INTO VNIF
  FROM CLIENTES
    WHERE UPPER(NOMBRE) = UPPER(PNOMBRE);
    
  RETURN VNIF;
  
EXCEPTION
  WHEN no_data_found THEN
    RETURN NULL;
END;

EXECUTE DBMS_OUTPUT.PUT_LINE(COMPRUEBA_CLIENTE ('MARIANO MORENO')); --NOMBRE ENCONTRADO--
EXECUTE DBMS_OUTPUT.PUT_LINE(COMPRUEBA_CLIENTE ('mariano moreno')); --NOMBRE ENCONTRADO--
EXECUTE DBMS_OUTPUT.PUT_LINE(COMPRUEBA_CLIENTE ('YOLANDA BARRIO')); --NOMBRE NO ENCONTRADO--

CREATE OR REPLACE PROCEDURE ALTA_NUEVA_CUENTA (PNOMBRE1 VARCHAR2, PNOMBRE2 VARCHAR2, PNUM_SUCURSAL NUMBER, PTIPO CHAR, PSALDO NUMBER)
AS
NULL_POINTER_EXCEPTION EXCEPTION;
NIF_NULL_EXCEPTION EXCEPTION;
NIF_DUPLICATE_EXCEPTION EXCEPTION;
SUCURSAL_NULL_EXCEPTION EXCEPTION;
TIPO_INVALID_EXCEPTION EXCEPTION;
VNIF1 CUENTAS.NIF_TITULAR%TYPE;
VNIF2 CUENTAS.NIF_TITULAR%TYPE;
CONTADOR NUMBER;
NCUENTA CUENTAS.NUM_CUENTA%TYPE;
BEGIN

  --A--

  IF PNOMBRE1 IS NULL OR PNUM_SUCURSAL IS NULL OR PTIPO IS NULL OR PSALDO IS NULL THEN
    RAISE NULL_POINTER_EXCEPTION;
  END IF;
  
  VNIF1:=COMPRUEBA_CLIENTE(PNOMBRE1);
  
  IF VNIF1 IS NULL THEN
    RAISE NIF_NULL_EXCEPTION;
  END IF;
  
  IF PNOMBRE2 IS NOT NULL THEN
    VNIF2:=COMPRUEBA_CLIENTE(PNOMBRE2);
    IF VNIF2 IS NULL THEN
      RAISE NIF_NULL_EXCEPTION;
    ELSIF VNIF2 = VNIF1 THEN
      RAISE NIF_DUPLICATE_EXCEPTION;
    END IF;
  ELSE
    VNIF2:=NULL;
  END IF;
  
  SELECT COUNT(NUM_SUCURSAL) INTO CONTADOR
    FROM SUCURSALES
    WHERE NUM_SUCURSAL = PNUM_SUCURSAL;
    
  IF CONTADOR = 0 THEN
    RAISE SUCURSAL_NULL_EXCEPTION;
  END IF;
  
  IF PTIPO NOT IN ('C','P','F') THEN
    RAISE TIPO_INVALID_EXCEPTION;
  END IF;
  
  --B--
  
  SELECT NVL(MAX(NUM_CUENTA),0) INTO NCUENTA
    FROM CUENTAS
    WHERE TIPO = PTIPO;
    
  IF TO_CHAR(SYSDATE,'D')=6 THEN
    INSERT INTO CUENTAS
      VALUES(NCUENTA+100,VNIF1,VNIF2,SYSDATE+2,PNUM_SUCURSAL,PTIPO,PSALDO,NULL);
  ELSIF TO_CHAR(SYSDATE,'D')=7 THEN
    INSERT INTO CUENTAS
      VALUES(NCUENTA+100,VNIF1,VNIF2,SYSDATE+1,PNUM_SUCURSAL,PTIPO,PSALDO,NULL);
  ELSE
    INSERT INTO CUENTAS
      VALUES(NCUENTA+100,VNIF1,VNIF2,SYSDATE,PNUM_SUCURSAL,PTIPO,PSALDO,NULL);
  END IF;
  
  DBMS_OUTPUT.PUT_LINE(COMPRUEBA_CUENTAS(VNIF1, VNIF2));
  
EXCEPTION
  WHEN NULL_POINTER_EXCEPTION THEN
    DBMS_OUTPUT.PUT_LINE('HAY CAMPOS OBLIGATORIOS QUE SON NULOS');
    
  WHEN NIF_NULL_EXCEPTION THEN
    DBMS_OUTPUT.PUT_LINE('NIF NO ENCONTRADO EN CLIENTES');
    
  WHEN NIF_DUPLICATE_EXCEPTION THEN
    DBMS_OUTPUT.PUT_LINE('NOMBRE1 Y NOMBRE2 TIENEN EL MISMO NIF. ERROR!'); 
    
  WHEN SUCURSAL_NULL_EXCEPTION THEN
    DBMS_OUTPUT.PUT_LINE('SUCURSAL NO EXISTE'); 
    
  WHEN TIPO_INVALID_EXCEPTION THEN
    DBMS_OUTPUT.PUT_LINE('TIPO NO VALIDO'); 
END;

EXECUTE ALTA_NUEVA_CUENTA('ALBERTO MOTOROLA',NULL,210,'C',13000); --NUM_CUENTA DEBE SER 17100
EXECUTE ALTA_NUEVA_CUENTA('BENITO REYES','LUCIA SALVADOR',210,'F',-123455); --30100--
EXECUTE ALTA_NUEVA_CUENTA('ALBERTO MOTOROLA','MARIANO MORENO',210,'C',13000); --17200--

--COMPROBACION DE ERRORES
EXECUTE ALTA_NUEVA_CUENTA(NULL,'BENITO REYES',210,'C',13000); --CAMPOS NULOS--
EXECUTE ALTA_NUEVA_CUENTA('YOLANDA BARRIO',NULL,210,'C',13000); --NOMBRE1 NO EST� EN CLIENTES--
EXECUTE ALTA_NUEVA_CUENTA('ALBERTO MOTOROLA','YOLANDA BARRIO',210,'C',13000); --NOMBRE2 NO EST� EN CLIENTES--
EXECUTE ALTA_NUEVA_CUENTA('ALBERTO MOTOROLA','ALBERTO MOTOROLA',210,'C',13000); --NIF IGUALES--
EXECUTE ALTA_NUEVA_CUENTA('ALBERTO MOTOROLA',NULL,207,'C',13000); --SUCURSAL NO EXISTE--
EXECUTE ALTA_NUEVA_CUENTA('ALBERTO MOTOROLA',NULL,210,'A',13000); --TIPO NO VALIDO--