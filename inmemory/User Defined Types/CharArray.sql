CREATE TYPE [inmemory].[CharArray] AS TABLE (
    [pos]       INT      NOT NULL,
    [character] CHAR (1) COLLATE Modern_Spanish_CI_AS NULL,
    PRIMARY KEY NONCLUSTERED HASH(pos) WITH ( BUCKET_COUNT=1000))    WITH (MEMORY_OPTIMIZED = ON);

/*
CREATE TYPE [dbo].[CharArray] AS TABLE(
	[pos] [int] NOT NULL,
	[character] [char](1) COLLATE Modern_Spanish_CI_AS NULL,
	 PRIMARY KEY NONCLUSTERED 
(
	[pos] ASC
)
)
WITH ( MEMORY_OPTIMIZED = ON )
GO
*/