

CREATE FUNCTION [UTIL].[splitStringsXML]
    (
       @List       NVARCHAR(MAX),
       @Delimiter  NVARCHAR(255)
)
RETURNS TABLE
WITH SCHEMABINDING
AS

/*

    Author:                        Frank Gellern (comment added)
    Create date:                2021-07-14
    Revision History:            yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Separates a list by a given delimiter

    Execution Sample:
                                SELECT * FROM [UTIL].[splitStringsXML] ('0-2-c', '-')

*/

   RETURN
       (
          SELECT Item = y.i.value('(./text())[1]', 'nvarchar(4000)')
          FROM
          (
            SELECT x = CONVERT(XML, '<i>'
              + REPLACE(@List, @Delimiter, '</i><i>')
              + '</i>').query('.')
          ) AS a CROSS APPLY x.nodes('i') AS y(i)
       );
