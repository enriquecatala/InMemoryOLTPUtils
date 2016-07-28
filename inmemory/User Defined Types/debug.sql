--
-- Enrique Catala is Mentor at SolidQ: http://www.solidq.com
-- Microsoft Data Platform MVP:        https://mvp.microsoft.com/es-es/PublicProfile/5000312?fullName=Enrique%20Catala
-- Blog:                               http://www.enriquecatala.com
-- Twitter:                            https://twitter.com/enriquecatala
--
CREATE TYPE [inmemory].[debug] AS TABLE (
    [id]    INT            IDENTITY (1, 1) NOT NULL,
    [debug] VARCHAR (1024) NULL,
    PRIMARY KEY NONCLUSTERED ([id] ASC))
    WITH (MEMORY_OPTIMIZED = ON);

