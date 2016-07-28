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
	@string_expression VARCHAR(8000) -- There is a bug in SQL Server 2016 - 13.0.1708.0  that causes a CRASH when you try to use MAX and the string is more than 25k characters
)
RETURNS VARCHAR(8000) -- There is a bug in SQL Server 2016 - 13.0.1708.0  that causes a CRASH when you try to use MAX and the string is more than 25k characters
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
       
	
        WHILE ( @i > 0 )
           
            BEGIN  
			    SET @return +=  SUBSTRING(@string_expression, @i, 1) ;         
                     
                SET @i -= 1;
            END;  
  
    
    RETURN (@return);  
END
