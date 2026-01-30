CREATE FUNCTION [UTIL].[is_main_database] ()
RETURNS TABLE
AS
/*

    Author:           noventum consulting GmbH

    Description:      Checks if database is the main one for a specific environment. This can be used to distinguish sandboxes for example.
                      As possible use case is to prevent delta loads that are tracked by the source system (e.g. SAP) to ever load in a non-main database.


    Parameters:       (none)

    Execution Sample:
                      SELECT * FROM [UTIL].[is_main_database] ()

*/
RETURN

SELECT CAST(CASE WHEN DB_NAME() = 'RepositoryVorlage' THEN 1 ELSE 0 END AS bit) AS [amDWH]

GO
