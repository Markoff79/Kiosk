CREATE FUNCTION [INTERNAL_ETL].[DIL_md_GLAccount_HIST] ()
RETURNS TABLE
AS
RETURN
SELECT
  [ChartOfAccounts_KEY]
  , [GLAccount_KEY]
  , [GLAccount_DESC_short]
  , [GLAccount_DESC_long]
  , [CompanyIDOfTradingPartner_KEY]
  , [CreatedDate]
  , [CreatedName_KEY]
  , [FunctionalArea_KEY]
  , [GLAccountGroup_KEY]
  , [GLAccountNumberSignificantLength_KEY]
  , [GroupAccount_KEY]
  , [IndicatorBalanceSheetAccount_KEY]
  , [IndicatorBlockedForPlanning_KEY]
  , [IndicatorIsBlockedForCreation_KEY]
  , [IndicatorIsBlockedForPosting_KEY]
  , [IndicatorMarkedForDeletion_KEY]
  , [NumberSampleAccount_KEY]
  , [PLStatementAccountType_KEY]
FROM [INTERNAL_ETL].[DIL_md_GLAccount]()
GO

EXECUTE sp_addextendedproperty
  @name = N'loadpattern'
  , @value = N'Scd2'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_md_GLAccount_HIST';
GO

EXECUTE sp_addextendedproperty
  @name = N'ValidFromDatatype'
  , @value = N'DATE'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_md_GLAccount_HIST';
GO

EXECUTE sp_addextendedproperty
  @name = N'businesskey'
  , @value = N'ChartOfAccounts_KEY,GLAccount_KEY'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_md_GLAccount_HIST';
GO

EXECUTE sp_addextendedproperty
  @name = N'deletemode'
  , @value = N'close'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_md_GLAccount_HIST';
GO
EXECUTE sp_addextendedproperty @name = N'compression', @value = N'PAGE', @level0type = N'SCHEMA', @level0name = N'INTERNAL_ETL', @level1type = N'FUNCTION', @level1name = N'DIL_md_GLAccount_HIST';
