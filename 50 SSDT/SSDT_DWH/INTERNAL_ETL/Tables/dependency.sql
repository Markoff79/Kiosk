CREATE TABLE [INTERNAL_ETL].[dependency] (
  --Dependency_ID should be deleted in the end... A surrgate key does not really make sense here...
  -- --> Only left it in here because of possible pains in stored procedures...
  [Dependency_ID] bigint IDENTITY (1, 1) NOT NULL
  -- Task_ID and DependsOnTask_ID should later be replaced by Task and DependsOnTask (nvarchar)
  , [Task_ID] bigint NOT NULL
  , [DependsOnTask_ID] bigint NOT NULL
  , [Task] nvarchar(255) NULL
  , [DependsOnTask] nvarchar(255) NULL
  , [tst] datetime2(3) CONSTRAINT [DF_INTERNAL_ETL_dependency_tst] DEFAULT (SYSDATETIME()) NOT NULL
  , [ValidFrom] datetime2(7) GENERATED ALWAYS AS ROW START NOT NULL
  , [ValidTo] datetime2(7) GENERATED ALWAYS AS ROW END NOT NULL
  , [isEnabled] bit CONSTRAINT [DF_INTERNAL_ETL_dependency_isEnabled] DEFAULT ('TRUE') NOT NULL
  , [DependencyType_ID] int CONSTRAINT [DF_INTERNAL_ETL_dependency_DependencyType_ID] DEFAULT ((1)) NULL
  , CONSTRAINT [PK_dependency] PRIMARY KEY CLUSTERED ([Dependency_ID] ASC)
  , CONSTRAINT [UN_dependency] UNIQUE NONCLUSTERED ([Task_ID] ASC, [DependsOnTask_ID] ASC)
  , PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [INTERNAL_ETL].[dependencyHistory], DATA_CONSISTENCY_CHECK = ON));


GO
EXECUTE sp_addextendedproperty
  @name = N'MS_Description', @value = N'Table contains task dependencies that are to be considered to load data in the correct order', @level0type = N'SCHEMA', @level0name = N'INTERNAL_ETL', @level1type = N'TABLE', @level1name = N'dependency';
