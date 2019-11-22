CREATE DATABASE DadosADV COLLATE Latin1_General_BIN
GO
USE [master]
GO
CREATE LOGIN [siga] WITH PASSWORD=N'Sig@1234', DEFAULT_DATABASE=[DadosADV], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
EXEC master..sp_addsrvrolemember @loginame = N'siga', @rolename = N'sysadmin'
GO

