/* 
* 
* Enrique Catala is Mentor at SolidQ: http://www.solidq.com
* Microsoft Data Platform MVP:        https://mvp.microsoft.com/es-es/PublicProfile/5000312?fullName=Enrique%20Catala
* Blog:                               http://www.enriquecatala.com
* Twitter:                            https://twitter.com/enriquecatala
*
* 
* EDUCATIONAL PURPOSES: For better performance, try LIKE :)
*/

-- Function to evaluate if @string_to_find is contained in @string
-- Returns: true/false
--
CREATE FUNCTION [inmemory].Contains_String (
      @string VARCHAR(MAX) ,
      @string_to_find VARCHAR(MAX)
    )
RETURNS bit
WITH NATIVE_COMPILATION, SCHEMABINDING  
BEGIN ATOMIC
WITH ( TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'us_english' )


        DECLARE @i INT = 1 ,
            @len INT = LEN(@string),
			@len_string_to_find INT = LEN(@string_to_find),
			@return BIT = 0,
			@search_init_pos INT = 1,
			@len_substring_contained INT = 0; -- this should be equal to the size of LEN(@string_to_find)

	
	--init variables
	--
        SET @i = 1;
        SET @search_init_pos = 1;
	-- loop until the size of the string or until we found that the string is found
	--
        WHILE ( @i <= @len )
            AND @return = 0
            BEGIN  
			

			-- if (actual_char <> char_in_string_to_find)
			--
                IF  (SUBSTRING(@string, @i, 1) <>SUBSTRING(@string_to_find, @search_init_pos, 1)      )
                    BEGIN
                        SET @search_init_pos = 1; --restart
                        SET @len_substring_contained = 0;
                    END;
                ELSE
                    BEGIN 
                        SET @search_init_pos = @search_init_pos + 1;
                        SET @len_substring_contained = @len_substring_contained
                            + 1;
                    END; 


                IF ( @len_substring_contained = @len_string_to_find )
                    SET @return = 1;

                SET @i = @i + 1;
            END;  
  
    
    RETURN (@return);  
  
  
    END;  
