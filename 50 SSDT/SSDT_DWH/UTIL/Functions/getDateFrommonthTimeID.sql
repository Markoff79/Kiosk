CREATE FUNCTION [UTIL].[getDateFrommonthTimeID]
(
  @monthTimeID int
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Daniel Christoph
    Create date:                2021-05-07
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Returns the last day of the given year as 8-digit-integer (YYYYMMDD)

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getDateFrommonthTimeID](20231208)

*/
RETURN
SELECT EOMONTH(CAST(CAST(@monthTimeID * 100 + 1 AS varchar(8)) AS date))
  AS returnValue
