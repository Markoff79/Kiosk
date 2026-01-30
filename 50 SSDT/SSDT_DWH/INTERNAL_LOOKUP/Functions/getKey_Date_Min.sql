CREATE FUNCTION [INTERNAL_LOOKUP].[getKey_Date_Min]
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

    Description:                Returns the predefined minimum date as DATEFROMPARTS(xxxx,xx,xx)

    Execution Sample:
                                SELECT [returnValue] FROM [INTERNAL_LOOKUP].[getKey_Date_Min]()

*/
RETURN
SELECT
  CAST(
    DATEFROMPARTS(2012, 1, 1)
    AS date
  ) AS returnValue
GO
