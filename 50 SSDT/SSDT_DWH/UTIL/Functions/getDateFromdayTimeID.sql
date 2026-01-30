CREATE FUNCTION [UTIL].[getDateFromdayTimeID]
(
  @dayTimeID int
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN

SELECT CAST(CAST(@dayTimeID AS varchar(8)) AS date) AS returnValue
