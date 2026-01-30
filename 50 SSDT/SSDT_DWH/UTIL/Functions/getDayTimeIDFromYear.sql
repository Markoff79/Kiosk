CREATE FUNCTION [UTIL].[getDayTimeIDFromYear]
(
  @Year int
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
                                SELECT [UTIL].[getDayTimeIDFromYear](2021)

*/
RETURN
SELECT CAST(
  @Year * 10000 + 1231
  AS int
) AS returnValue
