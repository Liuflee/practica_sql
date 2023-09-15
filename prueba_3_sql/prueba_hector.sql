CREATE SEQUENCE sequencia START WITH 10000 INCREMENT BY 10;

CREATE TABLE EDITORIAL (
cod_editorial NUMBER(4) CONSTRAINT pk_editorial_edi PRIMARY KEY,
nombre_editorial VARCHAR2(25) NOT NULL
);

CREATE TABLE AUTOR (
cod_autor NUMBER(4) CONSTRAINT pk_autor_aut PRIMARY KEY,
nombre_autor VARCHAR2(25) NOT NULL
);

CREATE TABLE FACULTAD (
cod_facultad NUMBER(2) CONSTRAINT pk_facultad_fac PRIMARY KEY,
nombre_facultad VARCHAR2(25) NOT NULL
);

CREATE TABLE CAMPUS (
cod_campus NUMBER(2),
nombre_campus VARCHAR2(25) CONSTRAINT pk_campus_cam PRIMARY KEY
);

CREATE TABLE CARRERA (
cod_carrera NUMBER(2) CONSTRAINT pk_carrera_car PRIMARY KEY,
nombre_carrera VARCHAR2(25) NOT NULL,
cod_facultad NUMBER(2) CONSTRAINT fk_carrera_facultad_car REFERENCES FACULTAD(cod_facultad)
);

CREATE TABLE TITULO (
cod_titulo NUMBER(6) CONSTRAINT pk_titulo_tit PRIMARY KEY,
titulo VARCHAR2(30) NOT NULL,
isbn NUMBER(6) CONSTRAINT isbn_unico_tit UNIQUE NOT NULL,
ano_publicacion NUMBER(4),
cod_editorial NUMBER(4) CONSTRAINT fk_titulo_editorial_tit REFERENCES EDITORIAL(cod_editorial)
);

CREATE TABLE DET_AUTOR (
AUTOR_codautor NUMBER(4) CONSTRAINT pk_det_autor_det PRIMARY KEY,
TITULO_codtitulo NUMBER(6) CONSTRAINT fk_det_autor_titulo_det REFERENCES TITULO(cod_titulo),
CONSTRAINT fk_det_autor_autor_det REFERENCES AUTOR(cod_autor)
);

CREATE TABLE BIBLIOTECA (
cod_biblioteca NUMBER(2) CONSTRAINT pk_biblioteca_bib PRIMARY KEY,
nombre_biblioteca VARCHAR2(25) NOT NULL,
cod_campus NUMBER(2) CONSTRAINT fk_biblioteca_campus_bib REFERENCES CAMPUS(cod_campus),
mts_cuadrados NUMBER(4) NOT NULL,
capacidad NUMBER(3) NOT NULL
);

CREATE TABLE VOLUMEN (
cod_volumen NUMBER(6) CONSTRAINT pk_volumen_vol PRIMARY KEY DEFAULT sequencia.NEXTVAL,
fecha_creacion DATE NOT NULL,
fecha_ultimo_inventario DATE,
estado VARCHAR2(25) NOT NULL,
BIBLIOTECE_codbiblioteca NUMBER(2) CONSTRAINT fk_volumen_biblioteca_vol REFERENCES BIBLIOTECA(cod_biblioteca),
TITULO_codtitulo NUMBER(6) CONSTRAINT fk_volumen_titulo_vol REFERENCES TITULO(cod_titulo)
);

CREATE TABLE ESTUDIANTE (
rut NUMBER(9) CONSTRAINT pk_estudiante_est PRIMARY KEY,
dv NUMBER(1) NOT NULL,
p_nombre VARCHAR2(25),
s_nombre VARCHAR2(25),
ap_paterno VARCHAR2(25) NOT NULL,
ap_materno VARCHAR2(25) NOT NULL,
email VARCHAR2(25) NOT NULL,
celular NUMBER(9) NOT NULL,
CONSTRAINT rut_unico_est UNIQUE (rut)
);

CREATE TABLE PRESTAMO (
id_prestamo NUMBER(6) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 999999 START WITH 1 INCREMENT BY 1
CONSTRAINT PRIMARY KEY,
estudiante_rut NUMBER(9) CONSTRAINT fk_prestamo_estudiante_pre REFERENCES ESTUDIANTE(rut),
cod_volumen NUMBER(6) CONSTRAINT fk_prestamo_volumen_pre REFERENCES VOLUMEN(cod_volumen),
fecha_prestamo DATE NOT NULL
);

CREATE TABLE DET_PRESTAMO_MES (
id_prestamo NUMBER(6) CONSTRAINT fk_pcm_prestamo_pre REFERENCES PRESTAMO(id_prestamo),
cod_carrera NUMBER(2) CONSTRAINT fk_pcm_carrera_car REFERENCES CARRERA(cod_carrera),
mes NUMBER(2) NOT NULL,
anio NUMBER(4) NOT NULL,
CONSTRAINT pk_pcm_pre PRIMARY KEY (id_prcod_carrera)
);