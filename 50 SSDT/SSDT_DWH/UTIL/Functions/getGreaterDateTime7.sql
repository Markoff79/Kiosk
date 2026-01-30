CREATE FUNCTION [UTIL].[getGreaterDateTime7]
(
  @ValidFromLeft datetime2(7)
  , @ValidFromRight datetime2(7)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Frank Gellern
    Create date:                2019-08-22
    Revision History:           2023-09-29 Ali Cengiz
                                    switched from scalar to TVF

    Description:                Returns greater one of two given dates (same as [UTIL].[getValidMax])

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getGreaterDateTime7](SYSDATETIME(),DATEADD(DD,-1,GETDATE()))

*/
RETURN
WITH CTE_base AS (
  SELECT
    CAST(
      CASE -- nimm das größere der beiden Join-Datensätze
        WHEN COALESCE(@ValidFromLeft, [getMinDateTime7].[returnValue]) > COALESCE(@ValidFromRight, [getMinDateTime7].[returnValue])
          THEN COALESCE(@ValidFromLeft, [getMinDateTime7].[returnValue])
        ELSE COALESCE(@ValidFromRight, [getMinDateTime7].[returnValue])
      END
      AS datetime2(7)
    ) AS [returnValue]
  FROM [INTERNAL_LOOKUP].[getKey_DateTime7_Min]() [getMinDateTime7]
)

SELECT
  [returnValue]
  , CAST([returnValue] AS date) AS [returnDate]
FROM CTE_base
