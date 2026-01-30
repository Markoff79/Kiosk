CREATE FUNCTION [UTIL].[getGermanHolidayNameFederalState] (@Date date, @State char(2))

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

    Description:                Function which returns the name of a holiday for a certain federal state (e.g. "Fronleichnam"). NULL is the return value for "not a holiday"

    State-Codes:                (vgl. https://de.wikipedia.org/wiki/Gesetzliche_Feiertage_in_Deutschland)
                                BW: Baden-Württemberg
                                BY: Bayern
                                BE: Berlin
                                BB: Brandenburg
                                HB: Bremen
                                HH: Hamburg
                                HE: Hessen
                                MV: Mecklenburg-Vorpommern
                                NI: Niedersachsen
                                NW: Nordrhein-Westfalen
                                RP: Rheinland-Pfalz
                                SL: Saarland
                                SN: Sachsen
                                ST: Sachsen-Anhalt
                                SH: Schleswig-Holstein
                                TH: Thüringen

    Execution Sample:
                                SELECT [returnValue] FROM [UTIL].[getGermanHolidayNameFederalState](GETDATE(),'HH')
                                SELECT [returnValue] FROM [UTIL].[getGermanHolidayNameFederalState]('20231031','HH')

*/
BEGIN

  DECLARE @Year AS int = YEAR(@Date)
  DECLARE @Month AS int = MONTH(@Date)
  DECLARE @Day AS int = DAY(@Date)
  DECLARE @EasterSunday AS date = (SELECT [returnValue] FROM [UTIL].[getEasterSunday](@Date))
  DECLARE @GermanyWideHoliday AS nvarchar(30) = (SELECT [returnValue] FROM [UTIL].[getGermanHolidayName](@Date))

  -- Return holiday name....
  DECLARE @HolidayName AS nvarchar(30)
  -- NULL means "no holiday"
  SET @HolidayName = CAST(NULL AS nvarchar(30))

  --
  -- Already a Germany-wide holiday then return it...
  --
  IF @GermanyWideHoliday IS NOT NULL
    BEGIN
      SET @HolidayName = @GermanyWideHoliday
    END

  --
  -- Additional fixed holidays
  --
  IF
    @Day = 6
    AND @Month = 1
    AND @State IN ('BW', 'BY', 'ST')
    BEGIN
      SET @HolidayName = 'Heilige Drei Könige'
    END

  IF
    @Day = 8
    AND @Month = 3
    AND @State IN ('BE')
    BEGIN
      SET @HolidayName = 'Frauentag'
    END

  /* nur in Ausgburg...
    IF @Day = 8
        AND @Month = 8
        AND @State IN ('BY')
    BEGIN
        SET @HolidayName = 'Augsburger Hohes Friedensfest'
    END
    */

  IF
    @Day = 15
    AND @Month = 8
    AND @State IN ('BY', 'SL')
    BEGIN
      SET @HolidayName = 'Mariä Himmelfahrt'
    END

  IF
    @Day = 20
    AND @Month = 9
    AND @State IN ('TH')
    BEGIN
      SET @HolidayName = 'Weltkindertag'
    END

  IF
    @Day = 31
    AND @Month = 10
    AND @State IN ('BB', 'HB', 'HH', 'MV', 'NI', 'SN', 'ST', 'SH', 'TH')
    BEGIN
      SET @HolidayName = 'Reformationstag'
    END

  IF
    @Day = 1
    AND @Month = 11
    AND @State IN ('BB', 'BY', 'NW', 'RP', 'SL')
    BEGIN
      SET @HolidayName = 'Allerheiligen' --'All Saints Day'
    END

  /* Mittwoch vor dem 23.11.
    IF "Mittwoch vor dem 23.11."
        AND @State IN ('SN')
    BEGIN
        SET @HolidayName = 'Buß- und Bettag'
    END
    */

  --
  -- Additional variable holidays
  --
  IF
    @Date = DATEADD(DAY, 0, @EasterSunday)
    AND @State IN ('BB', 'RP')
    BEGIN
      SET @HolidayName = 'Ostersonntag' --'Easter Sunday'
    END

  IF
    @Date = DATEADD(DAY, 49, @EasterSunday)
    AND @State IN ('BB', 'RP')
    BEGIN
      SET @HolidayName = 'Pfingstsonntag' --'Whit Sunday'
    END

  IF
    @Date = DATEADD(DAY, 60, @EasterSunday)
    AND @State IN ('BW', 'BY', 'HE', 'NW', 'RP', 'SL', /*ggf. auch...*/ 'SN', 'TH')
    BEGIN
      SET @HolidayName = 'Fronleichnam' --'Corpus Christi'
    END

  INSERT INTO @t_table

  SELECT @HolidayName AS [returnValue]

  RETURN;
END;
