CREATE FUNCTION [UTIL].[concatKeyAndDesc]
(
  @DPL_Key AS nvarchar(MAX)
  , @DPL_Desc AS nvarchar(MAX)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Frank Gellern
    Create date:                2019-09-25
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Returns the concatenated Key and Desc Input
                                 Input = 'Key', 'Desc' --> Output = 'Key || Desc'
                                 Input =  NULL,  NULL  --> Output = NULL
                                 Input = 'Key',  NULL  --> Output = 'Key || '

    Execution Sample:
                                SELECT [UTIL].[concatKeyAndDesc]('-1','n.a.')

*/
RETURN
SELECT CAST(
  LEFT(
    CASE
      WHEN COALESCE(@DPL_Key, @DPL_Desc) IS NOT NULL
        THEN CONCAT(COALESCE(@DPL_Key, ''), ' || ', COALESCE(@DPL_Desc, ''))
    END, 4000
  )
  AS nvarchar(4000)
) AS returnValue
