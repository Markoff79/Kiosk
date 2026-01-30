CREATE TABLE [DPL].[dim_Time_FiscalYear] (
  [fiscalyear_Time_ID] int NOT NULL
  , [fiscalyear_Desc] varchar(7) NULL
  , [fiscalyear_is_leap_year] tinyint NULL
  , [fiscalyear_weekdays] smallint NULL
  , [fiscalyear_first_day] date NULL
  , [fiscalyear_last_day] date NULL
  , [fiscalyear_PFY_Time_ID] int NULL
  , [fiscalyear_PPFY_Time_ID] int NULL
  , [fiscalyear_PPPFY_Time_ID] int NULL
  , CONSTRAINT [PK_DPL_dim_Time_FiscalYear] PRIMARY KEY CLUSTERED ([fiscalyear_Time_ID] ASC)
);






GO



GO



GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalYear_year_last_day]
  ON [DPL].[dim_Time_FiscalYear] ([fiscalyear_last_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalYear_year_first_day]
  ON [DPL].[dim_Time_FiscalYear] ([fiscalyear_first_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalYear_fiscalyear_Time_ID]
  ON [DPL].[dim_Time_FiscalYear] ([fiscalyear_Time_ID] ASC);
