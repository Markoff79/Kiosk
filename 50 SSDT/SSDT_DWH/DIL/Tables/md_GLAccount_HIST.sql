CREATE TABLE [DIL].[md_GLAccount_HIST] (
  [ChartOfAccounts_KEY] nvarchar(4) NOT NULL
  , [GLAccount_KEY] nvarchar(10) NOT NULL
  , [ValidFrom] date NOT NULL
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
  , [tst] datetime2(3) CONSTRAINT [DF_DIL_md_GLAccount_HIST_tst] DEFAULT (SYSDATETIME()) NOT NULL

  , [ValidTo] date NOT NULL
  , [isRowLatest] bit NOT NULL DEFAULT ('TRUE')
  , [isRowCurrent] bit NOT NULL DEFAULT ('TRUE')
  , [meta_hash] binary(16) NULL
  , [meta_created_execution_id] bigint NOT NULL DEFAULT -1
  , [meta_created_by] nvarchar(128) NOT NULL DEFAULT (SUSER_NAME())
  , [meta_created_at] datetime2(7) NOT NULL DEFAULT (SYSDATETIME())
  , [meta_modified_execution_id] bigint NULL
  , [meta_modified_by] nvarchar(128) NULL
  , [meta_modified_at] datetime2(7) NULL
);
GO

ALTER TABLE [DIL].[md_GLAccount_HIST] ADD CONSTRAINT [PK_DIL_md_GLAccount_HIST] PRIMARY KEY CLUSTERED ([ChartOfAccounts_KEY] ASC, [GLAccount_KEY] ASC, [ValidFrom] ASC) WITH (DATA_COMPRESSION = PAGE);
GO
