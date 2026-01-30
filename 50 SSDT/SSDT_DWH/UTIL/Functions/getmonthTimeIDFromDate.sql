CREATE FUNCTION [UTIL].[getMonthTimeIDFromDate]
(
  @Date datetime
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Frank Gellern
    Create date:                2019-11-07
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Returns the given datetime as 6-digit-integer (YYYYMM)

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getMonthTimeIDFromDate](GETDATE())

*/
RETURN
SELECT CAST(
  YEAR(@Date) * 100 + MONTH(@Date)
  AS int
) AS returnValue
