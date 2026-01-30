CREATE PROCEDURE [INTERNAL_ETL].[load_DIL_md_GLAccount_HIST]
  @execution_id bigint = -1
  , @RowCount bigint = NULL OUTPUT
  , @RowsInserted bigint = NULL OUTPUT
  , @RowsUpdated bigint = NULL OUTPUT
  , @RowsDeleted bigint = NULL OUTPUT
  , @RowsUpdatedDeactivated bigint = NULL OUTPUT
  , @RowsUpdatedReactivated bigint = NULL OUTPUT
  , @ValidFrom date = NULL

AS
/*

    Author:           noventum consulting GmbH

    Description:      loads from source into target

    Parameters:       (none)

    Execution Sample:
                      EXECUTE [INTERNAL_ETL].[load_DIL_md_GLAccount_HIST]

*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

  -- Declaration/Initialization of useful variables
  DECLARE
    @prev_run_deleted bigint
    , @prev_run_keptdeactivated_isRowLatest bigint
    , @prev_run_reactivated bigint

    -- Get current date/time
  DECLARE @ValidFrom_Current date = (SELECT CAST(SYSDATETIME() AS date))

  -- If @ValidFrom is not set, set default value (current date/time)
  SELECT @ValidFrom = ISNULL(@ValidFrom, @ValidFrom_Current)

  -- set @ValidTo = @ValidFrom - 1 (descrease ValidFrom by 1 unit of date/time)
  DECLARE @ValidTo date = LEFT(DATEADD(NS, -100, CAST(@ValidFrom AS datetime2(7))), LEN(@ValidFrom)) -- independent of ValidTo data type: cast to Datetime2(7), then reduce by 100 nanoseconds, then cut off irrelevant precision (to avoid automatic rounding during CAST in case of lower precision), then assign to @ValidFrom with implicit cast to target precision again

  -- Get global DWH MAX date/time value
  --cut off irrelevant precision (to avoid automatic rounding during CAST in case of lower precision), then assign to @ValidTo with implicit cast to target precision
  DECLARE @GlobalValidToMax date = (SELECT CAST(LEFT([returnValue], LEN(@ValidFrom)) AS date) FROM [INTERNAL_LOOKUP].[getKey_DateTime7_Max]())

  -- Get global DWH MIN date/time value
  --cut off irrelevant precision (to avoid automatic rounding during CAST in case of lower precision), then assign to @ValidTo with implicit cast to target precision
  DECLARE @GlobalValidFromMin date = (SELECT CAST(LEFT([returnValue], LEN(@ValidFrom)) AS date) FROM [INTERNAL_LOOKUP].[getKey_DateTime7_Min]())

  -- Get MAX ValidFrom from existing values; set global MIN date value, if no ValidFrom value exists
  DECLARE @LocalValidFromMax date = (SELECT MAX([ValidFrom]) FROM [DIL].[md_GLAccount_HIST])

  -- Validation of specified @ValidFrom

  -- Raise error and end procedure in case of "future" time slices or existing overlapping time slices or if specified @ValidFrom falls out of range in regards to DWH time configuration (min/max dates)
  IF @ValidFrom < @GlobalValidFromMin
    BEGIN
      RAISERROR (
        'The specified @ValidFrom is lower than the globally minimum ValidFrom value defined for the DWH. Please adjust @ValidFrom or adjust DWH configuration.', 16, 1
      )
      RETURN
    END

  -- If there are "future" time slices then raise error and end procedure
  IF @ValidFrom < @LocalValidFromMax
    BEGIN
      RAISERROR (
        'There exist already time slices starting after the specified @ValidFrom. Please adjust @ValidFrom or cleanup existing time slices.', 16, 1
      )
      RETURN
    END

  IF @ValidFrom > @ValidFrom_Current
    BEGIN
      RAISERROR (
        'There is not support for inserting timeslices of the future, this would break isCurrentRow logic', 16, 1
      )
      RETURN
    END

  -- Housekeeping/Cleanup of potential previous run with same @ValidFrom

  -- delete previous run if it was for the same @ValidFrom
  -- it is important to first delete latest slices and then reopen predecessor slices as otherwise unique constraints would be violated

  -- delete the last slice and remember business keys to identify which predecessor items have to be reopened
  -- cache records to be deleted
  SELECT
    [ValidTo_LAG]
    , [ChartOfAccounts_KEY]
    , [GLAccount_KEY]
  INTO #deletemarker
  FROM (
    SELECT
      LAG([ValidTo]) OVER (PARTITION BY [ChartOfAccounts_KEY], [GLAccount_KEY] ORDER BY [ValidTo] ASC) AS [ValidTo_LAG]
      , [ValidFrom]
      , [ChartOfAccounts_KEY]
      , [GLAccount_KEY]
    FROM [DIL].[md_GLAccount_HIST]
  ) i
  WHERE [ValidFrom] = @ValidFrom


  -- delete records
  DELETE
  FROM [DIL].[md_GLAccount_HIST]
  WHERE [ValidFrom] = @ValidFrom
  ;
  SET @prev_run_deleted = @@ROWCOUNT

  -- update predecessor slices that are not active anymore as they had a gap to the current @ValidFrom
  ; WITH d AS (
    SELECT s.*
    FROM [DIL].[md_GLAccount_HIST] s
    INNER JOIN #deletemarker t
      ON (
        t.[ChartOfAccounts_KEY] = s.[ChartOfAccounts_KEY]
        AND t.[GLAccount_KEY] = s.[GLAccount_KEY]
        AND t.[ValidTo_LAG] = s.[ValidTo]
      )
    WHERE [ValidTo_LAG] IS NOT NULL AND [ValidTo_LAG] != @ValidTo
  )

  UPDATE d SET
    [isRowLatest] = 'TRUE'
    , [isRowCurrent] = 'FALSE'
    , [tst] = SYSDATETIME()
    , meta_modified_execution_id = @execution_id
    , meta_modified_by = SUSER_NAME()
    , meta_modified_at = SYSDATETIME()
  SET @prev_run_keptdeactivated_isRowLatest = @@ROWCOUNT

  -- update predecssor slices that are directly adjacent to current @ValidFrom
  UPDATE [DIL].[md_GLAccount_HIST] SET
    [isRowLatest] = 'TRUE'
    , [isRowCurrent] = 'TRUE'
    , [ValidTo] = @GlobalValidToMax
    , [tst] = SYSDATETIME()
    , meta_modified_execution_id = @execution_id
    , meta_modified_by = SUSER_NAME()
    , meta_modified_at = SYSDATETIME()
  WHERE ValidTo = @ValidTo
  SET @prev_run_reactivated = @@ROWCOUNT;

  DROP TABLE IF EXISTS #deletemarker;


  -- new run for @ValidFrom starts here

  -- create temp table for new time slices

  DROP TABLE IF EXISTS #MergeOutput_DIL_md_GLAccount_HIST;
  CREATE TABLE #MergeOutput_DIL_md_GLAccount_HIST (
    [action] varchar(16) NULL
    , [meta_hash] binary(16) NULL
    , [deleted_isRowCurrent] bit NULL
    , [ChartOfAccounts_KEY] nvarchar(4) NULL
    , [GLAccount_KEY] nvarchar(10) NULL
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
  )

  DROP TABLE IF EXISTS #BufferedSource_DIL_md_GLAccount_HIST;
  CREATE TABLE #BufferedSource_DIL_md_GLAccount_HIST (
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
    , [meta_hash] binary(16) NULL

  )
  CREATE UNIQUE CLUSTERED INDEX UC_DIL_md_GLAccount_HIST_ingestSafety
    ON #BufferedSource_DIL_md_GLAccount_HIST ([ChartOfAccounts_KEY], [GLAccount_KEY])

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
      FROM INTERNAL_ETL.DIL_md_GLAccount_HIST()
    ) t
  )

  INSERT INTO #BufferedSource_DIL_md_GLAccount_HIST WITH (TABLOCK) (
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




  MERGE [DIL].[md_GLAccount_HIST] t
  USING #BufferedSource_DIL_md_GLAccount_HIST s
    ON (
      t.[ChartOfAccounts_KEY] = s.[ChartOfAccounts_KEY]
      AND t.[GLAccount_KEY] = s.[GLAccount_KEY]
    )
  -- Insert new/unknown business keys

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
      , [ValidFrom]
      , [ValidTo]
      , meta_hash
      , meta_created_execution_id
    )
    VALUES (
      s.[ChartOfAccounts_KEY]
      , s.[GLAccount_KEY]
      , s.[GLAccount_DESC_short]
      , s.[GLAccount_DESC_long]
      , s.[CompanyIDOfTradingPartner_KEY]
      , s.[CreatedDate]
      , s.[CreatedName_KEY]
      , s.[FunctionalArea_KEY]
      , s.[GLAccountGroup_KEY]
      , s.[GLAccountNumberSignificantLength_KEY]
      , s.[GroupAccount_KEY]
      , s.[IndicatorBalanceSheetAccount_KEY]
      , s.[IndicatorBlockedForPlanning_KEY]
      , s.[IndicatorIsBlockedForCreation_KEY]
      , s.[IndicatorIsBlockedForPosting_KEY]
      , s.[IndicatorMarkedForDeletion_KEY]
      , s.[NumberSampleAccount_KEY]
      , s.[PLStatementAccountType_KEY]
      , @ValidFrom
      , @GlobalValidToMax
      , s.meta_hash
      , @execution_id
    )

  -- Update last time slices for a business key (only when changes are recognized!)
  -- The insertion of new time slice for changed business keys is done by the following INSERT in combination with OUTPUT of the MERGE statement!

  WHEN MATCHED
  AND t.[isRowLatest] = 'TRUE'
  AND (
    EXISTS (
      SELECT s.meta_hash
      EXCEPT
      SELECT t.meta_hash
    )
    OR
    t.[isRowCurrent] = 'FALSE' -- in case attributes didn't change, but the KEY wasn't provided for a while (gap in history) = last time slice was already closed and business key needs to be reactivated. equivalent to @ValidTo <> @GlobalValidToMax
  )
    THEN
    -- Set ValidTo in case it wasnt set before and isRowLatest (FALSE) for last existing time-slice
    UPDATE SET
      t.[ValidTo] = CASE WHEN t.[isRowCurrent] = 'TRUE' THEN @ValidTo ELSE t.[ValidTo] END
      , t.[isRowLatest] = 'FALSE'
      , t.[isRowCurrent] = 'FALSE'
      , t.[tst] = SYSDATETIME()
      , t.meta_modified_execution_id = @execution_id
      , t.meta_modified_by = SUSER_NAME()
      , t.meta_modified_at = SYSDATETIME()

  -- If a business key is not included in source, close the last time-slice
  WHEN NOT MATCHED BY SOURCE AND t.[isRowLatest] = 'TRUE' AND t.[isRowCurrent] != 'FALSE'
    THEN
    UPDATE
      SET
        t.[ValidTo] = @ValidTo
        , t.[isRowCurrent] = 'FALSE'
        , t.[tst] = SYSDATETIME()
        , t.meta_modified_execution_id = @execution_id
        , t.meta_modified_by = SUSER_NAME()
        , t.meta_modified_at = SYSDATETIME()
  -- Write OUTPUT into temp table for subsequent inserts and determination of row counts
  OUTPUT
    $ACTION
    , s.[meta_hash]
    , [deleted].[isRowCurrent]
    , s.[ChartOfAccounts_KEY]
    , s.[GLAccount_KEY]
    , s.[GLAccount_DESC_short]
    , s.[GLAccount_DESC_long]
    , s.[CompanyIDOfTradingPartner_KEY]
    , s.[CreatedDate]
    , s.[CreatedName_KEY]
    , s.[FunctionalArea_KEY]
    , s.[GLAccountGroup_KEY]
    , s.[GLAccountNumberSignificantLength_KEY]
    , s.[GroupAccount_KEY]
    , s.[IndicatorBalanceSheetAccount_KEY]
    , s.[IndicatorBlockedForPlanning_KEY]
    , s.[IndicatorIsBlockedForCreation_KEY]
    , s.[IndicatorIsBlockedForPosting_KEY]
    , s.[IndicatorMarkedForDeletion_KEY]
    , s.[NumberSampleAccount_KEY]
    , s.[PLStatementAccountType_KEY]

  INTO #MergeOutput_DIL_md_GLAccount_HIST;


  -- INSERT for inserting new entries for updated entries by MERGE
  INSERT INTO [DIL].[md_GLAccount_HIST] WITH (TABLOCK) (
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
    , [ValidFrom]
    , [ValidTo]
    , [meta_hash]
    , [meta_created_execution_id]
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
    , @ValidFrom AS [ValidFrom]
    , @GlobalValidToMax AS [ValidTo]
    , [meta_hash]
    , @execution_id
  FROM #MergeOutput_DIL_md_GLAccount_HIST
  WHERE
    [action] = 'UPDATE'
    AND [ChartOfAccounts_KEY] IS NOT NULL AND [GLAccount_KEY] IS NOT NULL;

  DROP TABLE IF EXISTS #BufferedSource_DIL_md_GLAccount_HIST;


  SELECT
    @RowCount = @@ROWCOUNT
    , @RowsInserted = ISNULL(SUM(IIF([action] = 'INSERT', 1, 0)), 0)
    , @RowsUpdated = ISNULL(SUM(IIF([action] = 'UPDATE', 1, 0)), 0)
    , @RowsDeleted = ISNULL(SUM(IIF([action] = 'DELETE', 1, 0)), 0)
    , @RowsUpdatedDeactivated = ISNULL(SUM(IIF([action] = 'UPDATE' AND [ChartOfAccounts_KEY] IS NULL AND [GLAccount_KEY] IS NULL, 1, 0)), 0)
    , @RowsUpdatedReactivated = ISNULL(SUM(IIF([action] = 'UPDATE' AND NOT ([ChartOfAccounts_KEY] IS NULL AND [GLAccount_KEY] IS NULL) AND [deleted_isRowCurrent] = 'FALSE', 1, 0)), 0)
  FROM #MergeOutput_DIL_md_GLAccount_HIST

  DROP TABLE IF EXISTS #MergeOutput_DIL_md_GLAccount_HIST;

  SELECT
    '[DIL].[md_GLAccount_HIST]' AS [table]
    , 'SCD2' AS loadpattern
    , @execution_id AS execution_id
    , @RowsInserted AS inserted
    , @RowsUpdated AS updated
    , @RowsDeleted AS deleted
    , @RowsUpdatedDeactivated AS deactivated
    , @RowsUpdatedReactivated AS reactivated
    , @prev_run_deleted AS prev_run_deleted
    , @prev_run_keptdeactivated_isRowLatest AS prev_run_keptdeactivated_isRowLatest
    , @prev_run_reactivated AS prev_run_reactivated

END
