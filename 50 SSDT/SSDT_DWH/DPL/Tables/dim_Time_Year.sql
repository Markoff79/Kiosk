CREATE TABLE [DPL].[dim_Time_Year] (
  [year_Time_ID] int NOT NULL
  , [year_is_leap_year] tinyint NULL
  , [year_weekdays] smallint NULL
  , [year_first_day] date NULL
  , [year_last_day] date NULL
  , [year_PY_Time_ID] int NULL
  , [year_PPY_Time_ID] int NULL
  , [year_PPPY_Time_ID] int NULL
  , CONSTRAINT [PK_DPL_dim_Time_Year] PRIMARY KEY CLUSTERED ([year_Time_ID] ASC)
);






GO



GO



GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Year_year_Time_ID]
  ON [DPL].[dim_Time_Year] ([year_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Year_year_last_day]
  ON [DPL].[dim_Time_Year] ([year_last_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Year_year_first_day]
  ON [DPL].[dim_Time_Year] ([year_first_day] ASC);
