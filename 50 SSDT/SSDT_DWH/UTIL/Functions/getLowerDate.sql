CREATE FUNCTION [UTIL].[getLowerDate]
(
  @ValidToLeft datetime2(7)
  , @ValidToRight datetime2(7)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*
   Author:                      Frank Gellern
    Create date:                2021-07-13
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Returns lower one of two given dates

    Execution Sample:
                                SELECT [UTIL].[getLowerDate](DATEADD(DD,-1,SYSDATETIME()),GETDATE())

*/
RETURN
SELECT CAST([returnDate] AS date) AS [returnValue]
FROM [UTIL].[getLowerDateTime7](@ValidToLeft, @ValidToRight)
