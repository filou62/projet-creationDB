CREATE TABLE [dbo].[Utilisateur]
(
	[UtilisateurId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Email] NVARCHAR(50) NOT NULL, 
    [Login] NVARCHAR(50) NOT NULL, 
    [MotPasse] VARBINARY(32) NOT NULL,
    [PersonnelId] INT NOT NULL UNIQUE, 
    [EstActif] BIT NOT NULL DEFAULT 0, 
    CONSTRAINT UK_Login UNIQUE (Login),
    CONSTRAINT [FK_UtilisateurPersId] FOREIGN KEY ([PersonnelId]) REFERENCES [Personnel]([PersonnelId])
)
