USE master
GO
DROP DATABASE IF EXISTS Steam
GO
CREATE DATABASE Steam
GO
USE Steam
GO

CREATE TABLE Juegos(
    IdJuego INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR (300) NOT NULL,
    Descripcion VARCHAR (1000) NULL,
    PrecioActual DECIMAL (6,2) NOT NULL,
    FechaPublicacion VARCHAR(100) NOT NULL,
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
    Status BIT NOT NULL,
    Nivel INT NOT NULL,
    AboutMe VARCHAR (8000) NULL,
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

BULK INSERT Usuarios FROM '/var/opt/mssql/backup/csv/Usuarios.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)

BULK INSERT Amigos FROM '/var/opt/mssql/backup/csv/Amigos.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)

BULK INSERT Grupos FROM '/var/opt/mssql/backup/csv/Grupos.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)

/*BULK INSERT Juegos FROM '/var/opt/mssql/backup/csv/Juegos.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)*/

BULK INSERT Generos FROM '/var/opt/mssql/backup/csv/Generos.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)

BULK INSERT Desarrolladores FROM '/var/opt/mssql/backup/csv/Desarrolladores.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)

BULK INSERT JuegosDesarrolladores FROM '/var/opt/mssql/backup/csv/JuegosDesarrolladores.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)

/*BULK INSERT JuegosGeneros FROM '/var/opt/mssql/backup/csv/JuegosGeneros.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)*/

BULK INSERT Resenas FROM '/var/opt/mssql/backup/csv/Resenas.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)

BULK INSERT Pedidos FROM '/var/opt/mssql/backup/csv/Pedidos.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)

/*BULK INSERT PedidosJuegos FROM '/var/opt/mssql/backup/csv/PedidosJuegos.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)*/

BULK INSERT GruposUsuarios FROM '/var/opt/mssql/backup/csv/GruposUsuarios.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)

BULK INSERT Mensajes FROM '/var/opt/mssql/backup/csv/Mensajes.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)

BULK INSERT ComentariosPerfil FROM '/var/opt/mssql/backup/csv/ComentariosPerfil.csv'
WITH (

FIELDTERMINATOR=',',
ROWTERMINATOR='\n'

)