CREATE TABLE [dbo].[Societe]
(
	[SocieteId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [CodeSociete] NVARCHAR(50) NOT NULL, 
    [NomSociete] NVARCHAR(50) NULL,
    CONSTRAINT UK_CodeSociete UNIQUE (CodeSociete)
)
