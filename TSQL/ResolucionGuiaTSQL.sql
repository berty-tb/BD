/*1. Hacer una función que dado un artículo y un deposito devuelva un string que
indique el estado del depósito según el artículo. Si la cantidad almacenada es
menor al límite retornar “OCUPACION DEL DEPOSITO XX %” siendo XX el
% de ocupación. Si la cantidad almacenada es mayor o igual al límite retornar
“DEPOSITO COMPLETO”.*/
CREATE OR ALTER FUNCTION estadoDepositoSegunArticulo(@articulo char(8), @deposito char(2))
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @cantidadAlmacenada DECIMAL(12,2), @maximo DECIMAL(12,2)

    SELECT @cantidadAlmacenada = ISNULL(stoc_cantidad, 0), @maximo = ISNULL(stoc_stock_maximo, 0)
    FROM STOCK
    WHERE stoc_producto = @articulo AND stoc_deposito = @deposito

    IF @cantidadAlmacenada >= @maximo OR @maximo = 0
        RETURN 'DEPOSITO COMPLETO'
    RETURN 'OCUPACION DEL DEPOSITO ' + @deposito + '' + RTRIM(STR(ROUND(@cantidadAlmacenada / @maximo * 100, 2), 6, 2)) + '%'
END
GO

/*2. Realizar una función que dado un artículo y una fecha, retorne el stock que
existía a esa fecha
CREATE OR ALTER FUNCTION stockXFecha(@articulo char(8), @fecha date)
RETURNS decimal(12,2)
AS
BEGIN
END*/

/*11. Cree el/los objetos de base de datos necesarios para que dado un código de
empleado se retorne la cantidad de empleados que este tiene a su cargo (directa o
indirectamente). Solo contar aquellos empleados (directos o indirectos) que
tengan un código mayor que su jefe directo*/
CREATE OR ALTER FUNCTION cantidadACargo(@empleado numeric(6,0))
RETURNS INT
AS
BEGIN

DECLARE @cantidadACargo INT, @aCargoDirecto numeric(6,0)
DECLARE cEmpleadosACargo CURSOR FOR
    SELECT empl_codigo
    FROM Empleado
    WHERE empl_jefe = @empleado AND empl_codigo > @empleado

SELECT @cantidadACargo = COUNT(*)
FROM Empleado
WHERE empl_jefe = @empleado AND empl_codigo > @empleado

OPEN cEmpleadosACargo
FETCH NEXT FROM cEmpleadosACargo into @aCargoDirecto
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @cantidadACargo = @cantidadACargo + dbo.cantidadACargo(@aCargoDirecto)
            FETCH NEXT FROM cEmpleadosACargo into @aCargoDirecto
        END
CLOSE cEmpleadosACargo
DEALLOCATE cEmpleadosACargo

RETURN @cantidadACargo

END
