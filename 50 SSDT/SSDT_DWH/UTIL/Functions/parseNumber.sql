CREATE FUNCTION [UTIL].[parseNumber] (
  @string_value nvarchar(40)
)
/*
    Author:           noventum consulting GmbH

    Description:      we have an upload tool that uploads CSV files.
                      However, CSV files depend on Windows regional settings and thus are different based on users configuration.
                      This function tries a best guess approach to convert bad numbers into something that is reasonable.
                      Never use CSV files for international file delivery. This does not work if users export individually...

    Parameters:       @string_value

    Execution Sample:
                      SELECT [UTIL].[parseNumber]('12.310,12') --> 12310.12
                      SELECT [UTIL].[parseNumber]('1231 EUR')  --> 1231.00

*/
RETURNS numeric(14, 2)
AS
BEGIN
  DECLARE @result numeric(14, 2)
  SELECT @result = TRY_CAST(1.0 * int_value / IIF(numberType = 'decimal', 100, 1) AS numeric(14, 2)) FROM (
    SELECT
      *
      , TRY_CAST(REPLACE(REPLACE(NumericCharacters, '.', ''), ',', '') AS int) AS int_value
    FROM (
      SELECT
        *
        , IIF(SUBSTRING(REVERSE(NumericCharacters), 3, 1) IN ('.', ','), 'decimal', 'integer') AS numberType
      FROM (
        SELECT
          *
          , REPLACE(TRANSLATE(arr, nonNumericCharacters, REPLICATE('#', LEN(CONCAT(nonNumericCharacters, '#')) - 1)), '#', '') AS NumericCharacters
        FROM (
          SELECT
            *
            , REPLACE(TRANSLATE(arr, '-1234567890,.', '#############'), '#', '') AS nonNumericCharacters
          FROM
            (
              VALUES
              (@string_value)
            /*
            ('123.000'),
            ('11.00'  ),
            ('12,12'  ),
            ('-12,000' ),
            ('1231 ?'   ),
            ('12.310,12'   ),
            ('12,310.12'   ),
            ('1231 EUR'   ),
            ('$ 12.310,12'   ),
            (' 12,310.12 € '   ),
            (' 12,310.12 € '   ),
            (''   )
            */
            )
              t (arr)
        ) i
      ) i
    ) i
  ) i
  RETURN @result
END
