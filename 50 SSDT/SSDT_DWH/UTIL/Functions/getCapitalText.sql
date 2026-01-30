-- =============================================
/*
    Author:                      Ali Cengiz
    Create date:                2023-09-10
    Revision History:            2023-09-10 Ali Cengiz
                                    Convert Funktion in TVF

    Description:                Changes tExT into Text

    Execution Sample:
                                SELECT * from [UTIL].[getCapitalText]('die;S _ist EIN Bei-spiel')

*/
-- =============================================
CREATE FUNCTION [UTIL].[getCapitalText] (@StartText nvarchar(255))
RETURNS @t_table TABLE (
  ReturnValue nvarchar(255)
)
WITH SCHEMABINDING
AS
BEGIN
  DECLARE @GetText nvarchar(255) = LOWER(@StartText)
  DECLARE @LenText int = LEN(@StartText)
  DECLARE @IdxText int = 1
  DECLARE @Char char(1)
  DECLARE @PrevChar char(1)

  -- Add the T-SQL statements to compute the return value here
  WHILE @IdxText <= @LenText
    BEGIN
      SET @Char = SUBSTRING(@GetText, @IdxText, 1)
      SET @PrevChar = CASE WHEN @IdxText = 1 THEN ' ' ELSE SUBSTRING(@GetText, @IdxText - 1, 1) END
      SET @GetText = STUFF(@GetText, @IdxText, 1, CASE WHEN @PrevChar IN (' ', '-') THEN UPPER(@Char) ELSE @Char END)
      SET @IdxText = @IdxText + 1
    END

  INSERT INTO @t_table
  -- Return EasterSunday
  SELECT @GetText

  RETURN;
END;
