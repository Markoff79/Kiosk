CREATE FUNCTION [UTIL].[getGermanHolidayName] (@Date date)

RETURNS @t_table TABLE (
  [returnValue] nvarchar(30)
)
WITH SCHEMABINDING
AS
/*

    Author:                     Marco Nielinger
    Create date:                2020-12-04
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Function which returns the name of a germany-wide holiday (e.g. "Neujahr"). NULL is the return value for "not a holiday"

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getGermanHolidayName](GETDATE())
                                SELECT [returnValue] FROM [UTIL].[getGermanHolidayName]('20230101')

*/
BEGIN

  DECLARE @Year AS int = YEAR(@Date)
  DECLARE @Month AS int = MONTH(@Date)
  DECLARE @Day AS int = DAY(@Date)
  DECLARE @EasterSunday AS date = (SELECT [returnValue] FROM [UTIL].[getEasterSunday](@Date))

  -- Return holiday name....
  DECLARE @HolidayName AS nvarchar(30)
  -- NULL means "no holiday"
  SET @HolidayName = CAST(NULL AS nvarchar(30))

  --
  -- Fixed holidays
  --
  IF
    @Day = 1
    AND @Month = 1
    BEGIN
      SET @HolidayName = 'Neujahr' --'New Year'
    END

  IF
    @Day = 1
    AND @Month = 5
    BEGIN
      SET @HolidayName = 'Tag der Arbeit' --'Labor Day'
    END

  IF
    @Day = 3
    AND @Month = 10
    BEGIN
      SET @HolidayName = 'Tag der Deutschen Einheit' --'Day of German Unity'
    END

  IF
    @Day = 25
    AND @Month = 12
    BEGIN
      SET @HolidayName = '1.Weihnachstag' --'Christmas Day'
    END

  IF
    @Day = 26
    AND @Month = 12
    BEGIN
      SET @HolidayName = '2.Weihnachstag' --'Boxing Day'
    END

  --
  -- Variable holidays
  --
  IF @Date = DATEADD(DAY, -2, @EasterSunday)
    BEGIN
      SET @HolidayName = 'Karfreitag' --'Good Friday'
    END

  IF @Date = DATEADD(DAY, 1, @EasterSunday)
    BEGIN
      SET @HolidayName = 'Ostermontag' --'Easter Monday'
    END

  IF @Date = DATEADD(DAY, 39, @EasterSunday)
    BEGIN
      SET @HolidayName = 'Christi Himmelfahrt' --'Ascension Day'
    END

  IF @Date = DATEADD(DAY, 50, @EasterSunday)
    BEGIN
      SET @HolidayName = 'Pfingstmontag' --'Whit Monday'
    END


  INSERT INTO @t_table

  SELECT @HolidayName AS [returnValue]

  RETURN;
END;
