/*
The database must have a MEMORY_OPTIMIZED_DATA filegroup
before the memory optimized object can be created.
*/

CREATE FUNCTION inmemory.[RIGHT]
(
	@character_expression VARCHAR(MAX),
	@integer_expression bigint
)
RETURNS VARCHAR(MAX)
WITH NATIVE_COMPILATION, SCHEMABINDING
AS BEGIN ATOMIC WITH (
	TRANSACTION ISOLATION LEVEL = SNAPSHOT,
	LANGUAGE = N'English')
	DECLARE @len_character_expression int = LEN(@character_expression)

	RETURN(SUBSTRING(@character_expression,@len_character_expression-@integer_expression+1,@len_character_expression))
END
