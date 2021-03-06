
CREATE PROCEDURE SP_SATISLAR_TARIH
@ITEMCODE AS VARCHAR(100)='%',
@BEGDATE AS DATE='20170101',
@ENDDATE AS DATE='20171231'
AS

SELECT
STL.DATE_ AS TARIH,
SUM(STL.LINENET) AS TOPLAMSATIS
FROM LG_217_ITEMS ITM

LEFT JOIN LG_217_01_STLINE STL ON STL.STOCKREF=ITM.LOGICALREF
LEFT JOIN LG_217_01_STFICHE STF ON STF.LOGICALREF=STL.STFICHEREF
LEFT JOIN L_CAPIDIV D ON D.NR=STF.BRANCH AND D.FIRMNR=217

WHERE STL.TRCODE=7 
AND ITM.CODE LIKE @ITEMCODE AND STL.DATE_ BETWEEN @BEGDATE AND @ENDDATE
GROUP BY 
STL.DATE_
