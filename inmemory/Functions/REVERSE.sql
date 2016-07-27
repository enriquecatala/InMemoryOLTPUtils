--
-- Enrique Catala is Mentor at SolidQ: http://www.solidq.com
-- Microsoft Data Platform MVP:        https://mvp.microsoft.com/es-es/PublicProfile/5000312?fullName=Enrique%20Catala
-- Blog:                               http://www.enriquecatala.com
-- Twitter:                            https://twitter.com/enriquecatala
--
-- Returns the reverse of a string value.
-- 
CREATE FUNCTION inmemory.[REVERSE]
(
	@string_expression VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
WITH NATIVE_COMPILATION, SCHEMABINDING
AS BEGIN ATOMIC WITH (
	TRANSACTION ISOLATION LEVEL = SNAPSHOT,
	LANGUAGE = N'English')
     
	    DECLARE @i INT = 1 ,
            @len INT = LEN(@string_expression),
			
			@return varchar(MAX) = ''
			
	--init variables
	--
        SET @i = @len;
       
	-- loop until the size of the string or until we found that the string is found
	--
        WHILE ( @i >= 0 )
           
            BEGIN  
			    SET @return = @return+  SUBSTRING(@string_expression, @i, 1) ;         
                     
					
                SET @i = @i - 1;
            END;  
  
    
    RETURN (@return);  
END
