-- Creación de tablas

CREATE SEQUENCE seq_volumen
    START WITH 10000
    INCREMENT BY 10;

CREATE TABLE FACULTAD (
    codFacultad NUMBER(2) NOT NULL,
    nombreFacultad VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_FACULTAD PRIMARY KEY (codFacultad)
);

CREATE TABLE CARRERA (
    codCarrera NUMBER(2) NOT NULL,
    nombreCarrera VARCHAR2(50) NOT NULL,
    codFacultad NUMBER(2) NOT NULL,
    CONSTRAINT PK_CARRERA PRIMARY KEY (codCarrera),
    CONSTRAINT FK_CARRERA_FACULTAD FOREIGN KEY (codFacultad) REFERENCES FACULTAD(codFacultad)
);

CREATE TABLE CAMPUS (
    codCampus NUMBER(2),
    nombreCampus VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_CAMPUS PRIMARY KEY (codCampus)
);

CREATE TABLE AUTOR (
    codAutor NUMBER(4) NOT NULL,
    nombreAutor VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_AUTOR PRIMARY KEY (codAutor)
);

CREATE TABLE EDITORIAL (
    codEditorial NUMBER(4) NOT NULL,
    nombreEditorial VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_EDITORIAL PRIMARY KEY (codEditorial)
);

CREATE TABLE TITULO (
    codTitulo NUMBER(6) NOT NULL,
    titulo VARCHAR2(30) NOT NULL,
    ISBN NUMBER(7) NOT NULL,
    anoPublicacion NUMBER(4),
    codEditorial NUMBER(4) NOT NULL,
    CONSTRAINT PK_TITULO PRIMARY KEY (codTitulo),
    CONSTRAINT FK_TITULO_EDITORIAL FOREIGN KEY (codEditorial) REFERENCES EDITORIAL(codEditorial),
    CONSTRAINT ISBN_UNIQUE UNIQUE (ISBN)
);

CREATE TABLE DET_AUTOR (
    codAutor NUMBER(4) NOT NULL,
    codTitulo NUMBER(6) NOT NULL,
    CONSTRAINT PK_DET_AUTOR PRIMARY KEY (codAutor, codTitulo),
    CONSTRAINT FK_DET_AUTOR_AUTOR FOREIGN KEY (codAutor) REFERENCES AUTOR(codAutor),
    CONSTRAINT FK_DET_AUTOR_TITULO FOREIGN KEY (codTitulo) REFERENCES TITULO(codTitulo)
);

CREATE TABLE BIBLIOTECA (
    codBiblioteca NUMBER(2) NOT NULL,
    nombreBiblioteca VARCHAR2(50) NOT NULL,
    mtsCuadrados NUMBER(4) NOT NULL,
    capacidad NUMBER(3) NOT NULL,
    codCampus NUMBER(2) NOT NULL,
    CONSTRAINT PK_BIBLIOTECA PRIMARY KEY (codBiblioteca),
    CONSTRAINT FK_BIBLIOTECA_CAMPUS FOREIGN KEY (codCampus) REFERENCES CAMPUS(codCampus)
);

CREATE TABLE VOLUMEN (
    codVolumen NUMBER(6) DEFAULT seq_volumen.NEXTVAL,
    fechaCreacion DATE NOT NULL,
    fechaUltimoInventario DATE,
    estado VARCHAR2(50) NOT NULL,
    codBiblioteca NUMBER(2) NOT NULL,
    codTitulo NUMBER(6) NOT NULL,
    CONSTRAINT PK_VOLUMEN PRIMARY KEY (codVolumen),
    CONSTRAINT FK_VOLUMEN_BIBLIOTECA FOREIGN KEY (codBiblioteca) REFERENCES BIBLIOTECA(codBiblioteca),
    CONSTRAINT FK_VOLUMEN_TITULO FOREIGN KEY (codTitulo) REFERENCES TITULO(codTitulo)
);

CREATE TABLE ESTUDIANTE (
    rut NUMBER(9) CONSTRAINT PK_ESTUDIANTE PRIMARY KEY,
    dv NUMBER(1) NOT NULL,
    pNombre VARCHAR2(50),
    sNombre VARCHAR2(50),
    apPaterno VARCHAR2(50) NOT NULL,
    apMaterno VARCHAR2(50) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    celular NUMBER(9) NOT NULL
);

CREATE TABLE PRESTAMO (
    idPrestamo NUMBER(6) GENERATED ALWAYS AS IDENTITY
    MINVALUE 1 MAXVALUE 999999
    START WITH 1 INCREMENT BY 1,
    estudianteRut NUMBER(9) NOT NULL,
    codVolumen NUMBER(6) NOT NULL,
    fechaPrestamo DATE NOT NULL,
    CONSTRAINT PK_PRESTAMO PRIMARY KEY (idPrestamo),
    CONSTRAINT FK_PRESTAMO_ESTUDIANTE FOREIGN KEY (estudianteRut) REFERENCES ESTUDIANTE(rut),
    CONSTRAINT FK_PRESTAMO_VOLUMEN FOREIGN KEY (codVolumen) REFERENCES VOLUMEN(codVolumen)
);

CREATE TABLE PRESTAMO_CARRERA_MES (
    idPrestamo NUMBER(6) GENERATED ALWAYS AS IDENTITY
    MINVALUE 1 MAXVALUE 999999
    START WITH 1 INCREMENT BY 1,
    codCarrera NUMBER(2),
    mes NUMBER(2) NOT NULL,
    anio NUMBER(4) NOT NULL,
    CONSTRAINT FK_PCM_PRESTAMO FOREIGN KEY (idPrestamo) REFERENCES PRESTAMO(idPrestamo),
    CONSTRAINT FK_PCM_CARRERA FOREIGN KEY (codCarrera) REFERENCES CARRERA(codCarrera),
    CONSTRAINT PK_PCM PRIMARY KEY (codCarrera, mes, anio)
);


INSERT INTO FACULTAD (codFacultad, nombreFacultad) VALUES(1,'Administracion y Negocios');
INSERT INTO FACULTAD (codFacultad, nombreFacultad) VALUES(2,'Comunicacion');
INSERT INTO FACULTAD (codFacultad, nombreFacultad) VALUES(3,'Construccion');
INSERT INTO FACULTAD (codFacultad, nombreFacultad) VALUES(4,'Diseño');
INSERT INTO FACULTAD (codFacultad, nombreFacultad) VALUES(5,'Gastronomia');
INSERT INTO FACULTAD (codFacultad, nombreFacultad) VALUES(6,'Informatica y telecomunicaciones');
INSERT INTO FACULTAD (codFacultad, nombreFacultad) VALUES(7,'Ingenieria y recursos naturales');
INSERT INTO FACULTAD (codFacultad, nombreFacultad) VALUES(8,'Salud');
INSERT INTO FACULTAD (codFacultad, nombreFacultad) VALUES(9,'Turismo y hoteleria');


INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(1,'Auditoria', 1);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(2,'Comercio exterior', 1);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(3,'Actuacion', 2);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(4,'Animacion digital', 2);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(5,'Tecnico en construccion', 3);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(6,'Ingenieria en construccion', 3);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(7,'Desarrollo y diseño web', 4);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(8,'Diseño de vestuario', 4);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(9,'Gastronomia internacional', 5);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(10,'Analista de sistemas', 6);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(11,'Ingenieria en informatica', 6);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(12,'Ingenieria en conectividad y redes', 6);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(13,'Mecanico automotriz', 7);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(14,'Ingeniria agricola', 7);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(15,'Tecnico en enfermeria', 8);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(16,'Ingeniaria biomedica', 8);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(17,'Administracion hotelera', 9);
INSERT INTO CARRERA (codCarrera, nombreCarrera, codFacultad) VALUES(18,'Ecoturismo', 9);


INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(1,'Alameda');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(2,'Antonio Varas');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(3,'Maipu');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(4,'Melipilla');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(5,'Padre Alonso de Ovalle');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(6,'Plaza Norte');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(7,'Plaza Oeste');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(8,'Plaza Vespucio');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(9,'Puente Alto');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(10,'San Bernardo');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(11,'San Carlos de Apoquindo');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(12,'San Joaquín');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(13,'Valparaíso');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(14,'Viña del Mar');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(15,'Arauco');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(16,'Nacimiento');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(17,'San Andrés de Concepción');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(18,'Villarrica');
INSERT INTO CAMPUS (codCampus, nombreCampus) VALUES(19,'Puerto Montt');


INSERT INTO BIBLIOTECA VALUES(1,'Alameda', 407, 600, 1);
INSERT INTO BIBLIOTECA VALUES(2,'Antonio Varas', 224, 606, 2);
INSERT INTO BIBLIOTECA VALUES(3,'Maipu', 207, 909, 3);
INSERT INTO BIBLIOTECA VALUES(4,'Melipilla', 437, 553, 4);
INSERT INTO BIBLIOTECA VALUES(5,'Padre Alonso de Ovalle', 275, 741, 5);
INSERT INTO BIBLIOTECA VALUES(6,'Plaza Norte', 412, 731, 6);
INSERT INTO BIBLIOTECA VALUES(7,'Plaza Oeste', 204, 735, 7);
INSERT INTO BIBLIOTECA VALUES(8,'Plaza Vespucio', 275, 990, 8);
INSERT INTO BIBLIOTECA VALUES(9,'Puente Alto', 232, 830, 9);
INSERT INTO BIBLIOTECA VALUES(10,'San Bernardo', 468, 632, 10);
INSERT INTO BIBLIOTECA VALUES(11,'San Carlos de Apoquindo', 246, 674, 11);
INSERT INTO BIBLIOTECA VALUES(12,'San Joaquín', 483, 644, 12);
INSERT INTO BIBLIOTECA VALUES(13,'Valparaíso', 354, 593, 13);
INSERT INTO BIBLIOTECA VALUES(14,'Viña del Mar', 343, 971, 14);
INSERT INTO BIBLIOTECA VALUES(15,'Arauco', 443, 800, 15);
INSERT INTO BIBLIOTECA VALUES(16,'Nacimiento', 321, 839, 16);
INSERT INTO BIBLIOTECA VALUES(17,'San Andrés de Concepción', 296, 827, 17);
INSERT INTO BIBLIOTECA VALUES(18,'Villarrica', 298, 756, 18);
INSERT INTO BIBLIOTECA VALUES(19,'Puerto Montt', 502, 897, 19);


INSERT INTO EDITORIAL (codEditorial, nombreEditorial) VALUES(1,'Planeta');
INSERT INTO EDITORIAL (codEditorial, nombreEditorial) VALUES(2,'Zigzag');
INSERT INTO EDITORIAL (codEditorial, nombreEditorial) VALUES(3,'Alfaguara');
INSERT INTO EDITORIAL (codEditorial, nombreEditorial) VALUES(4,'Pearson');


INSERT INTO TITULO (codTitulo, titulo, ISBN, anoPublicacion, codEditorial) VALUES(1,'Papelucho', 6840355, 2010, 2);
INSERT INTO TITULO (codTitulo, titulo, ISBN, anoPublicacion, codEditorial) VALUES(2,'El principito', 9294495, 2011, 3);
INSERT INTO TITULO (codTitulo, titulo, ISBN, anoPublicacion, codEditorial) VALUES(3,'Ingenieria de software', 2192319, 2001, 1);
INSERT INTO TITULO (codTitulo, titulo, ISBN, anoPublicacion, codEditorial) VALUES(4,'Metodologia de investigacion', 5523534, 2000, 4);


INSERT INTO AUTOR (codAutor, nombreAutor) VALUES(1,'Marcela Paz');
INSERT INTO AUTOR (codAutor, nombreAutor) VALUES(2,'Antoine de Saint-Exupery');
INSERT INTO AUTOR (codAutor, nombreAutor) VALUES(3,'Ian Sommerville');
INSERT INTO AUTOR (codAutor, nombreAutor) VALUES(4,'Roberto Hernandez');
INSERT INTO AUTOR (codAutor, nombreAutor) VALUES(5,'Carlos Fernandez');


INSERT INTO DET_AUTOR (codAutor, codTitulo) VALUES(1, 1);
INSERT INTO DET_AUTOR (codAutor, codTitulo) VALUES(2, 2);
INSERT INTO DET_AUTOR (codAutor, codTitulo) VALUES(3, 3);
INSERT INTO DET_AUTOR (codAutor, codTitulo) VALUES(4, 4);
INSERT INTO DET_AUTOR (codAutor, codTitulo) VALUES(4, 5);


INSERT INTO VOLUMEN (codVolumen, fechaCreacion, fechaUltimoInventario, estado, codBiblioteca, codTitulo) 
    VALUES(seq_volumen.NEXTVAL, TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'Disponible', 1, 1);
INSERT INTO VOLUMEN (codVolumen, fechaCreacion, fechaUltimoInventario, estado, codBiblioteca, codTitulo)
    VALUES(seq_volumen.NEXTVAL, TO_DATE('2023-06-02', 'YYYY-MM-DD'), TO_DATE('2023-06-16', 'YYYY-MM-DD'), 'Prestado', 2, 2);
INSERT INTO VOLUMEN (codVolumen, fechaCreacion, fechaUltimoInventario, estado, codBiblioteca, codTitulo) 
    VALUES(seq_volumen.NEXTVAL, TO_DATE('2023-06-03', 'YYYY-MM-DD'), TO_DATE('2023-06-17', 'YYYY-MM-DD'), 'Disponible', 3, 3);
INSERT INTO VOLUMEN (codVolumen, fechaCreacion, fechaUltimoInventario, estado, codBiblioteca, codTitulo) 
    VALUES(seq_volumen.NEXTVAL, TO_DATE('2023-06-04', 'YYYY-MM-DD'), TO_DATE('2023-06-18', 'YYYY-MM-DD'), 'Disponible', 4, 4);
INSERT INTO VOLUMEN (codVolumen, fechaCreacion, fechaUltimoInventario, estado, codBiblioteca, codTitulo) 
    VALUES(seq_volumen.NEXTVAL, TO_DATE('2023-06-05', 'YYYY-MM-DD'), TO_DATE('2023-06-19', 'YYYY-MM-DD'), 'Prestado', 5, 4);


INSERT INTO ESTUDIANTE
VALUES(12345678, 1, 'Luke', 'Sky', 'walker', 'Perez', 'rebeldesexy1234@duocuc.cl', 12345678 );
INSERT INTO ESTUDIANTE  
VALUES(23232323, 2, 'Homero', 'Jay', 'Simpsons', 'Perez', 'gatabajolalluvia@duocuc.cl', 87654321 );
INSERT INTO ESTUDIANTE 
VALUES(24443434, 3, 'Ibai', NULL, 'Llanos', 'Garatea', 'ibai.llanos@duocuc.cl', 24443434);
INSERT INTO ESTUDIANTE  
VALUES(87654321, 1, 'William', 'Wallace', 'Grita','Libertaaad', 'willy.elmalote@duocuc.cl', 87654321 );
INSERT INTO ESTUDIANTE 
VALUES(32234344, 3, 'Donald', 'Bush', 'Trump', 'Obama', 'amantedelosmuros@duocuc.com', 32234344);


INSERT INTO PRESTAMO(estudianteRUT, codVolumen, fechaPrestamo) VALUES (12345678, 10000, TO_DATE('2023-06-01', 'YYYY-MM-DD'));
INSERT INTO PRESTAMO(estudianteRUT, codVolumen, fechaPrestamo) VALUES (23232323, 10010, TO_DATE('2023-06-02', 'YYYY-MM-DD'));
INSERT INTO PRESTAMO(estudianteRUT, codVolumen, fechaPrestamo) VALUES (24443434, 10020, TO_DATE('2023-06-03', 'YYYY-MM-DD'));
INSERT INTO PRESTAMO(estudianteRUT, codVolumen, fechaPrestamo) VALUES (87654321, 10030, TO_DATE('2023-06-04', 'YYYY-MM-DD'));
INSERT INTO PRESTAMO(estudianteRUT, codVolumen, fechaPrestamo) VALUES (32234344, 10040, TO_DATE('2023-06-05', 'YYYY-MM-DD'));

INSERT INTO PRESTAMO_CARRERA_MES (codCarrera, mes, anio) VALUES (1, 6, 2023);
INSERT INTO PRESTAMO_CARRERA_MES (codCarrera, mes, anio) VALUES (2, 6, 2023);
INSERT INTO PRESTAMO_CARRERA_MES (codCarrera, mes, anio) VALUES (3, 6, 2023);
INSERT INTO PRESTAMO_CARRERA_MES (codCarrera, mes, anio) VALUES (4, 6, 2023);
INSERT INTO PRESTAMO_CARRERA_MES (codCarrera, mes, anio) VALUES (5, 6, 2023);