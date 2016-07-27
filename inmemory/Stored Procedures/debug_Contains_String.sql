---- memory-optimized table type for collecting sales order details  
--CREATE TYPE dbo.debug AS TABLE  
--(  
--   id INT IDENTITY PRIMARY KEY NONCLUSTERED,
--   debug VARCHAR(1024)
--) WITH (MEMORY_OPTIMIZED=ON)  
--GO  

-- memory-optimized table type for collecting sales order details  
--CREATE TYPE dbo.CharArray AS TABLE  
--(  
--   pos INT  PRIMARY KEY NONCLUSTERED,
--   [character] CHAR(1)
--) WITH (MEMORY_OPTIMIZED=ON)  
--GO  


CREATE PROCEDURE [inmemory].debug_Contains_String
    (
      @string VARCHAR(MAX) ,
      @string_to_find VARCHAR(MAX)
    )
    WITH NATIVE_COMPILATION,
         SCHEMABINDING
AS
    BEGIN ATOMIC
WITH ( TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'us_english' )

  
    
        DECLARE @i INT = 1 ,
            @len INT = LEN(@string);  
    
        DECLARE @len_string_to_find INT = LEN(@string_to_find);
        DECLARE @return BIT = 0;
        --DECLARE @tmp_txt VARCHAR(MAX);
        DECLARE @tmp_char CHAR(1);
        DECLARE @tmp_char_string CHAR(1);
        DECLARE @trash BIT;
        DECLARE @search_init_pos INT = 1;

	--DECLARE @debug_table AS dbo.debug
        DECLARE @array_to_find AS inmemory.CharArray;

        DECLARE @len_substring_contained INT = 0; -- this should be equal to the size of LEN(@string_to_find)

	-- Creates the char array
        WHILE ( @i <= @len_string_to_find )
            BEGIN
		
                INSERT  INTO @array_to_find
                        ( pos, character )
                VALUES  ( @i, SUBSTRING(@string_to_find, @i, 1)  -- character - char(1)
                          );
		
                SET @i = @i + 1;
            END; 

	---- i have my array of words
	----
	--SELECT pos,character FROM @array_to_find

     

	--init variables
	--
        SET @i = 1;
        SET @search_init_pos = 1;
	-- loop until the size of the string or until we found that the string is found
	--
        WHILE ( @i <= @len )
            AND @return = 0
            BEGIN  
			
                SET @tmp_char_string = SUBSTRING(@string, @i, 1);
                SET @tmp_char = SUBSTRING(@string_to_find, @search_init_pos, 1);
			
                SET @trash = NULL; 
                SELECT  @trash = 1
                FROM    @array_to_find
                WHERE   pos = @search_init_pos
                        AND character = @tmp_char_string;

			--SELECT pos,character 
			--FROM @array_to_find 
			--WHERE pos=@search_init_pos AND character = @tmp_char_string
			
			-- if not found
			--
                IF ( @trash IS NULL )
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

			--SELECT @search_init_pos

			--INSERT INTO @debug_table (debug) VALUES(@tmp_txt)
			--select @search_init_pos init_pos,@search_end_pos end_pos,@tmp_txt tmp_txt
            -- we found the string
			--
                IF ( @len_substring_contained = @len_string_to_find )
                    SET @return = 1;

                SET @i = @i + 1;
            END;  
  
        SELECT  @len_substring_contained len_substring_contained ,
                @len len_to_find ,
                @return return_value;
    --RETURN (@ReturnValue);  
	--RETURN 
  
    END;  
