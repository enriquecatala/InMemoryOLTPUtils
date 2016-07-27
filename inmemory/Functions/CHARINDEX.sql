--
-- Enrique Catala is Mentor at SolidQ: http://www.solidq.com
-- Microsoft Data Platform MVP:        https://mvp.microsoft.com/es-es/PublicProfile/5000312?fullName=Enrique%20Catala
-- Blog:                               http://www.enriquecatala.com
-- Twitter:                            https://twitter.com/enriquecatala
--
-- Function to evaluate if @string_to_find is contained in @string
-- Returns: Searches expression2 for expression1 and returns its starting position if found. The search starts at start_location.
--
CREATE FUNCTION [inmemory].CHARINDEX (
      @expression1 VARCHAR(MAX) ,
      @expression2 VARCHAR(MAX),
	  @start_location INT = 1
    )
RETURNS bigint
WITH NATIVE_COMPILATION, SCHEMABINDING  
BEGIN ATOMIC
WITH ( TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'us_english' )


        DECLARE @i INT = 1 ,
            @len INT = LEN(@expression2),
			@len_string_to_find INT = LEN(@expression1),
			@return bigint = 0,
			@search_init_pos INT = 1,
			@len_substring_contained INT = 0, -- this should be equal to the size of LEN(@string_to_find)
			@exit bit = 0
	
	--init variables
	--
        SET @i = @start_location;
        SET @search_init_pos = 1;
	-- loop until the size of the string or until we found that the string is found
	--
        WHILE ( @i <= @len-@len_string_to_find )
            AND @exit = 0
            BEGIN  
			    IF  (SUBSTRING(@expression2, @i, @len_string_to_find) = @expression1)               
                    BEGIN 
						SET @exit = 1;
						SET @return = @i;
                    END; 

                SET @i = @i + 1;
            END;  
  
    
    RETURN (@return);  
  
  
    END;  
