CREATE TABLE [DPL].[dim_Time_Tertial] (
  [tertial_Time_ID] int NOT NULL
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
  , [year_Time_ID] int NULL
  , [year_is_leap_year] tinyint NULL
  , [year_weekdays] smallint NULL
  , [year_PY_Time_ID] int NULL
  , [year_PPY_Time_ID] int NULL
  , [year_PPPY_Time_ID] int NULL
  , CONSTRAINT [PK_DPL_dim_Time_Tertial] PRIMARY KEY CLUSTERED ([tertial_Time_ID] ASC)
);






GO



GO



GO



GO



GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Tertial_year_Time_ID]
  ON [DPL].[dim_Time_Tertial] ([year_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Tertial_tertial_Time_ID]
  ON [DPL].[dim_Time_Tertial] ([tertial_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Tertial_tertial_last_day]
  ON [DPL].[dim_Time_Tertial] ([tertial_last_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Tertial_tertial_first_day]
  ON [DPL].[dim_Time_Tertial] ([tertial_first_day] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Tertial_tertial_Desc]
  ON [DPL].[dim_Time_Tertial] ([tertial_Desc] ASC);
