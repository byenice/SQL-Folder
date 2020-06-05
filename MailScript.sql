msdb.dbo.sp_send_dbmail
@profile_name='SQL EGITIM',
@recipients='byenice798@gmail.com',
@body='Bu bir deneme mailidir. Sql server tarafýndan gönderilmiþtir.',
@subject='SQL deneme maili'

CREATE PROC SEND_EMAIL
@RECIPIENT_ AS VARCHAR(1000),
@BODY_ AS VARCHAR(MAX),
@SUBJECT_ AS VARCHAR(MAX)
AS
BEGIN
EXEC msdb.dbo.sp_send_dbmail
@profile_name='SQL EGITIM',
@recipients=@RECIPIENT_,
@body=@BODY_,
@subject=@SUBJECT_
END

--SEND_EMAIL 'byenice798@gmail.com','bu mailimizin body kýsmýdýr','SQL Test Maili'

