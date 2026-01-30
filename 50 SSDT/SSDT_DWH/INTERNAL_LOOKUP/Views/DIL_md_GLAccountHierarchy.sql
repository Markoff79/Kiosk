CREATE VIEW [INTERNAL_LOOKUP].[DIL_md_GLAccountHierarchy] AS
/*

    Author:           noventum consulting GmbH

    Description:      information objects for standard hierachy-flattening

    Parameters:       (none)

    Execution Sample:
                      SELECT * FROM [INTERNAL_LOOKUP].[DIL_md_GLAccountHierarchy]

*/
SELECT
  CAST('0GL_ACCOUNT' AS nvarchar(255)) AS [hierarchy_entity]
  , CAST(CONCAT([ChartOfAccounts_KEY], [GLAccount_KEY]) AS nvarchar(32)) AS [NodeName]
  , CASE WHEN [GLAccount_DESC_short] != '' THEN [GLAccount_DESC_short] END AS [TextShort]
  --, CASE WHEN [GLAccount_DESC_medium] != '' THEN [GLAccount_DESC_medium] END AS [TextMedium]
  , CAST(NULL AS nvarchar(40)) AS [TextMedium]
  , CASE WHEN [GLAccount_DESC_long] != '' THEN [GLAccount_DESC_long] END AS [TextLong]
FROM DIL.[md_GLAccount]
