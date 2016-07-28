--
-- Enrique Catala is Mentor at SolidQ: http://www.solidq.com
-- Microsoft Data Platform MVP:        https://mvp.microsoft.com/es-es/PublicProfile/5000312?fullName=Enrique%20Catala
-- Blog:                               http://www.enriquecatala.com
-- Twitter:                            https://twitter.com/enriquecatala
--
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
