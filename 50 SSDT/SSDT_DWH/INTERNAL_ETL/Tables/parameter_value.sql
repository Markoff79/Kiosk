CREATE TABLE [INTERNAL_ETL].[parameter_value] (
  [ID_parameter_values] bigint IDENTITY (1, 1) NOT NULL
  , [tst] datetime2(3) CONSTRAINT [DF_UTIL_INTERNAL_ETL_parameter_value_tst] DEFAULT (SYSDATETIME()) NOT NULL
  , [Task_ID] bigint NOT NULL
  , [parameter_value] nvarchar(4000) NULL
  , CONSTRAINT [PKNCL_INTERNAL_ETL_parameter_value_ID_parameter_values] PRIMARY KEY NONCLUSTERED ([ID_parameter_values] ASC) WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE)
);


GO
CREATE CLUSTERED INDEX [CL_INTERNAL_ETL_parameter_value_Task_ID]
  ON [INTERNAL_ETL].[parameter_value] ([Task_ID] ASC) WITH (FILLFACTOR = 95, DATA_COMPRESSION = PAGE);


GO
EXECUTE sp_addextendedproperty
  @name = N'MS_Description'
  , @value = N'Table to save the parameter values for a procedure'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'TABLE'
  , @level1name = N'parameter_value';
