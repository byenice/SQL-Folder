DECLARE @I AS INT=0
WHILE @I<1
BEGIN
	DECLARE @SINIF AS INTEGER
	DECLARE @RAND AS INTEGER
	SET @RAND=RAND()*4
	SELECT @SINIF=SINIFNO FROM SINIFLAR WHERE ID=@RAND
	UPDATE OGRENCILER SET SINIFNO=@SINIF
	SET @I=@I+1
END

SELECT * FROM OGRENCILER