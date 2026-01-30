CREATE VIEW [INTERNAL_LOOKUP].[DIL_md_GLAccount] AS
/*

    Author:           noventum consulting GmbH

    Description:      information objects for standard hierachy-flattening

    Parameters:       (none)

    Execution Sample:
                      SELECT * FROM [INTERNAL_LOOKUP].[DIL_md_GLAccount]

*/
SELECT
  [KTOPL] AS [ChartOfAccounts_KEY]
  , [SAKNR] AS [GLAccount_KEY]
  , [VBUND] AS [CompanyIDOfTradingPartner_KEY]
  , [ERDAT] AS [CreatedDate]
  , [ERNAM] AS [CreatedName_KEY]
  , [FUNC_AREA] AS [FunctionalArea_KEY]
  , [KTOKS] AS [GLAccountGroup_KEY]
  , [SAKAN] AS [GLAccountNumberSignificantLength_KEY]
  , [BILKT] AS [GroupAccount_KEY]
  , [XBILK] AS [IndicatorBalanceSheetAccount_KEY]
  , [XSPEP] AS [IndicatorBlockedForPlanning_KEY]
  , [XSPEA] AS [IndicatorIsBlockedForCreation_KEY]
  , [XSPEB] AS [IndicatorIsBlockedForPosting_KEY]
  , [XLOEV] AS [IndicatorMarkedForDeletion_KEY]
  , [MUSTR] AS [NumberSampleAccount_KEY]
  , [GVTYP] AS [PLStatementAccountType_KEY]
FROM [DAL_SAP].[md_0GL_ACCOUNT_ATTR]
