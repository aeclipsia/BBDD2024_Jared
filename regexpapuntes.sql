CREATE TABLE TEST
(
TELMOVIL VARCHAR2(9),
CONSTRAINT CK_TELMOVIL CHECK (REGEXP_LIKE(TELMOVIL,'^[6-7]{1}[0-9]{8}$'))
);