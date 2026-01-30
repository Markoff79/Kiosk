CREATE FUNCTION [UTIL].[getIsDeleted]
(
  -- Add the parameters for the function here
  @SysEndTime datetime2(7)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Frank Gellern
    Create date:                2019-08-22
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Flag about existence in TemporalTables-History only

    Parameters:                 SysEndTime (usually datetime2(7) - can be switched into date for suitable temporal tables)

    Execution Sample:
                                SELECT [UTIL].[getIsDeleted](GETDATE())
                                SELECT [UTIL].[getIsDeleted]([INTERNAL_LOOKUP].[getKey_DateTime7_Max]())

*/
RETURN
SELECT
  CAST(
    CASE
      WHEN @SysEndTime = [getMaxDateTime7].[returnValue]
        THEN 0
      ELSE 1
    END AS bit
  ) AS returnValue
FROM [INTERNAL_LOOKUP].[getKey_DateTime7_Max]() [getMaxDateTime7]
