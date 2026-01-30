CREATE FUNCTION [INTERNAL_LOOKUP].[getKey_Exception_Volume] (
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:           noventum consulting GmbH

    Description:      Returns the predefined standard mamimum line of issues

    Parameters:       none

    Execution Sample:
                      SELECT [returnValue] FROM [INTERNAL_LOOKUP].[getKey_Exception_Volume]()

*/
RETURN SELECT CAST(

  31

  AS int
) AS [returnValue]
