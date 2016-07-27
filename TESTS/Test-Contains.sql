﻿USE [InMemoryOLTPUtils];
GO
CREATE  TABLE dbo.textos_ondisk
    (
      id INT IDENTITY
             PRIMARY KEY
             NOT NULL ,
      txt VARCHAR(MAX)
    );
GO
-- insert data with
-- 
/*
SELECT   cast(textdata as varchar(max)) txt
FROM    ::
        fn_trace_gettable('D:\Clientes\dbaws001\Profiler\traza_dbaws001_2016-07-11 104525.trc',
                          1)
*/
SET ANSI_NULLS ON;
GO

CREATE TABLE [dbo].[textos_inmemory]
    (
      [id] [INT] IDENTITY(1, 1)
                 NOT NULL ,
      [txt] [VARCHAR](MAX) COLLATE Modern_Spanish_CI_AS
                           NULL ,
      CONSTRAINT [textos_primaryKey] PRIMARY KEY NONCLUSTERED ( [id] ASC )
    )
    WITH (
         MEMORY_OPTIMIZED =
         ON ,
         DURABILITY =
         SCHEMA_AND_DATA );

GO

SET IDENTITY_INSERT [InMemoryOLTPUtils].[dbo].[textos_inmemory] ON; 

GO

INSERT  INTO [InMemoryOLTPUtils].[dbo].[textos_inmemory]
        ( [id] ,
          [txt]
        )
        SELECT  [id] ,
                [txt]
        FROM    [InMemoryOLTPUtils].[dbo].[textos_ondisk]; 

GO

SET IDENTITY_INSERT [InMemoryOLTPUtils].[dbo].[textos_inmemory] OFF; 

GO


SELECT  COUNT(*)
FROM    dbo.textos_ondisk;
GO
SELECT  COUNT(*)
FROM    dbo.textos_inmemory;
GO

-- testing performance
--
SELECT  COUNT(*)
FROM    dbo.textos_ondisk
WHERE   inmemory.Contains_String(txt, 'ORDER BY') = 1;

GO
SELECT  COUNT(*)
FROM    dbo.textos_ondisk
WHERE   txt LIKE '%ORDER BY%';
GO

SELECT  COUNT(*)
FROM    dbo.textos_ondisk
WHERE   SQLCLRUtils.dbo.SqlContainsCI(txt, 'ORDER BY') = 1;
GO


CREATE ASSEMBLY [SQLCLRUtils]
FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C0103006C7598570000000000000000E00002210B010B00003A00000006000000000000DE58000000200000006000000000001000200000000200000400000000000000060000000000000000A0000000020000000000000300608500001000001000000000100000100000000000001000000000000000000000008458000057000000006000000004000000000000000000000000000000000000008000000C0000004C5700001C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E74657874000000E438000000200000003A000000020000000000000000000000000000200000602E72737263000000000400000060000000040000003C0000000000000000000000000000400000402E72656C6F6300000C0000000080000000020000004000000000000000000000000000004000004200000000000000000000000000000000C0580000000000004800000002000500302F00001C2800000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000360002731300000A7D010000042A0000133003005D0000000100001100036F1400000A16FE010A062D022B4C04281500000A16FE010A062D2600027B01000004161F2F6F1600000A26027B0100000416036F1700000A6F1800000A26002B19027B01000004036F1700000A6F1900000A1F2F6F1A00000A262A5600027B010000040F017B010000046F1B00000A262A00133004004D00000002000011007E1C00000A0A027B010000042C13027B010000046F1D00000A16FE0216FE012B0117000C082D1A027B0100000416027B010000046F1D00000A17596F1E00000A0A06731F00000A0B2B00072A4E0002036F2000000A732100000A7D010000042A520003027B010000046F2200000A6F2300000A002A00001B3004002D010000030000110072010000700A7224010070732500000A0B000607732600000A0C0072540100701F16732700000A0D09026F2800000A00086F2900000A096F2A00000A26086F2B00000A6F2C00000A00086F2D00000A1304002B7C001104166F2E00000A13051104176F2F00000A1306031105283000000A1307283100000A727001007011051107283200000A6F3300000A00110717733400000A130800110811066F3500000A1611066F3600000A696F3700000A0011086F3800000A0000DE14110814FE01130911092D0811086F3900000A00DC000011046F3A00000A130911093A74FFFFFF00DE14110414FE01130911092D0811046F3900000A00DC0000DE120814FE01130911092D07086F3900000A00DC00076F3B00000A0000DE120714FE01130911092D07076F3900000A00DC002A00000041640000020000009700000024000000BB0000001400000000000000020000005200000092000000E40000001400000000000000020000001B000000E1000000FC000000120000000000000002000000120000000701000019010000120000000000000013300200210000000400001100166A0A2B07000006176A580A062100C3CA0102000000FE0216FE010B072DE62A00000013300300350000000500001100166A0A2B07000006176A580A06283D00000A1F646A283D00000A02283E00000A283F00000A281500000A0C082DD7020B2B00072A000000133002002D0000000400001100284000000A00166A0A2B07000006176A580A062100C3CA0102000000FE0216FE010B072DE6284100000A002A000000133002003B0000000400001100166A0A2B21000620F40100006A5D166AFE0116FE010B072D0716284200000A000006176A580A062100C3CA0102000000FE0216FE010B072DCC2A001B3003008500000006000011007224010070732500000A0A00066F2C00000A0072BE01007006732600000A0B076F2900000A725F0200701E732700000A6F2A00000A028C0D0000016F2800000A00076F2900000A72670200701E732700000A6F2A00000A038C0D0000016F2800000A00283100000A076F4300000A0000DE100614FE010C082D07066F3900000A00DC002A0000000110000002000C0067730010000000001B3003008C00000007000011007224010070732500000A0A00066F2C00000A0072BE01007006732600000A0B076F2900000A725F0200701E732700000A6F2A00000A028C0D0000016F2800000A00076F2900000A72670200701E732700000A6F2A00000A038C0D0000016F2800000A00076F2D00000A0C283100000A086F4400000A0000DE100614FE010D092D07066F3900000A00DC002A0110000002000C006E7A0010000000001B3003006400000006000011007224010070732500000A0A00066F2C00000A00726F02007006732600000A0B076F2900000A72E10200701F16732700000A6F2A00000A028C090000016F2800000A00283100000A076F4300000A0000DE100614FE010C082D07066F3900000A00DC002A0110000002000C0046520010000000001E02284500000A2A133002002E00000008000011000218284600000A284700000A16284600000A284800000A281500000A2D03162B011700734900000A0A2B00062A0000133002002E00000008000011000218284600000A284700000A16284600000A284800000A281500000A2D03162B011700734900000A0A2B00062A0000133002003400000009000011000F00284A00000A16FE010B072D087E4B00000A0A2B1B0F00284C00000A0F01284C00000A6F4D00000A284E00000A0A2B00062A133004003C00000009000011000F00284A00000A16FE010B072D087E4B00000A0A2B230F00284C00000A0F01284C00000A16176F4F00000A16FE0416FE01284E00000A0A2B00062A133005007F0000000A000011000F00284A00000A16FE010C082D087E4B00000A0B2B65000F01284C00000A178D3A0000010D091604166A6F5000000A9D096F5100000A13041613052B2A110411059A0A000F00284C00000A066F4D00000A16FE010C082D087E5200000A0BDE1B00110517581305110511048E69FE040C082DCA7E5300000A0B2B0000072A0013300200560000000B000011000F00284A00000A2D1A0F01284A00000A2D110F01284C00000A285400000A16FE012B0116000C082D087E5300000A0B2B220F01284C00000A735500000A0A060F00284C00000A6F5600000A284E00000A0B2B00072A000013300300580000000C000011000F00284A00000A2D150F01284A00000A2D0C0F02284A00000A16FE012B0116000C082D087E5700000A0B2B290F01284C00000A735500000A0A060F00284C00000A0F02284C00000A6F5800000A731F00000A0B2B00072A13300100160000000D00001100026F1700000A735900000A73260000060A2B00062A0000133002003E0000000E000011000274060000020A03066F22000006735A00000A810D00000104066F230000066F5B00000A735C00000A5105066F240000066F5B00000A735C00000A512A0000133002003B0000000F00001100026F1400000A2D1B036F1400000A2D13026F1700000A036F1700000A731E0000062B11168D3A000001168D3A000001731E000006000A2B00062A00133002003B0000000F00001100026F1400000A2D1B036F1400000A2D13026F1700000A036F1700000A731E0000062B11168D3A000001168D3A000001731E000006000A2B00062A4E0003027424000001731F00000A81090000012A620003027424000001285D00000A735E00000A810C0000012A1E02284500000A2A033003004F0000000000000002284500000A000002037D0400000402038E697D0600000402047D0500000402048E69D27D0700000402027B0700000417FE017D0800000402167D0200000402027B07000004155A7D03000004002A0013300400240000001000001100027B04000004027B02000004027B03000004027B0200000459735F00000A0A2B00062A133003005F0100001100001100027B03000004027B06000004FE04130411042D07160D38410100000002027B03000004027B07000004587D02000004027B020000040A38CF00000000170B027B0800000416FE01130411042D1E00027B040000040693027B050000041693FE01130411042D02160B002B4A00160C2B3500060858027B060000042F16027B0400000406085893027B050000040893FE012B011600130411042D0500160B2B1500081758D20C08027B07000004FE04130411042DBC000716FE01130411042D460002067D03000004027B03000004027B020000045916FE0216FE01130411042D04170D2B780006027B070000041759580A02257B02000004027B07000004587D020000040000000617580A06027B06000004FE04130411043A1FFFFFFF02027B03000004027B07000004587D0200000402027B060000047D03000004027B03000004027B020000045916FE0216FE01130411042D04170D2B04160D2B00092A5E0002167D0200000402027B07000004155A7D030000042A00133001000C0000001200001100027B090000040A2B00062A133001000C0000001300001100027B0A0000040A2B00062A133001000C0000001300001100027B0B0000040A2B00062A7E02284500000A000002037D0900000402047D0A00000402057D0B000004002A4602284500000A000002037D0C000004002A00001B3004008C01000014000011027B100000040B0745030000000700000009000000020000002B0738130100002B05385601000002157D100000040002167D1200000402147D13000004027E0D0000046F6400000A7D140000040002257B1200000417587D1200000402027B130000042C0D027B130000046F6500000A2B157E0D000004027B110000047B0C0000046F6600000A007D13000004027B130000046F6700000A16FE010C083AC7000000000002177D1000000402027B140000047D1700000402167D18000004388700000002027B17000004027B180000049A7D150000040002027B130000046F6800000A027B150000046F6900000A7D16000004027B160000046F6700000A16FE010C082D360002027B12000004027B15000004027B160000046F6A00000A73250000067D0F00000402187D10000004170ADE5602177D10000004000002027B1800000417587D18000004027B18000004027B170000048E69FE040C083A62FFFFFF022835000006000000027B130000046F6700000A0C083AD1FEFFFF00160ADE0802283200000600DC00062A411C0000040000000000000081010000810100000800000000000000133001000B00000010000011027B0F0000040A2B00062A1A736C00000A7A0000133002002700000012000011027B100000040A061759450200000004000000020000002B042B042B022B07022835000006002A00133001000B00000010000011027B0F0000040A2B00062A3A02284500000A02037D100000042A2202157D100000042A001330020014000000150000111673340000060A06027D11000004060B2B00072A4A72E70200701F09736D00000A800D0000042A360002731300000A7D0E0000042A000000133002002C00000001000011000F01284A00000A16FE010A062D022B1A027B0E0000040F01284C00000A6F6F00000A1F3B6F1A00000A262A5600027B0E0000040F017B0E0000046F1B00000A262A000013300400490000000200001100140A027B0E0000042C13027B0E0000046F1D00000A16FE0216FE012B0117000C082D1A027B0E00000416027B0E0000046F1D00000A17596F1E00000A0A06731F00000A0B2B00072A4E0002036F2000000A732100000A7D0E0000042A520003027B0E0000046F2200000A6F2300000A002A000042534A4201000100000000000C00000076342E302E33303331390000000005006C000000D40B0000237E0000400C0000E00C000023537472696E67730000000020190000B404000023555300D41D0000100000002347554944000000E41D0000380A000023426C6F6200000000000000020000015717A20B0902000000FA253300160000010000004400000009000000180000003500000033000000070000006F0000002A00000015000000030000000600000006000000050000000100000001000000030000000200000000000A0001000000000006009A0093000A00CB00B0000600DC0093000600F600E30006000201E30006001A010E010A004C0137010A00550137010A007101370106008F0185010600A10185010A00D00137010A000D0237010E001B04FC030A003604B00006001805F90406006505530506007C0553050600990553050600B80553050600D10553050600EA055305060005065305060020065305060039065305060052065305060082066F066F00960600000600C506A5060600E506A50606000F0793000A002507B0000A004607B00006004D07F90406006307F90406008F0793000A00BB07B0000A00E707D1070A00F507D1070A000008D1070A000D08A4000A002A0817080A004008D1070A00790817080A008B08D1070A00A70817080A00BE0837010600D30885010A00E008B0000A00EB08B00006000109850106000C0985010600150985010600220993000A003609B0000600870976090600EE0993000600070A93000600550A93000600900A750A0E00790BFC030E005404FC030E005D0CFC030E00780CFC030600800C6F060600980C93000E00B50CFC030600C20CA5060000000001000000000001000100092110001A000000050001000100010010002F0000000D000200070001001000400000000D000200100002001000550000000D0002001E0000001000670000000D000900220000001000710000000D000C002600092110007F00000005000E00290003011000610A00000D000F002F00010028010A0001005E03B40001006603B40021006E03B70021007803B70021008203B40021008C03BB0021009903BE000100B303B4000100C403C9000100D303C9000100F503C90031002104DF00010028010A0001009E0ABB0801002D0BB4000600630BC30806006D0BB40006007F0BC70806008D0BCC080600990BC9000600A40BD0080600BE0BCC080600C90BB400502000000000860032010E0001006020000000008600600112000100C9200000000086006B011A000300E0200000000086007B0120000400392100000000E6019C01250004004D2100000000E601AE012B0005006421000000009600B401310006000423000000009600C101370008003423000000009600D9013B0008007823000000009600F10137000900B423000000009600010237000900FC23000000009600160242000900A024000000009600300242000B00482500000000960055024A000D00C8250000000086186A020E000E00D025000000009600700250000E000C260000000096007F0250000F0048260000000096009802570010008826000000009600A40257001200D026000000009600B202600014005C27000000009600C60257001700C027000000009600D3026B0019002428000000009600E00276001C004828000000009600FC027D001D00942800000000960009038B002100DC280000000096001C038B00230023290000000096002D0394002500372900000000960035039C00270050290000000086186A020E00290058290000000086186A02A4002900B42900000000E6094303AC002B00E42900000000E6014F03B0002B004F2B00000000E60158030E002B00682B000000008608BA03C5002B00802B000000008608CA03CC002B00982B000000008608DA03CC002B00B02B0000000086186A02D0002B00D02B0000000086186A02E3002E001C2E00000000E6012804E8002F003C2E000000009118AE0C37002F004F2E00000000860032010E002F00602E0000000086006001ED002F00982E0000000086006B01F3003000B02E0000000086007B0120003100052F00000000E6019C0125003100192F00000000E601AE012B003200E42B00000000E1014F03B0003300982D00000000E109AB0AAC003300AF2D00000000E101ED0A0E003300B82D00000000E101120B0E003300EC2D00000000E109380BAC003300032E0000000086186A026A013300122E000000008100B00B0E00340000000100EF03000002004804000001005404000001005A04000001005C04000001005E04000002006B04000001007B04000001008104000002008E04000001008104000002008E04000001009B0400000100A40400000100A40400000100A80400000200B40400000100A80400000200B40400000100A80400000200B40400000300C30400000100CD0400000200D30400000100DB0400000200D30400000300E60400000100CD0400000100EE0402000200F304020003002505020004002B0500000100300500000200360500000100300500000200360500000100400502000200440500000100400502000200440500000100490500000200360500000100F304000002002505000003007B0400000100CD0400000100EF03000001005404000001005A04000001005C04000001002D0B0200090005001100070015000800090009000600090011000900D90079006A020E0081006A020E0089006A02E30091006A02E30099006A02E300A1006A02E300A9006A02E300B1006A02E300B9006A02E300C1006A02E300C9006A02E300D1006A02E300D9006A026401E9006A026A01F1006A020E00F9006A020E0001016A026F0111016A02060231006A020E0039006E07B000410079070D023100810713023900DA031A02310081071F02310088072702310088072E0231008807380221019607C90031009C07C5003100A7073E0249006A02E3005100B007CC0031006A02E3001900A707CC005900AE01E30029016A020E0031016A02E30039016A02500241016A025802510136086002390157086502590166086B0239016A087402610186080E00390199087A027101B40880026901C70885028101D8088C028901F30892022101460798029101FC08E30099016A029F027901DA03A70279019C07AC02A901AE01B002A9011C090E00B1012E090E0071019C01B00061011C090E00B9016A020E0061004B09930361005709990361006309A203C1018E093700C101A2093700C101B409B2039101BA09B7039101FC08C80319006A020E0069004B098D046900C90993046900D4099C0441006A02A50449006E07B0004100E00960054900DA03CC002101E509640541004B0969052101FF09750539000C0A7E052101150A830541001B0A60054100200A60052101260A470671006A02E3007100390A64054900E00954067100410A580621016A02D50669006A026A012101490A1A0239006A02D506D9015B0A8E0861006A02930821016A02980821004F03B0000C004303BE08210058030E0021004303AC007100390CD508E901470CDA087100790BE008F101510CB000E9016D0CE708F9010C0AED080102DA03CC0009026A020E0011026A020E0071006A02010921026A020E00310088078F0924000B00F9002E006B00060A2E007B00180A2E006300F9092E0073000F0A2E002B00C3092E001B0095092E002300A6092E003B0095092E004B00DD092E003300C9092E004300DD0943008B007601E00023014B02000123014B0203018B0009092001E301D602230173034B02400123014B02600123014B02800123014B02A00123014B02C00123014B020002E301DC032002E301AF044002E3014B026002E3014B028002E3014B02A002E3019605C002E3019605C4020B000C01E002E30166062003E301E5064003E301BB0724040B003E0144040B00510164040B003E0184040B00510100065B034B0220065B034B0260065B034B0280065B034B0234024402B802D102AB03BE03CF03AA046F058A054C065E06DB06E006B607A008A408AC08B008F408FA080500010006000200090005000000AB03C1000000E403D7000000EA03DB000000EF03DB000000D40BC1000000120CC10002001F000300020022000500020023000700020024000900020030000B00020033000D0009005E00C10009006000C30009006200C50009006400730009006600C700B4080480000001000000000000000000000000000307000004000000000000000000000001008A00000000000400000000000000000000000100A40000000000040000000000000000000000010093000000000005000400090007000000003C4D6F64756C653E0053514C434C525574696C732E646C6C00434F4E4341545F4147475F4F7074696D697A65640053746F72656450726F636564757265730055736572446566696E656446756E6374696F6E7300537472696E6753706C69745F436C6173730047726F75704E6F64650047726F75704974657261746F7200434F4E4341545F414747006D73636F726C69620053797374656D0056616C7565547970650053797374656D2E44617461004D6963726F736F66742E53716C5365727665722E536572766572004942696E61727953657269616C697A65004F626A6563740053797374656D2E436F6C6C656374696F6E730049456E756D657261746F720049456E756D657261626C650053797374656D2E5465787400537472696E674275696C64657200726573756C7461646F00496E69740053797374656D2E446174612E53716C54797065730053716C43686172730053716C426F6F6C65616E00416363756D756C617465004D657267650053716C537472696E67005465726D696E6174650053797374656D2E494F0042696E61727952656164657200526561640042696E6172795772697465720057726974650053617665417373656D626C79004275636C655F4E6F6E5969656C640053716C496E743634004275636C655F4E6F6E5969656C645F66756E6374696F6E004275636C655F507265656D74697665004275636C655F5969656C640053716C496E74333200506572666F726D616E636541636365736F4461746F73434C5200506572666F726D616E636541636365736F4461746F73434C525F4D616E75616C53656E64004D7953746F72656450726F636564757265434C52002E63746F720045734E756D65726F506172436C720045734E756D65726F506172436C72446174614163636573730053716C436F6E7461696E730053716C436F6E7461696E7343490053716C436F6E7461696E734D756C7469706C6500526567457849734D617463680052656745785265706C6163650054726565416E64466F7572506172744E616D654465746563746F720046696C6C47726F7570526F7700537472696E6753706C69745F4E756D62657200537472696E6753706C69745F546578740046696C6C526F770046696C6C526F774E756D626572006765745F43757272656E74004D6F76654E657874005265736574006C617374506F73006E657874506F7300746865537472696E670064656C696D6974657200737472696E674C656E0064656C696D697465724C656E00697353696E676C654368617244656C696D0043757272656E74005F696E646578006765745F496E646578005F6E616D65006765745F4E616D65005F76616C7565006765745F56616C756500496E646578004E616D650056616C7565005F696E7075740053797374656D2E546578742E526567756C617245787072657373696F6E73005265676578005F726567657800476574456E756D657261746F720053716C4661636574417474726962757465007072696D657256616C6F720047726F75700072007700617373656D626C794E616D650064657374696E6174696F6E506174680076616C756500696450726F647563744D696E00696450726F647563744D61780070726F647563746F006E756D007175657279737472696E6700746578746F5F615F62757363617200736570617261646F7200696E707574007061747465726E0065787072657373696F6E007265706C616365006461746100696E6465780053797374656D2E52756E74696D652E496E7465726F705365727669636573004F75744174747269627574650067726F7570007465787400496E7075740044656C696D69746572006F626A006974656D00546865537472696E670053797374656D2E5265666C656374696F6E00417373656D626C795469746C6541747472696275746500417373656D626C794465736372697074696F6E41747472696275746500417373656D626C79436F6E66696775726174696F6E41747472696275746500417373656D626C79436F6D70616E7941747472696275746500417373656D626C7950726F6475637441747472696275746500417373656D626C79436F7079726967687441747472696275746500417373656D626C7954726164656D61726B41747472696275746500417373656D626C7943756C7475726541747472696275746500417373656D626C7956657273696F6E41747472696275746500417373656D626C7946696C6556657273696F6E4174747269627574650053797374656D2E446961676E6F73746963730044656275676761626C6541747472696275746500446562756767696E674D6F6465730053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300436F6D70696C6174696F6E52656C61786174696F6E734174747269627574650052756E74696D65436F6D7061746962696C6974794174747269627574650053514C434C525574696C730053657269616C697A61626C654174747269627574650053716C55736572446566696E656441676772656761746541747472696275746500466F726D6174005374727563744C61796F7574417474726962757465004C61796F75744B696E64006765745F49734E756C6C006F705F5472756500496E7365727400417070656E6400537472696E6700456D707479006765745F4C656E67746800546F537472696E670052656164537472696E670053716C50726F6365647572654174747269627574650053797374656D2E446174612E53716C436C69656E740053716C436F6E6E656374696F6E0053716C436F6D6D616E640053716C506172616D657465720053716C4462547970650053797374656D2E446174612E436F6D6D6F6E004462506172616D65746572007365745F56616C75650053716C506172616D65746572436F6C6C656374696F6E006765745F506172616D657465727300416464006765745F436F6E6E656374696F6E004462436F6E6E656374696F6E004F70656E0053716C4461746152656164657200457865637574655265616465720044624461746152656164657200476574537472696E670053716C42797465730047657453716C4279746573005061746800436F6D62696E650053716C436F6E746578740053716C50697065006765745F506970650053656E640046696C6553747265616D0046696C654D6F64650053747265616D00436C6F73650049446973706F7361626C6500446973706F73650053716C46756E6374696F6E417474726962757465006F705F496D706C69636974006F705F4D756C7469706C79006F705F4C6573735468616E4F72457175616C0053797374656D2E546872656164696E670054687265616400426567696E546872656164416666696E69747900456E64546872656164416666696E69747900536C6565700045786563757465416E6453656E64006F705F4D6F64756C7573006F705F457175616C697479004E756C6C00436F6E7461696E7300537472696E67436F6D70617269736F6E00496E6465784F660043686172006765745F4974656D0053706C697400547275650046616C73650049734E756C6C4F72576869746553706163650049734D61746368005265706C61636500546F43686172417272617900496E743634005061727365003C476574456E756D657261746F723E645F5F300053797374656D2E436F6C6C656374696F6E732E47656E657269630049456E756D657261746F726031003C3E325F5F63757272656E740053797374656D2E436F6C6C656374696F6E732E47656E657269632E49456E756D657261746F723C53797374656D2E4F626A6563743E2E6765745F43757272656E740053797374656D2E436F6C6C656374696F6E732E49456E756D657261746F722E52657365740053797374656D2E49446973706F7361626C652E446973706F7365003C3E315F5F73746174650053797374656D2E436F6C6C656374696F6E732E49456E756D657261746F722E6765745F43757272656E74003C3E345F5F74686973003C696E6465783E355F5F31004D61746368003C63757272656E743E355F5F32003C6E616D65733E355F5F33003C6E616D653E355F5F34003C67726F75703E355F5F35003C3E6D5F5F46696E616C6C7936003C3E375F5F7772617037003C3E375F5F77726170380053797374656D2E436F6C6C656374696F6E732E47656E657269632E49456E756D657261746F723C53797374656D2E4F626A6563743E2E43757272656E740053797374656D2E436F6C6C656374696F6E732E49456E756D657261746F722E43757272656E740047657447726F75704E616D6573004E6578744D61746368006765745F537563636573730047726F7570436F6C6C656374696F6E006765745F47726F757073004361707475726500446562756767657248696464656E417474726962757465004E6F74537570706F72746564457863657074696F6E002E6363746F720052656765784F7074696F6E7300436F6D70696C657247656E65726174656441747472696275746500000000008121530045004C004500430054002000610066002E006E0061006D0065002C002000610066002E0063006F006E00740065006E0074002000460052004F004D0020007300790073002E0061007300730065006D0062006C0069006500730020006100200049004E004E004500520020004A004F0049004E0020007300790073002E0061007300730065006D0062006C0079005F00660069006C006500730020006100660020004F004E00200061002E0061007300730065006D0062006C0079005F006900640020003D002000610066002E0061007300730065006D0062006C0079005F0069006400200057004800450052004500200061002E006E0061006D00650020003D002000400061007300730065006D0062006C0079006E0061006D006500002F63006F006E007400650078007400200063006F006E006E0065006300740069006F006E003D007400720075006500001B400061007300730065006D0062006C0079006E0061006D006500004D4500780070006F007200740069006E006700200061007300730065006D0062006C0079002000660069006C00650020005B007B0030007D005D00200074006F0020005B007B0031007D005D0000809F730065006C0065006300740020005B00500072006F0064007500630074005F004E0061006D0065005D002000660072006F006D002000640062006F002E00500072006F00640075006300740073004200690067002000770068006500720065002000490044005F00500072006F00640075006300740020006200650074007700650065006E002000400070003100200061006E0064002000400070003200000740007000310000074000700032000071530045004C00450043005400200063006F006C0031002000460052004F004D002000640062006F002E00500072006F00640075006300740073004200690067002000570048004500520045002000500072006F0064007500630074005F004E0061006D00650020003D002000400070000005400070000081C928003F003C003D005B00660072006F006D007C006A006F0069006E007C0065007800650063007C0069006E0074006F005D005C0073002B00290028003F003C0066006F007500720050006100720074003E005B005C005B007C005C0027005D003F005C0077002A005B005C005D007C005C0027005D003F005C002E005B005C005B007C005C0027005D003F005C0077002A005B005C005D007C005C0027005D003F005C002E005B005C005B007C005C0027005D003F005C0077002A005B005C005D007C005C0027005D003F005C002E005B005C005B007C005C0027005D003F005C0077002A005B005C005D007C005C0027005D003F0029007C0028003F003C003D005B00660072006F006D007C006A006F0069006E007C0065007800650063007C0069006E0074006F005D005C0073002B00290028003F003C00740072006500650050006100720074003E005B005C005B007C005C0027005D003F005C0077002A005B005C005D007C005C0027005D003F005C002E005B005C005B007C005C0027005D003F005C0077002A005B005C005D007C005C0027005D003F005C002E005B005C005B007C005C0027005D003F005C0077002A005B005C005D007C005C0027005D003F002900010000F826D45D8C35F848BCFEE4A900AA5F810008B77A5C561934E089030612190320000107200201121D1121052001011108042000112505200101122905200101122D050002010E0E03000001060001113111310700020111351135050001011125060001112111350800021121112511250A0003112111251125121D0A000311251125112511250600011215121D0D0004011C10113510121D10121D0800021211121D121D070002011C101125070002011C101131072002011D031D030320001C0320000202060803061D030206050206020328001C0320000802060E0320000E06200301080E0E032800080328000E03061239042001010E042000121105200101112505200101112012010001005408074D617853697A650A000000310100030054020D497346697865644C656E6774680154020A49734E756C6C61626C65005408074D617853697A650100000012010001005408074D617853697A65FFFFFFFF12010001005408074D617853697A65FF000000052001011171042001010806200101118085808E01000200000006005402124973496E76617269616E74546F4E756C6C73005402124973496E76617269616E74546F4F72646572005402174973496E76617269616E74546F4475706C6963617465730054020D49734E756C6C4966456D7074790154080B4D61784279746553697A65FFFFFFFF540E044E616D6514434F4E4341545F4147475F4F7074696D697A65640620010111808D050001021121062002121908030420001D030720021219081D0306200112191D030520011219030307010205200112191C0520020E08080607030E1125020401000000072002010E128099072002010E1180A5042001011C0520001280AD0820011280A11280A10520001280990520001280B50420010E080620011280BD080500020E0E0E0500001280C90600030E0E1C1C072002010E1180D10420001D050320000A072003011D05080818070A0E12809912809D1280A11280B50E1280BD0E1280CD020407020A0280BB0100030054557F4D6963726F736F66742E53716C5365727665722E5365727665722E53797374656D446174614163636573734B696E642C2053797374656D2E446174612C2056657273696F6E3D342E302E302E302C2043756C747572653D6E65757472616C2C205075626C69634B6579546F6B656E3D623737613563353631393334653038391053797374656D446174614163636573730000000054020F497344657465726D696E6973746963015402094973507265636973650105000111310A0800021131113111310800021121113111310607030A11310204000101080620010112809D09070312809912809D02062001011280B50C070412809912809D1280B50280AF010003005402094973507265636973650154020F497344657465726D696E6973746963015455794D6963726F736F66742E53716C5365727665722E5365727665722E446174614163636573734B696E642C2053797374656D2E446174612C2056657273696F6E3D342E302E302E302C2043756C747572653D6E65757472616C2C205075626C69634B6579546F6B656E3D623737613563353631393334653038390A44617461416363657373000000000500011135080800021135113511350800021121113511350420010102040701112180AF010003005402094973507265636973650154020F497344657465726D696E6973746963015455794D6963726F736F66742E53716C5365727665722E5365727665722E446174614163636573734B696E642C2053797374656D2E446174612C2056657273696F6E3D342E302E302E302C2043756C747572653D6E65757472616C2C205075626C69634B6579546F6B656E3D623737613563353631393334653038390A446174614163636573730100000003061121042001020E050001112102050702112102082003080E081180E5042001030A0620011D0E1D030B07060E1121021D031D0E0880AF0100030054020F497344657465726D696E697374696301540209497350726563697365015455794D6963726F736F66742E53716C5365727665722E5365727665722E446174614163636573734B696E642C2053797374656D2E446174612C2056657273696F6E3D342E302E302E302C2043756C747572653D6E65757472616C2C205075626C69634B6579546F6B656E3D623737613563353631393334653038390A4461746141636365737300000000040001020E0707031239112102030611250520020E0E0E07070312391125026E01000200540E1146696C6C526F774D6574686F644E616D650C46696C6C47726F7570526F77540E0F5461626C65446566696E6974696F6E365B496E6465785D20696E742C5B47726F75705D206E76617263686172286D6178292C5B546578745D206E76617263686172286D617829052001011D030407011215040701121880CF01000300540E1146696C6C526F774D6574686F644E616D650D46696C6C526F774E756D626572540E0F5461626C65446566696E6974696F6E0B6974656D20626967696E745455794D6963726F736F66742E53716C5365727665722E5365727665722E446174614163636573734B696E642C2053797374656D2E446174612C2056657273696F6E3D342E302E302E302C2043756C747572653D6E65757472616C2C205075626C69634B6579546F6B656E3D623737613563353631393334653038390A4461746141636365737300000000040701121180D101000300540E1146696C6C526F774D6574686F644E616D650746696C6C526F77540E0F5461626C65446566696E6974696F6E136974656D206E766172636861722834303030295455794D6963726F736F66742E53716C5365727665722E5365727665722E446174614163636573734B696E642C2053797374656D2E446174612C2056657273696F6E3D342E302E302E302C2043756C747572653D6E65757472616C2C205075626C69634B6579546F6B656E3D623737613563353631393334653038390A44617461416363657373000000000400010A0E042001010A072003011D0308080307011C0707050802050202030701080307010E06151280F1011C02061C04200013000306121C04061280F503061D0E04061280F90420001D0E0520001280F50620011280F50E0520001280FD0620011280F90E05070302080206070212241211072002010E11810D808401000200000006005402124973496E76617269616E74546F4E756C6C73015402124973496E76617269616E74546F4F72646572005402174973496E76617269616E74546F4475706C6963617465730054020D49734E756C6C4966456D7074790154080B4D61784279746553697A65FFFFFFFF540E044E616D650A434F4E4341545F41474705200112190E1001000B53514C434C525574696C7300001C01001755736566756C2053514C434C52207574696C697469657300000501000000001301000E456E726971756520436174616C6100001B010016456E726971756520436174616C61204261C3B1756C7300000C010007312E302E302E3000000801000701000000000801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F77730100000000006C75985700000000020000001C010000685700006839000052534453D7DEFA3E4A0FC346918971182CA9690F09000000643A5C4769745F6563625C53514C434C525574696C735C53514C434C525574696C735C53514C434C525574696C735C6F626A5C44656275675C53514C434C525574696C732E7064620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AC5800000000000000000000CE580000002000000000000000000000000000000000000000000000C05800000000000000000000000000000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF2500200010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100100000001800008000000000000000000000000000000100010000003000008000000000000000000000000000000100000000004800000058600000A40300000000000000000000A40334000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE00000100000001000000000000000100000000003F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B00404030000010053007400720069006E006700460069006C00650049006E0066006F000000E0020000010030003000300030003000340062003000000048001800010043006F006D006D0065006E00740073000000550073006500660075006C002000530051004C0043004C00520020007500740069006C0069007400690065007300000040000F00010043006F006D00700061006E0079004E0061006D0065000000000045006E0072006900710075006500200043006100740061006C0061000000000040000C000100460069006C0065004400650073006300720069007000740069006F006E0000000000530051004C0043004C0052005500740069006C0073000000300008000100460069006C006500560065007200730069006F006E000000000031002E0030002E0030002E003000000040001000010049006E007400650072006E0061006C004E0061006D0065000000530051004C0043004C0052005500740069006C0073002E0064006C006C0000005000160001004C006500670061006C0043006F007000790072006900670068007400000045006E0072006900710075006500200043006100740061006C006100200042006100F10075006C00730000005400160001004C006500670061006C00540072006100640065006D00610072006B0073000000000045006E0072006900710075006500200043006100740061006C006100200042006100F10075006C00730000004800100001004F0072006900670069006E0061006C00460069006C0065006E0061006D0065000000530051004C0043004C0052005500740069006C0073002E0064006C006C00000038000C000100500072006F0064007500630074004E0061006D00650000000000530051004C0043004C0052005500740069006C0073000000340008000100500072006F006400750063007400560065007200730069006F006E00000031002E0030002E0030002E003000000038000800010041007300730065006D0062006C0079002000560065007200730069006F006E00000031002E0030002E0030002E003000000000000000005000000C000000E03800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
GO

CREATE FUNCTION [dbo].[SqlContainsCI]
    (
      @querystring NVARCHAR(MAX) ,
      @texto_a_buscar NVARCHAR(MAX)
    )
RETURNS BIT
AS EXTERNAL NAME
    [SQLCLRUtils].[UserDefinedFunctions].[SqlContainsCI];
GO
 

SET STATISTICS TIME ON
go
SELECT  COUNT(*)
FROM    dbo.textos_inmemory
WHERE   inmemory.Contains_String(txt, 'ORDER BY') = 1;

GO
SELECT  COUNT(*)
FROM    dbo.textos_inmemory
WHERE   txt LIKE '%ORDER BY%';
GO


SELECT  COUNT(*)
FROM    dbo.textos_inmemory
WHERE   dbo.SqlContainsCI(txt, 'ORDER BY') = 1;
GO