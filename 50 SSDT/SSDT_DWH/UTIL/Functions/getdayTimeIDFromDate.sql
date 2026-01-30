CREATE FUNCTION [UTIL].[getDayTimeIDFromDate]
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

    Description:                Returns the given datetime as 8-digit-integer (YYYYMMDD)

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getDayTimeIDFromDate](GETDATE())

*/
RETURN
SELECT CAST(
  YEAR(@Date) * 10000 + MONTH(@Date) * 100 + DAY(@Date)
  AS int
) AS returnValue
