CREATE PROCEDURE [INTERNAL_ETL].[load_DIL_md_GLAccount]
  @execution_id bigint = -1
  , @RowCount bigint = NULL OUTPUT
  , @RowsInserted bigint = NULL OUTPUT
  , @RowsUpdated bigint = NULL OUTPUT
  , @RowsDeleted bigint = NULL OUTPUT
  , @RowsUpdatedDeactivated bigint = NULL OUTPUT
  , @RowsUpdatedReactivated bigint = NULL OUTPUT

AS
/*
    Author:           noventum consulting GmbH

    Description:      loads from source into target

    Parameters:       (none)

    Execution Sample:
                      EXECUTE [INTERNAL_ETL].[load_DIL_md_GLAccount]

*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN


  DROP TABLE IF EXISTS #MergeOutput_DIL_md_GLAccount;
  CREATE TABLE #MergeOutput_DIL_md_GLAccount (
    [action] varchar(16) NULL
    , [insert_meta_isActive] bit NULL
    , [delete_meta_isActive] bit NULL
  )

  DROP TABLE IF EXISTS #BufferedSource_DIL_md_GLAccount;
  CREATE TABLE #BufferedSource_DIL_md_GLAccount (
    [ChartOfAccounts_KEY] nvarchar(4) NOT NULL
    , [GLAccount_KEY] nvarchar(10) NOT NULL
    , [GLAccount_DESC_short] nvarchar(20) NULL
    , [GLAccount_DESC_long] nvarchar(60) NULL
    , [CompanyIDOfTradingPartner_KEY] nvarchar(6) NULL
    , [CreatedDate] date NULL
    , [CreatedName_KEY] nvarchar(12) NULL
    , [FunctionalArea_KEY] nvarchar(16) NULL
    , [GLAccountGroup_KEY] nvarchar(4) NULL
    , [GLAccountNumberSignificantLength_KEY] nvarchar(10) NULL
    , [GroupAccount_KEY] nvarchar(10) NULL
    , [IndicatorBalanceSheetAccount_KEY] nvarchar(1) NULL
    , [IndicatorBlockedForPlanning_KEY] nvarchar(1) NULL
    , [IndicatorIsBlockedForCreation_KEY] nvarchar(1) NULL
    , [IndicatorIsBlockedForPosting_KEY] nvarchar(1) NULL
    , [IndicatorMarkedForDeletion_KEY] nvarchar(1) NULL
    , [NumberSampleAccount_KEY] nvarchar(10) NULL
    , [PLStatementAccountType_KEY] nvarchar(2) NULL
    , [meta_hash] binary(16)
  )
  CREATE UNIQUE CLUSTERED INDEX UC_DIL_md_GLAccount_ingestSafety
    ON #BufferedSource_DIL_md_GLAccount ([ChartOfAccounts_KEY], [GLAccount_KEY])

    ; WITH s AS (
    SELECT
      *
      , HASHBYTES(
        'MD5'
        , CONCAT(
          CAST([GLAccount_DESC_short] AS nvarchar(MAX))
          , '|'
          , [GLAccount_DESC_long]
          , '|'
          , [CompanyIDOfTradingPartner_KEY]
          , '|'
          , [CreatedDate]
          , '|'
          , [CreatedName_KEY]
          , '|'
          , [FunctionalArea_KEY]
          , '|'
          , [GLAccountGroup_KEY]
          , '|'
          , [GLAccountNumberSignificantLength_KEY]
          , '|'
          , [GroupAccount_KEY]
          , '|'
          , [IndicatorBalanceSheetAccount_KEY]
          , '|'
          , [IndicatorBlockedForPlanning_KEY]
          , '|'
          , [IndicatorIsBlockedForCreation_KEY]
          , '|'
          , [IndicatorIsBlockedForPosting_KEY]
          , '|'
          , [IndicatorMarkedForDeletion_KEY]
          , '|'
          , [NumberSampleAccount_KEY]
          , '|'
          , [PLStatementAccountType_KEY]
        )
      ) AS meta_hash
    FROM (
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
      FROM INTERNAL_ETL.DIL_md_GLAccount()
    ) t
  )

  INSERT INTO #BufferedSource_DIL_md_GLAccount WITH (TABLOCK) (
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
    , [meta_hash]
  )
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
    , [meta_hash]
  FROM s

  MERGE [DIL].[md_GLAccount] t
  USING #BufferedSource_DIL_md_GLAccount s
    ON (
      t.[ChartOfAccounts_KEY] = s.[ChartOfAccounts_KEY]
      AND t.[GLAccount_KEY] = s.[GLAccount_KEY]
    )
  WHEN NOT MATCHED BY TARGET
    THEN
    INSERT (
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
      , meta_hash
      , meta_created_execution_id
    )
    VALUES (
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
      , s.meta_hash
      , @execution_id
    )
  WHEN MATCHED AND EXISTS (
    SELECT s.meta_hash -- https://docs.sqlfluff.com/en/stable/rules.html#inline-ignoring-errors -- noqa: RF01
    EXCEPT
    SELECT t.meta_hash
  ) OR t.meta_isActive = 'FALSE'
    THEN
    UPDATE
      SET
        t.[GLAccount_DESC_short] = s.[GLAccount_DESC_short]
        , t.[GLAccount_DESC_long] = s.[GLAccount_DESC_long]
        , t.[CompanyIDOfTradingPartner_KEY] = s.[CompanyIDOfTradingPartner_KEY]
        , t.[CreatedDate] = s.[CreatedDate]
        , t.[CreatedName_KEY] = s.[CreatedName_KEY]
        , t.[FunctionalArea_KEY] = s.[FunctionalArea_KEY]
        , t.[GLAccountGroup_KEY] = s.[GLAccountGroup_KEY]
        , t.[GLAccountNumberSignificantLength_KEY] = s.[GLAccountNumberSignificantLength_KEY]
        , t.[GroupAccount_KEY] = s.[GroupAccount_KEY]
        , t.[IndicatorBalanceSheetAccount_KEY] = s.[IndicatorBalanceSheetAccount_KEY]
        , t.[IndicatorBlockedForPlanning_KEY] = s.[IndicatorBlockedForPlanning_KEY]
        , t.[IndicatorIsBlockedForCreation_KEY] = s.[IndicatorIsBlockedForCreation_KEY]
        , t.[IndicatorIsBlockedForPosting_KEY] = s.[IndicatorIsBlockedForPosting_KEY]
        , t.[IndicatorMarkedForDeletion_KEY] = s.[IndicatorMarkedForDeletion_KEY]
        , t.[NumberSampleAccount_KEY] = s.[NumberSampleAccount_KEY]
        , t.[PLStatementAccountType_KEY] = s.[PLStatementAccountType_KEY]
        , t.meta_hash = s.meta_hash
        , t.meta_modified_execution_id = @execution_id
        , t.meta_modified_by = SUSER_NAME()
        , t.meta_modified_at = SYSDATETIME()
        , t.meta_isActive = 'TRUE'

  WHEN NOT MATCHED BY SOURCE AND t.[meta_isActive] = 'TRUE'
    THEN
    UPDATE
      SET
        t.[meta_isActive] = 'FALSE'
        , t.meta_modified_execution_id = @execution_id
        , t.meta_modified_by = SUSER_NAME()
        , t.meta_modified_at = SYSDATETIME()
  OUTPUT
    CASE
      WHEN
        $action = 'UPDATE' AND deleted.meta_modified_at IS NULL THEN 'INSERT'
      ELSE $action
    END
    , [inserted].[meta_isActive]
    , deleted.meta_isActive
  INTO #MergeOutput_DIL_md_GLAccount;

  SELECT
    @RowCount = @@ROWCOUNT
    , @RowsInserted = ISNULL(SUM(IIF([action] = 'INSERT', 1, 0)), 0)
    , @RowsUpdated = ISNULL(SUM(IIF([action] = 'UPDATE', 1, 0)), 0)
    , @RowsDeleted = ISNULL(SUM(IIF([action] = 'DELETE', 1, 0)), 0)
    , @RowsUpdatedDeactivated = ISNULL(SUM(IIF([action] = 'UPDATE' AND insert_meta_isActive = 'FALSE' AND delete_meta_isActive = 'TRUE', 1, 0)), 0)
    , @RowsUpdatedReactivated = ISNULL(SUM(IIF([action] = 'UPDATE' AND insert_meta_isActive = 'TRUE' AND delete_meta_isActive = 'FALSE', 1, 0)), 0)
  FROM #MergeOutput_DIL_md_GLAccount

  DROP TABLE IF EXISTS #BufferedSource_DIL_md_GLAccount;
  DROP TABLE IF EXISTS #MergeOutput_DIL_md_GLAccount;

  SELECT
    '[DIL].[md_GLAccount]' AS [table]
    , 'Merge' AS loadpattern
    , @execution_id AS execution_id
    , @RowsInserted AS inserted
    , @RowsUpdated AS updated
    , @RowsDeleted AS deleted
    , @RowsUpdatedDeactivated AS deactivated
    , @RowsUpdatedReactivated AS reactivated

END
