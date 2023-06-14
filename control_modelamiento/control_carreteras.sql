/*

6.	Diseñar una base de datos que recoja la organización para contener
la información sobre todas las carreteras del país,
sabiendo que se deben cumplir las siguientes especificaciones:

a.	Las carreteras están divididas en varias categorías 
(locales, comerciales, regionales, nacionales, autovías, etc).

b.	Las carreteras se dividen en tramos.
Un tramo siempre pertenece a una única carretera y no puede cambiar de carretera.

c.	Un tramo puede pasar por varias comunas, interesando conocer el Km de la carretera
y la comuna donde empieza el tramo y en donde termina.

d.	Para los tramos que suponen principio o final de carretera, interesa saber si es que la carretera
concluye físicamente o es que confluye en otra carretera.
En este caso, interesa conocer con qué carretera confluye y en qué kilómetro, tramo y comuna.

*/


--Creacion tabla carretera

CREATE TABLE CARRETERA (
  id_carretera NUMBER(7) 
  GENERATED ALWAYS AS IDENTITY
  MINVALUE 10 MAXVALUE 9999999
  INCREMENT BY 10 START WITH 10
  CONSTRAINT PK_CARRETERA PRIMARY KEY,
  nombre_carretera VARCHAR2(50) NOT NULL,
  categoria VARCHAR2(50) NOT NULL
);

--Creacion tabla comuna


CREATE TABLE COMUNA (
  id_comuna NUMBER(7)
  GENERATED ALWAYS AS IDENTITY
  MINVALUE 10 MAXVALUE 9999999
  INCREMENT BY 10 START WITH 10
  CONSTRAINT PK_COMUNA PRIMARY KEY,
  nombre_comuna VARCHAR2(30) NOT NULL
);

--Creacion tabla tramo

CREATE TABLE TRAMO (
  id_tramo NUMBER(7) 
  GENERATED ALWAYS AS IDENTITY
  MINVALUE 10 MAXVALUE 9999999
  INCREMENT BY 10 START WITH 10
  CONSTRAINT PK_TRAMO PRIMARY KEY,
  id_carretera NUMBER(7) CONSTRAINT FK_CARRETERA_TRAMO 
  REFERENCES CARRETERA(id_carretera),
  km_inicio NUMBER(5) NOT NULL,
  km_fin NUMBER(5) NOT NULL,
  comuna_inicio NUMBER(7) CONSTRAINT FK_COMUNA_INICIO 
  REFERENCES COMUNA(id_comuna),
  comuna_fin NUMBER(7) CONSTRAINT FK_COMUNA_FIN 
  REFERENCES COMUNA(id_comuna)
);

--Creacion tabla confluencia 

CREATE TABLE CONFLUENCIA (
  id_confluencia NUMBER(7)
  GENERATED ALWAYS AS IDENTITY
  MINVALUE 10 MAXVALUE 9999999
  INCREMENT BY 10 START WITH 10
  CONSTRAINT PK_CONFLUENCIA PRIMARY KEY,
  id_tramo NUMBER(7) CONSTRAINT FK_TRAMO_CONF 
  REFERENCES TRAMO(id_tramo),
  km_confluencia NUMBER(5) NOT NULL,
  id_carretera NUMBER(7) CONSTRAINT FK_CARRETERA_CONF 
  REFERENCES CARRETERA(id_carretera),
  id_comuna NUMBER(7) CONSTRAINT FK_COMUNA_CONF 
  REFERENCES COMUNA(id_comuna)
);
