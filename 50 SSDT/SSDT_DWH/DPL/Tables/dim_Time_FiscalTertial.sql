CREATE TABLE [DPL].[dim_Time_FiscalTertial] (
  [fiscaltertial_Time_ID] int NOT NULL
  , [fiscaltertial_Desc] varchar(10) NULL
  , [fiscaltertial_number] tinyint NULL
  , [fiscaltertial_name] varchar(3) NULL
  , [fiscaltertial_days] tinyint NULL
  , [fiscaltertial_weekdays] tinyint NULL
  , [fiscaltertial_first_day] date NULL
  , [fiscaltertial_last_day] date NULL
  , [fiscaltertial_PFT_Time_ID] int NULL
  , [fiscaltertial_PPFT_Time_ID] int NULL
  , [fiscaltertial_PPPFT_Time_ID] int NULL
  , [fiscaltertial_PFY_Time_ID] int NULL
  , [fiscaltertial_PPFY_Time_ID] int NULL
  , [fiscaltertial_PPPFY_Time_ID] int NULL
  , [fiscalyear_Time_ID] int NULL
  , [fiscalyear_Desc] varchar(7) NULL
  , [fiscalyear_is_leap_year] tinyint NULL
  , [fiscalyear_weekdays] smallint NULL
  , [fiscalyear_first_day] date NULL
  , [fiscalyear_last_day] date NULL
  , [fiscalyear_PFY_Time_ID] int NULL
  , [fiscalyear_PPFY_Time_ID] int NULL
  , [fiscalyear_PPPFY_Time_ID] int NULL
  , CONSTRAINT [PK_DPL_dim_Time_FiscalTertial] PRIMARY KEY CLUSTERED ([fiscaltertial_Time_ID] ASC)
);






GO



GO



GO



GO



GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalTertial_tertial_last_day]
  ON [DPL].[dim_Time_FiscalTertial] ([fiscaltertial_last_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalTertial_tertial_first_day]
  ON [DPL].[dim_Time_FiscalTertial] ([fiscaltertial_first_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalTertial_fiscalyear_Time_ID]
  ON [DPL].[dim_Time_FiscalTertial] ([fiscalyear_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalTertial_fiscaltertial_Time_ID]
  ON [DPL].[dim_Time_FiscalTertial] ([fiscaltertial_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalTertial_fiscaltertial_Desc]
  ON [DPL].[dim_Time_FiscalTertial] ([fiscaltertial_Desc] ASC);
