CREATE TABLE [dbo].[Contrat]
(
	[ContratId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [TypeContrat] NVARCHAR(50) NOT NULL, 
    [DescriptionContrat] NVARCHAR(50) NULL,
    CONSTRAINT UK_TypeContrat UNIQUE (TypeContrat)
)
