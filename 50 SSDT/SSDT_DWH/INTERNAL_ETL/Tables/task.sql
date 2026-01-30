CREATE TABLE [INTERNAL_ETL].[task] (
  [Task_ID] bigint IDENTITY (1, 1) NOT NULL
  , [Task] nvarchar(255) NOT NULL
  , [tst] datetime2(3) CONSTRAINT [DF_INTERNAL_ETL_task_tst] DEFAULT (SYSDATETIME()) NOT NULL
  , [ValidFrom] datetime2(7) GENERATED ALWAYS AS ROW START NOT NULL
  , [ValidTo] datetime2(7) GENERATED ALWAYS AS ROW END NOT NULL
  , [isEnabled] bit CONSTRAINT [DF_INTERNAL_ETL_task_isEnabled] DEFAULT ('TRUE') NOT NULL
  , [TaskType] nvarchar(5) NOT NULL
  , [Executable] nvarchar(500) NULL
  , [Layer] nvarchar(255) NOT NULL
  , [ParameterDefinition] nvarchar(4000) NULL
  , [Retry_max] tinyint NULL
  , [Retry_wait] int NULL
  , CONSTRAINT [PK_task] PRIMARY KEY CLUSTERED ([Task_ID] ASC)
  , CONSTRAINT [UN_task] UNIQUE NONCLUSTERED ([Task] ASC)
  , PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [INTERNAL_ETL].[taskHistory], DATA_CONSISTENCY_CHECK = ON));




GO
EXECUTE sp_addextendedproperty
  @name = N'MS_Description', @value = N'Table to store meta data for tasks like data flows, stored procedures, ADF pipelines, etc.', @level0type = N'SCHEMA', @level0name = N'INTERNAL_ETL', @level1type = N'TABLE', @level1name = N'task';
