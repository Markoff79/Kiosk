CREATE FUNCTION [INTERNAL_LOOKUP].[getKey_DateTime7_Max]
(
-- Add the parameters for the function here
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Daniel Christoph
    Create date:                2019-08-05
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Returns the predefined maximum date as DATETIME2FROMPARTS(xxxx,xx,xx,xx,xx,xx,xxxxxxx,7)

    Execution Sample:
                                SELECT [returnValue] FROM [INTERNAL_LOOKUP].[getKey_DateTime7_Max]()

*/
RETURN
SELECT
  CAST(
    DATETIME2FROMPARTS(9999, 12, 31, 23, 59, 59, 9999999, 7)
    AS datetime2(7)
  ) AS returnValue
GO
