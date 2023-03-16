USE master
GO
DROP DATABASE IF EXISTS Steam
GO
CREATE DATABASE Steam
GO
USE Steam
GO

CREATE TABLE Paises(
    IdPais INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR (100) NOT NULL,
    TipoMoneda VARCHAR (100) NOT NULL,
    ConversionDolar DECIMAL (10,2)
)

CREATE TABLE Juegos(
    IdJuego INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR (300) NOT NULL,
    Descripcion VARCHAR (1000) NULL,
    PrecioActual DECIMAL (6,2) NOT NULL,
    FechaPublicacion DATETIME NULL,
)

CREATE TABLE Generos(
    IdGenero INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR (50) NOT NULL,
)

CREATE TABLE Grupos (
    IdGrupo INT IDENTITY (1,1) PRIMARY KEY,
    Nombre VARCHAR(200) NOT NULL,
)

CREATE TABLE Desarrolladores(
    IdDesarrollador INT IDENTITY (1,1) PRIMARY KEY,
    Nombre VARCHAR (200) NOT NULL,
)

CREATE TABLE Usuarios(
    IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
    Email VARCHAR(200) NOT NULL,
    Contrasena VARCHAR (50) NOT NULL,
    FechaNacimiento DATETIME NOT NULL,
    Nick VARCHAR (100) NOT NULL,
    IdPais INT NOT NULL,
    Status BIT NOT NULL,
    Nivel INT NOT NULL,
    AboutMe VARCHAR (1000) NULL,
    CONSTRAINT FKPaisU FOREIGN KEY (IdPais) REFERENCES Paises(IdPais),
)

CREATE TABLE Mensajes(
    IdMensaje INT IDENTITY(1,1) PRIMARY KEY,
    IdUsuarioRemitente INT NOT NULL,
    IdUsuarioDestinatario INT NOT NULL,
    FechaMensaje DATETIME NOT NULL,
    ContenidoMensaje VARCHAR(300) NOT NULL,
    CONSTRAINT FKUsuarioRemitente FOREIGN KEY (IdUsuarioRemitente) REFERENCES Usuarios(IdUsuario),
    CONSTRAINT FKUsuarioDestinatario FOREIGN KEY (IdUsuarioDestinatario) REFERENCES Usuarios(IdUsuario),
)

CREATE TABLE Amigos(
    Usuario1 INT NOT NULL,
    Usuario2 INT NOT NULL,
    FechaInicioAmistad DATETIME NOT NULL,
    PRIMARY KEY (Usuario1, Usuario2),
    CONSTRAINT FKUsuario1 FOREIGN KEY (Usuario1) REFERENCES Usuarios(IdUsuario),
    CONSTRAINT FKUsuario2 FOREIGN KEY (Usuario2) REFERENCES Usuarios(IdUsuario),
)

CREATE TABLE ComentariosPerfil(
    IdComentario INT IDENTITY(1,1) PRIMARY KEY,
    IdUsuarioEscritor INT NOT NULL,
    IdUsuarioReceptor INT NOT NULL,
    ContenidoComentario VARCHAR (1000) NOT NULL,
    FechaComentario DATETIME NOT NULL,
    CONSTRAINT FKUsuarioEscritor FOREIGN KEY (IdUsuarioEscritor) REFERENCES Usuarios(IdUsuario),
    CONSTRAINT FKUsuarioReceptor FOREIGN KEY (IdUsuarioReceptor) REFERENCES Usuarios(IdUsuario),
)

CREATE TABLE GruposUsuarios(
    IdGrupo INT NOT NULL,
    IdUsuario INT NOT NULL,
    FechaUnion DATETIME NOT NULL,
    PRIMARY KEY(IdGrupo, IdUsuario),
    CONSTRAINT FKGrupoU FOREIGN KEY (IdGrupo) REFERENCES Grupos(IdGrupo),
    CONSTRAINT FKUsuarioG FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
)

CREATE TABLE JuegosUsuarios(
    IdUsuario INT NOT NULL,
    IdJuego INT NOT NULL,
    HorasJugados DECIMAL (7,2),
    PRIMARY KEY(IdUsuario, IdJuego),
    CONSTRAINT FKUsuarioJ FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
    CONSTRAINT FKJuegoU FOREIGN KEY (IdJuego) REFERENCES Juegos(IdJuego)
)

CREATE TABLE Pedidos(
    IdPedido INT IDENTITY (1,1) PRIMARY KEY,
    IdUsuarioComprador INT NOT NULL,
    IdUsuarioRecibidor INT NOT NULL,
    Fecha DATETIME NOT NULL,
    Mensaje VARCHAR (100) NULL,
    CONSTRAINT FKUsuarioComprador FOREIGN KEY (IdUsuarioComprador) REFERENCES Usuarios(IdUsuario),
    CONSTRAINT FKUsuarioRecibidor FOREIGN KEY (IdUsuarioRecibidor) REFERENCES Usuarios(IdUsuario),
)

CREATE TABLE JuegosGeneros(
    IdJuego INT NOT NULL,
    IdGenero INT NOT NULL,
    PRIMARY KEY (IdJuego, IdGenero),
    CONSTRAINT FKJuegoG FOREIGN KEY (IdJuego) REFERENCES Juegos(IdJuego),
    CONSTRAINT FKGeneroJ FOREIGN KEY (IdGenero) REFERENCES Generos(IdGenero),
)

CREATE TABLE JuegosDesarrolladores(
    IdJuego INT NOT NULL,
    IdDesarrollador INT NOT NULL,
    PRIMARY KEY (IdJuego, IdDesarrollador),
    CONSTRAINT FKJuegoD FOREIGN KEY (IdJuego) REFERENCES Juegos(IdJuego),
    CONSTRAINT FKDesarrolladorJ FOREIGN KEY (IdDesarrollador) REFERENCES Desarrolladores(IdDesarrollador),
)

CREATE TABLE PedidosJuegos(
    IdPedido INT NOT NULL,
    IdJuego INT NOT NULL,
    PrecioHistorico DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (IdPedido, IdJuego),
    CONSTRAINT FKPedido FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido),
    CONSTRAINT FKJuego FOREIGN KEY (IdJuego) REFERENCES Juegos(IdJuego),
)

CREATE TABLE Resenas(
    IdUsuario INT NOT NULL,
    IdJuego INT NOT NULL,
    Tipo BIT NOT NULL,
    Contenido VARCHAR(1000) NOT NULL,
    PRIMARY KEY (IdUsuario, IdJuego),
    CONSTRAINT FKUsuarioR FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
    CONSTRAINT FKJuegoR FOREIGN KEY (IdJuego) REFERENCES Juegos(IdJuego),
)

CREATE TABLE Mods(
    IdMod INT IDENTITY(1,1) PRIMARY KEY,
    IdJuego INT NOT NULL,
    IdCreador INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    FechaPublicacion DATETIME NOT NULL,
    Descripcion VARCHAR(1000) NULL,
    CONSTRAINT FKJuegoM FOREIGN KEY (IdJuego) REFERENCES Juegos(IdJuego),
    CONSTRAINT FKUsuarioM FOREIGN KEY (IdCreador) REFERENCES Usuarios(IdUsuario),
)

CREATE TABLE Suscripciones(
    IdUsuario INT NOT NULL,
    IdMod INT NOT NULL,
    FechaSuscripcion DATETIME NOT NULL,
    Valoracion INT NULL,
    PRIMARY KEY (IdUsuario, IdMod),
    CONSTRAINT FKUsuarioS FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
    CONSTRAINT FKModS FOREIGN KEY (IdMod) REFERENCES Mods(IdMod),
)

CREATE TABLE ComentariosMods(
    IdComentario INT IDENTITY(1,1) PRIMARY KEY,
    IdMod INT NOT NULL,
    IdUsuario INT NOT NULL,
    Fecha DATETIME NOT NULL,
    Contenido VARCHAR (1000) NOT NULL,
    CONSTRAINT FKModCM FOREIGN KEY (IdMod) REFERENCES Mods(IdMod),
    CONSTRAINT FKUsuarioCM FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
)

CREATE TABLE Hilos(
    IdHilo INT IDENTITY(1,1) PRIMARY KEY,
    IdGrupo INT NOT NULL,
    IdUsuario INT NOT NULL,
    FechaCreacion DATETIME NOT NULL,
    Titulo VARCHAR(100) NOT NULL,
    Contendio VARCHAR (1000) NOT NULL,
    CONSTRAINT FKGrupoH FOREIGN KEY (IdGrupo) REFERENCES Grupos(IdGrupo),
    CONSTRAINT FKUsuarioH FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
)

CREATE TABLE ComentariosHilo(
    IdComentario INT IDENTITY (1,1) PRIMARY KEY,
    IdHilo INT NOT NULL,
    IdUsuario INT NOT NULL,
    Fecha DATETIME NOT NULL,
    Contenido VARCHAR (1000) NOT NULL,
    CONSTRAINT FKHiloCH FOREIGN KEY (IdHilo) REFERENCES Hilos(IdHilo),
    CONSTRAINT FKUsuariosCH FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
)