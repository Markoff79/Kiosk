CREATE TABLE [DAL_SAP].[md_0GL_ACCOUNT_ATTR] (
  [tst] datetime2(3) CONSTRAINT [DF_DAL_SAP_md_0GL_ACCOUNT_ATTR] DEFAULT (SYSDATETIME()) NOT NULL
  , [JobID] bigint NOT NULL
  , [JobTST] datetime2(7) NOT NULL
  , [KTOPL] nvarchar(4) NULL
  , [SAKNR] nvarchar(10) NULL
  , [BILKT] nvarchar(10) NULL
  , [GVTYP] nvarchar(2) NULL
  , [VBUND] nvarchar(6) NULL
  , [XBILK] nvarchar(1) NULL
  , [SAKAN] nvarchar(10) NULL
  , [ERDAT] date NULL
  , [ERNAM] nvarchar(12) NULL
  , [KTOKS] nvarchar(4) NULL
  , [XLOEV] nvarchar(1) NULL
  , [XSPEA] nvarchar(1) NULL
  , [XSPEB] nvarchar(1) NULL
  , [XSPEP] nvarchar(1) NULL
  , [FUNC_AREA] nvarchar(16) NULL
  , [MUSTR] nvarchar(10) NULL
);

GO
EXECUTE sp_addextendedproperty
  @name = N'sampleDataExportFilter', @value = N'WHERE KTOPL = ''INT''', @level0type = N'SCHEMA', @level0name = N'DAL_SAP', @level1type = N'TABLE', @level1name = N'md_0GL_ACCOUNT_ATTR';


GO
EXECUTE sp_addextendedproperty @name = N'sampleDataExport', @value = N'yes', @level0type = N'SCHEMA', @level0name = N'DAL_SAP', @level1type = N'TABLE', @level1name = N'md_0GL_ACCOUNT_ATTR';
