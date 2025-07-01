/*23. Realizar una consulta SQL que para cada año muestre :
 Año
 El producto con composición más vendido para ese año.
 Cantidad de productos que componen directamente al producto más vendido
 La cantidad de facturas en las cuales aparece ese producto.
 El código de cliente que más compro ese producto.
 El porcentaje que representa la venta de ese producto respecto al total de venta
del año.
El resultado deberá ser ordenado por el total vendido por año en forma descendente.*/
SELECT
    YEAR(f1.fact_fecha) anio,
    c1.comp_producto,
    COUNT(DISTINCT c1.comp_componente) cantidadComponentesDistintos,
    COUNT(DISTINCT f1.fact_numero+f1.fact_tipo+f1.fact_sucursal) cantidadFacturasDistintas,
    (
        SELECT TOP 1 f3.fact_cliente
        FROM Factura f3
        JOIN Item_Factura i3 ON
            f3.fact_numero = i3.item_numero AND f3.fact_sucursal = i3.item_sucursal AND f3.fact_tipo = i3.item_tipo
        WHERE i3.item_producto = c1.comp_producto AND YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha)
        GROUP BY f3.fact_cliente
        ORDER BY SUM(i3.item_cantidad) DESC
    ) clienteMasComprador,
    (
        (
            SELECT SUM(i4.item_precio * i4.item_cantidad)
            FROM Item_Factura i4
            JOIN Factura f4 ON
                f4.fact_numero = i4.item_numero AND f4.fact_sucursal = i4.item_sucursal AND f4.fact_tipo = i4.item_tipo
            WHERE i4.item_producto = c1.comp_producto AND YEAR(f4.fact_fecha) = YEAR(f1.fact_fecha)
        ) / (
            SELECT SUM(f5.fact_total - f5.fact_total_impuestos)
            FROM Factura f5
            WHERE YEAR(f5.fact_fecha) = YEAR(f1.fact_fecha)
        ) * 100
    ) porcentajeRespectoVentaTotal
FROM Factura f1
JOIN Item_Factura i1 ON 
    f1.fact_numero = i1.item_numero AND f1.fact_sucursal = i1.item_sucursal AND f1.fact_tipo = i1.item_tipo
JOIN Composicion c1 ON i1.item_producto = c1.comp_producto
JOIN Producto p1 ON c1.comp_producto = p1.prod_codigo
GROUP BY YEAR(f1.fact_fecha), c1.comp_producto
HAVING c1.comp_producto IN (
    SELECT TOP 1 c2.comp_producto
    FROM Composicion c2
    JOIN Item_Factura i2 ON c2.comp_producto = i2.item_producto
    JOIN Factura f2 ON
        f2.fact_numero = i2.item_numero AND f2.fact_sucursal = i2.item_sucursal AND f2.fact_tipo = i2.item_tipo
    WHERE YEAR(f1.fact_fecha) = YEAR(f2.fact_fecha)
    GROUP BY c2.comp_producto
    ORDER BY SUM(item_cantidad) DESC
)

/*24. Escriba una consulta que considerando solamente las facturas correspondientes a los
dos vendedores con mayores comisiones, retorne los productos con composición
facturados al menos en cinco facturas,
La consulta debe retornar las siguientes columnas:
 Código de Producto
 Nombre del Producto
 Unidades facturadas
El resultado deberá ser ordenado por las unidades facturadas descendente.*/
SELECT
    c1.comp_producto,
    p1.prod_detalle,
    SUM(i1.item_cantidad)
FROM Composicion c1
JOIN Producto p1 ON c1.comp_producto = p1.prod_codigo
JOIN Item_Factura i1 ON i1.item_producto = p1.prod_codigo
JOIN Factura f1 ON
    f1.fact_numero = i1.item_numero AND f1.fact_sucursal = i1.item_sucursal AND f1.fact_tipo = i1.item_tipo
WHERE (
    f1.fact_vendedor IN (
        SELECT TOP 2 empl_codigo
        FROM Empleado
        ORDER BY empl_comision DESC
    )
)
GROUP BY c1.comp_producto, p1.prod_detalle
HAVING COUNT(DISTINCT f1.fact_tipo+f1.fact_sucursal+f1.fact_numero) >= 5
ORDER BY SUM(item_cantidad) DESC