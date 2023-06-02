CREATE TABLE curso (
    sigla_curso VARCHAR2(10) CONSTRAINT PK_CURSO PRIMARY KEY,
    descripcion VARCHAR2(25) NOT NULL
);

CREATE TABLE asignatura (
    sigla_asignatura VARCHAR2(10) CONSTRAINT PK_ASIGNATURA PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL
);

CREATE TABLE alumno (
    numrut_alumno NUMBER(10) CONSTRAINT PK_ALUMNO PRIMARY KEY,
    dvrut_alumno VARCHAR2(1) NOT NULL,
    pnombre VARCHAR2(25) NOT NULL,
    snombre VARCHAR2(25),
    appaterno VARCHAR2(25) NOT NULL,
    apmaterno VARCHAR2(25) NOT NULL,
    direccion VARCHAR2(20) NOT NULL,
    fono NUMBER(10),
    fecha_nacimiento DATE NOT NULL,
    sigla_curso VARCHAR2(10) NOT NULL,
    CONSTRAINT FK_CURSO FOREIGN KEY (sigla_curso) REFERENCES curso(sigla_curso)
);

CREATE TABLE nota_alumno (
    numrut_alumno NUMBER(10) NOT NULL,
    sigla_asignatura VARCHAR2(10) NOT NULL,
    nota1 NUMBER(2, 1) NOT NULL,
    nota2 NUMBER(2, 1) NOT NULL,
    nota3 NUMBER(2, 1) NOT NULL,
    nota4 NUMBER(2, 1) NOT NULL,
    nota5 NUMBER(2, 1),
    CONSTRAINT PK_NOTA_ALUMNO PRIMARY KEY (numrut_alumno, sigla_asignatura),
    CONSTRAINT FK_NOTA_ALUMNO_ALUMNO FOREIGN KEY (numrut_alumno) REFERENCES alumno(numrut_alumno),
    CONSTRAINT FK_NOTA_ALUMNO_ASIGNATURA FOREIGN KEY (sigla_asignatura) REFERENCES asignatura(sigla_asignatura)
);