CREATE FUNCTION [UTIL].[getLowerDateTime7]
(
  @ValidToLeft datetime2(7)
  , @ValidToRight datetime2(7)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Frank Gellern
    Create date:                2019-08-22
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Returns lower one of two given date(time)s - e.g. to determine [getValidTo]

    Execution Sample:
                                SELECT [UTIL].[getLowerDateTime7](SYSDATETIME(),GETDATE())

*/
RETURN
WITH CTE_base AS (
  SELECT
    CAST(
      CASE -- nimm das kleinere der beiden Join-Datensätze
        WHEN COALESCE(@ValidToLeft, [getMaxDateTime7].[returnValue]) < COALESCE(@ValidToRight, [getMaxDateTime7].[returnValue])
          THEN COALESCE(@ValidToLeft, [getMaxDateTime7].[returnValue])
        ELSE COALESCE(@ValidToRight, [getMaxDateTime7].[returnValue])
      END
      AS datetime2(7)
    ) AS returnValue
  FROM [INTERNAL_LOOKUP].[getKey_DateTime7_Max]() [getMaxDateTime7]
)

SELECT
  [returnValue]
  , CAST([returnValue] AS date) AS [returnDate]
FROM CTE_base
