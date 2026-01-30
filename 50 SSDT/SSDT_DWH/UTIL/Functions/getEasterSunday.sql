CREATE FUNCTION [UTIL].[getEasterSunday] (@Date date)

RETURNS @t_table TABLE (
  [returnValue] date
)
WITH SCHEMABINDING
AS
/*

    Author:                     Marco Nielinger
    Create date:                2020-12-04
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Function which returns the date of EasterSunday (OsterSonntag) within the same year of an input date

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getEasterSunday](GETDATE())

*/
BEGIN

  -- Osterfunktion nach Carl Friedrich Gauß (1800)
  -- Vgl.: www.oraylis.de/blog/bewegliche-feiertage-berechnen
  DECLARE @Year AS int = YEAR(@Date)
  DECLARE @Month AS int = MONTH(@Date)
  DECLARE @Day AS int = DAY(@Date)
  DECLARE @a AS int
  DECLARE @b AS int
  DECLARE @c AS int
  DECLARE @d AS int
  DECLARE @e AS int
  DECLARE @f AS int
  DECLARE @EasterSunday AS date

  SET @a = @Year % 19
  SET @b = @Year / 100
  SET @c = (8 * @b + 13) / 25 - 2
  SET @d = @b - (@Year / 400) - 2
  SET @e = (19 * (@Year % 19) + ((15 - @c + @d) % 30)) % 30

  IF @e = 28
    BEGIN
      IF @a > 10
        BEGIN
          SET @e = 27
        END
    END
  ELSE
    BEGIN
      IF @e = 29
        BEGIN
          SET @e = 28
        END
    END

  SET @f = (@d + 6 * @e + 2 * (@Year % 4) + 4 * (@Year % 7) + 6) % 7
  -- Calculate date of EasterSunday (OsterSonntag) for corresponding year
  SET @EasterSunday = CAST(CAST(@Year * 10000 + 101 AS varchar(8)) AS date)
  SET @EasterSunday = DATEADD(MM, 2, @EasterSunday)
  SET @EasterSunday = DATEADD(DAY, @e + @f + 21, @EasterSunday)


  INSERT INTO @t_table

  SELECT @EasterSunday AS [returnValue]

  RETURN;
END;
