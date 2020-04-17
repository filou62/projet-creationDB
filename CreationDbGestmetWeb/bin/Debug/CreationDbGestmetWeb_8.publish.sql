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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


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
    [SocieteId]           INT             NOT NULL,
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
    [HeuresProd]     DECIMAL (10, 2) NOT NULL,
    [VoitPerso]      BIT             NOT NULL,
    [ZoneDepl]       NVARCHAR (50)   NOT NULL,
    [ChefChantierId] INT             NOT NULL,
    [Login]          INT             NOT NULL,
    [NumSemaine]     AS              DATEPART(ISO_WEEK, DateChantier),
    [EstValide]      BIT             NOT NULL,
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
    [Qualification] NVARCHAR (50) NOT NULL,
    [ChefEquipe]    BIT           NOT NULL,
    [SocieteId]     INT           NOT NULL,
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
    [ChantierId]       INT             NOT NULL,
    [SaisiePoste]      BIT             NOT NULL,
    PRIMARY KEY CLUSTERED ([PosteId] ASC),
    CONSTRAINT [UK_PosteChant] UNIQUE NONCLUSTERED ([RefPoste] ASC, [ChantierId] ASC)
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
    [PersonnelId]   INT            NOT NULL,
    [EstActif]      BIT            NOT NULL,
    PRIMARY KEY CLUSTERED ([UtilisateurId] ASC),
    UNIQUE NONCLUSTERED ([PersonnelId] ASC),
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
    ADD DEFAULT 0.00 FOR [HeuresProd];


GO
PRINT N'Création de contrainte sans nom sur [dbo].[JournalDesTravaux]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux]
    ADD DEFAULT 0 FOR [VoitPerso];


GO
PRINT N'Création de contrainte sans nom sur [dbo].[JournalDesTravaux]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux]
    ADD DEFAULT 0 FOR [EstValide];


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
PRINT N'Création de contrainte sans nom sur [dbo].[Poste]...';


GO
ALTER TABLE [dbo].[Poste]
    ADD DEFAULT 0 FOR [SaisiePoste];


GO
PRINT N'Création de contrainte sans nom sur [dbo].[Utilisateur]...';


GO
ALTER TABLE [dbo].[Utilisateur]
    ADD DEFAULT 0 FOR [EstActif];


GO
PRINT N'Création de [dbo].[FK_ChantierSocId]...';


GO
ALTER TABLE [dbo].[Chantier]
    ADD CONSTRAINT [FK_ChantierSocId] FOREIGN KEY ([SocieteId]) REFERENCES [dbo].[Societe] ([SocieteId]);


GO
PRINT N'Création de [dbo].[FK_JDTPersonnelId]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux]
    ADD CONSTRAINT [FK_JDTPersonnelId] FOREIGN KEY ([PersonnelId]) REFERENCES [dbo].[Personnel] ([PersonnelId]);


GO
PRINT N'Création de [dbo].[FK_PosteId]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux]
    ADD CONSTRAINT [FK_PosteId] FOREIGN KEY ([PosteId]) REFERENCES [dbo].[Poste] ([PosteId]);


GO
PRINT N'Création de [dbo].[FK_Login]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux]
    ADD CONSTRAINT [FK_Login] FOREIGN KEY ([PersonnelId]) REFERENCES [dbo].[Personnel] ([PersonnelId]);


GO
PRINT N'Création de [dbo].[FK_PersonnelSocId]...';


GO
ALTER TABLE [dbo].[Personnel]
    ADD CONSTRAINT [FK_PersonnelSocId] FOREIGN KEY ([SocieteId]) REFERENCES [dbo].[Societe] ([SocieteId]);


GO
PRINT N'Création de [dbo].[FK_ContPersonnelId]...';


GO
ALTER TABLE [dbo].[Personnel_Contrat]
    ADD CONSTRAINT [FK_ContPersonnelId] FOREIGN KEY ([PersonnelId]) REFERENCES [dbo].[Personnel] ([PersonnelId]);


GO
PRINT N'Création de [dbo].[FK_ContratId]...';


GO
ALTER TABLE [dbo].[Personnel_Contrat]
    ADD CONSTRAINT [FK_ContratId] FOREIGN KEY ([ContratId]) REFERENCES [dbo].[Contrat] ([ContratId]);


GO
PRINT N'Création de [dbo].[FK_PosteChantierId]...';


GO
ALTER TABLE [dbo].[Poste]
    ADD CONSTRAINT [FK_PosteChantierId] FOREIGN KEY ([ChantierId]) REFERENCES [dbo].[Chantier] ([ChantierId]);


GO
PRINT N'Création de [dbo].[FK_UtilisateurId]...';


GO
ALTER TABLE [dbo].[Transaction_Acces]
    ADD CONSTRAINT [FK_UtilisateurId] FOREIGN KEY ([UtilisateurId]) REFERENCES [dbo].[Utilisateur] ([UtilisateurId]) ON DELETE CASCADE;


GO
PRINT N'Création de [dbo].[FK_TransactionId]...';


GO
ALTER TABLE [dbo].[Transaction_Acces]
    ADD CONSTRAINT [FK_TransactionId] FOREIGN KEY ([TransactionId]) REFERENCES [dbo].[Transaction] ([TransactionId]) ON DELETE CASCADE;


GO
PRINT N'Création de [dbo].[FK_UtilisateurPersId]...';


GO
ALTER TABLE [dbo].[Utilisateur]
    ADD CONSTRAINT [FK_UtilisateurPersId] FOREIGN KEY ([PersonnelId]) REFERENCES [dbo].[Personnel] ([PersonnelId]);


GO
PRINT N'Création de [dbo].[V_ChantierActif]...';


GO
CREATE VIEW [dbo].[V_ChantierActif]
	AS SELECT T1.ChantierId,T1.RefChantier,T1.NomChantier,T1.LieuChantier,T2.NomSociete 
	FROM [dbo].[Chantier] AS T1 INNER JOIN [dbo].[Societe] AS T2 ON T2.SocieteId = T1.SocieteId  WHERE T1.Cloture = 0
GO
PRINT N'Création de [dbo].[V_PersonnelActif]...';


GO
CREATE VIEW [dbo].[V_PersonnelActif]
	AS SELECT T1.PersonnelId,T2.Matricule,T2.Nom,T2.Prenom,T2.ChefEquipe 
	FROM [dbo].[Personnel_Contrat] AS T1 INNER JOIN [dbo].[Personnel] AS T2 ON T2.PersonnelId = T1.PersonnelId  WHERE T1.DateSortie > GETDATE()
GO
PRINT N'Création de [dbo].[V_PosteActif]...';


GO
CREATE VIEW [dbo].[V_PosteActif]
	AS SELECT T2.ChantierId,T2.RefChantier,T2.NomChantier,T2.LieuChantier,T1.PosteId,T1.RefPoste,T1.LibellePoste
	FROM [dbo].[Poste] AS T1 INNER JOIN [dbo].[Chantier] AS T2 ON T2.ChantierId = T1.ChantierId  WHERE T1.SaisiePoste = 1
GO
PRINT N'Création de [dbo].[SF_HashPassword]...';


GO
CREATE FUNCTION [dbo].[SF_HashPassword]
(
	@password NVARCHAR(64)
)
RETURNS VARBINARY(32)
AS
BEGIN
	DECLARE @passwordWithNoise NVARCHAR(MAX)
	SET @passwordWithNoise = 'Ahfezf'+@password+'jhdzs8552'
	RETURN HASHBYTES('SHA2_256',@passwordWithNoise)
END
GO
PRINT N'Création de [dbo].[SP_AddJDT]...';


GO
CREATE PROCEDURE [dbo].[SP_AddJDT]
	@PersonnelId INT, 
    @PosteId INT, 
    @DateChantier DATE, 
    @HeuresProd DECIMAL(10, 2), 
    @VoitPerso BIT, 
    @ZoneDepl NVARCHAR(50), 
    @ChefChantierId INT, 
    @Login INT
AS
	INSERT INTO[dbo].[JournalDesTravaux]
	([PersonnelId], 
    [PosteId], 
    [DateChantier], 
    [HeuresProd], 
    [VoitPerso], 
    [ZoneDepl], 
    [ChefChantierId], 
    [Login])
	VALUES
	(@PersonnelId, 
    @PosteId, 
    @DateChantier, 
    @HeuresProd, 
    @VoitPerso, 
    @ZoneDepl, 
    @ChefChantierId, 
    @Login)
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
PRINT N'Création de [dbo].[SP_AddTransactionAcces]...';


GO
CREATE PROCEDURE [dbo].[SP_AddTransactionAcces]
    @UtilisateurId INT, 
    @TransactionId INT
AS

	INSERT INTO[dbo].[Transaction_Acces]
	([UtilisateurId], 
    [TransactionId] )
	VALUES
	(@UtilisateurId, 
    @TransactionId)
GO
PRINT N'Création de [dbo].[SP_AddUtilisateur]...';


GO
CREATE PROCEDURE [dbo].[SP_AddUtilisateur]
	@Email NVARCHAR(50), 
    @Login NVARCHAR(50), 
    @MotPasse  NVARCHAR(64),
    @PersonnelId INT
    AS
	INSERT INTO[dbo].[Utilisateur]
	([Email],
    [Login],
    [MotPasse],
    [PersonnelId])

	VALUES
	(@Email, 
    @Login, 
   dbo.SF_HashPassword( @MotPasse),
   @PersonnelId)
GO
PRINT N'Création de [dbo].[SP_ConnectUtilisateur]...';


GO
CREATE PROCEDURE [dbo].[SP_ConnectUtilisateur]
	
    @Login NVARCHAR(50), 
    @MotPasse  NVARCHAR(64)
AS
	SELECT * FROM [dbo].[Utilisateur] 
	WHERE [Login]=@Login AND [MotPasse]=dbo.SF_HashPassword( @MotPasse)
GO
PRINT N'Création de [dbo].[SP_DeleteJDT]...';


GO
CREATE PROCEDURE [dbo].[SP_DeleteJDT]
	@JDTId INT
    
AS
	DELETE [dbo].[JournalDesTravaux] 
	WHERE [JDTId]=@JDTId
GO
PRINT N'Création de [dbo].[SP_DeleteTransactionAcces]...';


GO
CREATE PROCEDURE [dbo].[SP_DeleteTransactionAcces]
	@TransAccesId INT
AS

	DELETE [dbo].[Transaction_Acces]
	WHERE [TransAccesId] = @TransAccesId
GO
PRINT N'Création de [dbo].[SP_DeleteUtilisateur]...';


GO
CREATE PROCEDURE [dbo].[SP_DeleteUtilisateur]
	@UtilisateurId INT

AS
	DELETE [dbo].[Utilisateur] WHERE [UtilisateurId]=@UtilisateurId
GO
PRINT N'Création de [dbo].[SP_UpdateJDT]...';


GO
CREATE PROCEDURE [dbo].[SP_UpdateJDT]
	@JDTId INT,
    @PersonnelId INT, 
    @PosteId INT, 
    @DateChantier DATE, 
    @HeuresProd DECIMAL(10, 2), 
    @VoitPerso BIT, 
    @ZoneDepl NVARCHAR(50), 
    @ChefChantierId INT, 
    @Login INT,
    @EstValide BIT
AS
	UPDATE [dbo].[JournalDesTravaux] SET
	[PersonnelId]=@PersonnelId,
    [PosteId]= @PosteId, 
    [DateChantier]= @DateChantier, 
    [HeuresProd]=  @HeuresProd, 
    [VoitPerso]=@VoitPerso, 
    [ZoneDepl]=  @ZoneDepl, 
    [ChefChantierId]= @ChefChantierId, 
    [Login]= @Login,
    [EstValide]=@EstValide

	WHERE [JDTId]=@JDTId
GO
PRINT N'Création de [dbo].[SP_UpdateUtilisateur]...';


GO
CREATE PROCEDURE [dbo].[SP_UpdateUtilisateur]
	@UtilisateurId Int,
    @Email NVARCHAR(50), 
    @Login NVARCHAR(50), 
    @MotPasse  NVARCHAR(64),
    @PersonnelId INT,
    @EstActif BIT
AS
	UPDATE [dbo].[Utilisateur] SET
	[Email] =@Email,
    [Login]=@Login,
    [MotPasse]=dbo.SF_HashPassword( @MotPasse),
    [PersonnelId]=@PersonnelId,
    [EstActif] = @EstActif
	WHERE [UtilisateurId]=@UtilisateurId
GO
-- Étape de refactorisation pour mettre à jour le serveur cible avec des journaux de transactions déployés

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'fb2349df-de91-4028-9877-1093237547e3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('fb2349df-de91-4028-9877-1093237547e3')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a1beb427-3c2e-4e1a-ade7-8f4a22df1730')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a1beb427-3c2e-4e1a-ade7-8f4a22df1730')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
