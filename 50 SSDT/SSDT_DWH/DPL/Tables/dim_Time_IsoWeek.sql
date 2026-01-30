CREATE TABLE [DPL].[dim_Time_IsoWeek] (
  [isoweek_Time_ID] int NOT NULL
  , [isoweek_Desc] varchar(9) NULL
  , [isoweek_year] smallint NULL
  , [isoweek_number] tinyint NULL
  , [isoweek_number_string] varchar(2) NULL
  , [isoweek_name] varchar(4) NULL
  , [isoweek_in_same_month] tinyint NULL
  , [isoweek_in_same_year] tinyint NULL
  , [isoweek_first_day] date NULL
  , [isoweek_last_day] date NULL
  , [isoweek_PW_Time_ID] int NULL
  , [isoweek_PPW_Time_ID] int NULL
  , [isoweek_PPPW_Time_ID] int NULL
  , [isoweek_PY_Time_ID] int NULL
  , [isoweek_PPY_Time_ID] int NULL
  , [isoweek_PPPY_Time_ID] int NULL
  , CONSTRAINT [PK_DPL_dim_Time_IsoWeek] PRIMARY KEY CLUSTERED ([isoweek_Time_ID] ASC)
);




GO



GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_IsoWeek_isoweek_Time_ID]
  ON [DPL].[dim_Time_IsoWeek] ([isoweek_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_IsoWeek_isoweek_Desc]
  ON [DPL].[dim_Time_IsoWeek] ([isoweek_Desc] ASC);
