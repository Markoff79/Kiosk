CREATE FUNCTION [INTERNAL_LOOKUP].[getKey_Exception_Superfluous] (
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:           noventum consulting GmbH

    Description:      Returns the predefined text for a superflous exception entry

    Parameters:       none

    Execution Sample:
                      SELECT [returnValue] FROM [INTERNAL_LOOKUP].[getKey_Exception_Superfluous]()

*/
RETURN SELECT CAST(

  'exception superfluous, please remove'

  AS nvarchar(255)
) AS [returnValue]
