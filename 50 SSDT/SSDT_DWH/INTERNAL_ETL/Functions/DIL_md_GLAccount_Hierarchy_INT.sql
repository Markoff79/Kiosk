CREATE FUNCTION [INTERNAL_ETL].[DIL_md_GLAccount_Hierarchy_INT] ()
RETURNS TABLE
AS
/*
    Author:           noventum consulting GmbH

    Description:      selects all at generation time known columns of a source

    Parameters:       (none)

    Execution Sample:
                      SELECT TOP (42) * FROM [INTERNAL_ETL].[DIL_md_GLAccount_Hierarchy_INT]()

*/
RETURN
WITH HIER_INT AS (
  SELECT * FROM [UTIL].[get_hierarchy_flattened]('0GL_ACCOUNT_T011_HIER_INT')
  -- nodes in a hierarchy are not necessarily unique.
  -- In the GL Account this is used to differentiate between assets and liabilities.
  -- in general we assume those accounts to be positive and thus on the asset side.
  -- Thus, we determine r in [UTIL].[get_hierarchy_flattened] by the to always get the first node in a breadth-first search.
  WHERE [r] = 1
)

SELECT
  gl.[ChartOfAccounts_KEY]
  , gl.[GLAccount_KEY]
  , h.[HIER_GENERIC_NodeKey_L01] AS [GLAccount_L01_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L01] AS [GLAccount_L01_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L01] AS [GLAccount_L01_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L01] AS [GLAccount_L01_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L01] AS [GLAccount_L01_SORT]
  , h.[HIER_GENERIC_NodeKey_L02] AS [GLAccount_L02_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L02] AS [GLAccount_L02_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L02] AS [GLAccount_L02_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L02] AS [GLAccount_L02_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L02] AS [GLAccount_L02_SORT]
  , h.[HIER_GENERIC_NodeKey_L03] AS [GLAccount_L03_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L03] AS [GLAccount_L03_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L03] AS [GLAccount_L03_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L03] AS [GLAccount_L03_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L03] AS [GLAccount_L03_SORT]
  , h.[HIER_GENERIC_NodeKey_L04] AS [GLAccount_L04_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L04] AS [GLAccount_L04_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L04] AS [GLAccount_L04_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L04] AS [GLAccount_L04_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L04] AS [GLAccount_L04_SORT]
  , h.[HIER_GENERIC_NodeKey_L05] AS [GLAccount_L05_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L05] AS [GLAccount_L05_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L05] AS [GLAccount_L05_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L05] AS [GLAccount_L05_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L05] AS [GLAccount_L05_SORT]
  , h.[HIER_GENERIC_NodeKey_L06] AS [GLAccount_L06_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L06] AS [GLAccount_L06_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L06] AS [GLAccount_L06_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L06] AS [GLAccount_L06_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L06] AS [GLAccount_L06_SORT]
  , h.[HIER_GENERIC_NodeKey_L07] AS [GLAccount_L07_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L07] AS [GLAccount_L07_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L07] AS [GLAccount_L07_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L07] AS [GLAccount_L07_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L07] AS [GLAccount_L07_SORT]
  , h.[HIER_GENERIC_NodeKey_L08] AS [GLAccount_L08_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L08] AS [GLAccount_L08_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L08] AS [GLAccount_L08_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L08] AS [GLAccount_L08_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L08] AS [GLAccount_L08_SORT]
  , h.[HIER_GENERIC_NodeKey_L09] AS [GLAccount_L09_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L09] AS [GLAccount_L09_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L09] AS [GLAccount_L09_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L09] AS [GLAccount_L09_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L09] AS [GLAccount_L09_SORT]
  , h.[HIER_GENERIC_NodeKey_L10] AS [GLAccount_L10_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L10] AS [GLAccount_L10_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L10] AS [GLAccount_L10_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L10] AS [GLAccount_L10_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L10] AS [GLAccount_L10_SORT]
  , h.[HIER_GENERIC_NodeKey_L11] AS [GLAccount_L11_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L11] AS [GLAccount_L11_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L11] AS [GLAccount_L11_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L11] AS [GLAccount_L11_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L11] AS [GLAccount_L11_SORT]
  , h.[HIER_GENERIC_NodeKey_L12] AS [GLAccount_L12_KEY]
  , h.[HIER_GENERIC_NodeDescShort_L12] AS [GLAccount_L12_DESC_short]
  , h.[HIER_GENERIC_NodeDescMedium_L12] AS [GLAccount_L12_DESC_medium]
  , h.[HIER_GENERIC_NodeDescLong_L12] AS [GLAccount_L12_DESC_long]
  , h.[HIER_GENERIC_NodeSort_L12] AS [GLAccount_L12_SORT]
  , CAST(h.[HIER_GENERIC_NodeType_L12] AS nvarchar(30)) AS [GLAccount_Type]
  , h.[HIER_GENERIC_IsLeaf] AS [GLAccount_IsLeaf]
  , h.[HIER_GENERIC_Level] AS [GLAccount_Level]
FROM [INTERNAL_ETL].[DIL_md_GLAccount]() gl
-- some NodeKeys are of type 'xx yyyy', other of type 'xxyyyy' - there may be further occurences
INNER JOIN HIER_INT h ON (h.[HIER_GENERIC_NodeKey_L12] LIKE CONCAT(gl.[ChartOfAccounts_KEY], '%', gl.[GLAccount_KEY]))
OUTER APPLY [INTERNAL_LOOKUP].[getKey_Hierarchy_NodeType_Leaf]() l
WHERE
  -- only GLAccount/SAKNR nodes (no text nodes)
  h.[HIER_GENERIC_NodeType_L12] = l.returnValue

GO

EXECUTE sp_addextendedproperty
  @name = N'loadpattern'
  , @value = N'Merge'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_md_GLAccount_Hierarchy_INT';
GO

EXECUTE sp_addextendedproperty
  @name = N'businesskey'
  , @value = N'ChartOfAccounts_KEY,GLAccount_KEY'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_md_GLAccount_Hierarchy_INT';
GO

EXECUTE sp_addextendedproperty
  @name = N'deletemode'
  , @value = N'inactive'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_md_GLAccount_Hierarchy_INT';
GO
