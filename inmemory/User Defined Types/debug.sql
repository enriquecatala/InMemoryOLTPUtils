CREATE TYPE [inmemory].[debug] AS TABLE (
    [id]    INT            IDENTITY (1, 1) NOT NULL,
    [debug] VARCHAR (1024) NULL,
    PRIMARY KEY NONCLUSTERED ([id] ASC))
    WITH (MEMORY_OPTIMIZED = ON);

