CREATE TABLE [dbo].[Transaction_Acces]
(
	[TransAccesId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [UtilisateurId] INT NOT NULL, 
    [TransactionId] INT NOT NULL,
    CONSTRAINT [FK_UtilisateurId] FOREIGN KEY ([UtilisateurId]) REFERENCES [Utilisateur]([UtilisateurId]) ON DELETE CASCADE,
    CONSTRAINT [FK_TransactionId] FOREIGN KEY ([TransactionId]) REFERENCES [Transaction]([TransactionId]) ON DELETE CASCADE,
    CONSTRAINT [UK_UtilTrans] UNIQUE ([UtilisateurId],[TransactionId])
)
