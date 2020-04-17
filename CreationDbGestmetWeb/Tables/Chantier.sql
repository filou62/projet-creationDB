CREATE TABLE [dbo].[Chantier]
(
	[ChantierId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [RefChantier] NVARCHAR(50) NOT NULL, 
    [TypeChantier] NVARCHAR(50) NOT NULL, 
    [NomChantier] NVARCHAR(50) NOT NULL, 
    [CPChantier] INT NULL, 
    [LieuChantier] NVARCHAR(255) NULL, 
    [DescriptionChantier] NVARCHAR(255) NULL, 
    [DateDebutChantier] DATE NOT NULL, 
    [DateFinChantier] DATE NOT NULL, 
    [HeuresPrevues] DECIMAL(10, 2) NULL, 
    [ZoneDeplacement] NVARCHAR(50) NOT NULL, 
    [ZoneKm] NVARCHAR(50) NOT NULL, 
    [RefDevis] NVARCHAR(50) NULL, 
    [Cloture] BIT NOT NULL DEFAULT 0, 
    [Archive] BIT NOT NULL DEFAULT 0,
    [SocieteId] INT NOT NULL, 
    CONSTRAINT UK_RefChantier UNIQUE (RefChantier),
    CONSTRAINT FK_ChantierSocId FOREIGN KEY ([SocieteId]) REFERENCES [Societe]([SocieteId])
)
