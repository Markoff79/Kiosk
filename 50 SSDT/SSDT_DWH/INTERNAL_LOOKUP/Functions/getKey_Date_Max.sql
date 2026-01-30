CREATE FUNCTION [INTERNAL_LOOKUP].[getKey_Date_Max]
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
                                SELECT [returnValue] FROM [INTERNAL_LOOKUP].[getKey_Date_Max]()

*/
RETURN
SELECT
  CAST(
    DATEFROMPARTS(9999, 12, 31)
    AS date
  ) AS returnValue
GO
