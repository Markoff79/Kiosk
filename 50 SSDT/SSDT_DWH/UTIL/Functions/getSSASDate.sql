-- =============================================
-- Author:        Marco Nielinger
-- Create date: 8.7.2019
-- Update: Ali Cengiz, 29.09.2023, Konvertierung Funktion zu TVF
-- Description:    Der 1.3.1900 ist das kleinstmögliche Datum in SSAS Tabular. Um Prozessierungsfehler zu vermeiden werden Tage davor umgeschlüsselt auf den 1.3.1900.
-- =============================================
CREATE FUNCTION [UTIL].[getSSASDate] (@Date date)

RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
SELECT CASE -- Der 1.3.1900 ist das kleinstmögliche Datum in SSAS Tabular
  WHEN @Date IS NULL
    THEN @Date
  WHEN @Date > DATEFROMPARTS(1900, 3, 1)
    THEN @Date
  ELSE DATEFROMPARTS(1900, 3, 1)
END
  AS ReturnValue
