CREATE TABLE [dbo].[JournalDesTravaux]
(
	[JDTId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [PersonnelId] INT NOT NULL, 
    [PosteId] INT NOT NULL, 
    [DateChantier] DATE NOT NULL, 
    [HeuresProd] DECIMAL(10, 2) NOT NULL DEFAULT 0.00, 
    [VoitPerso] BIT NOT NULL DEFAULT 0, 
    [ZoneDepl] NVARCHAR(50) NOT NULL, 
    [ChefChantierId] INT NOT NULL, 
    [Login] INT NOT NULL,
    [NumSemaine] AS DATEPART(ISO_WEEK,DateChantier), 
    [EstValide] BIT NOT NULL DEFAULT 0, 
    CONSTRAINT [FK_JDTPersonnelId] FOREIGN KEY ([PersonnelId]) REFERENCES [Personnel]([PersonnelId]),
    CONSTRAINT [FK_PosteId] FOREIGN KEY ([PosteId]) REFERENCES [Poste]([PosteId]),
    CONSTRAINT [FK_Login] FOREIGN KEY ([PersonnelId]) REFERENCES [Personnel]([PersonnelId])

)
