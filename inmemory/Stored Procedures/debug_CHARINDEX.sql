/* 
* 
* Enrique Catala is Mentor at SolidQ: http://www.solidq.com
* Microsoft Data Platform MVP:        https://mvp.microsoft.com/es-es/PublicProfile/5000312?fullName=Enrique%20Catala
* Blog:                               http://www.enriquecatala.com
* Twitter:                            https://twitter.com/enriquecatala
*
* 
* 
*/

-- Function to evaluate if @string_to_find is contained in @string
-- Returns: Searches expression2 for expression1 and returns its starting position if found. The search starts at start_location.
--
CREATE PROCEDURE [inmemory].debug_CHARINDEX (
      @expression1 VARCHAR(MAX) ,
      @expression2 VARCHAR(MAX),
	  @start_location INT = 1
    )
 WITH NATIVE_COMPILATION,
         SCHEMABINDING
AS
    BEGIN ATOMIC
WITH ( TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'us_english' )



        DECLARE @i INT = 1 ,
            @len INT = LEN(@expression2),
			@len_string_to_find INT = LEN(@expression1),
			@return BIT = 0,
			@search_init_pos INT = 1,
			@len_substring_contained INT = 0, -- this should be equal to the size of LEN(@string_to_find)
			@exit bit = 0,
			@tmp_init_pos_found int = 0
	
	--init variables
	--
        SET @i = @start_location;
        SET @search_init_pos = 1;
	-- loop until the size of the string or until we found that the string is found
	--
        WHILE ( @i <= @len )
            AND @exit = 0
            BEGIN  
			

			-- if (actual_char <> char_in_string_to_find)
			--
			SELECT SUBSTRING(@expression2, @i, 1) e2, SUBSTRING(@expression1, @search_init_pos, 1) e1
                IF  (SUBSTRING(@expression2, @i, 1) <>SUBSTRING(@expression1, @search_init_pos, 1)      )
                    BEGIN
						-- restart
                        SET @search_init_pos = 1; 
                        SET @len_substring_contained = 0;
						SET @tmp_init_pos_found = 0;
                    END;
                ELSE
                    BEGIN 
						
						-- first ocurrence, i save the pos
						--IF @i=1 OR @search_init_pos = 1
							SET @tmp_init_pos_found = @i
							

                        SET @search_init_pos = @search_init_pos + 1;
                        SET @len_substring_contained = @len_substring_contained
                            + 1;

						SELECT @tmp_init_pos_found tmp_init_pos_found, @i i
                    END; 

		SELECT @tmp_init_pos_found tmp_init_pos_found, @i i, @len_substring_contained lsc, @len_string_to_find lstf

                IF ( @len_substring_contained = @len_string_to_find )
				BEGIN
                    SET @exit = 1;
					SET @return = @tmp_init_pos_found;
					SELECT 'entrado', @return retur, @tmp_init_pos_found inipos
				END

                SET @i = @i + 1;
            END;  
  
    
SELECT @return, @tmp_init_pos_found
  
  
    END;  
