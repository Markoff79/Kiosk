CREATE TABLE [DPL].[dim_Time_Day] (
  [day_Time_ID] int NOT NULL
  , [day_date] date NULL
  , [day_number] tinyint NULL
  , [day_name] varchar(10) NULL
  , [day_name_short] varchar(2) NULL
  , [day_of_week] tinyint NULL
  , [day_of_year] smallint NULL
  , [day_holiday_name] varchar(30) NULL
  , [day_holidayNW_name] varchar(30) NULL
  , [day_is_holiday] tinyint NULL
  , [day_is_holidayNW] tinyint NULL
  , [day_is_last_day_in_month] tinyint NULL
  , [day_is_last_day_in_quarter] tinyint NULL
  , [day_is_weekday] tinyint NULL
  , [day_is_workingday] tinyint NULL
  , [day_is_workingdayNW] tinyint NULL
  , [day_days_remaining_in_month] tinyint NULL
  , [day_days_remaining_in_quarter] tinyint NULL
  , [day_days_remaining_in_year] smallint NULL
  , [day_days_completed_in_month] tinyint NULL
  , [day_days_completed_in_quarter] tinyint NULL
  , [day_days_completed_in_year] smallint NULL
  , [day_weekdays_remaining_in_month] tinyint NULL
  , [day_weekdays_remaining_in_quarter] tinyint NULL
  , [day_weekdays_remaining_in_year] smallint NULL
  , [day_weekdays_completed_in_month] tinyint NULL
  , [day_weekdays_completed_in_quarter] tinyint NULL
  , [day_weekdays_completed_in_year] smallint NULL
  , [day_PD_Time_ID] int NULL
  , [day_PD_date] date NULL
  , [day_PPD_Time_ID] int NULL
  , [day_PPD_date] date NULL
  , [day_PPPD_Time_ID] int NULL
  , [day_PPPD_date] date NULL
  , [day_PW_Time_ID] int NULL
  , [day_PW_date] date NULL
  , [day_PPW_Time_ID] int NULL
  , [day_PPW_date] date NULL
  , [day_PPPW_Time_ID] int NULL
  , [day_PPPW_date] date NULL
  , [day_PM_Time_ID] int NULL
  , [day_PM_date] date NULL
  , [day_PPM_Time_ID] int NULL
  , [day_PPM_date] date NULL
  , [day_PPPM_Time_ID] int NULL
  , [day_PPPM_date] date NULL
  , [day_PY_Time_ID] int NULL
  , [day_PY_date] date NULL
  , [day_PPY_Time_ID] int NULL
  , [day_PPY_date] date NULL
  , [day_PPPY_Time_ID] int NULL
  , [day_PPPY_date] date NULL
  , [isoweek_Time_ID] int NULL
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
  , [week_Time_ID] int NULL
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
  , [month_Time_ID] int NULL
  , [month_Desc] varchar(7) NULL
  , [month_FiscalDesc] varchar(10) NULL
  , [month_number] tinyint NULL
  , [month_fiscalnumber] tinyint NULL
  , [month_number_string] varchar(2) NULL
  , [month_fiscalnumber_string] varchar(2) NULL
  , [month_name] varchar(10) NULL
  , [month_name_short] varchar(3) NULL
  , [month_name_year] varchar(15) NULL
  , [month_name_short_year] varchar(8) NULL
  , [month_name_year_short] varchar(13) NULL
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
  , CONSTRAINT [PK_DPL_dim_Time_Day] PRIMARY KEY CLUSTERED ([day_Time_ID] ASC)
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



GO



GO



GO



GO



GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_year_Time_ID]
  ON [DPL].[dim_Time_Day] ([year_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_week_Time_ID]
  ON [DPL].[dim_Time_Day] ([week_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_week_Desc]
  ON [DPL].[dim_Time_Day] ([week_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_tertial_Time_ID]
  ON [DPL].[dim_Time_Day] ([tertial_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_tertial_Desc]
  ON [DPL].[dim_Time_Day] ([tertial_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_quarter_Time_ID]
  ON [DPL].[dim_Time_Day] ([quarter_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_quarter_Desc]
  ON [DPL].[dim_Time_Day] ([quarter_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_month_Time_ID]
  ON [DPL].[dim_Time_Day] ([month_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_month_FiscalDesc]
  ON [DPL].[dim_Time_Day] ([month_FiscalDesc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_month_Desc]
  ON [DPL].[dim_Time_Day] ([month_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_isoweek_Time_ID]
  ON [DPL].[dim_Time_Day] ([isoweek_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_isoweek_Desc]
  ON [DPL].[dim_Time_Day] ([isoweek_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_fiscalyear_Time_ID]
  ON [DPL].[dim_Time_Day] ([fiscalyear_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_fiscaltertial_Time_ID]
  ON [DPL].[dim_Time_Day] ([fiscaltertial_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_fiscaltertial_Desc]
  ON [DPL].[dim_Time_Day] ([fiscaltertial_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_fiscalquarter_Time_ID]
  ON [DPL].[dim_Time_Day] ([fiscalquarter_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_fiscalquarter_Desc]
  ON [DPL].[dim_Time_Day] ([fiscalquarter_Desc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_day_Time_ID]
  ON [DPL].[dim_Time_Day] ([day_Time_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DPL_dim_Time_Day_day_date]
  ON [DPL].[dim_Time_Day] ([day_date] ASC);
