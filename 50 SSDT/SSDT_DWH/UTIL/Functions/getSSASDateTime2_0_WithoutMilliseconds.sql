-- =============================================
-- Author:		Daniel Christoph
-- Create date: 10.9.2020
-- Description:	Some front end tools can't interpret milliseconds of data type DateTime correctly (i.e. '2019-06-05 23:59:59.9900000' will be formatted and displayed as '2019-07-01 00:00:00' in some cases).
--				This function cuts off the milliseconds in order to avoid the automatic rounding of miliseconds resulting in wrong dates being displayed in front end tools.
-- Example:
--SELECT
--	CAST('2019-06-05 23:59:59.9900000' AS DATETIME2(7)) AS [DATETIME2(7)],
--	CAST('2019-06-05 23:59:59.9900000' AS DATETIME2(6)) AS [DATETIME2(6)],
--	CAST('2019-06-05 23:59:59.9900000' AS DATETIME2(5)) AS [DATETIME2(5)],
--	CAST('2019-06-05 23:59:59.9900000' AS DATETIME2(4)) AS [DATETIME2(4)],
--	CAST('2019-06-05 23:59:59.9900000' AS DATETIME2(3)) AS [DATETIME2(3)],
--	CAST('2019-06-05 23:59:59.9900000' AS DATETIME2(2)) AS [DATETIME2(2)],
--	CAST('2019-06-05 23:59:59.9900000' AS DATETIME2(1)) AS [DATETIME2(1)], -- hier wird aus 2019-06-05 plötzlich 2019-06-06
--	CAST('2019-06-05 23:59:59.9900000' AS DATETIME2(0)) AS [DATETIME2(0)],  -- hier wird aus 2019-06-05 plötzlich 2019-06-06
--	CAST(CAST('2019-06-05 23:59:59.9900000' AS DATETIME2(7)) AS DATETIME) AS [DATETIME],
--	CAST(CAST('2019-06-05 23:59:59.9900000' AS DATETIME2(7)) AS DATE) AS [DATE]
-- =============================================
CREATE FUNCTION [UTIL].[getSSASDateTime2_0_WithoutMilliseconds]
(
  -- Add the parameters for the function here
  @DateTime7 datetime2(7)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
SELECT CAST(
  DATEADD(MILLISECOND, -DATEPART(MILLISECOND, @DateTime7), @DateTime7)
  AS datetime2(0)
) AS returnValue
