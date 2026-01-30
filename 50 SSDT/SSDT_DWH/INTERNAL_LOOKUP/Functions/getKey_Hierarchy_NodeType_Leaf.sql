CREATE FUNCTION [INTERNAL_LOOKUP].[getKey_Hierarchy_NodeType_Leaf] (
-- Add the parameters for the function here
)
RETURNS TABLE
WITH SCHEMABINDING
AS

/*

    Author:						noventum consulting

    Description:				Returns the predefined key for nodes within a hierarchy. Hierarchies so far have leaf and node elements.

    Execution Sample:
	                            SELECT [returnValue] FROM [INTERNAL_LOOKUP].[getKey_Hierarchy_NodeType_Leaf]()

*/

RETURN SELECT CAST(

  'L'

  AS nvarchar(1)
) AS [returnValue]
