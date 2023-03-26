use Steam
--1-¿Cuál es el precio más alto y cuál es el precio más bajo de los juegos?
SELECT MAX(PrecioActual) AS PrecioMasAlto, MIN(PrecioActual) AS PrecioMasBajo
FROM Juegos;
--2¿Cuál es el número de amigos promedio por usuario?
SELECT AVG(CAST((SELECT COUNT(*) FROM Amigos WHERE Usuario1 = u.IdUsuario OR Usuario2 = u.IdUsuario) AS FLOAT)) AS AmigosPromedio
FROM Usuarios u;
--3¿Cuántos usuarios tienen un nivel mayor o igual a 10?
SELECT COUNT(*) AS TotalUsuariosNivel10
FROM Usuarios
WHERE Nivel >= 10;
--4¿Cuántos juegos tienen un precio mayor a $20?
SELECT COUNT(*) AS TotalJuegosPrecioMayor20
FROM Juegos
WHERE PrecioActual > 20.00;
--5¿Cuáles son los 5 juegos más antiguos (con fecha de publicación más temprana)?
SELECT TOP 5 Nombre, FechaPublicacion
FROM Juegos
ORDER BY FechaPublicacion ASC;
--6¿Cuántos pedidos se realizaron durante el mes de octubre de 2022?
SELECT COUNT(*) AS TotalPedidosOct2022
FROM Pedidos
WHERE Fecha BETWEEN '2022-10-01' AND '2022-10-31';
--7¿Cuáles son los juegos más vendidos en los últimos 30 días?
SELECT j.Nombre AS Juego, SUM(pj.PrecioHistorico) AS TotalVendido
FROM Juegos j
INNER JOIN PedidosJuegos pj ON j.IdJuego = pj.IdJuego
INNER JOIN Pedidos p ON pj.IdPedido = p.IdPedido
WHERE p.Fecha >= DATEADD(day, -30, GETDATE())
GROUP BY j.Nombre
ORDER BY SUM(pj.PrecioHistorico) DESC
--8¿Cuántos usuarios han escrito al menos una reseña?
SELECT COUNT(DISTINCT IdUsuario)
FROM Resenas
--9¿Cuál es el promedio de precio actual de los juegos de cada género?
SELECT G.Nombre AS Genero, AVG(J.PrecioActual) AS PromedioPrecio
FROM Generos G
JOIN JuegosGeneros JG ON G.IdGenero = JG.IdGenero
JOIN Juegos J ON JG.IdJuego = J.IdJuego
GROUP BY G.Nombre
ORDER BY G.Nombre
--10¿Cuáles son los usuarios que han comprado un juego por más del doble de su precio histórico?
SELECT DISTINCT u.Nick
FROM Usuarios u
inner JOIN Pedidos p ON u.IdUsuario = p.IdUsuarioComprador
inner JOIN PedidosJuegos pj ON p.IdPedido = pj.IdPedido
inner JOIN Juegos j ON pj.IdJuego = j.IdJuego
WHERE pj.PrecioHistorico * 2 < j.PrecioActual;