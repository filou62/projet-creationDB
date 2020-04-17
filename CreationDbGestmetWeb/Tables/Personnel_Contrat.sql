CREATE TABLE [dbo].[Personnel_Contrat]
(
	[PersonContId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [PersonnelId] INT NOT NULL, 
    [ContratId] INT NOT NULL, 
    [DateEntree] DATE NOT NULL, 
    [DateSortie] DATE NOT NULL DEFAULT '2099/12/31',
    CONSTRAINT [FK_ContPersonnelId] FOREIGN KEY ([PersonnelId]) REFERENCES [Personnel]([PersonnelId]),
    CONSTRAINT [FK_ContratId] FOREIGN KEY ([ContratId]) REFERENCES [Contrat]([ContratId]),
    CONSTRAINT [UK_PerContDate] UNIQUE ([PersonnelId],[ContratId], [DateEntree], [DateSortie])
)
