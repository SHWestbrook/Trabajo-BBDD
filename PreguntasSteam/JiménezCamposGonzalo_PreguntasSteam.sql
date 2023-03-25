USE Steam

--1. ¿Cuántos juegos hay en Steam?

SELECT Count(1) FROM Juegos

--2. ¿Cuál es el grupo con más usuarios?

SELECT TOP 1 Nombre, COUNT(IdUsuario) FROM Grupos G
INNER JOIN GruposUsuarios GU ON GU.IdGrupo=G.IdGrupo
GROUP BY G.IdGrupo, Nombre
ORDER BY COUNT(IdUsuario) DESC

--Hay muchos grupos que tienen la misma cantidad de usuarios

--3. ¿Cuántos mensajes se han enviaron en 2019, 2020, 2021 ?

SELECT COUNT(1), YEAR(FechaMensaje) FROM Mensajes
WHERE YEAR(FechaMensaje)=2019 OR 
YEAR(FechaMensaje)=2020 OR 
YEAR(FechaMensaje)=2021
GROUP BY YEAR(FechaMensaje)

--4. ¿Cuál es el juego con genero Tactical que más reseñas positivas tiene? (Positiva=1, negativa=0)

SELECT TOP 1 J.Nombre, G.Nombre, COUNT(R.IdUsuario) FROM Juegos J
INNER JOIN JuegosGeneros JG ON J.IdJuego=JG.IdJuego
INNER JOIN Generos G ON G.IdGenero=JG.IdGenero
INNER JOIN Resenas R ON J.IdJuego=R.IdJuego
WHERE G.Nombre like 'Tactical%' AND R.Tipo=1
GROUP BY J.IdJuego, G.IdGenero, J.Nombre, G.Nombre
ORDER BY COUNT(R.IdUsuario) DESC

--La consulta no funciona porque todos los generos tienen un espacio delante

--5. ¿Cual es el nombre de los desarrolladores con id 52 y cual es el juego más caro que han desarrollado?

SELECT TOP 1 D.Nombre, J.Nombre, J.PrecioActual FROM Desarrolladores D
INNER JOIN JuegosDesarrolladores JG ON D.IdDesarrollador=JG.IdDesarrollador
INNER JOIN Juegos J ON J.IdJuego=JG.IdJuego
WHERE D.IdDesarrollador=52
ORDER BY J.PrecioActual DESC

--6. ¿Cuál es el usuario que ha recibido más juegos regalados de otros usuarios? ¿Y el que más juegos a regalado? 
--(Se considera un pedido como regalo cuando el que le compra es diferente del que lo recibe)

SELECT TOP 1 P.IdUsuarioRecibidor,  U.Email, COUNT(PJ.IdJuego) FROM Pedidos P
INNER JOIN Usuarios U ON P.IdUsuarioRecibidor=U.IdUsuario
INNER JOIN PedidosJuegos PJ ON PJ.IdPedido=P.IdPedido
WHERE P.IdUsuarioComprador<>P.IdUsuarioRecibidor
GROUP BY IdUsuarioRecibidor, U.Email
ORDER BY COUNT(PJ.IdJuego) DESC

SELECT TOP 1 P.IdUsuarioComprador, U.Email, COUNT(PJ.IdJuego) FROM Pedidos P
INNER JOIN Usuarios U ON P.IdUsuarioComprador=U.IdUsuario
INNER JOIN PedidosJuegos PJ ON PJ.IdPedido=P.IdPedido
WHERE P.IdUsuarioComprador<>P.IdUsuarioRecibidor
GROUP BY IdUsuarioComprador, U.Email
ORDER BY COUNT(PJ.IdJuego) DESC

--7. ¿Cual es el usuario del grupo con id 732 que más veces ha comentando en el perfil de usuarios que tienen comprado el juego Counter-Strike: Global Offensive ?

SELECT TOP 1 U.IdUsuario, COUNT(IdComentario) FROM Usuarios U
INNER JOIN GruposUsuarios GU ON GU.IdUsuario=U.IdUsuario
INNER JOIN ComentariosPerfil CP ON CP.IdUsuarioEscritor=U.IdUsuario
WHERE IdGrupo=732 AND CP.IdUsuarioReceptor in (
    SELECT IdUsuario FROM Usuarios U
    INNER JOIN Pedidos P ON P.IdUsuarioRecibidor=U.IdUsuario
    INNER JOIN PedidosJuegos PJ ON P.IdPedido=PJ.IdPedido
    INNER JOIN Juegos J ON PJ.IdJuego=J.IdJuego
    WHERE J.Nombre like 'Counter-Strike: Global Offensive'
    GROUP BY IdUsuario)
GROUP BY U.IdUsuario
ORDER BY COUNT(IdComentario) DESC

--8. Ordena los pedidos por precio total

SELECT P.IdPedido, SUM(PrecioHistorico) as Total FROM Pedidos P
INNER JOIN PedidosJuegos PJ ON P.IdPedido=PJ.IdPedido
GROUP BY P.IdPedido
ORDER BY SUM(PrecioHistorico) DESC

--9. ¿Cuál es el juego que ha sido más comprado?

SELECT TOP 1 J.Nombre, COUNT(PJ.IdJuego) FROM Juegos J
INNER JOIN PedidosJuegos PJ ON J.IdJuego=PJ.IdJuego
GROUP BY J.IdJuego, J.Nombre
ORDER BY COUNT(PJ.IdJuego) DESC

--10. ¿Cuál es el usuario que pertenece a más grupos?

SELECT TOP 1 U.IdUsuario, COUNT(GU.IdUsuario) FROM Usuarios U
INNER JOIN GruposUsuarios GU ON GU.IdUsuario=U.IdUsuario
GROUP BY U.IdUsuario
ORDER BY COUNT(GU.IdUsuario) DESC