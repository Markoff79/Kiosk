CREATE FUNCTION [UTIL].[getGreaterDate]
(
  @ValidFromLeft datetime2(7)
  , @ValidFromRight datetime2(7)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Frank Gellern
    Create date:                2021-07-13
    Revision History:           2023-09-29 Ali Cengiz
                                    switched from scalar to TVF

    Description:                Returns greater one of two given dates

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getGreaterDate](SYSDATETIME(),DATEADD(DD,-1,GETDATE()))

*/
RETURN
SELECT CAST([returnDate] AS date) AS [returnValue]
FROM [UTIL].[getGreaterDateTime7](@ValidFromLeft, @ValidFromRight)
