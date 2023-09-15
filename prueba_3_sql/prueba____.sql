create sequence secuencia start with 10000 increment by 10;

create table campus (
    cod_campus NUMBER(2) constraint pk_campus primary key,
    nombre_campus VARCHAR2(35) not null
);

create table editorial (
    cod_editorial NUMBER(4) constraint pk_editorial primary key,
    nombre_editorial VARCHAR2(35) not null
);

create table facultad (
    cod_facultad NUMBER(2) constraint pk_facultad primary key,
    nombre_facultad VARCHAR2(35) not null
);

create table autor (
    cod_autor NUMBER(4) constraint pk_autor primary key,
    nombre_autor VARCHAR2(35) not null
);

create table carrera (
    cod_carrera NUMBER(2) constraint pk_carrera primary key,
    nombre_carrera VARCHAR2(35) not null,
    cod_facultad NUMBER(2) constraint fk_carrera_facultad references facultad(cod_facultad)
);

create table biblioteca (
    cod_biblioteca NUMBER(2) constraint pk_biblioteca primary key,
    nombrebiblioteca VARCHAR2(35) not null,
    mts_cuadrados NUMBER(4) not null,
    capacidad NUMBER(3) not null,
    cod_campus NUMBER(2) constraint fk_biblioteca_campus references campus(cod_campus)
);

create table titulo (
    cod_titulo NUMBER(6) constraint pk_titulo primary key,
    titulo VARCHAR2(35) not null,
    ISBN NUMBER(7) not null unique,
    anno_p NUMBER(4),
    cod_editorial NUMBER(4) constraint fk_titulo_editorial references editorial(cod_editorial)
);

create table detalle_autor (
    cod_autor NUMBER(4),
    cod_titulo NUMBER(6),
    constraint pk_detalle_autor primary key (cod_autor, cod_titulo),
    constraint fk_detalle_autor_autor foreign key (cod_autor) references autor(cod_autor),
    constraint fk_detalle_autor_titulo foreign key (cod_titulo) references titulo(cod_titulo)
);

create table volumen (
    cod_volumen NUMBER(6) default secuencia.NEXTVAL constraint pk_volumen primary key,
    fecha_creacion date not null,
    fecha_ultimo_inventario date,
    estado VARCHAR2(35) not null,
    cod_biblioteca NUMBER(2) constraint fk_volumen_biblioteca references biblioteca(cod_biblioteca),
    cod_titulo NUMBER(6) constraint fk_volumen_titulo references titulo(cod_titulo)
);

create table estudiante (
    rut NUMBER(9) constraint pk_estudiante primary key,
    dv NUMBER(1) not null,
    primer_nombre VARCHAR2(35),
    segundo_nombre VARCHAR2(35),
    apellido_paterno VARCHAR2(35) not null,
    apellido_materno VARCHAR2(35) not null,
    email VARCHAR2(35) not null,
    celular NUMBER(9) not null
);
create table prestamo (
    id_prestamo NUMBER(6) generated always as identity minvalue 1 maxvalue 999999 start with 1 increment by 1 constraint pk_prestamo primary key,
    estudiante_rut NUMBER(9) constraint fk_pres_estudiante references estudiante(rut),
    cod_volumen NUMBER(6) constraint fk_pres_volumen references volumen(cod_volumen),
    fecha_prestamo date not null
);
    
create table detalle_prestamo (
    id_prestamo generated always as identity minvalue 1 maxvalue 999999 start with 1 increment by 1 ,
    cod_carrera NUMBER(2),
    mes NUMBER(2) not null,
    anno NUMBER(4) not null,
    constraint fk_dp_id foreign key (id_prestamo) references prestamo(id_prestamo),
    constraint fk_dp_cod foreign key (cod_carrera) references carrera(cod_carrera),
    constraint pk_dp primary key (cod_carrera)
);


insert into facultad (cod_facultad, nombre_facultad) values(1, 'Administracion y Negocios');
insert into facultad (cod_facultad, nombre_facultad) values(2, 'Comunicacion');
insert into facultad (cod_facultad, nombre_facultad) values(3, 'Construccion');
insert into facultad (cod_facultad, nombre_facultad) values(4, 'Diseño');
insert into facultad (cod_facultad, nombre_facultad) values(5, 'Gastronomia');
insert into facultad (cod_facultad, nombre_facultad) values(6, 'Informatica y telecomunicaciones');
insert into facultad (cod_facultad, nombre_facultad) values(7, 'Ingenieria y recursos naturales');
insert into facultad (cod_facultad, nombre_facultad) values(8, 'Salud');
insert into facultad (cod_facultad, nombre_facultad) values(9, 'Turismo y hoteleria');


insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(1, 'Auditoria', 1);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(2, 'Comercio exterior', 1);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(3, 'Actuacion', 2);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(4, 'Animacion digital', 2);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(5, 'Tecnico en construccion', 3);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(6, 'Ingenieria en construccion', 3);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(7, 'Desarrollo y diseño web', 4);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(8, 'Diseño de vestuario', 4);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(9, 'Gastronomia internacional', 5);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(10, 'Analista de sistemas', 6);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(11, 'Ingenieria en informatica', 6);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(12, 'Ingenieria en conectividad y redes', 6);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(13, 'Mecanico automotriz', 7);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(14, 'Ingeniria agricola', 7);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(15, 'Tecnico en enfermeria', 8);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(16, 'Ingeniaria biomedica', 8);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(17, 'Administracion hotelera', 9);
insert into carrera (cod_carrera, nombre_carrera, cod_facultad) values(18, 'Ecoturismo', 9);


insert into campus (cod_campus, nombre_campus) values(1, 'Alameda');
insert into campus (cod_campus, nombre_campus) values(2, 'Antonio Varas');
insert into campus (cod_campus, nombre_campus) values(3, 'Maipu');
insert into campus (cod_campus, nombre_campus) values(4, 'Melipilla');
insert into campus (cod_campus, nombre_campus) values(5, 'Padre Alonso de Ovalle');
insert into campus (cod_campus, nombre_campus) values(6, 'Plaza Norte');
insert into campus (cod_campus, nombre_campus) values(7, 'Plaza Oeste');
insert into campus (cod_campus, nombre_campus) values(8, 'Plaza Vespucio');
insert into campus (cod_campus, nombre_campus) values(9, 'Puente Alto');
insert into campus (cod_campus, nombre_campus) values(10, 'San Bernardo');
insert into campus (cod_campus, nombre_campus) values(11, 'San Carlos de Apoquindo');
insert into campus (cod_campus, nombre_campus) values(12, 'San Joaquín');
insert into campus (cod_campus, nombre_campus) values(13, 'Valparaíso');
insert into campus (cod_campus, nombre_campus) values(14, 'Viña del Mar');
insert into campus (cod_campus, nombre_campus) values(15, 'Arauco');
insert into campus (cod_campus, nombre_campus) values(16, 'Nacimiento');
insert into campus (cod_campus, nombre_campus) values(17, 'San Andrés de Concepción');
insert into campus (cod_campus, nombre_campus) values(18, 'Villarrica');
insert into campus (cod_campus, nombre_campus) values(19, 'Puerto Montt');


insert into biblioteca values(1,'Alameda', 407, 600, 1);
insert into biblioteca values(2,'Antonio Varas', 224, 606, 2);
insert into biblioteca values(3,'Maipu', 207, 909, 3);
insert into biblioteca values(4,'Melipilla', 437, 553, 4);
insert into biblioteca values(5,'Padre Alonso de Ovalle', 275, 741, 5);
insert into biblioteca values(6,'Plaza Norte', 412, 731, 6);
insert into biblioteca values(7,'Plaza Oeste', 204, 735, 7);
insert into biblioteca values(8,'Plaza Vespucio', 275, 990, 8);
insert into biblioteca values(9,'Puente Alto', 232, 830, 9);
insert into biblioteca values(10,'San Bernardo', 468, 632, 10);
insert into biblioteca values(11,'San Carlos de Apoquindo', 246, 674, 11);
insert into biblioteca values(12,'San Joaquín', 483, 644, 12);
insert into biblioteca values(13,'Valparaíso', 354, 593, 13);
insert into biblioteca values(14,'Viña del Mar', 343, 971, 14);
insert into biblioteca values(15,'Arauco', 443, 800, 15);
insert into biblioteca values(16,'Nacimiento', 321, 839, 16);
insert into biblioteca values(17,'San Andrés de Concepción', 296, 827, 17);
insert into biblioteca values(18,'Villarrica', 298, 756, 18);
insert into biblioteca values(19,'Puerto Montt', 352, 897, 19);


insert into editorial (cod_editorial, nombre_editorial) values(1, 'Planeta');
insert into editorial (cod_editorial, nombre_editorial) values(2, 'zigzag');
insert into editorial (cod_editorial, nombre_editorial) values(3, 'Alfaguara');
insert into editorial (cod_editorial, nombre_editorial) values(4, 'Pearson');


insert into titulo (cod_titulo, titulo, ISBN, anno_p, cod_editorial) values(1, 'Papelucho', 6840355, 2010, 2);
insert into titulo (cod_titulo, titulo, ISBN, anno_p, cod_editorial) values(2, 'El principito', 9294495, 2011, 3);
insert into titulo (cod_titulo, titulo, ISBN, anno_p, cod_editorial) values(3, 'Ingenieria de software', 2192319, 2001, 1);
insert into titulo (cod_titulo, titulo, ISBN, anno_p, cod_editorial) values(4, 'Metodologia de lainvestigacion', 5523534, 2000, 4);


insert into autor (cod_autor, nombre_autor) values(1, 'Marcela Paz');
insert into autor (cod_autor, nombre_autor) values(2, 'Antoine de Saint-Exupery');
insert into autor (cod_autor, nombre_autor) values(3, 'Ian Sommerville');
insert into autor (cod_autor, nombre_autor) values(4, 'Roberto Hernandez');
insert into autor (cod_autor, nombre_autor) values(5, 'Carlos Fernandez');


insert into detalle_autor (cod_autor, cod_titulo) values(1, 1);
insert into detalle_autor (cod_autor, cod_titulo) values(2, 2);
insert into detalle_autor (cod_autor, cod_titulo) values(3, 3);
insert into detalle_autor (cod_autor, cod_titulo) values(4, 4);
insert into detalle_autor (cod_autor, cod_titulo) values(4, 1);


insert into volumen (cod_volumen, fecha_creacion, fecha_ultimo_inventario, estado, cod_biblioteca, cod_titulo) values(secuencia.NEXTVAL, DATE '2022-02-12', DATE '2022-02-22', 'Disponible', 1, 1);
insert into volumen (cod_volumen, fecha_creacion, fecha_ultimo_inventario, estado, cod_biblioteca, cod_titulo) values(secuencia.NEXTVAL, DATE '2022-02-14', DATE'2022-02-21', 'Prestado', 2, 3);
insert into volumen (cod_volumen, fecha_creacion, fecha_ultimo_inventario, estado, cod_biblioteca, cod_titulo) values(secuencia.NEXTVAL, DATE '2022-01-16', DATE '2022-02-12', 'Disponible', 3, 1);
insert into volumen (cod_volumen, fecha_creacion, fecha_ultimo_inventario, estado, cod_biblioteca, cod_titulo) values(secuencia.NEXTVAL, DATE'2022-02-18', DATE '2022-02-12', 'Disponible', 4, 2);
insert into volumen (cod_volumen, fecha_creacion, fecha_ultimo_inventario, estado, cod_biblioteca, cod_titulo) values(secuencia.NEXTVAL, DATE'2022-03-22', DATE '2022-02-12', 'Prestado', 5, 4);

insert into estudiante values(45713246, 1, 'John', 'Eggbert', 'The', 'Third', 'nerdemoji@hotmail.cl', 12443244 );
insert into estudiante values(13323332, 2, 'Rose', 'Lalonde', 'Vantas', 'Horned', 'poemreading@hotmail.cl', 23732392 );
insert into estudiante values(24443434, 3, 'Angel', 'David', 'Revilla', 'Dross', 'dross@hotmail.cl', 53431232);
insert into estudiante values(23738492, 1, 'Ete', 'Sech', 'El','Pepe', 'potaxio@gmail.com', 84373882 );
insert into estudiante values(72234344, 3, 'Juanito', 'Arcoiris', 'Creiamos', 'Enti', 'juan@outlook.com', 32234344);

insert into prestamo(estudiante_rut, cod_volumen, fecha_prestamo) values (45713246, 10000, DATE '2022-02-12');
insert into prestamo(estudiante_rut, cod_volumen, fecha_prestamo) values (13323332, 10010, DATE '2022-02-14');
insert into prestamo(estudiante_rut, cod_volumen, fecha_prestamo) values (24443434, 10020, DATE'2022-01-16');
insert into prestamo(estudiante_rut, cod_volumen, fecha_prestamo) values (23738492, 10030, DATE '2022-02-18');
insert into prestamo(estudiante_rut, cod_volumen, fecha_prestamo) values (72234344, 10040, DATE '2022-03-22');

insert into detalle_prestamo (cod_carrera, mes, anno) values (7, 7, 2022);
insert into detalle_prestamo (cod_carrera, mes, anno) values (2, 6, 2023);
insert into detalle_prestamo ( cod_carrera, mes, anno) values (3, 5, 2021 );
insert into detalle_prestamo (cod_carrera, mes, anno) values (9, 3, 2023);
insert into detalle_prestamo (cod_carrera, mes, anno) values (10, 2, 2023);
