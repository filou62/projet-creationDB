CREATE TABLE [dbo].[Poste]
(
	[PosteId] INT NOT NULL PRIMARY KEY IDENTITY, 
    [RefPoste] INT NOT NULL, 
    [LibellePoste] NVARCHAR(50) NOT NULL, 
    [UMPoste] NVARCHAR(50) NULL, 
    [QteUMPoste] DECIMAL(10, 2) NULL, 
    [QteHPoste] DECIMAL(10, 2) NULL, 
    [QteHPosteST] DECIMAL(10, 2) NULL, 
    [NiveauPoste] INT NOT NULL, 
    [QteHPosteInterne] AS  ([QteHPoste]-[QteHPosteST]), 
    [ChantierId] INT NOT NULL,
    [SaisiePoste] BIT NOT NULL DEFAULT 0, 
    CONSTRAINT UK_PosteChant UNIQUE (RefPoste,ChantierId),
    CONSTRAINT FK_PosteChantierId FOREIGN KEY ([ChantierId]) REFERENCES [Chantier]([ChantierId])
)
