CREATE FUNCTION [UTIL].[concatDescAndDesc]
(
  @DPL_Desc1 AS nvarchar(MAX)
  , @DPL_Desc2 AS nvarchar(MAX)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Frank Gellern
    Create date:                2019-10-11
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Returns the concatenated two Input parts
                                 Input = 'Desc1', 'Desc2' --> Output = 'Desc1 Desc2'
                                 Input =  NULL,  NULL     --> Output = NULL
                                 Input = 'Desc1',  NULL   --> Output = 'Desc1'

    Execution Sample:
                                SELECT [UTIL].[concatDescAndDesc]('-a-','+b+')

*/RETURN
SELECT CAST(
  LEFT(
    CASE
      WHEN @DPL_Desc1 IS NULL THEN @DPL_Desc2
      WHEN @DPL_Desc2 IS NULL THEN @DPL_Desc1
      ELSE CONCAT(COALESCE(@DPL_Desc1, ''), ' ', COALESCE(@DPL_Desc2, ''))
    END
    , 4000
  )
  AS nvarchar(4000)
) AS returnValue
