CREATE FUNCTION [UTIL].[getIsRowCurrent_DateTime7]
(
  @SysStartTime datetime2(7)
  , @SysEndTime datetime2(7)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:						Frank Gellern
    Create date:				2019-08-22
    Revision History:			yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:				Flag about timeslice valid status while being processed

                IMPORTANT: time slices need to be non overlapping wrt @SysEndTime and @SysStartTime

    Parameters:					SysStartTime (Meldezeitpunkt)
                                SysEndTime (usually datetime2(7) - can be switched into date for suitable temporal tables)

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getIsRowCurrent_DateTime7](DATEADD(DD,-1,GETDATE()),DATEADD(MS,-1,GETDATE()))
                                SELECT [returnValue] FROM [UTIL].[getIsRowCurrent_DateTime7](GETDATE(),[INTERNAL_LOOKUP].[getKey_DateTime7_Max]())

*/
RETURN
SELECT
  CASE
    WHEN @SysStartTime <= SYSDATETIME() AND SYSDATETIME() <= @SysEndTime
      THEN CAST(1 AS bit)
    ELSE CAST(0 AS bit)
  END AS [returnValue]
