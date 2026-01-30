CREATE FUNCTION [UTIL].[getStringFromDate]
(
  @Date datetime
)
RETURNS TABLE
WITH SCHEMABINDING
/*

    Author:                     Frank Gellern
    Create date:                2019-11-07
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Returns the given datetime as nvarchar(8)-string (YYYYMMDD)

    Parameters:                    Date

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getStringFromDate](GETDATE())

*/
AS
RETURN
SELECT CAST(
  YEAR(@Date) * 10000 + MONTH(@Date) * 100 + DAY(@Date)
  AS nvarchar(8)
) AS returnValue
