SELECT 
    V.nom_vendedor + SPACE(1) + V.ape_vendedor 'Nombre Completo',
    C.nom_cliente + ', ' + C.ape_cliente 'Cliente',
    SUM(DF.pre_unitario * DF.cantidad) 'Facturado'
FROM facturas F
JOIN vendedores V ON F.cod_vendedor = V.cod_vendedor
JOIN detalle_facturas DF ON DF.nro_factura = F.nro_factura
JOIN clientes C ON F.cod_cliente = C.cod_cliente
WHERE DATEDIFF(YEAR, F.fecha, GETDATE()) = 1
GROUP BY 
    V.nom_vendedor,
    V.ape_vendedor,
    C.nom_cliente,
    C.ape_cliente
ORDER BY 
    'Nombre Completo',
    'Cliente',
    'Facturado'


	--2)SE NECESITA UN LISTADO QUE INFORME SOBRE EL MONTO MAXIMO, MINIMO, Y TOTAL QUE GASTO EN ESTA LIBRERIA CADA CLIENTE 
	--EL AÑO PASADO, PERO SOLO DONDE EL IMPORTE TOTAL GASTADO POR ESOS CLIENTES ESTE ENTRE 50000 7 90000

	SELECT  C.nom_cliente + ', ' + C.ape_cliente 'Cliente',
	MAX(DF.pre_unitario) 'MAXIMO',
	MIN(DF.pre_unitario )'MINIMO',
	SUM(DF.cantidad * DF.pre_unitario) 'Facturado'
	FROM clientes C 
	JOIN facturas F ON C.cod_cliente = F.cod_cliente
	JOIN detalle_facturas DF ON DF.nro_factura = F.nro_factura
	WHERE DATEDIFF(YEAR, F.fecha, GETDATE()) = 1
	GROUP BY C.nom_cliente + ', ' + C.ape_cliente 
	HAVING SUM (DF.cantidad * DF.pre_unitario) BETWEEN 50000 AND 90000