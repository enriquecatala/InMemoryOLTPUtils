--
-- Enrique Catala is Mentor at SolidQ: http://www.solidq.com
-- Microsoft Data Platform MVP:        https://mvp.microsoft.com/es-es/PublicProfile/5000312?fullName=Enrique%20Catala
-- Blog:                               http://www.enriquecatala.com
-- Twitter:                            https://twitter.com/enriquecatala
--
DECLARE @expression1 VARCHAR(MAX) ,
    @expression2 VARCHAR(MAX) ,
    @start_location BIGINT;

SELECT  @expression1 = 'c' ,
        @expression2 = 'hola caracola' ,
        @start_location = 0;
IF CHARINDEX(@expression1, @expression2, @start_location) <> inmemory.CHARINDEX(@expression1,
                                                              @expression2,
                                                              @start_location)
    SELECT  'ERROR test 1';
ELSE
    SELECT  'OK test 1';
-- test2j
--
SELECT  @expression1 = 'ORDER BY' ,
        @expression2 = 'set dateformat dmy SET DATEFIRST 1  Select idusuario,idempresa,idcontacto,-1 as idempresa_elink,-1 as idcontacto_elink,'''' as strempresa_elink, '''' as strcontacto_elink,(case empresas_idsucursal when  (select empresas_idsucursal from tblusuarios (nolock) where tblusuarios.id=66) then 1 else 2 end) as OrderTag ,'''' as strempresa,'''' as strcontacto,'''' as strusuario,'''' as strsucursal from index_phones (nolock) where borrado=0  and  (strtel1 like ''%978730039'' or strtel2 like ''%978730039'' or strtel3 like ''%978730039'') UNION Select -1 as idusuario,tbltelefonos.idempresa as idempresa,tbltelefonos.idcontacto as idcontacto,-1 as idempresa_elink,-1 as idcontacto_elink,'''' as strempresa_elink, '''' as strcontacto_elink,5 as OrderTag ,isnull(empresas.nombre,'''') as strempresa,isnull(contactos.nombre,'''')+isnull('' ''+contactos.apellidos,'''') as strcontacto,'''' as strusuario,'''' as strsucursal from tbltelefonos (nolock)  left join empresas (nolock) on tbltelefonos.idempresa=empresas.id left join contactos (nolock) on tbltelefonos.idcontacto=contactos.id where tbltelefonos.borrado=0  and  REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(strtel,'' '',''''),''.'',''''),''-'',''''),'')'',''''),''('','''') LIKE ''%978730039'' order by ordertag asc,idcontacto desc' ,
        @start_location = 0;
		
IF CHARINDEX(@expression1, @expression2, @start_location) <> inmemory.CHARINDEX(@expression1,
                                                              @expression2,
                                                              @start_location)
    SELECT  'ERROR Test 2';
ELSE
    SELECT  'OK test 2';

-- test 3
SELECT  @expression1 = 'la' ,
        @expression2 = 'hola caracola' ,
        @start_location = 0;
IF CHARINDEX(@expression1, @expression2, @start_location) <> inmemory.CHARINDEX(@expression1,
                                                              @expression2,
                                                              @start_location)
    SELECT  'ERROR test 3';
ELSE
    SELECT  'OK test 3';

-- Test 4
SELECT  @expression1 = 'h' ,
        @expression2 = 'hola caracola' ,
        @start_location = 0;
IF CHARINDEX(@expression1, @expression2, @start_location) <> inmemory.CHARINDEX(@expression1,
                                                              @expression2,
                                                              @start_location)
    SELECT  'ERROR test 4';
ELSE
    SELECT  'OK test 4';

-- Test 5
SELECT  @expression1 = 'c' ,
        @expression2 = 'hola caracola' ,
        @start_location = 7;
IF CHARINDEX(@expression1, @expression2, @start_location) <> inmemory.CHARINDEX(@expression1,
                                                              @expression2,
                                                              @start_location)
    SELECT  'ERROR test 5';
ELSE
    SELECT  'OK test 5';