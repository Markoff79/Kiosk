CREATE TABLE [DAL_SAP].[td_0FI_AP_4_DELTA] (
  [tst] datetime2(3) CONSTRAINT [DF_DAL_SAP_td_0FI_AP_4_DELTA] DEFAULT (SYSDATETIME()) NOT NULL
  , [JobID] bigint NOT NULL
  , [JobTST] datetime2(7) NOT NULL
  , [TS_SEQUENCE_NUMBER] int NOT NULL
  , [ODQ_CHANGEMODE] nvarchar(1) NULL
  , [ODQ_ENTITYCNTR] numeric(19) NULL
  , [BUKRS] nvarchar(4) NULL
  , [FISCPER] nvarchar(7) NULL
  , [BELNR] nvarchar(10) NULL
  , [BUZEI] nvarchar(3) NULL
  , [UPOSZ] nvarchar(4) NULL
  , [STATUSPS] nvarchar(1) NULL
  , [LIFNR] nvarchar(10) NULL
  , [KKBER] nvarchar(4) NULL
  , [MABER] nvarchar(2) NULL
  , [KOART] nvarchar(1) NULL
  , [UMSKZ] nvarchar(1) NULL
  , [BLART] nvarchar(2) NULL
  , [BSCHL] nvarchar(2) NULL
  , [FISCVAR] nvarchar(2) NULL
  , [BLDAT] date NULL
  , [BUDAT] date NULL
  , [CPUDT] date NULL
  , [AUGDT] date NULL
  , [MADAT] date NULL
  , [NETDT] date NULL
  , [SK1DT] date NULL
  , [SK2DT] date NULL
  , [ZFBDT] date NULL
  , [ZBD1T] numeric(3) NULL
  , [ZBD2T] numeric(3) NULL
  , [ZBD3T] numeric(3) NULL
  , [ZBD1P] numeric(5, 3) NULL
  , [ZBD2P] numeric(5, 3) NULL
  , [LAND1] nvarchar(3) NULL
  , [ZLSCH] nvarchar(1) NULL
  , [ZTERM] nvarchar(4) NULL
  , [ZLSPR] nvarchar(1) NULL
  , [RSTGR] nvarchar(3) NULL
  , [MANSP] nvarchar(1) NULL
  , [MSCHL] nvarchar(1) NULL
  , [MANST] nvarchar(1) NULL
  , [LCURR] nvarchar(5) NULL
  , [DMSOL] numeric(13, 2) NULL
  , [DMHAB] numeric(13, 2) NULL
  , [DMSHB] numeric(13, 2) NULL
  , [SKNTO] numeric(13, 2) NULL
  , [WAERS] nvarchar(5) NULL
  , [WRSOL] numeric(13, 2) NULL
  , [WRHAB] numeric(13, 2) NULL
  , [WRSHB] numeric(13, 2) NULL
  , [SKFBT] numeric(13, 2) NULL
  , [WSKTO] numeric(13, 2) NULL
  , [KTOPL] nvarchar(4) NULL
  , [HKONT] nvarchar(10) NULL
  , [SAKNR] nvarchar(10) NULL
  , [FILKD] nvarchar(10) NULL
  , [AUGBL] nvarchar(10) NULL
  , [XBLNR] nvarchar(16) NULL
  , [REBZG] nvarchar(10) NULL
  , [REBZJ] nvarchar(4) NULL
  , [REBZZ] nvarchar(3) NULL
  , [VBELN] nvarchar(10) NULL
  , [XREF1] nvarchar(12) NULL
  , [XREF2] nvarchar(12) NULL
  , [XREF3] nvarchar(20) NULL
  , [SGTXT] nvarchar(50) NULL
  , [XNEGP] nvarchar(1) NULL
  , [XARCH] nvarchar(1) NULL
  , [UMSKS] nvarchar(1) NULL
  , [UPDMOD] nvarchar(1) NULL
  , [ZUONR] nvarchar(18) NULL
  , [AWTYP] nvarchar(5) NULL
  , [AWKEY] nvarchar(20) NULL
  , [BSTAT] nvarchar(1) NULL
  , [DMBTR] numeric(13, 2) NULL
  , [DMBE2] numeric(13, 2) NULL
  , [DMBE3] numeric(13, 2) NULL
  , [GJAHR] nvarchar(4) NULL
  , [HWAE2] nvarchar(5) NULL
  , [HWAE3] nvarchar(5) NULL
  , [MONAT] nvarchar(2) NULL
  , [PROJK] nvarchar(8) NULL
  , [SHKZG] nvarchar(1) NULL
  , [WRBTR] numeric(13, 2) NULL
);
