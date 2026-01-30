CREATE TABLE [INTERNAL_ETL].[taskHistory] (
  [Task_ID] bigint NOT NULL
  , [Task] nvarchar(255) NOT NULL
  , [tst] datetime2(3) NOT NULL
  , [ValidFrom] datetime2(7) NOT NULL
  , [ValidTo] datetime2(7) NOT NULL
  , [isEnabled] bit NOT NULL
  , [TaskType] nvarchar(5) NOT NULL
  , [Executable] nvarchar(500) NULL
  , [Layer] nvarchar(255) NOT NULL
  , [ParameterDefinition] nvarchar(4000) NULL
  , [Retry_max] tinyint NULL
  , [Retry_wait] int NULL
);




GO
CREATE CLUSTERED INDEX [ix_taskHistory]
  ON [INTERNAL_ETL].[taskHistory] ([ValidTo] ASC, [ValidFrom] ASC) WITH (DATA_COMPRESSION = PAGE);
