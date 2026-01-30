CREATE FUNCTION [UTIL].[getEndOfDayDateTime7]
(
  @Date date
)
RETURNS TABLE
WITH SCHEMABINDING
/*

    Author:                        Marco Nielinger
    Create date:                2021-05-20
    Revision History:            yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Returns the ultimo (23:59:59.9999999) of a given date as datetime2(7)

    Parameters:                    Date

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getEndOfDayDateTime7](GETDATE())

*/
AS
RETURN
SELECT DATETIME2FROMPARTS(YEAR(@Date), MONTH(@Date), DAY(@Date), 23, 59, 59, 9999999, 7) AS returnValue
