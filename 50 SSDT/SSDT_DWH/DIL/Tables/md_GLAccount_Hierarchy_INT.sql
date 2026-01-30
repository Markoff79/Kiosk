CREATE TABLE [DIL].[md_GLAccount_Hierarchy_INT] (
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
  , [tst] datetime2(3) CONSTRAINT [DF_DIL_md_GLAccount_Hierarchy_INT_tst] DEFAULT (SYSDATETIME()) NOT NULL

  , [meta_isActive] bit NOT NULL DEFAULT ('TRUE')
  , [meta_hash] binary(16) NULL
  , [meta_created_execution_id] bigint NOT NULL DEFAULT -1
  , [meta_created_by] nvarchar(128) NOT NULL DEFAULT (SUSER_NAME())
  , [meta_created_at] datetime2(7) NOT NULL DEFAULT (SYSDATETIME())
  , [meta_modified_execution_id] bigint NULL
  , [meta_modified_by] nvarchar(128) NULL
  , [meta_modified_at] datetime2(7) NULL
);
GO

ALTER TABLE [DIL].[md_GLAccount_Hierarchy_INT] ADD CONSTRAINT [PK_DIL_md_GLAccount_Hierarchy_INT] PRIMARY KEY CLUSTERED ([ChartOfAccounts_KEY] ASC, [GLAccount_KEY] ASC) WITH (DATA_COMPRESSION = PAGE);
GO
