CREATE PROCEDURE [INTERNAL_ETL].[load_DIL_md_GLAccount_Hierarchy_INT]
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
                      EXECUTE [INTERNAL_ETL].[load_DIL_md_GLAccount_Hierarchy_INT]

*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN


  DROP TABLE IF EXISTS #MergeOutput_DIL_md_GLAccount_Hierarchy_INT;
  CREATE TABLE #MergeOutput_DIL_md_GLAccount_Hierarchy_INT (
    [action] varchar(16) NULL
    , [insert_meta_isActive] bit NULL
    , [delete_meta_isActive] bit NULL
  )

  DROP TABLE IF EXISTS #BufferedSource_DIL_md_GLAccount_Hierarchy_INT;
  CREATE TABLE #BufferedSource_DIL_md_GLAccount_Hierarchy_INT (
    [ChartOfAccounts_KEY] nvarchar(4) NOT NULL
    , [GLAccount_KEY] nvarchar(10) NOT NULL
    , [GLAccount_L01_KEY] nvarchar(32) NULL
    , [GLAccount_L01_DESC_short] nvarchar(20) NULL
    , [GLAccount_L01_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L01_DESC_long] nvarchar(60) NULL
    , [GLAccount_L01_SORT] numeric(36, 0) NULL
    , [GLAccount_L02_KEY] nvarchar(32) NULL
    , [GLAccount_L02_DESC_short] nvarchar(20) NULL
    , [GLAccount_L02_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L02_DESC_long] nvarchar(60) NULL
    , [GLAccount_L02_SORT] numeric(36, 0) NULL
    , [GLAccount_L03_KEY] nvarchar(32) NULL
    , [GLAccount_L03_DESC_short] nvarchar(20) NULL
    , [GLAccount_L03_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L03_DESC_long] nvarchar(60) NULL
    , [GLAccount_L03_SORT] numeric(36, 0) NULL
    , [GLAccount_L04_KEY] nvarchar(32) NULL
    , [GLAccount_L04_DESC_short] nvarchar(20) NULL
    , [GLAccount_L04_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L04_DESC_long] nvarchar(60) NULL
    , [GLAccount_L04_SORT] numeric(36, 0) NULL
    , [GLAccount_L05_KEY] nvarchar(32) NULL
    , [GLAccount_L05_DESC_short] nvarchar(20) NULL
    , [GLAccount_L05_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L05_DESC_long] nvarchar(60) NULL
    , [GLAccount_L05_SORT] numeric(36, 0) NULL
    , [GLAccount_L06_KEY] nvarchar(32) NULL
    , [GLAccount_L06_DESC_short] nvarchar(20) NULL
    , [GLAccount_L06_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L06_DESC_long] nvarchar(60) NULL
    , [GLAccount_L06_SORT] numeric(36, 0) NULL
    , [GLAccount_L07_KEY] nvarchar(32) NULL
    , [GLAccount_L07_DESC_short] nvarchar(20) NULL
    , [GLAccount_L07_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L07_DESC_long] nvarchar(60) NULL
    , [GLAccount_L07_SORT] numeric(36, 0) NULL
    , [GLAccount_L08_KEY] nvarchar(32) NULL
    , [GLAccount_L08_DESC_short] nvarchar(20) NULL
    , [GLAccount_L08_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L08_DESC_long] nvarchar(60) NULL
    , [GLAccount_L08_SORT] numeric(36, 0) NULL
    , [GLAccount_L09_KEY] nvarchar(32) NULL
    , [GLAccount_L09_DESC_short] nvarchar(20) NULL
    , [GLAccount_L09_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L09_DESC_long] nvarchar(60) NULL
    , [GLAccount_L09_SORT] numeric(36, 0) NULL
    , [GLAccount_L10_KEY] nvarchar(32) NULL
    , [GLAccount_L10_DESC_short] nvarchar(20) NULL
    , [GLAccount_L10_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L10_DESC_long] nvarchar(60) NULL
    , [GLAccount_L10_SORT] numeric(36, 0) NULL
    , [GLAccount_L11_KEY] nvarchar(32) NULL
    , [GLAccount_L11_DESC_short] nvarchar(20) NULL
    , [GLAccount_L11_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L11_DESC_long] nvarchar(60) NULL
    , [GLAccount_L11_SORT] numeric(36, 0) NULL
    , [GLAccount_L12_KEY] nvarchar(32) NULL
    , [GLAccount_L12_DESC_short] nvarchar(20) NULL
    , [GLAccount_L12_DESC_medium] nvarchar(40) NULL
    , [GLAccount_L12_DESC_long] nvarchar(60) NULL
    , [GLAccount_L12_SORT] numeric(36, 0) NULL
    , [GLAccount_Type] nvarchar(30) NULL
    , [GLAccount_IsLeaf] int NULL
    , [GLAccount_Level] smallint NULL
    , [meta_hash] binary(16)
  )
  CREATE UNIQUE CLUSTERED INDEX UC_DIL_md_GLAccount_Hierarchy_INT_ingestSafety
    ON #BufferedSource_DIL_md_GLAccount_Hierarchy_INT ([ChartOfAccounts_KEY], [GLAccount_KEY])

    ; WITH s AS (
    SELECT
      *
      , HASHBYTES(
        'MD5'
        , CONCAT(
          CAST([GLAccount_L01_KEY] AS nvarchar(MAX))
          , '|'
          , [GLAccount_L01_DESC_short]
          , '|'
          , [GLAccount_L01_DESC_medium]
          , '|'
          , [GLAccount_L01_DESC_long]
          , '|'
          , [GLAccount_L01_SORT]
          , '|'
          , [GLAccount_L02_KEY]
          , '|'
          , [GLAccount_L02_DESC_short]
          , '|'
          , [GLAccount_L02_DESC_medium]
          , '|'
          , [GLAccount_L02_DESC_long]
          , '|'
          , [GLAccount_L02_SORT]
          , '|'
          , [GLAccount_L03_KEY]
          , '|'
          , [GLAccount_L03_DESC_short]
          , '|'
          , [GLAccount_L03_DESC_medium]
          , '|'
          , [GLAccount_L03_DESC_long]
          , '|'
          , [GLAccount_L03_SORT]
          , '|'
          , [GLAccount_L04_KEY]
          , '|'
          , [GLAccount_L04_DESC_short]
          , '|'
          , [GLAccount_L04_DESC_medium]
          , '|'
          , [GLAccount_L04_DESC_long]
          , '|'
          , [GLAccount_L04_SORT]
          , '|'
          , [GLAccount_L05_KEY]
          , '|'
          , [GLAccount_L05_DESC_short]
          , '|'
          , [GLAccount_L05_DESC_medium]
          , '|'
          , [GLAccount_L05_DESC_long]
          , '|'
          , [GLAccount_L05_SORT]
          , '|'
          , [GLAccount_L06_KEY]
          , '|'
          , [GLAccount_L06_DESC_short]
          , '|'
          , [GLAccount_L06_DESC_medium]
          , '|'
          , [GLAccount_L06_DESC_long]
          , '|'
          , [GLAccount_L06_SORT]
          , '|'
          , [GLAccount_L07_KEY]
          , '|'
          , [GLAccount_L07_DESC_short]
          , '|'
          , [GLAccount_L07_DESC_medium]
          , '|'
          , [GLAccount_L07_DESC_long]
          , '|'
          , [GLAccount_L07_SORT]
          , '|'
          , [GLAccount_L08_KEY]
          , '|'
          , [GLAccount_L08_DESC_short]
          , '|'
          , [GLAccount_L08_DESC_medium]
          , '|'
          , [GLAccount_L08_DESC_long]
          , '|'
          , [GLAccount_L08_SORT]
          , '|'
          , [GLAccount_L09_KEY]
          , '|'
          , [GLAccount_L09_DESC_short]
          , '|'
          , [GLAccount_L09_DESC_medium]
          , '|'
          , [GLAccount_L09_DESC_long]
          , '|'
          , [GLAccount_L09_SORT]
          , '|'
          , [GLAccount_L10_KEY]
          , '|'
          , [GLAccount_L10_DESC_short]
          , '|'
          , [GLAccount_L10_DESC_medium]
          , '|'
          , [GLAccount_L10_DESC_long]
          , '|'
          , [GLAccount_L10_SORT]
          , '|'
          , [GLAccount_L11_KEY]
          , '|'
          , [GLAccount_L11_DESC_short]
          , '|'
          , [GLAccount_L11_DESC_medium]
          , '|'
          , [GLAccount_L11_DESC_long]
          , '|'
          , [GLAccount_L11_SORT]
          , '|'
          , [GLAccount_L12_KEY]
          , '|'
          , [GLAccount_L12_DESC_short]
          , '|'
          , [GLAccount_L12_DESC_medium]
          , '|'
          , [GLAccount_L12_DESC_long]
          , '|'
          , [GLAccount_L12_SORT]
          , '|'
          , [GLAccount_Type]
          , '|'
          , [GLAccount_IsLeaf]
          , '|'
          , [GLAccount_Level]
        )
      ) AS meta_hash
    FROM (
      SELECT
        [ChartOfAccounts_KEY]
        , [GLAccount_KEY]
        , [GLAccount_L01_KEY]
        , [GLAccount_L01_DESC_short]
        , [GLAccount_L01_DESC_medium]
        , [GLAccount_L01_DESC_long]
        , [GLAccount_L01_SORT]
        , [GLAccount_L02_KEY]
        , [GLAccount_L02_DESC_short]
        , [GLAccount_L02_DESC_medium]
        , [GLAccount_L02_DESC_long]
        , [GLAccount_L02_SORT]
        , [GLAccount_L03_KEY]
        , [GLAccount_L03_DESC_short]
        , [GLAccount_L03_DESC_medium]
        , [GLAccount_L03_DESC_long]
        , [GLAccount_L03_SORT]
        , [GLAccount_L04_KEY]
        , [GLAccount_L04_DESC_short]
        , [GLAccount_L04_DESC_medium]
        , [GLAccount_L04_DESC_long]
        , [GLAccount_L04_SORT]
        , [GLAccount_L05_KEY]
        , [GLAccount_L05_DESC_short]
        , [GLAccount_L05_DESC_medium]
        , [GLAccount_L05_DESC_long]
        , [GLAccount_L05_SORT]
        , [GLAccount_L06_KEY]
        , [GLAccount_L06_DESC_short]
        , [GLAccount_L06_DESC_medium]
        , [GLAccount_L06_DESC_long]
        , [GLAccount_L06_SORT]
        , [GLAccount_L07_KEY]
        , [GLAccount_L07_DESC_short]
        , [GLAccount_L07_DESC_medium]
        , [GLAccount_L07_DESC_long]
        , [GLAccount_L07_SORT]
        , [GLAccount_L08_KEY]
        , [GLAccount_L08_DESC_short]
        , [GLAccount_L08_DESC_medium]
        , [GLAccount_L08_DESC_long]
        , [GLAccount_L08_SORT]
        , [GLAccount_L09_KEY]
        , [GLAccount_L09_DESC_short]
        , [GLAccount_L09_DESC_medium]
        , [GLAccount_L09_DESC_long]
        , [GLAccount_L09_SORT]
        , [GLAccount_L10_KEY]
        , [GLAccount_L10_DESC_short]
        , [GLAccount_L10_DESC_medium]
        , [GLAccount_L10_DESC_long]
        , [GLAccount_L10_SORT]
        , [GLAccount_L11_KEY]
        , [GLAccount_L11_DESC_short]
        , [GLAccount_L11_DESC_medium]
        , [GLAccount_L11_DESC_long]
        , [GLAccount_L11_SORT]
        , [GLAccount_L12_KEY]
        , [GLAccount_L12_DESC_short]
        , [GLAccount_L12_DESC_medium]
        , [GLAccount_L12_DESC_long]
        , [GLAccount_L12_SORT]
        , [GLAccount_Type]
        , [GLAccount_IsLeaf]
        , [GLAccount_Level]
      FROM INTERNAL_ETL.DIL_md_GLAccount_Hierarchy_INT()
    ) t
  )

  INSERT INTO #BufferedSource_DIL_md_GLAccount_Hierarchy_INT WITH (TABLOCK) (
    [ChartOfAccounts_KEY]
    , [GLAccount_KEY]
    , [GLAccount_L01_KEY]
    , [GLAccount_L01_DESC_short]
    , [GLAccount_L01_DESC_medium]
    , [GLAccount_L01_DESC_long]
    , [GLAccount_L01_SORT]
    , [GLAccount_L02_KEY]
    , [GLAccount_L02_DESC_short]
    , [GLAccount_L02_DESC_medium]
    , [GLAccount_L02_DESC_long]
    , [GLAccount_L02_SORT]
    , [GLAccount_L03_KEY]
    , [GLAccount_L03_DESC_short]
    , [GLAccount_L03_DESC_medium]
    , [GLAccount_L03_DESC_long]
    , [GLAccount_L03_SORT]
    , [GLAccount_L04_KEY]
    , [GLAccount_L04_DESC_short]
    , [GLAccount_L04_DESC_medium]
    , [GLAccount_L04_DESC_long]
    , [GLAccount_L04_SORT]
    , [GLAccount_L05_KEY]
    , [GLAccount_L05_DESC_short]
    , [GLAccount_L05_DESC_medium]
    , [GLAccount_L05_DESC_long]
    , [GLAccount_L05_SORT]
    , [GLAccount_L06_KEY]
    , [GLAccount_L06_DESC_short]
    , [GLAccount_L06_DESC_medium]
    , [GLAccount_L06_DESC_long]
    , [GLAccount_L06_SORT]
    , [GLAccount_L07_KEY]
    , [GLAccount_L07_DESC_short]
    , [GLAccount_L07_DESC_medium]
    , [GLAccount_L07_DESC_long]
    , [GLAccount_L07_SORT]
    , [GLAccount_L08_KEY]
    , [GLAccount_L08_DESC_short]
    , [GLAccount_L08_DESC_medium]
    , [GLAccount_L08_DESC_long]
    , [GLAccount_L08_SORT]
    , [GLAccount_L09_KEY]
    , [GLAccount_L09_DESC_short]
    , [GLAccount_L09_DESC_medium]
    , [GLAccount_L09_DESC_long]
    , [GLAccount_L09_SORT]
    , [GLAccount_L10_KEY]
    , [GLAccount_L10_DESC_short]
    , [GLAccount_L10_DESC_medium]
    , [GLAccount_L10_DESC_long]
    , [GLAccount_L10_SORT]
    , [GLAccount_L11_KEY]
    , [GLAccount_L11_DESC_short]
    , [GLAccount_L11_DESC_medium]
    , [GLAccount_L11_DESC_long]
    , [GLAccount_L11_SORT]
    , [GLAccount_L12_KEY]
    , [GLAccount_L12_DESC_short]
    , [GLAccount_L12_DESC_medium]
    , [GLAccount_L12_DESC_long]
    , [GLAccount_L12_SORT]
    , [GLAccount_Type]
    , [GLAccount_IsLeaf]
    , [GLAccount_Level]
    , [meta_hash]
  )
  SELECT
    [ChartOfAccounts_KEY]
    , [GLAccount_KEY]
    , [GLAccount_L01_KEY]
    , [GLAccount_L01_DESC_short]
    , [GLAccount_L01_DESC_medium]
    , [GLAccount_L01_DESC_long]
    , [GLAccount_L01_SORT]
    , [GLAccount_L02_KEY]
    , [GLAccount_L02_DESC_short]
    , [GLAccount_L02_DESC_medium]
    , [GLAccount_L02_DESC_long]
    , [GLAccount_L02_SORT]
    , [GLAccount_L03_KEY]
    , [GLAccount_L03_DESC_short]
    , [GLAccount_L03_DESC_medium]
    , [GLAccount_L03_DESC_long]
    , [GLAccount_L03_SORT]
    , [GLAccount_L04_KEY]
    , [GLAccount_L04_DESC_short]
    , [GLAccount_L04_DESC_medium]
    , [GLAccount_L04_DESC_long]
    , [GLAccount_L04_SORT]
    , [GLAccount_L05_KEY]
    , [GLAccount_L05_DESC_short]
    , [GLAccount_L05_DESC_medium]
    , [GLAccount_L05_DESC_long]
    , [GLAccount_L05_SORT]
    , [GLAccount_L06_KEY]
    , [GLAccount_L06_DESC_short]
    , [GLAccount_L06_DESC_medium]
    , [GLAccount_L06_DESC_long]
    , [GLAccount_L06_SORT]
    , [GLAccount_L07_KEY]
    , [GLAccount_L07_DESC_short]
    , [GLAccount_L07_DESC_medium]
    , [GLAccount_L07_DESC_long]
    , [GLAccount_L07_SORT]
    , [GLAccount_L08_KEY]
    , [GLAccount_L08_DESC_short]
    , [GLAccount_L08_DESC_medium]
    , [GLAccount_L08_DESC_long]
    , [GLAccount_L08_SORT]
    , [GLAccount_L09_KEY]
    , [GLAccount_L09_DESC_short]
    , [GLAccount_L09_DESC_medium]
    , [GLAccount_L09_DESC_long]
    , [GLAccount_L09_SORT]
    , [GLAccount_L10_KEY]
    , [GLAccount_L10_DESC_short]
    , [GLAccount_L10_DESC_medium]
    , [GLAccount_L10_DESC_long]
    , [GLAccount_L10_SORT]
    , [GLAccount_L11_KEY]
    , [GLAccount_L11_DESC_short]
    , [GLAccount_L11_DESC_medium]
    , [GLAccount_L11_DESC_long]
    , [GLAccount_L11_SORT]
    , [GLAccount_L12_KEY]
    , [GLAccount_L12_DESC_short]
    , [GLAccount_L12_DESC_medium]
    , [GLAccount_L12_DESC_long]
    , [GLAccount_L12_SORT]
    , [GLAccount_Type]
    , [GLAccount_IsLeaf]
    , [GLAccount_Level]
    , [meta_hash]
  FROM s

  MERGE [DIL].[md_GLAccount_Hierarchy_INT] t
  USING #BufferedSource_DIL_md_GLAccount_Hierarchy_INT s
    ON (
      t.[ChartOfAccounts_KEY] = s.[ChartOfAccounts_KEY]
      AND t.[GLAccount_KEY] = s.[GLAccount_KEY]
    )
  WHEN NOT MATCHED BY TARGET
    THEN
    INSERT (
      [ChartOfAccounts_KEY]
      , [GLAccount_KEY]
      , [GLAccount_L01_KEY]
      , [GLAccount_L01_DESC_short]
      , [GLAccount_L01_DESC_medium]
      , [GLAccount_L01_DESC_long]
      , [GLAccount_L01_SORT]
      , [GLAccount_L02_KEY]
      , [GLAccount_L02_DESC_short]
      , [GLAccount_L02_DESC_medium]
      , [GLAccount_L02_DESC_long]
      , [GLAccount_L02_SORT]
      , [GLAccount_L03_KEY]
      , [GLAccount_L03_DESC_short]
      , [GLAccount_L03_DESC_medium]
      , [GLAccount_L03_DESC_long]
      , [GLAccount_L03_SORT]
      , [GLAccount_L04_KEY]
      , [GLAccount_L04_DESC_short]
      , [GLAccount_L04_DESC_medium]
      , [GLAccount_L04_DESC_long]
      , [GLAccount_L04_SORT]
      , [GLAccount_L05_KEY]
      , [GLAccount_L05_DESC_short]
      , [GLAccount_L05_DESC_medium]
      , [GLAccount_L05_DESC_long]
      , [GLAccount_L05_SORT]
      , [GLAccount_L06_KEY]
      , [GLAccount_L06_DESC_short]
      , [GLAccount_L06_DESC_medium]
      , [GLAccount_L06_DESC_long]
      , [GLAccount_L06_SORT]
      , [GLAccount_L07_KEY]
      , [GLAccount_L07_DESC_short]
      , [GLAccount_L07_DESC_medium]
      , [GLAccount_L07_DESC_long]
      , [GLAccount_L07_SORT]
      , [GLAccount_L08_KEY]
      , [GLAccount_L08_DESC_short]
      , [GLAccount_L08_DESC_medium]
      , [GLAccount_L08_DESC_long]
      , [GLAccount_L08_SORT]
      , [GLAccount_L09_KEY]
      , [GLAccount_L09_DESC_short]
      , [GLAccount_L09_DESC_medium]
      , [GLAccount_L09_DESC_long]
      , [GLAccount_L09_SORT]
      , [GLAccount_L10_KEY]
      , [GLAccount_L10_DESC_short]
      , [GLAccount_L10_DESC_medium]
      , [GLAccount_L10_DESC_long]
      , [GLAccount_L10_SORT]
      , [GLAccount_L11_KEY]
      , [GLAccount_L11_DESC_short]
      , [GLAccount_L11_DESC_medium]
      , [GLAccount_L11_DESC_long]
      , [GLAccount_L11_SORT]
      , [GLAccount_L12_KEY]
      , [GLAccount_L12_DESC_short]
      , [GLAccount_L12_DESC_medium]
      , [GLAccount_L12_DESC_long]
      , [GLAccount_L12_SORT]
      , [GLAccount_Type]
      , [GLAccount_IsLeaf]
      , [GLAccount_Level]
      , meta_hash
      , meta_created_execution_id
    )
    VALUES (
      [ChartOfAccounts_KEY]
      , [GLAccount_KEY]
      , [GLAccount_L01_KEY]
      , [GLAccount_L01_DESC_short]
      , [GLAccount_L01_DESC_medium]
      , [GLAccount_L01_DESC_long]
      , [GLAccount_L01_SORT]
      , [GLAccount_L02_KEY]
      , [GLAccount_L02_DESC_short]
      , [GLAccount_L02_DESC_medium]
      , [GLAccount_L02_DESC_long]
      , [GLAccount_L02_SORT]
      , [GLAccount_L03_KEY]
      , [GLAccount_L03_DESC_short]
      , [GLAccount_L03_DESC_medium]
      , [GLAccount_L03_DESC_long]
      , [GLAccount_L03_SORT]
      , [GLAccount_L04_KEY]
      , [GLAccount_L04_DESC_short]
      , [GLAccount_L04_DESC_medium]
      , [GLAccount_L04_DESC_long]
      , [GLAccount_L04_SORT]
      , [GLAccount_L05_KEY]
      , [GLAccount_L05_DESC_short]
      , [GLAccount_L05_DESC_medium]
      , [GLAccount_L05_DESC_long]
      , [GLAccount_L05_SORT]
      , [GLAccount_L06_KEY]
      , [GLAccount_L06_DESC_short]
      , [GLAccount_L06_DESC_medium]
      , [GLAccount_L06_DESC_long]
      , [GLAccount_L06_SORT]
      , [GLAccount_L07_KEY]
      , [GLAccount_L07_DESC_short]
      , [GLAccount_L07_DESC_medium]
      , [GLAccount_L07_DESC_long]
      , [GLAccount_L07_SORT]
      , [GLAccount_L08_KEY]
      , [GLAccount_L08_DESC_short]
      , [GLAccount_L08_DESC_medium]
      , [GLAccount_L08_DESC_long]
      , [GLAccount_L08_SORT]
      , [GLAccount_L09_KEY]
      , [GLAccount_L09_DESC_short]
      , [GLAccount_L09_DESC_medium]
      , [GLAccount_L09_DESC_long]
      , [GLAccount_L09_SORT]
      , [GLAccount_L10_KEY]
      , [GLAccount_L10_DESC_short]
      , [GLAccount_L10_DESC_medium]
      , [GLAccount_L10_DESC_long]
      , [GLAccount_L10_SORT]
      , [GLAccount_L11_KEY]
      , [GLAccount_L11_DESC_short]
      , [GLAccount_L11_DESC_medium]
      , [GLAccount_L11_DESC_long]
      , [GLAccount_L11_SORT]
      , [GLAccount_L12_KEY]
      , [GLAccount_L12_DESC_short]
      , [GLAccount_L12_DESC_medium]
      , [GLAccount_L12_DESC_long]
      , [GLAccount_L12_SORT]
      , [GLAccount_Type]
      , [GLAccount_IsLeaf]
      , [GLAccount_Level]
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
        t.[GLAccount_L01_KEY] = s.[GLAccount_L01_KEY]
        , t.[GLAccount_L01_DESC_short] = s.[GLAccount_L01_DESC_short]
        , t.[GLAccount_L01_DESC_medium] = s.[GLAccount_L01_DESC_medium]
        , t.[GLAccount_L01_DESC_long] = s.[GLAccount_L01_DESC_long]
        , t.[GLAccount_L01_SORT] = s.[GLAccount_L01_SORT]
        , t.[GLAccount_L02_KEY] = s.[GLAccount_L02_KEY]
        , t.[GLAccount_L02_DESC_short] = s.[GLAccount_L02_DESC_short]
        , t.[GLAccount_L02_DESC_medium] = s.[GLAccount_L02_DESC_medium]
        , t.[GLAccount_L02_DESC_long] = s.[GLAccount_L02_DESC_long]
        , t.[GLAccount_L02_SORT] = s.[GLAccount_L02_SORT]
        , t.[GLAccount_L03_KEY] = s.[GLAccount_L03_KEY]
        , t.[GLAccount_L03_DESC_short] = s.[GLAccount_L03_DESC_short]
        , t.[GLAccount_L03_DESC_medium] = s.[GLAccount_L03_DESC_medium]
        , t.[GLAccount_L03_DESC_long] = s.[GLAccount_L03_DESC_long]
        , t.[GLAccount_L03_SORT] = s.[GLAccount_L03_SORT]
        , t.[GLAccount_L04_KEY] = s.[GLAccount_L04_KEY]
        , t.[GLAccount_L04_DESC_short] = s.[GLAccount_L04_DESC_short]
        , t.[GLAccount_L04_DESC_medium] = s.[GLAccount_L04_DESC_medium]
        , t.[GLAccount_L04_DESC_long] = s.[GLAccount_L04_DESC_long]
        , t.[GLAccount_L04_SORT] = s.[GLAccount_L04_SORT]
        , t.[GLAccount_L05_KEY] = s.[GLAccount_L05_KEY]
        , t.[GLAccount_L05_DESC_short] = s.[GLAccount_L05_DESC_short]
        , t.[GLAccount_L05_DESC_medium] = s.[GLAccount_L05_DESC_medium]
        , t.[GLAccount_L05_DESC_long] = s.[GLAccount_L05_DESC_long]
        , t.[GLAccount_L05_SORT] = s.[GLAccount_L05_SORT]
        , t.[GLAccount_L06_KEY] = s.[GLAccount_L06_KEY]
        , t.[GLAccount_L06_DESC_short] = s.[GLAccount_L06_DESC_short]
        , t.[GLAccount_L06_DESC_medium] = s.[GLAccount_L06_DESC_medium]
        , t.[GLAccount_L06_DESC_long] = s.[GLAccount_L06_DESC_long]
        , t.[GLAccount_L06_SORT] = s.[GLAccount_L06_SORT]
        , t.[GLAccount_L07_KEY] = s.[GLAccount_L07_KEY]
        , t.[GLAccount_L07_DESC_short] = s.[GLAccount_L07_DESC_short]
        , t.[GLAccount_L07_DESC_medium] = s.[GLAccount_L07_DESC_medium]
        , t.[GLAccount_L07_DESC_long] = s.[GLAccount_L07_DESC_long]
        , t.[GLAccount_L07_SORT] = s.[GLAccount_L07_SORT]
        , t.[GLAccount_L08_KEY] = s.[GLAccount_L08_KEY]
        , t.[GLAccount_L08_DESC_short] = s.[GLAccount_L08_DESC_short]
        , t.[GLAccount_L08_DESC_medium] = s.[GLAccount_L08_DESC_medium]
        , t.[GLAccount_L08_DESC_long] = s.[GLAccount_L08_DESC_long]
        , t.[GLAccount_L08_SORT] = s.[GLAccount_L08_SORT]
        , t.[GLAccount_L09_KEY] = s.[GLAccount_L09_KEY]
        , t.[GLAccount_L09_DESC_short] = s.[GLAccount_L09_DESC_short]
        , t.[GLAccount_L09_DESC_medium] = s.[GLAccount_L09_DESC_medium]
        , t.[GLAccount_L09_DESC_long] = s.[GLAccount_L09_DESC_long]
        , t.[GLAccount_L09_SORT] = s.[GLAccount_L09_SORT]
        , t.[GLAccount_L10_KEY] = s.[GLAccount_L10_KEY]
        , t.[GLAccount_L10_DESC_short] = s.[GLAccount_L10_DESC_short]
        , t.[GLAccount_L10_DESC_medium] = s.[GLAccount_L10_DESC_medium]
        , t.[GLAccount_L10_DESC_long] = s.[GLAccount_L10_DESC_long]
        , t.[GLAccount_L10_SORT] = s.[GLAccount_L10_SORT]
        , t.[GLAccount_L11_KEY] = s.[GLAccount_L11_KEY]
        , t.[GLAccount_L11_DESC_short] = s.[GLAccount_L11_DESC_short]
        , t.[GLAccount_L11_DESC_medium] = s.[GLAccount_L11_DESC_medium]
        , t.[GLAccount_L11_DESC_long] = s.[GLAccount_L11_DESC_long]
        , t.[GLAccount_L11_SORT] = s.[GLAccount_L11_SORT]
        , t.[GLAccount_L12_KEY] = s.[GLAccount_L12_KEY]
        , t.[GLAccount_L12_DESC_short] = s.[GLAccount_L12_DESC_short]
        , t.[GLAccount_L12_DESC_medium] = s.[GLAccount_L12_DESC_medium]
        , t.[GLAccount_L12_DESC_long] = s.[GLAccount_L12_DESC_long]
        , t.[GLAccount_L12_SORT] = s.[GLAccount_L12_SORT]
        , t.[GLAccount_Type] = s.[GLAccount_Type]
        , t.[GLAccount_IsLeaf] = s.[GLAccount_IsLeaf]
        , t.[GLAccount_Level] = s.[GLAccount_Level]
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
  INTO #MergeOutput_DIL_md_GLAccount_Hierarchy_INT;

  SELECT
    @RowCount = @@ROWCOUNT
    , @RowsInserted = ISNULL(SUM(IIF([action] = 'INSERT', 1, 0)), 0)
    , @RowsUpdated = ISNULL(SUM(IIF([action] = 'UPDATE', 1, 0)), 0)
    , @RowsDeleted = ISNULL(SUM(IIF([action] = 'DELETE', 1, 0)), 0)
    , @RowsUpdatedDeactivated = ISNULL(SUM(IIF([action] = 'UPDATE' AND insert_meta_isActive = 'FALSE' AND delete_meta_isActive = 'TRUE', 1, 0)), 0)
    , @RowsUpdatedReactivated = ISNULL(SUM(IIF([action] = 'UPDATE' AND insert_meta_isActive = 'TRUE' AND delete_meta_isActive = 'FALSE', 1, 0)), 0)
  FROM #MergeOutput_DIL_md_GLAccount_Hierarchy_INT

  DROP TABLE IF EXISTS #BufferedSource_DIL_md_GLAccount_Hierarchy_INT;
  DROP TABLE IF EXISTS #MergeOutput_DIL_md_GLAccount_Hierarchy_INT;

  SELECT
    '[DIL].[md_GLAccount_Hierarchy_INT]' AS [table]
    , 'Merge' AS loadpattern
    , @execution_id AS execution_id
    , @RowsInserted AS inserted
    , @RowsUpdated AS updated
    , @RowsDeleted AS deleted
    , @RowsUpdatedDeactivated AS deactivated
    , @RowsUpdatedReactivated AS reactivated

END
