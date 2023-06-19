/*

e.	Las sedes olímpicas se dividen en complejos deportivos.
Los complejos deportivos se subdividen en aquellos en los que se desarrolla un único deporte y en los polideportivos.
Los complejos polideportivos tienen áreas designadas para cada deporte con un indicador de localización (ejemplo: centro, esquina-NE, etc.).
Un complejo tiene una localización, un jefe de organización individual y un área total ocupada.

f.	Los dos tipos de complejos (deporte único y polideportivo) tendrán diferentes tipos de información.
Para cada tipo de sede, se conservará el número de complejos junto con su presupuesto aproximado.

g.	Cada complejo celebra una serie de eventos (ejemplo: la pista del estadio puede celebrar muchas
	carreras distintas.).

h.  Para cada evento está prevista una fecha, duración, número de participantes, número de comisarios.
Una lista de todos los comisarios se conservará junto con la lista de los eventos en los que esté involucrado
cada comisario ya sea cumpliendo la tarea de juez u observador.
Tanto para cada evento como para el mantenimiento se necesitará cierto equipamiento
(ejemplo: arcos, pértigas, barras paralelas, etc).

*/

CREATE TABLE SEDE_OLIMPICA(
    id_sede NUMBER(5) 
    GENERATED ALWAYS AS IDENTITY
    MINVALUE 100 MAXVALUE 99999
    START WITH 100 INCREMENT BY 10,
    nombre_sede VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_SEDE PRIMARY KEY (id_sede)
);

CREATE TABLE DET_SEDE(
    id_det_sede NUMBER(5) 
    GENERATED ALWAYS AS IDENTITY
    MINVALUE 1 MAXVALUE 99999
    START WITH 1 INCREMENT BY 10,
    id_sede NUMBER(5),
    cant_complejos NUMBER(2) NOT NULL,
    presupuesto_aprox NUMBER(10) NOT NULL,
    CONSTRAINT PK_DET_SEDE PRIMARY KEY (id_det_sede),
    CONSTRAINT FK_SEDE_DET FOREIGN KEY (id_sede) REFERENCES SEDE_OLIMPICA(id_sede)
);

CREATE TABLE JEFE_ORGANIZACION (
    id_jefe NUMBER(5) 
    GENERATED ALWAYS AS IDENTITY
    MINVALUE 10000 MAXVALUE 99999
    START WITH 10000 INCREMENT BY 10,
    nombre VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_JEFE PRIMARY KEY (id_jefe)
);

CREATE TABLE DEPORTE(
    id_deporte NUMBER(3) 
    GENERATED ALWAYS AS IDENTITY
    MINVALUE 1 MAXVALUE 999
    START WITH 1 INCREMENT BY 1,
    nombre_deporte VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_DEPORTE PRIMARY KEY (id_deporte)
);

CREATE TABLE COMPLEJO_DEP(
    id_complejo NUMBER(5) 
    GENERATED ALWAYS AS IDENTITY
    MINVALUE 100 MAXVALUE 99999
    START WITH 100 INCREMENT BY 10,
    id_sede NUMBER(5),
    nom_complejo VARCHAR2(20) NOT NULL,
    localizacion VARCHAR2(20) NOT NULL,
    area_total_oc NUMBER(10) NOT NULL,
    id_jefe NUMBER(5),
    tipo_complejo VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_COMPLEJO PRIMARY KEY (id_complejo),
    CONSTRAINT FK_COMP_SEDE FOREIGN KEY (id_sede) 
    REFERENCES SEDE_OLIMPICA (id_sede),
    CONSTRAINT FK_COMP_JEFE FOREIGN KEY (id_jefe) 
    REFERENCES JEFE_ORGANIZACION (id_jefe)
);

CREATE TABLE COMP_POLIDEPORTIVO (
    id_complejo NUMBER(5),
    area_deporte NUMBER(3),
    indic_localizacion VARCHAR2(100) NOT NULL,
    tipo_complejo VARCHAR2(20) 
    DEFAULT 'POLIDEPORTIVO' NOT NULL,
    CONSTRAINT PK_COMP_POLIDEPORTIVO PRIMARY KEY (id_complejo),
    CONSTRAINT FK_COMP_POLIDEPORTIVO FOREIGN KEY (id_complejo) 
    REFERENCES COMPLEJO_DEP (id_complejo)
);

CREATE TABLE COMP_DEPORTIVO_UNIC (
    id_complejo NUMBER(5),
    id_deporte NUMBER(3),
    tipo_complejo VARCHAR2(20) 
    DEFAULT 'DEPORTIVO UNIC' NOT NULL,
    CONSTRAINT PK_COMP_DEPORTIVO_UNIC PRIMARY KEY (id_complejo),
    CONSTRAINT FK_COMP_DEPORTIVO_UNIC FOREIGN KEY (id_complejo) 
    REFERENCES COMPLEJO_DEP (id_complejo),
    CONSTRAINT FK_COMP_DEPORTIVO_UNIC_DEPORTE FOREIGN KEY (id_deporte) 
    REFERENCES DEPORTE (id_deporte)
);

CREATE TABLE AREA_DEPORTE(
    id_area_dep NUMBER(3) 
    GENERATED ALWAYS AS IDENTITY
    MINVALUE 1 MAXVALUE 999
    START WITH 1 INCREMENT BY 1,
    id_complejo NUMBER(5),
    id_deporte NUMBER(3),
    localizacion VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_AREA_DEP PRIMARY KEY (id_area_dep),
    CONSTRAINT FK_AREA_COMP FOREIGN KEY (id_complejo) 
    REFERENCES COMPLEJO_DEP(id_complejo),
    CONSTRAINT FK_AREA_DEP FOREIGN KEY (id_deporte) 
    REFERENCES DEPORTE(id_deporte)
);

CREATE TABLE EVENTO (
    id_evento NUMBER(5) 
    GENERATED ALWAYS AS IDENTITY
    MINVALUE 10000 MAXVALUE 99999
    START WITH 10000 INCREMENT BY 10,
    id_complejo NUMBER(5),
    fecha DATE NOT NULL,
    duracion NUMBER(3) NOT NULL,
    cant_participantes NUMBER(5) NOT NULL,
    cant_comisarios NUMBER(5) NOT NULL,
    CONSTRAINT PK_EVENTO PRIMARY KEY (id_evento),
    CONSTRAINT FK_EVENTO_COMP FOREIGN KEY (id_complejo) 
    REFERENCES COMPLEJO_DEP(id_complejo)
);

CREATE TABLE COMISARIO (
    id_comisario NUMBER(5) 
    GENERATED ALWAYS AS IDENTITY
    MINVALUE 10000 MAXVALUE 99999
    START WITH 10000 INCREMENT BY 10,
    nombre VARCHAR2(100) NOT NULL,
    id_evento NUMBER(5),
    CONSTRAINT PK_COMISARIO PRIMARY KEY (id_comisario),
    CONSTRAINT FK_COMISARIO_EVENTO FOREIGN KEY (id_evento) 
    REFERENCES EVENTO(id_evento)
);

CREATE TABLE COMISARIO_EVENTO (
    id_comisario NUMBER(5),
    id_evento NUMBER(5),
    tarea VARCHAR2(50) NOT NULL,
    CONSTRAINT FK_COM_ID_EVENTO FOREIGN KEY (id_comisario) 
    REFERENCES COMISARIO(id_comisario),
    CONSTRAINT FK_COM_EVENTO_ID FOREIGN KEY (id_evento) 
    REFERENCES EVENTO(id_evento)
);

CREATE TABLE EQUIPAMIENTO (
    id_equipamiento NUMBER(5) 
    GENERATED ALWAYS AS IDENTITY
    MINVALUE 10000 MAXVALUE 99999
    START WITH 10000 INCREMENT BY 10,
    nombre VARCHAR2(100) NOT NULL,
    id_evento NUMBER(5),
    CONSTRAINT PK_EQUIPAMIENTO PRIMARY KEY (id_equipamiento),
    CONSTRAINT FK_EQUIPAMIENTO_EVENTO FOREIGN KEY (id_evento) 
    REFERENCES EVENTO(id_evento)
);

CREATE TABLE EQUIPAMIENTO_EVENTO (
    id_equipamiento NUMBER(5),
    id_evento NUMBER(5),
    CONSTRAINT FK_EQUIP_EVENTO_ID FOREIGN KEY (id_equipamiento)
    REFERENCES EQUIPAMIENTO(id_equipamiento),
    CONSTRAINT FK_EQUIPAMIENTO_EVENTO_ID FOREIGN KEY (id_evento) 
    REFERENCES EVENTO(id_evento)
);