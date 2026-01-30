CREATE TABLE [DPL].[dim_Time_Week] (
  [week_Time_ID] int NOT NULL
  , [week_Desc] varchar(9) NULL
  , [week_number] tinyint NULL
  , [week_number_string] varchar(2) NULL
  , [week_name] varchar(4) NULL
  , [week_days] tinyint NULL
  , [week_weekdays] tinyint NULL
  , [week_in_same_month] tinyint NULL
  , [week_first_day] date NULL
  , [week_last_day] date NULL
  , [week_PW_Time_ID] int NULL
  , [week_PPW_Time_ID] int NULL
  , [week_PPPW_Time_ID] int NULL
  , [week_PY_Time_ID] int NULL
  , [week_PPY_Time_ID] int NULL
  , [week_PPPY_Time_ID] int NULL
  , [year_Time_ID] int NULL
  , [year_is_leap_year] tinyint NULL
  , [year_weekdays] smallint NULL
  , [year_PY_Time_ID] int NULL
  , [year_PPY_Time_ID] int NULL
  , [year_PPPY_Time_ID] int NULL
  , CONSTRAINT [PK_DPL_dim_Time_Week] PRIMARY KEY CLUSTERED ([week_Time_ID] ASC)
);




GO



GO



GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Week_year_Time_ID]
  ON [DPL].[dim_Time_Week] ([year_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Week_week_Time_ID]
  ON [DPL].[dim_Time_Week] ([week_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Week_week_Desc]
  ON [DPL].[dim_Time_Week] ([week_Desc] ASC);
