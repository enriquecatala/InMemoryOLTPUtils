--
-- Enrique Catala is Mentor at SolidQ: http://www.solidq.com
-- Microsoft Data Platform MVP:        https://mvp.microsoft.com/es-es/PublicProfile/5000312?fullName=Enrique%20Catala
-- Blog:                               http://www.enriquecatala.com
-- Twitter:                            https://twitter.com/enriquecatala
--
CREATE FUNCTION inmemory.[REPLICATE]
(
	@string_expression VARCHAR(MAX),
	@integer_expression bigint
)
RETURNS VARCHAR(MAX)
WITH NATIVE_COMPILATION, SCHEMABINDING
AS BEGIN ATOMIC WITH (
	TRANSACTION ISOLATION LEVEL = SNAPSHOT,
	LANGUAGE = N'English')
BEGIN
	DECLARE @retorno varchar(MAX) = @string_expression
	DECLARE @i bigint = 1

	WHILE (@i<@integer_expression)
	BEGIN
		SET @retorno = @retorno + @string_expression
		SET @i = @i+1
    END 

	RETURN (@retorno)
END
END
