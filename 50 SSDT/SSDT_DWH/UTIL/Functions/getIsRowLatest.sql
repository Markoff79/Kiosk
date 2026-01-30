CREATE FUNCTION [UTIL].[getIsRowLatest]
(
  @SysRow int = 0
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Frank Gellern
    Create date:                2019-08-22
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Flag about last valid timeslice

    Parameters:                 SysRow (expects ROW_NUMBER() over a group of timesliced IDs)

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getIsRowLatest](ROW_NUMBER() OVER (ORDER BY GETDATE()))
                                SELECT [returnValue] FROM [UTIL].[getIsRowLatest](ROW_NUMBER() OVER (ORDER BY GETDATE())+1)

*/
RETURN
SELECT
  CAST(
    CASE
      WHEN @SysRow = 1
        THEN CAST(1 AS bit)
      ELSE CAST(0 AS bit)
    END
    AS bit
  ) AS [returnValue]
FROM (SELECT SYSDATETIME() AS sdt) t
