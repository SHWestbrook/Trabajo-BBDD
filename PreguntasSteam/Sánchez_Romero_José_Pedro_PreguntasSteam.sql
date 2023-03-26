use Steam
--1- Muestra el nick de los usuarios que no tienen comentarios en el perfil

select Nick from Usuarios u
left join ComentariosPerfil cp on u.IdUsuario=cp.IdUsuarioReceptor
WHERE cp.ContenidoComentario is null

rollback tran
insert into Usuarios(Email,Contrasena,FechaNacimiento,Nick, [Status],Nivel,AboutMe)
values('user@gmail.com', 'fkasjdflkasjd',GETDATE(),'userue',1,300,'hola buenas tardes')
begin tran 

--2-El precio de todos los juegos de los desarrolladores

SELECT D.Nombre, J.Nombre, J.PrecioActual, J.FechaPublicacion FROM Desarrolladores D
INNER JOIN JuegosDesarrolladores JG ON D.IdDesarrollador=JG.IdDesarrollador
INNER JOIN Juegos J ON JG.IdJuego=J.IdJuego
ORDER BY D.Nombre

--4-Juego con el mayor precio

select top 1 IdJuego, Nombre, PrecioActual from Juegos
order by PrecioActual desc

--5-Juego con genero Tactical y First-person shooter

SELECT tabla1.id, tabla1.juego, tabla1.genero, tabla2.genero FROM
(SELECT J.IdJuego as id, J.Nombre as Juego, G.Nombre as Genero FROM Juegos J
INNER JOIN JuegosGeneros JG ON J.IdJuego=JG.IdJuego
INNER JOIN Generos G ON G.IdGenero=JG.IdGenero
WHERE G.Nombre like 'Tactical%') as tabla1
INNER JOIN 
(SELECT J.IdJuego as id, J.Nombre as Juego, G.Nombre as Genero FROM Juegos J
INNER JOIN JuegosGeneros JG ON J.IdJuego=JG.IdJuego
INNER JOIN Generos G ON G.IdGenero=JG.IdGenero
WHERE G.Nombre like 'First-person shooter%') as tabla2 
ON tabla1.id=Tabla2.id

--6. -Cuantas reseñas tiene el juego csgo

SELECT J.Nombre, COUNT(r.IdJuego) FROM Resenas R
INNER JOIN Juegos J ON R.IdJuego=J.IdJuego
WHERE R.IdJuego=(SELECT IdJuego FROM Juegos WHERE Nombre like 'Galactic Bowling')
GROUP BY J.Nombre

--8. -Regalo con mas valor(Pista tabla pedidos)

SELECT P.IdPedido, SUM(PrecioHistorico) as Total FROM Pedidos P
INNER JOIN PedidosJuegos PJ ON P.IdPedido=PJ.IdPedido
WHERE P.IdUsuarioComprador<>P.IdUsuarioRecibidor
GROUP BY P.IdPedido
ORDER BY SUM(PrecioHistorico) DESC

--9.Juego mas vendido

SELECT TOP 1 J.Nombre, COUNT(PJ.IdJuego) FROM Juegos J
INNER JOIN PedidosJuegos PJ ON J.IdJuego=PJ.IdJuego
GROUP BY J.IdJuego, J.Nombre
ORDER BY COUNT(PJ.IdJuego) DESC

--10. -Juegos publicados entre 2012 y 2014

SELECT * FROM Juegos
WHERE YEAR(FechaPublicacion) BETWEEN 2012 AND 2014
