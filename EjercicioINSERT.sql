CREATE TABLE VENDEDOR (
    id_empleado NUMBER(5) 
    GENERATED ALWAYS AS IDENTITY
    MINVALUE 1 MAXVALUE 99999 
    START WITH 1 INCREMENT BY 1
    CONSTRAINT PK_VENDEDOR PRIMARY KEY,
    numrut NUMBER(10) NOT NULL,
    dvrut VARCHAR2(1) NOT NULL,
    pnombre VARCHAR2(20) NOT NULL,
    snombre VARCHAR2(20),
    appaterno VARCHAR2(20) NOT NULL,
    apmaterno VARCHAR2(20) NOT NULL,
    fecha_contrato DATE NOT NULL,
    sueldo_base NUMBER(7) NOT NULL
);

CREATE TABLE BOLETA (
    nro_boleta NUMBER(8) CONSTRAINT PK_BOLETA PRIMARY KEY,
    id_empleado NUMBER(5) CONSTRAINT FK_BOLETA REFERENCES VENDEDOR(id_empleado),
    fecha_boleta DATE NOT NULL,
    monto_total NUMBER(8) NOT NULL
);

CREATE TABLE COMISION_BOLETA (
    nro_boleta NUMBER(8),
    id_empleado NUMBER(5),
    monto_comision NUMBER(8) NOT NULL,
    CONSTRAINT PK_COM_BOLETA PRIMARY KEY (nro_boleta, id_empleado),
    CONSTRAINT FK_COM_BOLETA FOREIGN KEY (nro_boleta) REFERENCES BOLETA(nro_boleta),
    CONSTRAINT FK_COM_VENDEDOR FOREIGN KEY (id_empleado) REFERENCES VENDEDOR(id_empleado)
);


INSERT INTO VENDEDOR (numrut, dvrut, pnombre, snombre, appaterno, apmaterno, fecha_contrato, sueldo_base)
VALUES (22222222, '2', 'Pablo', NULL, 'Perez', 'Soto', TO_DATE('01-03-2010', 'dd-mm-yyyy'), 300000);

INSERT INTO VENDEDOR (numrut, dvrut, pnombre, snombre, appaterno, apmaterno, fecha_contrato, sueldo_base)
VALUES (33333333, '3', 'Pedro', 'Jose', 'Torres', 'Troncoso', TO_DATE('14-03-2011', 'dd-mm-yyyy'), 280000);

INSERT INTO VENDEDOR (numrut, dvrut, pnombre, snombre, appaterno, apmaterno, fecha_contrato, sueldo_base)
VALUES (44444444, '4', 'Francisco', 'Alejandro', 'Aguilar', 'Tapia', TO_DATE('01-06-2011', 'dd-mm-yyyy'), 250000);

INSERT INTO VENDEDOR (numrut, dvrut, pnombre, snombre, appaterno, apmaterno, fecha_contrato, sueldo_base)
VALUES (55555555, '5', 'María', NULL, 'Toledo', 'Arancibia', TO_DATE('01-03-2014', 'dd-mm-yyyy'), 180000);


INSERT INTO BOLETA VALUES(90, 3, TO_DATE('02-02-2014', 'dd-mm-yyyy'), 75000);
INSERT INTO BOLETA VALUES(100, 1, TO_DATE('01-03-2014', 'dd-mm-yyyy'), 200000);
INSERT INTO BOLETA VALUES(101, 1, TO_DATE('02-03-2014', 'dd-mm-yyyy'), 100000);
INSERT INTO BOLETA VALUES(102, 2, TO_DATE('02-03-2014', 'dd-mm-yyyy'), 75000);
INSERT INTO BOLETA VALUES(103, 3, TO_DATE('02-03-2014', 'dd-mm-yyyy'), 45200);

INSERT INTO COMISION_BOLETA VALUES(90, 3, 9750);
INSERT INTO COMISION_BOLETA VALUES(100, 1, 26000);
INSERT INTO COMISION_BOLETA VALUES(101, 1, 13000);
INSERT INTO COMISION_BOLETA VALUES(102, 2, 9750);
INSERT INTO COMISION_BOLETA VALUES(103, 3, 5876);

--A) Segundo nombre nulo

SELECT * FROM VENDEDOR WHERE snombre IS NULL;

--B) Boletas 02/03/2014

SELECT * FROM BOLETA WHERE fecha_boleta = TO_DATE('02-03-2014', 'dd-mm-yyyy');

--C) Comision boletas del empleado ID

SELECT * FROM COMISION_BOLETA WHERE id_empleado = 3;

--D) Mostrar vendedores ordenados por apellido paterno descendente

SELECT * FROM VENDEDOR ORDER BY appaterno DESC;


