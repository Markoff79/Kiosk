CREATE FUNCTION [UTIL].[getSSASDateTime7]
(
  -- Add the parameters for the function here
  @DateTime7 datetime2(7)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Marco Nielinger
    Create date:                2019-07-08
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Der 1.3.1900 ist das kleinstmögliche Datum in SSAS Tabular. Um Prozessierungsfehler zu vermeiden werden Tage davor umgeschlüsselt auf den 1.3.1900.

    Execution Sample:
                                SELECT [UTIL].[getSSASDateTime7](DATEADD(YY,-1000,SYSDATETIME()))

*/
RETURN
SELECT CASE -- Der 1.3.1900 ist das kleinstmögliche Datum in SSAS Tabular
  WHEN @DateTime7 IS NULL
    THEN @DateTime7
  WHEN @DateTime7 > DATETIME2FROMPARTS(1900, 3, 1, 0, 0, 0, 0000000, 7)
    THEN @DateTime7
  ELSE DATETIME2FROMPARTS(1900, 3, 1, 0, 0, 0, 0000000, 7)
END
  AS returnValue
