CREATE TABLE [INTERNAL_ETL].[dependencyHistory] (
  [Dependency_ID] bigint NOT NULL
  , [Task_ID] bigint NOT NULL
  , [DependsOnTask_ID] bigint NOT NULL
  , [Task] nvarchar(255) NULL
  , [DependsOnTask] nvarchar(255) NULL
  , [tst] datetime2(3) NOT NULL
  , [ValidFrom] datetime2(7) NOT NULL
  , [ValidTo] datetime2(7) NOT NULL
  , [isEnabled] bit NOT NULL
  , [DependencyType_ID] int NULL
);


GO
CREATE CLUSTERED INDEX [ix_dependencyHistory]
  ON [INTERNAL_ETL].[dependencyHistory] ([ValidTo] ASC, [ValidFrom] ASC) WITH (DATA_COMPRESSION = PAGE);
