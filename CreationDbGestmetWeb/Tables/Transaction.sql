CREATE TABLE [dbo].[Transaction]
(
	[TransactionId] INT NOT NULL PRIMARY KEY IDENTITY,
    [TypeTransaction] NVARCHAR(50) NOT NULL, 
    [NomTransaction] NVARCHAR(50) NOT NULL,
    CONSTRAINT UK_TypeTransaction UNIQUE(TypeTransaction)
)
