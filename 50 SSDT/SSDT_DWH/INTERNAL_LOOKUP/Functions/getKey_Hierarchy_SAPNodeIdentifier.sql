CREATE FUNCTION [INTERNAL_LOOKUP].[getKey_Hierarchy_SAPNodeIdentifier] (
-- Add the parameters for the function here
)
RETURNS TABLE
WITH SCHEMABINDING
AS

/*

    Author:						Frank Gellern

    Description:				Returns the predefined functional key for a SAP hierarchy base element ('NODENAME')

    Execution Sample:
	                            SELECT [returnValue] FROM [INTERNAL_LOOKUP].[getKey_Hierarchy_Nodename]()

*/

RETURN SELECT
  CAST(

    'NODENAME'

    AS nvarchar(20)
  ) AS [returnValue]
