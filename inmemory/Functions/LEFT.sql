/*
The database must have a MEMORY_OPTIMIZED_DATA filegroup
before the memory optimized object can be created.
*/

CREATE FUNCTION inmemory.[LEFT]
(
	@character_expression VARCHAR(MAX),
	@integer_expression bigint
)
RETURNS VARCHAR(MAX)
WITH NATIVE_COMPILATION, SCHEMABINDING
AS BEGIN ATOMIC WITH (
	TRANSACTION ISOLATION LEVEL = SNAPSHOT,
	LANGUAGE = N'English')
	
	
		RETURN( SUBSTRING(@character_expression,1,@integer_expression) ) 
		
END
