/* 24/06/2025 TM
1. Realizar una consulta SQL que retorne para el último año, los 5 vendedores con menos clientes asignados
que más vendieron en pesos (si hay varios con menos clientes asignados debe traer el que más vendió), sólo
deben considerarse las facturas que tengan más de dos items facturados:
    1) Apellido y Nombre del Vendedor
    2) Total de unidades de Producto Vendidas
    3) Monto promedio de venta por factura
    4) Monto total de ventas
El resultado deberá mostrar ordenado la cantidad de ventas descendente, en  caso de igualdad de cantidades,
ordenar por código de vendedor
NOTA: No se permite el uso de sub-selects en el FROM

2. Dado el contescto inflacionario se tiene que aplicar un control en el cual nunca se permita vender un
producto a un precio que no esté entre 0%-5% del precio de venta del producto el mes anterior, ni tampoco
que esté en más de un 50% el precio del mismo producto que hace 12 meses atrás. Aquellos productors nuevos,
o que no tuvieron ventas en meses anteriores no debe considerarse esta regla ya que no hay precio precio
de referencia
*/



/* 24/06/2025 TT
1. Se requiere armar una estadística que retorne para cada año y familia el clientes que menos productos
diferentes compró y que más monto compró para ese año y familia
Año, Razón Social Cliente, Familia, Cantidad de unidades compradas de esa familia
Los resultados deben ser ordenados por año de menor a mayor y para cada año ordenados por la familia que
menos productos tenga asignados
NOTA: No se permite resolver ninguna columna con un sub-select y tampoco el uso de sub-selects en el FROM

2. Realizar un stored procedure que calcule e infrome la comisión de un vendedor para un determinado mes.
Los parámetros de entrada es código de vendedor, mes y año.
El criterio para calcular la comisión es: 5% del total vendido tomando como importe base el valor de la
factura sin los impuestos del mes a comisionar, a esto se le debe sumar un plus del 3% más en el caso de
que sea el vendedor que más vendió los productos nuevos en comparación al resto de vendedores, es decir
este plus se le aplica solo a un vendedor y en caso de igualdad se le otorga al que posea el código de
vendedor más alto. Se considera que un producto es nuevo cuando su primera venta en la empresa se produjo
durante el mes en curso o en alguno de los 4 meses anteriores. De no haber ventas de productos nuevos en
ese periodo, ese plus nunca se aplica
*/



/* 01/07/2025 TM
1. Realizar una consulta SQL que retorne para todas las zonas que tengan 2(dos) o más depósitos
Detalle Zona
Cantidad de Depósitos x Zona
Cantidad de Productos distintos en los depósitos de esa zona
Cantidad de Productos distintos vendidos de esos depósitos y zona
El resultado deberá ser ordenado por la zona que más empleados tenga
NOTA: No se permite el uso de sub-selects en el FROM

2. Cree el o los objetos necesarios para que controlar que un producto no pueda tener asignado un rubro
que tenga más de 20 productos asignados, si esto ocurre, hay que asignarle el rubro que menos productos
tenga asignado e informar a qué producto y qué rubro se le asignó. En la actualidad la regla se cumple
y no se sabe la forma en que se accede a la Base de Datos
*/