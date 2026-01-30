CREATE FUNCTION [UTIL].[get_string_from_numeric_sort] (
  @NumericSort numeric(36)
)
RETURNS nvarchar(36)
AS
/*
    Author:           noventum consulting GmbH

    Description:      casts a numeric(36) into nvarchar(36) with leading '000..'

    Parameters:       (none)

    Execution Sample:
                      SELECT [UTIL].[get_string_from_numeric_sort] (17) --> '000000000000000000000000000000000017'

*/
BEGIN

  DECLARE @NvarcharSort nvarchar(36)

  SELECT
    @NvarcharSort =
    RIGHT((CAST(CONCAT('1', REPLICATE('0', 36)) AS numeric(37, 0)) + @NumericSort), 36)

  RETURN @NvarcharSort

END
