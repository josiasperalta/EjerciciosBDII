use LIBRERIA2024

--------------------SUBCONSULTAS------------------------------
SELECT cod_articulo, descripcion, pre_unitario
FROM articulos 
WHERE pre_unitario < (SELECT AVG(pre_unitario)FROM articulos)
ORDER BY cod_articulo

SELECT *
FROM clientes
WHERE cod_cliente IN (SELECT cod_cliente
						FROM facturas
						WHERE YEAR(fecha) = YEAR(GETDATE())
					 )

------------------------Ejercicio 1-----------------------------
SELECT C.nom_cliente+' '+ape_cliente'Cliente', 
C.calle+' '+CONVERT(Varchar(50),C.altura)'Direccion',
B.barrio,nro_tel,[e-mail]
FROM clientes C
JOIN barrios B ON B.cod_barrio = C.cod_barrio
WHERE cod_cliente NOT IN (SELECT DISTINCT F.cod_cliente
							FROM facturas F
							WHERE YEAR(fecha) = YEAR(GETDATE())-1
						  )

------------------------Ejercicio 2-----------------------------
--ANY
SELECT DISTINCT C.nom_cliente+' '+ape_cliente'Cliente', 
C.calle+' '+CONVERT(Varchar(50),C.altura)'Direccion',
B.barrio,nro_tel,[e-mail]
FROM clientes C
JOIN barrios B ON B.cod_barrio = C.cod_barrio
JOIN facturas FA ON FA.nro_factura = C.cod_cliente
JOIN detalle_facturas DF ON DF.nro_factura = FA.nro_factura
WHERE C.cod_cliente = ANY(SELECT F.cod_cliente
						FROM facturas F
						JOIN detalle_facturas DF ON DF.nro_factura = F.nro_factura			
						WHERE pre_unitario < 10)


------------------------------------------------ Ejercicio 3 --------------------------------------
------------------------------ALL
SELECT C.nom_cliente+' '+ape_cliente'Cliente', 
C.calle+' '+CONVERT(Varchar(50),C.altura)'Direccion',
C.nro_tel,C.[e-mail]
FROM clientes C
WHERE 4 = ALL(SELECT F.cod_vendedor
	        	FROM facturas f
		        WHERE F.cod_cliente = C.cod_cliente
AND 0 < 
( SELECT COUNT(*)
FROM FACTURAS F 
WHERE F.cod_cliente = C.cod_cliente )


-------------------------------------------EJERCICIO----------------------------------------------------
SELECT *
FROM articulos A
WHERE A.cod_articulo NOT IN (SELECT DISTINCT DF.cod_articulo
							FROM detalle_facturas DF
							JOIN facturas F ON F.nro_factura = DF.nro_factura
							WHERE YEAR(F.fecha) = YEAR(GETDATE())							
							)
AND A.pre_unitario BETWEEN 1000 AND 2000

-------------------------------------------Problema 4-------------------------------------------------------

SELECT v.cod_vendedor,
sum(DF.cantidad * DF.pre_unitario)'Ventas Totales'
FROM vendedores V
JOIN facturas F ON F.cod_vendedor = V.cod_vendedor
JOIN detalle_facturas DF ON DF.nro_factura = F.nro_factura
GROUP BY V.cod_vendedor
HAVING sum(df.pre_unitario * df.cantidad) > (SELECT AVG(dfA.cantidad * DFA.pre_unitario)
								              from detalle_facturas DFA)
