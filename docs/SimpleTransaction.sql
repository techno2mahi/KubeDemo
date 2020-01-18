USE [master]
GO

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'SimpleTransaction')
BEGIN
CREATE DATABASE [SimpleTransaction]
END
GO 

USE [SimpleTransaction]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AccountSummary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AccountSummary](
	[AccountNumber] [int] NOT NULL,
	[Balance] [decimal](19,2) NOT NULL,
	[Currency] [varchar](3) NOT NULL
	CONSTRAINT [PK_AccountSummary] PRIMARY KEY CLUSTERED([AccountNumber])
 );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AccountTransaction]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AccountTransaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[AccountNumber] [int] NOT NULL,
	[Date] DATETIME CONSTRAINT [DF_AccountTransaction_Date] DEFAULT (getutcdate()) NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[TransactionType] [varchar](10) NOT NULL,
	[Amount] [decimal](19,2) NOT NULL
	CONSTRAINT [PK_AccountTransaction] PRIMARY KEY CLUSTERED ([TransactionId] ASC),
	CONSTRAINT [FK_AccountTransaction_AccountNumber] FOREIGN KEY ([AccountNumber]) REFERENCES [dbo].[AccountSummary] ([AccountNumber]) 
 );
END
GO

IF NOT EXISTS (SELECT * FROM dbo.AccountSummary WHERE AccountNumber = 3628101)
BEGIN
    Insert Into dbo.AccountSummary(AccountNumber, Balance, Currency) 
	Values(3628101, 25000, 'EUR')
END
GO

IF NOT EXISTS (SELECT * FROM dbo.AccountSummary WHERE AccountNumber = 3637897)
BEGIN
    Insert Into dbo.AccountSummary(AccountNumber, Balance, Currency) 
	Values(3637897, 1500, 'EUR')
END
GO

IF NOT EXISTS (SELECT * FROM dbo.AccountSummary WHERE AccountNumber = 3648755)
BEGIN
    Insert Into dbo.AccountSummary(AccountNumber, Balance, Currency) 
	Values(3648755, 17600, 'EUR')
END
GO