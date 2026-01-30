-- =============================================
-- Author:        <Author,,Name>
-- Create date: <Create Date, ,>
-- Description:    Gets FiscalYearPeriods (typically "<Year>00" - "<Year>16" in SAP)
-- =============================================
CREATE FUNCTION [UTIL].[getFiscalYearPeriods] ()
RETURNS TABLE
AS
RETURN
(
  WITH years AS (
    SELECT year_Time_ID
    FROM [DPL].[dim_Time_Year]
  )

  , periods AS (
    SELECT n AS period
    -- Different Periods (e.g. 00-16 in SAP) with help of getRangeOfNumbers
    FROM [UTIL].[getRangeOfNumbers](0, 16)
  )

  SELECT CAST(CONCAT(year_Time_ID, RIGHT(CONCAT('00', period), 3)) AS nvarchar(7)) AS PERIO
  FROM years
  CROSS JOIN periods
)
