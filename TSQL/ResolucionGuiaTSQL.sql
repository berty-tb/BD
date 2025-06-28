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