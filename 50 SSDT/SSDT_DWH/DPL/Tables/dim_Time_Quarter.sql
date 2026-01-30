CREATE TABLE [DPL].[dim_Time_Quarter] (
  [quarter_Time_ID] int NOT NULL
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
  , [year_Time_ID] int NULL
  , [year_is_leap_year] tinyint NULL
  , [year_weekdays] smallint NULL
  , [year_first_day] date NULL
  , [year_last_day] date NULL
  , [year_PY_Time_ID] int NULL
  , [year_PPY_Time_ID] int NULL
  , [year_PPPY_Time_ID] int NULL
  , CONSTRAINT [PK_DPL_dim_Time_Quarter] PRIMARY KEY CLUSTERED ([quarter_Time_ID] ASC)
);






GO



GO



GO



GO



GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Quarter_year_Time_ID]
  ON [DPL].[dim_Time_Quarter] ([year_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Quarter_quarter_Time_ID]
  ON [DPL].[dim_Time_Quarter] ([quarter_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Quarter_quarter_last_day]
  ON [DPL].[dim_Time_Quarter] ([quarter_last_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Quarter_quarter_first_day]
  ON [DPL].[dim_Time_Quarter] ([quarter_first_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Quarter_quarter_Desc]
  ON [DPL].[dim_Time_Quarter] ([quarter_Desc] ASC);
