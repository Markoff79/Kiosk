-- =============================================
-- Author:		Marco Nielinger
-- Create date: 20.05.2021
-- Description:	Returns the ultimo (23:59:59.9999999) of a given date as datetime2(7)
-- Parameters:  Date
-- =============================================
CREATE FUNCTION [UTIL].[getDateUltimo]
(
  -- Add the parameters for the function here
  @Date date
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
--Vom SysEndTime wird immer die möglichst kleinste Einheit abgezogen (damit die Zeitscheiben sich nicht überlappen!)
-- --> Bei datetime2(7) ist die kleinste Einheit 100ns
--Z.B. Bei einem UPDATE in der Temporal-Table gilt anscheinend immer: "SysEndTime (alter Stand) = SysStartTime (neuer Stand)" !!
--Nur für das Default-SysEndTime 31.12.9999 wird nichts abgezogen!
SELECT CAST(
  DATETIME2FROMPARTS(YEAR(@Date), MONTH(@Date), DAY(@Date), 23, 59, 59, 9999999, 7)
  AS datetime2(7)
) AS returnValue
