CREATE FUNCTION [UTIL].[getIsRowCurrent_Date] (@ValidFrom date, @ValidTo date)

RETURNS @t_table TABLE (
  val bit
)
WITH SCHEMABINDING
AS
/*

    Author:           noventum consulting gmbh

    Description:      flag, if a given intervall contains the (relative) execution time

	Execution Sample:
                      SELECT * FROM [UTIL].[getIsRowCurrent_Date]('20231212',GETDATE())
                      SELECT * FROM [UTIL].[getIsRowCurrent_Date]('20231212',DATEADD(DD,-1,(GETDATE())))
                      SELECT * FROM [UTIL].[getIsRowCurrent_Date](GETDATE(),'20231212')

*/
BEGIN


  DECLARE @GetFlag bit
  DECLARE @SysDate date
  SET @SysDate = CAST(SYSDATETIME() AS date)

  INSERT INTO @t_table

  SELECT
    CASE
      WHEN @ValidFrom <= @SysDate AND @SysDate <= @ValidTo
        THEN CAST(1 AS bit)
      ELSE CAST(0 AS bit)
    END
  RETURN;
END;
