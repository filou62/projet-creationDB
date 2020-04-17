CREATE TABLE [dbo].[Personnel]
(
	[PersonnelId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Matricule] INT NOT NULL,
    [Prenom] NVARCHAR(50) NOT NULL, 
    [Nom] NVARCHAR(50) NOT NULL, 
    [DateNaissance] DATE NULL, 
    [Qualification] NVARCHAR(50) NOT NULL, 
    [ChefEquipe] BIT NOT NULL DEFAULT 0,
    [SocieteId] INT NOT NULL, 
    CONSTRAINT UK_Matricule UNIQUE (Matricule),
    CONSTRAINT FK_PersonnelSocId FOREIGN KEY ([SocieteId]) REFERENCES [Societe]([SocieteId])
)
