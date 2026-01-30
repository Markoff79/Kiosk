CREATE TABLE [DAL_SAP].[md_0GL_ACCOUNT_T011_HIER_INT] (
  [tst] datetime2(3) CONSTRAINT [DF_DAL_SAP_md_0GL_ACCOUNT_T011_HIER_INT] DEFAULT (SYSDATETIME()) NOT NULL
  , [JobID] bigint NOT NULL
  , [JobTST] datetime2(7) NOT NULL
  , [NodeID] nvarchar(8) NULL
  , [NodeName] nvarchar(32) NULL
  , [TLEVEL] nvarchar(2) NULL
  , [Link] nvarchar(1) NULL
  , [ParentID] nvarchar(8) NULL
  , [ChildID] nvarchar(8) NULL
  , [NextID] nvarchar(8) NULL
  , [FIELDNM] nvarchar(30) NULL
  , [KTOPL] nvarchar(4) NULL
  , [SAKNR] nvarchar(10) NULL
  , [RSIGN] nvarchar(1) NULL
  , [PLUMI] nvarchar(1) NULL
  , [TXTSH] nvarchar(20) NULL
  , [TXTMD] nvarchar(40) NULL
  , [TXTLG] nvarchar(60) NULL
);

GO
EXECUTE sp_addextendedproperty @name = N'sampleDataExport', @value = N'yes', @level0type = N'SCHEMA', @level0name = N'DAL_SAP', @level1type = N'TABLE', @level1name = N'md_0GL_ACCOUNT_T011_HIER_INT';

GO
EXECUTE sp_addextendedproperty
  @name = N'sampleDataExportFilter', @value = N' WHERE 1 = 1 ', @level0type = N'SCHEMA', @level0name = N'DAL_SAP', @level1type = N'TABLE', @level1name = N'md_0GL_ACCOUNT_T011_HIER_INT';
