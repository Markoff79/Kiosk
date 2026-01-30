CREATE TABLE [DPL].[dim_Time_Month] (
  [month_Time_ID] int NOT NULL
  , [month_Desc] varchar(7) NULL
  , [month_FiscalDesc] varchar(10) NULL
  , [month_number] tinyint NULL
  , [month_fiscalnumber] tinyint NULL
  , [month_number_string] varchar(2) NULL
  , [month_fiscalnumber_string] varchar(2) NULL
  , [month_name] varchar(10) NULL
  , [month_name_short] varchar(3) NULL
  , [month_name_year] varchar(15) NULL
  , [month_name_year_short] varchar(13) NULL
  , [month_name_short_year] varchar(8) NULL
  , [month_name_short_year_short] varchar(6) NULL
  , [month_days] tinyint NULL
  , [month_holidays] tinyint NULL
  , [month_holidaysRP] tinyint NULL
  , [month_weekdays] tinyint NULL
  , [month_workingdays] tinyint NULL
  , [month_workingdaysRP] tinyint NULL
  , [month_first_day] date NULL
  , [month_last_day] date NULL
  , [month_PM_Time_ID] int NULL
  , [month_PPM_Time_ID] int NULL
  , [month_PPPM_Time_ID] int NULL
  , [month_PY_Time_ID] int NULL
  , [month_PPY_Time_ID] int NULL
  , [month_PPPY_Time_ID] int NULL
  , [quarter_Time_ID] int NULL
  , [quarter_Desc] varchar(7) NULL
  , [quarter_number] tinyint NULL
  , [quarter_name] varchar(2) NULL
  , [quarter_days] tinyint NULL
  , [quarter_weekdays] tinyint NULL
  , [quarter_first_day] date NULL
  , [quarter_last_day] date NULL
  , [quarter_PQ_Time_ID] int NULL
  , [quarter_PPQ_Time_ID] int NULL
  , [quarter_PPPQ_Time_ID] int NULL
  , [quarter_PY_Time_ID] int NULL
  , [quarter_PPY_Time_ID] int NULL
  , [quarter_PPPY_Time_ID] int NULL
  , [fiscalquarter_Time_ID] int NULL
  , [fiscalquarter_Desc] varchar(10) NULL
  , [fiscalquarter_number] tinyint NULL
  , [fiscalquarter_name] varchar(3) NULL
  , [fiscalquarter_days] tinyint NULL
  , [fiscalquarter_weekdays] tinyint NULL
  , [fiscalquarter_first_day] date NULL
  , [fiscalquarter_last_day] date NULL
  , [fiscalquarter_PFQ_Time_ID] int NULL
  , [fiscalquarter_PPFQ_Time_ID] int NULL
  , [fiscalquarter_PPPFQ_Time_ID] int NULL
  , [fiscalquarter_PFY_Time_ID] int NULL
  , [fiscalquarter_PPFY_Time_ID] int NULL
  , [fiscalquarter_PPPFY_Time_ID] int NULL
  , [tertial_Time_ID] int NULL
  , [tertial_Desc] varchar(7) NULL
  , [tertial_number] tinyint NULL
  , [tertial_name] varchar(2) NULL
  , [tertial_days] tinyint NULL
  , [tertial_weekdays] tinyint NULL
  , [tertial_first_day] date NULL
  , [tertial_last_day] date NULL
  , [tertial_PT_Time_ID] int NULL
  , [tertial_PPT_Time_ID] int NULL
  , [tertial_PPPT_Time_ID] int NULL
  , [tertial_PY_Time_ID] int NULL
  , [tertial_PPY_Time_ID] int NULL
  , [tertial_PPPY_Time_ID] int NULL
  , [fiscaltertial_Time_ID] int NULL
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
  , [year_Time_ID] int NULL
  , [year_is_leap_year] tinyint NULL
  , [year_weekdays] smallint NULL
  , [year_first_day] date NULL
  , [year_last_day] date NULL
  , [year_PY_Time_ID] int NULL
  , [year_PPY_Time_ID] int NULL
  , [year_PPPY_Time_ID] int NULL
  , [fiscalyear_Time_ID] int NULL
  , [fiscalyear_Desc] varchar(7) NULL
  , [fiscalyear_is_leap_year] tinyint NULL
  , [fiscalyear_weekdays] smallint NULL
  , [fiscalyear_first_day] date NULL
  , [fiscalyear_last_day] date NULL
  , [fiscalyear_PFY_Time_ID] int NULL
  , [fiscalyear_PPFY_Time_ID] int NULL
  , [fiscalyear_PPPFY_Time_ID] int NULL
  , CONSTRAINT [PK_DPL_dim_Time_Month] PRIMARY KEY CLUSTERED ([month_Time_ID] ASC)
);








GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO



GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_year_Time_ID]
  ON [DPL].[dim_Time_Month] ([year_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_tertial_Time_ID]
  ON [DPL].[dim_Time_Month] ([tertial_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_tertial_Desc]
  ON [DPL].[dim_Time_Month] ([tertial_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_quarter_Time_ID]
  ON [DPL].[dim_Time_Month] ([quarter_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_quarter_Desc]
  ON [DPL].[dim_Time_Month] ([quarter_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_month_Time_ID]
  ON [DPL].[dim_Time_Month] ([month_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_month_last_day]
  ON [DPL].[dim_Time_Month] ([month_last_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_month_FiscalDesc]
  ON [DPL].[dim_Time_Month] ([month_FiscalDesc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_month_first_day]
  ON [DPL].[dim_Time_Month] ([month_first_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_month_Desc]
  ON [DPL].[dim_Time_Month] ([month_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_fiscalyear_Time_ID]
  ON [DPL].[dim_Time_Month] ([fiscalyear_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_fiscaltertial_Time_ID]
  ON [DPL].[dim_Time_Month] ([fiscaltertial_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_fiscaltertial_Desc]
  ON [DPL].[dim_Time_Month] ([fiscaltertial_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_fiscalquarter_Time_ID]
  ON [DPL].[dim_Time_Month] ([fiscalquarter_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Month_fiscalquarter_Desc]
  ON [DPL].[dim_Time_Month] ([fiscalquarter_Desc] ASC);
