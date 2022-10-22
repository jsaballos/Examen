ALTER PROCEDURE ReturnDate
@Startdate AS DATE = NULL, @Enddate AS DATE
AS 
 IF @StartDate IS NULL 
    BEGIN
        PRINT 'ERROR: Debe poner fecha'
        RETURN (0)
	
	SELECT ProductID , Name , SellStartDate, SellEndDate
	FROM Production.Product WHERE SellStartDate BETWEEN @Startdate AND ´´

	END


DECLARE @SalesStartdate
EXECUTE ReturnDate  N'',  @Startdate = @SalesStartDate OUTPUT
PRINT N'Informacion General Del Producto' +  
    CONVERT(varchar(10), @SalesStartDate);  
GO






CREATE PROCEDURE Sales.usp_GetSalesYTD 
    @StartDate datetime,
	@EndDate datetime,
	@SalesPerson NVARCHAR(50) = NULL, 
    @SalesYTD MONEY=NULL OUTPUT
AS
    IF @SalesPerson IS NULL 
    BEGIN
        PRINT 'ERROR: Debe especificar nombre de empleado'
        RETURN (1)
    END

    SELECT @SalesYTD=SalesYTD
    FROM Sales.SalesPerson AS sp
         JOIN HumanResources.vEmployee AS e ON e.BusinessEntityID=sp.BusinessEntityID
    WHERE LastName=@SalesPerson;

    IF @@ERROR<>0 
    BEGIN
        RETURN (3)
    END 
    ELSE 
    BEGIN
        IF @SalesYTD IS NULL 
            RETURN (4)
        ELSE 
            RETURN (0)
    END

    EXEC Sales.usp_GetSalesYTD;
GO


DECLARE @SalesYTDForSalesPerson money, @ret_code int;  

EXECUTE Sales.usp_GetSalesYTD  N'',  @SalesYTD = @SalesYTDForSalesPerson OUTPUT;  

PRINT N'Ventas al dia para este emplado son:' +  
    CONVERT(varchar(10), @SalesYTDForSalesPerson);  
GO

