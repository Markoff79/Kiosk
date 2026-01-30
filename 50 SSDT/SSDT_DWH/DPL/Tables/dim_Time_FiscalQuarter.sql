CREATE TABLE [DPL].[dim_Time_FiscalQuarter] (
  [fiscalquarter_Time_ID] int NOT NULL
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
  , [fiscalyear_Time_ID] int NULL
  , [fiscalyear_Desc] varchar(7) NULL
  , [fiscalyear_is_leap_year] tinyint NULL
  , [fiscalyear_weekdays] smallint NULL
  , [fiscalyear_first_day] date NULL
  , [fiscalyear_last_day] date NULL
  , [fiscalyear_PFY_Time_ID] int NULL
  , [fiscalyear_PPFY_Time_ID] int NULL
  , [fiscalyear_PPPFY_Time_ID] int NULL
  , CONSTRAINT [PK_DPL_dim_Time_FiscalQuarter] PRIMARY KEY CLUSTERED ([fiscalquarter_Time_ID] ASC)
);






GO



GO



GO



GO



GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalQuarter_quarter_last_day]
  ON [DPL].[dim_Time_FiscalQuarter] ([fiscalquarter_last_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalQuarter_quarter_first_day]
  ON [DPL].[dim_Time_FiscalQuarter] ([fiscalquarter_first_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalQuarter_fiscalyear_Time_ID]
  ON [DPL].[dim_Time_FiscalQuarter] ([fiscalyear_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalQuarter_fiscalquarter_Time_ID]
  ON [DPL].[dim_Time_FiscalQuarter] ([fiscalquarter_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_FiscalQuarter_fiscalquarter_Desc]
  ON [DPL].[dim_Time_FiscalQuarter] ([fiscalquarter_Desc] ASC);
