CREATE TABLE [DAL_SAP].[md_0GL_ACCOUNT_TEXT] (
  [tst] datetime2(3) CONSTRAINT [DF_DAL_SAP_md_0GL_ACCOUNT_TEXT] DEFAULT (SYSDATETIME()) NOT NULL
  , [JobID] bigint NOT NULL
  , [JobTST] datetime2(7) NOT NULL
  , [LANGU] nvarchar(1) NULL
  , [KTOPL] nvarchar(4) NULL
  , [SAKNR] nvarchar(10) NULL
  , [TXTSH] nvarchar(20) NULL
  , [TXTLG] nvarchar(50) NULL
);

GO
EXECUTE sp_addextendedproperty
  @name = N'sampleDataExportFilter', @value = N'WHERE KTOPL = ''INT'' and LANGU = ''E''', @level0type = N'SCHEMA'
  , @level0name = N'DAL_SAP', @level1type = N'TABLE', @level1name = N'md_0GL_ACCOUNT_TEXT';

GO
EXECUTE sp_addextendedproperty @name = N'sampleDataExport', @value = N'yes', @level0type = N'SCHEMA', @level0name = N'DAL_SAP', @level1type = N'TABLE', @level1name = N'md_0GL_ACCOUNT_TEXT';
