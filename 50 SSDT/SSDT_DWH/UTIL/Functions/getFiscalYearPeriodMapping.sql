CREATE FUNCTION [UTIL].[getFiscalYearPeriodMapping] ()
RETURNS TABLE
AS
/*

    Author:           noventum consulting GmbH

    Description:      Table valued function to get information about the server

    Parameters:       (none)

    Execution Sample:
                      SELECT TOP 10000 * FROM [UTIL_Plus].[getFiscalYearPeriodMapping]()

                      was:
                      SELECT TOP 10000 * FROM [UTIL].[getFiscalYearPeriodMapping]()

*/
RETURN

WITH realMonths AS (
  SELECT
    month_Time_ID
    , year_Time_ID
    , month_number
  FROM DPL.dim_Time_Month
)

, CTE_this_result AS (
  --Normal Periods (e.g. 202101 <-> 202102, 202102 <-> 202101, ...)
  SELECT
    CAST(year_Time_ID * 1000 + month_number AS nvarchar(7)) AS FiscalYearPeriod
    , month_Time_ID
  FROM realMonths
  UNION ALL
  --Special Period 0 (e.g 202100 <-> 202101)
  SELECT
    CAST(year_Time_ID * 1000 + 0 AS nvarchar(7)) AS FiscalYearPeriod
    , month_Time_ID
  FROM realMonths WHERE month_number = 1
  UNION ALL
  --Special Period 13 (e.g. 202113 <-> 202112)
  SELECT
    CAST(year_Time_ID * 1000 + 13 AS nvarchar(7)) AS FiscalYearPeriod
    , month_Time_ID
  FROM realMonths WHERE month_number = 12
  UNION ALL
  --Special Period 14 (e.g. 202114 <-> 202112)
  SELECT
    CAST(year_Time_ID * 1000 + 14 AS nvarchar(7)) AS FiscalYearPeriod
    , month_Time_ID
  FROM realMonths WHERE month_number = 12
  UNION ALL
  --Special Period 15 (e.g. 202115 <-> 202112)
  SELECT
    CAST(year_Time_ID * 1000 + 15 AS nvarchar(7)) AS FiscalYearPeriod
    , month_Time_ID
  FROM realMonths WHERE month_number = 12
  UNION ALL
  --Special Period 16 (e.g. 202116 <-> 202112)
  SELECT
    CAST(year_Time_ID * 1000 + 16 AS nvarchar(7)) AS FiscalYearPeriod
    , month_Time_ID
  FROM realMonths WHERE month_number = 12
)

SELECT
  [FiscalYearPeriod]
  , [FiscalYearPeriod] AS [FiscalYearPeriod_KEY]
  , [month_Time_ID]
FROM CTE_this_result
