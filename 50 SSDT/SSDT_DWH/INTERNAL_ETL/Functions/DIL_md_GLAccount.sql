CREATE FUNCTION [INTERNAL_ETL].[DIL_md_GLAccount] ()
RETURNS TABLE
AS
/*

    Author:           BIDI\marco.nielinger
    Create date:      2021-07-13
    Revision History: yyyy-mm-dd Revisor
                      description (DescriptionOfChanges)

    Description:      selects all at generation time known columns of a source

    Execution Sample:
                      SELECT TOP (42) * FROM [INTERNAL_ETL].[DIL_md_GLAccount]()

*/
RETURN
WITH CTE_gen_md_0GL_ACCOUNT_ATTR AS (
  SELECT
    [JobID]
    , [JobTST]
    , [KTOPL] AS [ChartOfAccounts_KEY]
    , [SAKNR] AS [GLAccount_KEY]
    , [BILKT] AS [GroupAccount_KEY]
    , [GVTYP] AS [PLStatementAccountType_KEY]
    , [VBUND] AS [CompanyIDOfTradingPartner_KEY]
    , [XBILK] AS [IndicatorBalanceSheetAccount_KEY]
    , [SAKAN] AS [GLAccountNumberSignificantLength_KEY]
    , [ERDAT] AS [CreatedDate]
    , [ERNAM] AS [CreatedName_KEY]
    , [KTOKS] AS [GLAccountGroup_KEY]
    , [XLOEV] AS [IndicatorMarkedForDeletion_KEY]
    , [XSPEA] AS [IndicatorIsBlockedForCreation_KEY]
    , [XSPEB] AS [IndicatorIsBlockedForPosting_KEY]
    , [XSPEP] AS [IndicatorBlockedForPlanning_KEY]
    , [FUNC_AREA] AS [FunctionalArea_KEY]
    , [MUSTR] AS [NumberSampleAccount_KEY]
  FROM DAL_SAP.md_0GL_ACCOUNT_ATTR
)

, CTE_md_0GL_ACCOUNT_TEXT AS (
  SELECT
    [LANGU]
    , [KTOPL] AS [ChartOfAccounts_KEY]
    , [SAKNR] AS [GLAccount_KEY]
    , [TXTSH] AS [GLAccount_DESC_short]
    , CAST([TXTLG] AS nvarchar(60)) AS [GLAccount_DESC_long]
    --Englisch führend, danach Deutsch, dann LANGU wie gesetzt
    , ROW_NUMBER() OVER (
      PARTITION BY [KTOPL]
      , [SAKNR] ORDER BY CASE
        WHEN [LANGU] = N'E' COLLATE Latin1_General_CS_AS
          THEN 1
        WHEN [LANGU] = N'D' COLLATE Latin1_General_CS_AS
          THEN 2
        ELSE 999
      END ASC
    ) AS r
  FROM [DAL_SAP].[md_0GL_ACCOUNT_TEXT]
)

, CTE_md_0GL_ACCOUNT_TEXT_LeadingLanguage AS (
  SELECT
    [ChartOfAccounts_KEY]
    , [GLAccount_KEY]
    , [GLAccount_DESC_short]
    , [GLAccount_DESC_long]
  FROM CTE_md_0GL_ACCOUNT_TEXT
  --nur führende Sprache...
  WHERE r = 1
)

SELECT
  attr.[ChartOfAccounts_KEY]
  , attr.[GLAccount_KEY]
  , ll.[GLAccount_DESC_short]
  , ll.[GLAccount_DESC_long]
  , attr.[CompanyIDOfTradingPartner_KEY]
  , attr.[CreatedDate]
  , attr.[CreatedName_KEY]
  , attr.[FunctionalArea_KEY]
  , attr.[GLAccountGroup_KEY]
  , attr.[GLAccountNumberSignificantLength_KEY]
  , attr.[GroupAccount_KEY]
  , attr.[IndicatorBalanceSheetAccount_KEY]
  , attr.[IndicatorBlockedForPlanning_KEY]
  , attr.[IndicatorIsBlockedForCreation_KEY]
  , attr.[IndicatorIsBlockedForPosting_KEY]
  , attr.[IndicatorMarkedForDeletion_KEY]
  , attr.[NumberSampleAccount_KEY]
  , attr.[PLStatementAccountType_KEY]
FROM CTE_gen_md_0GL_ACCOUNT_ATTR attr
LEFT JOIN CTE_md_0GL_ACCOUNT_TEXT_LeadingLanguage ll
  ON (
    ll.[ChartOfAccounts_KEY] = attr.[ChartOfAccounts_KEY]
    AND ll.[GLAccount_KEY] = attr.[GLAccount_KEY]
  )
GO

EXECUTE sp_addextendedproperty
  @name = N'loadpattern'
  , @value = N'Merge'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_md_GLAccount';
GO

EXECUTE sp_addextendedproperty
  @name = N'businesskey'
  , @value = N'ChartOfAccounts_KEY,GLAccount_KEY'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_md_GLAccount';
GO

EXECUTE sp_addextendedproperty
  @name = N'deletemode'
  , @value = N'inactive'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_md_GLAccount';
GO
EXECUTE sp_addextendedproperty @name = N'compression', @value = N'ROW', @level0type = N'SCHEMA', @level0name = N'INTERNAL_ETL', @level1type = N'FUNCTION', @level1name = N'DIL_md_GLAccount';
