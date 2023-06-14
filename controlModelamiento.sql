
/*

e.	Las sedes olímpicas se dividen en complejos deportivos.
Los complejos deportivos se subdividen en aquellos en los que se desarrolla un único deporte y en los polideportivos.
Los complejos polideportivos tienen áreas designadas para cada deporte con un indicador de localización
(ejemplo: centro, esquina-NE, etc.).
Un complejo tiene una localización, un jefe de organización individual y un área total ocupada.

f.	Los dos tipos de complejos (deporte único y polideportivo) tendrán diferentes tipos de información.
Para cada tipo de sede, se conservará el número de complejos junto con su presupuesto aproximado.

g.	Cada complejo celebra una serie de eventos (ejemplo: la pista del estadio puede celebrar muchas
	carreras distintas.). 

h.  Para cada evento está prevista una fecha, duración, número de participantes, número de comisarios.
Una lista de todos los comisarios se conservará junto con la lista de los eventos en los que esté
involucrado cada comisario ya sea cumpliendo la tarea de juez u observador.
Tanto para cada evento como para el mantenimiento se necesitará cierto equipamiento
 (ejemplo: arcos, pértigas, barras paralelas, etc).

*/

CREATE TABLE SEDE_OLIMPICA(
    id_sede NUMBER(5) GENERATED ALWAYS AS IDENTITY
    MINVALUE 100  MAXVALUE 99999
    START WITH 100 INCREMENT BY 10
    CONSTRAINT PK_SEDE PRIMARY KEY,
    nombre_sede VARCHAR2(20) NOT NULL
);

CREATE TABLE DET_SEDE(
    id_det_sede NUMBER(5) GENERATED ALWAYS AS IDENTITY
    MINVALUE 1  MAXVALUE 99999
    START WITH 1 INCREMENT BY 10
    CONSTRAINT PK_DET_SEDE PRIMARY KEY,
    id_sede NUMBER(5) CONSTRAINT FK_SEDE_DET REFERENCES SEDE_OLIMPICA(id_sede),
    cant_complejos NUMBER(2) NOT NULL,
    presupuesto_aprox NUMBER(10) NOT NULL
);

CREATE TABLE JEFE_ORGANIZACION (
    id_jefe NUMBER(5) GENERATED ALWAYS AS IDENTITY
    MINVALUE 10000 MAXVALUE 99999
    START WITH 10000 INCREMENT BY 10
    CONSTRAINT PK_JEFE PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE COMPLEJO_DEP(
    id_complejo NUMBER(5) GENERATED ALWAYS AS IDENTITY
    MINVALUE 100 MAXVALUE 99999
    START WITH 100 INCREMENT BY 10
    CONSTRAINT PK_COMPLEJO PRIMARY KEY,
    id_sede NUMBER(5) CONSTRAINT FK_COMP_SEDE REFERENCES SEDE_OLIMPICA(id_sede),
    nom_complejo VARCHAR2(20) NOT NULL,
    localizacion VARCHAR2(20) NOT NULL,
    area_total_oc NUMBER(10), NOT NULL,
    id_jefe NUMBER(5) CONSTRAINT FK_COMP_JEFE REFERENCES JEFE_ORGANIZACION(id_jefe)
);

CREATE TABLE DEPORTE(
    id_deporte NUMBER(3) GENERATED ALWAYS AS IDENTITY
    MINVALUE 1 MAXVALUE 999
    START WITH 1 INCREMENT BY 1
    CONSTRAINT PK_DEPORTE PRIMARY KEY,
    nombre_deporte VARCHAR2(100) NOT NULL
);

CREATE TABLE AREA_DEPORTE(
    id_area_dep NUMBER(3) GENERATED ALWAYS AS IDENTITY
    MINVALUE 1 MAXVALUE 999
    START WITH 1 INCREMENT BY 1
    CONSTRAINT PK_AREA_DEP PRIMARY KEY,
    id_complejo NUMBER(5) CONSTRAINT FK_AREA_COMP REFERENCES COMPLEJO_DEP(id_complejo),
    id_deporte NUMBER(3) CONSTRAINT FK_AREA_DEP REFERENCES DEPORTE(id_deporte),  
    localizacion VARCHAR2(50) NOT NULL    
);

CREATE TABLE COMP_DEPORTIVO_UNIC OF COMPLEJO_DEP(
    id_deporte NUMBER(3) REFERENCES DEPORTE(id_deporte)
); 

CREATE TABLE COMP_POLIDEPORTIVO OF COMPLEJO_DEP(
    area_deporte NUMBER(3) REFERENCES AREA_DEPORTE(id_area_dep),
    indic_localizacion VARCHAR2(100) NOT NULL
); 

CREATE TABLE EVENTO (
    id_evento NUMBER(5) GENERATED ALWAYS AS IDENTITY
    MINVALUE 10000 MAXVALUE 99999
    START WITH 10000 INCREMENT BY 10
    CONSTRAINT PK_EVENTO PRIMARY KEY,
    id_complejo NUMBER(5) CONSTRAINT FK_EVENTO_COMP REFERENCES COMPLEJO_DEP(id_complejo),
    fecha DATE NOT NULL,
    duracion NUMBER(3) NOT NULL,
    cant_participantes NUMBER(5) NOT NULL,
    cant_comisarios NUMBER(5) NOT NULL
);

CREATE TABLE COMISARIO (
    id_comisario NUMBER(5) GENERATED ALWAYS AS IDENTITY
    MINVALUE 10000 MAXVALUE 99999
    START WITH 10000 INCREMENT BY 10
    CONSTRAINT PK_COMISARIO PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    id_evento NUMBER(5) CONSTRAINT FK_COMISARIO_EVENTO REFERENCES EVENTO(id_evento)
);

CREATE TABLE COMISARIO_EVENTO (
    id_comisario NUMBER(5) CONSTRAINT FK_COM_ID_EVENTO REFERENCES COMISARIO(id_comisario),
    id_evento NUMBER(5) CONSTRAINT FK_COM_EVENTO_ID REFERENCES EVENTO(id_evento),
    tarea VARCHAR2(50) NOT NULL
);

CREATE TABLE EQUIPAMIENTO (
    id_equipamiento NUMBER(5) GENERATED ALWAYS AS IDENTITY
    MINVALUE 10000 MAXVALUE 99999
    START WITH 10000 INCREMENT BY 10
    CONSTRAINT PK_EQUIPAMIENTO PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    id_evento NUMBER(5) CONSTRAINT FK_EQUIPAMIENTO_EVENTO REFERENCES EVENTO(id_evento)
);

CREATE TABLE EQUIPAMIENTO_EVENTO (
    id_equipamiento NUMBER(5) CONSTRAINT FK_EQUIPAMIENTO_EVENTO REFERENCES EQUIPAMIENTO(id_equipamiento),
    id_evento NUMBER(5) CONSTRAINT FK_EQUIPAMIENTO_EVENTO REFERENCES EVENTO(id_evento)
);

