/*
Script de déploiement pour DBGESTMETWEB

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DBGESTMETWEB"
:setvar DefaultFilePrefix "DBGESTMETWEB"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Création de [dbo].[Chantier]...';


GO
CREATE TABLE [dbo].[Chantier] (
    [ChantierId]          INT             IDENTITY (1, 1) NOT NULL,
    [RefChantier]         NVARCHAR (50)   NOT NULL,
    [TypeChantier]        NVARCHAR (50)   NOT NULL,
    [NomChantier]         NVARCHAR (50)   NOT NULL,
    [CPChantier]          INT             NULL,
    [LieuChantier]        NVARCHAR (255)  NULL,
    [DescriptionChantier] NVARCHAR (255)  NULL,
    [DateDebutChantier]   DATE            NOT NULL,
    [DateFinChantier]     DATE            NOT NULL,
    [HeuresPrevues]       DECIMAL (10, 2) NULL,
    [ZoneDeplacement]     NVARCHAR (50)   NOT NULL,
    [ZoneKm]              NVARCHAR (50)   NOT NULL,
    [RefDevis]            NVARCHAR (50)   NULL,
    [Cloture]             BIT             NOT NULL,
    [Archive]             BIT             NOT NULL,
    PRIMARY KEY CLUSTERED ([ChantierId] ASC),
    CONSTRAINT [UK_RefChantier] UNIQUE NONCLUSTERED ([RefChantier] ASC)
);


GO
PRINT N'Création de [dbo].[Contrat]...';


GO
CREATE TABLE [dbo].[Contrat] (
    [ContratId]          INT           IDENTITY (1, 1) NOT NULL,
    [TypeContrat]        NVARCHAR (50) NOT NULL,
    [DescriptionContrat] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([ContratId] ASC),
    CONSTRAINT [UK_TypeContrat] UNIQUE NONCLUSTERED ([TypeContrat] ASC)
);


GO
PRINT N'Création de [dbo].[JournalDesTravaux]...';


GO
CREATE TABLE [dbo].[JournalDesTravaux] (
    [JDTId]          INT             IDENTITY (1, 1) NOT NULL,
    [PersonnelId]    INT             NOT NULL,
    [PosteId]        INT             NOT NULL,
    [DateChantier]   DATE            NOT NULL,
    [HeuresProd]     DECIMAL (10, 2) NULL,
    [VoitPerso]      BIT             NOT NULL,
    [ZoneDepl]       NVARCHAR (50)   NOT NULL,
    [IdChefChantier] INT             NOT NULL,
    [Login]          NVARCHAR (50)   NOT NULL,
    PRIMARY KEY CLUSTERED ([JDTId] ASC)
);


GO
PRINT N'Création de [dbo].[Personnel]...';


GO
CREATE TABLE [dbo].[Personnel] (
    [PersonnelId]   INT           IDENTITY (1, 1) NOT NULL,
    [Matricule]     INT           NOT NULL,
    [Prenom]        NVARCHAR (50) NOT NULL,
    [Nom]           NVARCHAR (50) NOT NULL,
    [DateNaissance] DATE          NULL,
    [Qualification] NVARCHAR (50) NULL,
    [ChefEquipe]    BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([PersonnelId] ASC),
    CONSTRAINT [UK_Matricule] UNIQUE NONCLUSTERED ([Matricule] ASC)
);


GO
PRINT N'Création de [dbo].[Personnel_Contrat]...';


GO
CREATE TABLE [dbo].[Personnel_Contrat] (
    [PersonContId] INT  IDENTITY (1, 1) NOT NULL,
    [PersonnelId]  INT  NOT NULL,
    [ContratId]    INT  NOT NULL,
    [DateEntree]   DATE NOT NULL,
    [DateSortie]   DATE NOT NULL,
    PRIMARY KEY CLUSTERED ([PersonContId] ASC),
    CONSTRAINT [UK_PerContDate] UNIQUE NONCLUSTERED ([PersonnelId] ASC, [ContratId] ASC, [DateEntree] ASC, [DateSortie] ASC)
);


GO
PRINT N'Création de [dbo].[Poste]...';


GO
CREATE TABLE [dbo].[Poste] (
    [PosteId]          INT             IDENTITY (1, 1) NOT NULL,
    [RefPoste]         INT             NOT NULL,
    [LibellePoste]     NVARCHAR (50)   NOT NULL,
    [UMPoste]          NVARCHAR (50)   NULL,
    [QteUMPoste]       DECIMAL (10, 2) NULL,
    [QteHPoste]        DECIMAL (10, 2) NULL,
    [QteHPosteST]      DECIMAL (10, 2) NULL,
    [NiveauPoste]      INT             NOT NULL,
    [QteHPosteInterne] AS              ([QteHPoste] - [QteHPosteST]),
    PRIMARY KEY CLUSTERED ([PosteId] ASC)
);


GO
PRINT N'Création de [dbo].[Societe]...';


GO
CREATE TABLE [dbo].[Societe] (
    [SocieteId]   INT           IDENTITY (1, 1) NOT NULL,
    [CodeSociete] NVARCHAR (50) NOT NULL,
    [NomSociete]  NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([SocieteId] ASC),
    CONSTRAINT [UK_CodeSociete] UNIQUE NONCLUSTERED ([CodeSociete] ASC)
);


GO
PRINT N'Création de [dbo].[Transaction]...';


GO
CREATE TABLE [dbo].[Transaction] (
    [TransactionId]   INT           IDENTITY (1, 1) NOT NULL,
    [TypeTransaction] NVARCHAR (50) NOT NULL,
    [NomTransaction]  NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([TransactionId] ASC),
    CONSTRAINT [UK_TypeTransaction] UNIQUE NONCLUSTERED ([TypeTransaction] ASC)
);


GO
PRINT N'Création de [dbo].[Transaction_Acces]...';


GO
CREATE TABLE [dbo].[Transaction_Acces] (
    [TransAccesId]  INT IDENTITY (1, 1) NOT NULL,
    [UtilisateurId] INT NOT NULL,
    [TransactionId] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([TransAccesId] ASC),
    CONSTRAINT [UK_UtilTrans] UNIQUE NONCLUSTERED ([UtilisateurId] ASC, [TransactionId] ASC)
);


GO
PRINT N'Création de [dbo].[Utilisateur]...';


GO
CREATE TABLE [dbo].[Utilisateur] (
    [UtilisateurId] INT            IDENTITY (1, 1) NOT NULL,
    [Email]         NVARCHAR (50)  NOT NULL,
    [Login]         NVARCHAR (50)  NOT NULL,
    [MotPasse]      VARBINARY (32) NOT NULL,
    PRIMARY KEY CLUSTERED ([UtilisateurId] ASC),
    CONSTRAINT [UK_Login] UNIQUE NONCLUSTERED ([Login] ASC)
);


GO
PRINT N'Création de contrainte sans nom sur [dbo].[Chantier]...';


GO
ALTER TABLE [dbo].[Chantier]
    ADD DEFAULT 0 FOR [Cloture];


GO
PRINT N'Création de contrainte sans nom sur [dbo].[Chantier]...';


GO
ALTER TABLE [dbo].[Chantier]
    ADD DEFAULT 0 FOR [Archive];


GO
PRINT N'Création de contrainte sans nom sur [dbo].[JournalDesTravaux]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux]
    ADD DEFAULT 0 FOR [VoitPerso];


GO
PRINT N'Création de contrainte sans nom sur [dbo].[Personnel]...';


GO
ALTER TABLE [dbo].[Personnel]
    ADD DEFAULT 0 FOR [ChefEquipe];


GO
PRINT N'Création de contrainte sans nom sur [dbo].[Personnel_Contrat]...';


GO
ALTER TABLE [dbo].[Personnel_Contrat]
    ADD DEFAULT '2099/12/31' FOR [DateSortie];


GO
PRINT N'Création de [dbo].[FK_JDTPersonnelId]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux] WITH NOCHECK
    ADD CONSTRAINT [FK_JDTPersonnelId] FOREIGN KEY ([PersonnelId]) REFERENCES [dbo].[Personnel] ([PersonnelId]);


GO
PRINT N'Création de [dbo].[FK_PosteId]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux] WITH NOCHECK
    ADD CONSTRAINT [FK_PosteId] FOREIGN KEY ([PosteId]) REFERENCES [dbo].[Contrat] ([ContratId]);


GO
PRINT N'Création de [dbo].[FK_ContPersonnelId]...';


GO
ALTER TABLE [dbo].[Personnel_Contrat] WITH NOCHECK
    ADD CONSTRAINT [FK_ContPersonnelId] FOREIGN KEY ([PersonnelId]) REFERENCES [dbo].[Personnel] ([PersonnelId]);


GO
PRINT N'Création de [dbo].[FK_ContratId]...';


GO
ALTER TABLE [dbo].[Personnel_Contrat] WITH NOCHECK
    ADD CONSTRAINT [FK_ContratId] FOREIGN KEY ([ContratId]) REFERENCES [dbo].[Contrat] ([ContratId]);


GO
PRINT N'Création de [dbo].[FK_UtilisateurId]...';


GO
ALTER TABLE [dbo].[Transaction_Acces] WITH NOCHECK
    ADD CONSTRAINT [FK_UtilisateurId] FOREIGN KEY ([UtilisateurId]) REFERENCES [dbo].[Utilisateur] ([UtilisateurId]) ON DELETE CASCADE;


GO
PRINT N'Création de [dbo].[FK_TransactionId]...';


GO
ALTER TABLE [dbo].[Transaction_Acces] WITH NOCHECK
    ADD CONSTRAINT [FK_TransactionId] FOREIGN KEY ([TransactionId]) REFERENCES [dbo].[Transaction] ([TransactionId]) ON DELETE CASCADE;


GO
PRINT N'Création de [dbo].[V_PersonnelActif]...';


GO
CREATE VIEW [dbo].[V_PersonnelActif]
	AS SELECT T1.*,T2.Nom,T2.Prenom,T2.ChefEquipe 
	FROM [dbo].[Personnel_Contrat] AS T1 INNER JOIN [dbo].[Personnel] AS T2 ON T2.PersonnelId = T1.PersonnelId  WHERE DateSortie > GETDATE()
GO
PRINT N'Création de [dbo].[SP_AddPersCont]...';


GO
CREATE PROCEDURE [dbo].[SP_AddPersCont]
	@PersonnelId INT, 
    @ContratId INT, 
    @DateEntree DATE, 
    @DateSortie DATE 
AS

	INSERT INTO[dbo].[Personnel_Contrat]
	([PersonnelId], 
    [ContratId], 
    [DateEntree], 
    [DateSortie])
	VALUES
	(@PersonnelId, 
    @ContratId, 
    @DateEntree, 
    ISNULL(@DateSortie,'2099/12/31'))
GO
PRINT N'Création de [dbo].[SP_AddPersonnel]...';


GO
CREATE PROCEDURE [dbo].[SP_AddPersonnel]
	@Matricule INT,
    @Prenom NVARCHAR(50), 
    @Nom NVARCHAR(50), 
    @DateNaissance DATE, 
    @Qualification NVARCHAR(50), 
    @ChefEquipe BIT
AS
	INSERT INTO[dbo].[Personnel]
	([Matricule],
    [Prenom], 
    [Nom], 
    [DateNaissance], 
    [Qualification], 
    [ChefEquipe])
	VALUES
	(@Matricule,
    @Prenom, 
    @Nom, 
    @DateNaissance, 
    @Qualification, 
    @ChefEquipe)
GO
PRINT N'Création de [dbo].[SP_AddUtilisateur]...';


GO
CREATE PROCEDURE [dbo].[SP_AddUtilisateur]
	@Email NVARCHAR(50), 
    @Login NVARCHAR(50), 
    @MotPasse  NVARCHAR(64)
AS
	INSERT INTO[dbo].[Utilisateur]
	([Email],
    [Login],
    [MotPasse])
	VALUES
	(@Email, 
    @Login, 
   dbo.SF_HashPassword( @MotPasse))
GO
PRINT N'Création de [dbo].[SP_DeleteUtilisateur]...';


GO
CREATE PROCEDURE [dbo].[SP_DeleteUtilisateur]
	@UtilisateurId INT

AS
	DELETE [dbo].[Utilisateur] WHERE [UtilisateurId]=@UtilisateurId
GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[JournalDesTravaux] WITH CHECK CHECK CONSTRAINT [FK_JDTPersonnelId];

ALTER TABLE [dbo].[JournalDesTravaux] WITH CHECK CHECK CONSTRAINT [FK_PosteId];

ALTER TABLE [dbo].[Personnel_Contrat] WITH CHECK CHECK CONSTRAINT [FK_ContPersonnelId];

ALTER TABLE [dbo].[Personnel_Contrat] WITH CHECK CHECK CONSTRAINT [FK_ContratId];

ALTER TABLE [dbo].[Transaction_Acces] WITH CHECK CHECK CONSTRAINT [FK_UtilisateurId];

ALTER TABLE [dbo].[Transaction_Acces] WITH CHECK CHECK CONSTRAINT [FK_TransactionId];


GO
PRINT N'Mise à jour terminée.';


GO
