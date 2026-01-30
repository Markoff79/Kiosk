/*

    Author:                        Frank Gellern
    Create date:                2019-02-20
    Revision History:            2023-9-29, Ali Cengiz: Convert funktion to TVF
                                    DescriptionOfChanges

    Description:                Removes existing '[' and ']' from schema, table, column

    Execution Sample:
                                SELECT [UTIL].[getTextWithoutBrackets]('SELECT [UTIL].[getTextWithoutBrackets]('''')')

*/
CREATE FUNCTION [UTIL].[getTextWithoutBrackets]
(

  @StartText nvarchar(255)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
SELECT REPLACE(REPLACE(@StartText, '[', ''), ']', '')
  AS returnValue
