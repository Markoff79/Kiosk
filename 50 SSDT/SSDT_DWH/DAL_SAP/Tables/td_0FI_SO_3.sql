CREATE TABLE [DAL_SAP].[td_0FI_SO_3] (
  [tst] datetime2(3) CONSTRAINT [DF_DAL_SAP_td_0FI_SO_3] DEFAULT (SYSDATETIME()) NOT NULL
  , [JobID] bigint NOT NULL
  , [JobTST] datetime2(7) NOT NULL
  , [TS_SEQUENCE_NUMBER] int NOT NULL
  , [ODQ_CHANGEMODE] nvarchar(1) NULL
  , [ODQ_ENTITYCNTR] numeric(19) NULL
  , [BUKRS] nvarchar(8) NULL
  , [BILKT] nvarchar(8) NULL
  , [FISCPER] nvarchar(7) NULL
  , [BELNR] nvarchar(10) NULL
  , [BUZEI] nvarchar(3) NULL
  , [Marco] nvarchar(4) NULL
  , [STATUS] nvarchar(1) NULL
  , [MANR] nvarchar(10) NULL
  , [SHKZG] nvarchar(1) NULL
  , [WRBTR] numeric(13, 2) NULL
);

GO
EXECUTE sp_addextendedproperty @name = N'sampleDataExport', @value = N'yes', @level0type = N'SCHEMA', @level0name = N'DAL_SAP', @level1type = N'TABLE', @level1name = N'td_0FI_SO_3';
