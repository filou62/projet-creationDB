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
/*
La colonne [dbo].[Chantier].[SocieteId] de la table [dbo].[Chantier] doit être ajoutée mais la colonne ne comporte pas de valeur par défaut et n'autorise pas les valeurs NULL. Si la table contient des données, le script ALTER ne fonctionnera pas. Pour éviter ce problème, vous devez ajouter une valeur par défaut à la colonne, la marquer comme autorisant les valeurs Null ou activer la génération de smart-defaults en tant qu'option de déploiement.
*/

IF EXISTS (select top 1 1 from [dbo].[Chantier])
    RAISERROR (N'Lignes détectées. Arrêt de la mise à jour du schéma en raison d''''un risque de perte de données.', 16, 127) WITH NOWAIT

GO
/*
La colonne HeuresProd de la table [dbo].[JournalDesTravaux] doit être modifiée de NULL à NOT NULL. Si la table contient des données, le script ALTER peut ne pas fonctionner. Pour éviter ce problème, vous devez ajouter des valeurs à cette colonne pour toutes les lignes, marquer la colonne comme autorisant les valeurs NULL ou activer la génération de smart-defaults en tant qu'option de déploiement.
*/

IF EXISTS (select top 1 1 from [dbo].[JournalDesTravaux])
    RAISERROR (N'Lignes détectées. Arrêt de la mise à jour du schéma en raison d''''un risque de perte de données.', 16, 127) WITH NOWAIT

GO
/*
La colonne [dbo].[Personnel].[SocieteId] de la table [dbo].[Personnel] doit être ajoutée mais la colonne ne comporte pas de valeur par défaut et n'autorise pas les valeurs NULL. Si la table contient des données, le script ALTER ne fonctionnera pas. Pour éviter ce problème, vous devez ajouter une valeur par défaut à la colonne, la marquer comme autorisant les valeurs Null ou activer la génération de smart-defaults en tant qu'option de déploiement.

La colonne Qualification de la table [dbo].[Personnel] doit être modifiée de NULL à NOT NULL. Si la table contient des données, le script ALTER peut ne pas fonctionner. Pour éviter ce problème, vous devez ajouter des valeurs à cette colonne pour toutes les lignes, marquer la colonne comme autorisant les valeurs NULL ou activer la génération de smart-defaults en tant qu'option de déploiement.
*/

IF EXISTS (select top 1 1 from [dbo].[Personnel])
    RAISERROR (N'Lignes détectées. Arrêt de la mise à jour du schéma en raison d''''un risque de perte de données.', 16, 127) WITH NOWAIT

GO
/*
La colonne [dbo].[Poste].[ChantierId] de la table [dbo].[Poste] doit être ajoutée mais la colonne ne comporte pas de valeur par défaut et n'autorise pas les valeurs NULL. Si la table contient des données, le script ALTER ne fonctionnera pas. Pour éviter ce problème, vous devez ajouter une valeur par défaut à la colonne, la marquer comme autorisant les valeurs Null ou activer la génération de smart-defaults en tant qu'option de déploiement.
*/

IF EXISTS (select top 1 1 from [dbo].[Poste])
    RAISERROR (N'Lignes détectées. Arrêt de la mise à jour du schéma en raison d''''un risque de perte de données.', 16, 127) WITH NOWAIT

GO
/*
La colonne [dbo].[Utilisateur].[PersonnelId] de la table [dbo].[Utilisateur] doit être ajoutée mais la colonne ne comporte pas de valeur par défaut et n'autorise pas les valeurs NULL. Si la table contient des données, le script ALTER ne fonctionnera pas. Pour éviter ce problème, vous devez ajouter une valeur par défaut à la colonne, la marquer comme autorisant les valeurs Null ou activer la génération de smart-defaults en tant qu'option de déploiement.
*/

IF EXISTS (select top 1 1 from [dbo].[Utilisateur])
    RAISERROR (N'Lignes détectées. Arrêt de la mise à jour du schéma en raison d''''un risque de perte de données.', 16, 127) WITH NOWAIT

GO
PRINT N'L''opération de refactorisation de changement de nom avec la clé fb2349df-de91-4028-9877-1093237547e3 est ignorée, l''élément [dbo].[Poste].[PosteActif] (SqlSimpleColumn) ne sera pas renommé en SaisiePoste';


GO
PRINT N'L''opération suivante a été générée à partir d''un fichier journal de refactorisation a1beb427-3c2e-4e1a-ade7-8f4a22df1730';

PRINT N'Renommer [dbo].[JournalDesTravaux].[IdChefChantier] en ChefChantierId';


GO
EXECUTE sp_rename @objname = N'[dbo].[JournalDesTravaux].[IdChefChantier]', @newname = N'ChefChantierId', @objtype = N'COLUMN';


GO
PRINT N'Suppression de [dbo].[FK_PosteId]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux] DROP CONSTRAINT [FK_PosteId];


GO
PRINT N'Modification de [dbo].[Chantier]...';


GO
ALTER TABLE [dbo].[Chantier]
    ADD [SocieteId] INT NOT NULL;


GO
PRINT N'Modification de [dbo].[JournalDesTravaux]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux] ALTER COLUMN [HeuresProd] DECIMAL (10, 2) NOT NULL;


GO
ALTER TABLE [dbo].[JournalDesTravaux]
    ADD [NumSemaine] AS DATEPART(ISO_WEEK, DateChantier);


GO
PRINT N'Modification de [dbo].[Personnel]...';


GO
ALTER TABLE [dbo].[Personnel] ALTER COLUMN [Qualification] NVARCHAR (50) NOT NULL;


GO
ALTER TABLE [dbo].[Personnel]
    ADD [SocieteId] INT NOT NULL;


GO
PRINT N'Modification de [dbo].[Poste]...';


GO
ALTER TABLE [dbo].[Poste]
    ADD [ChantierId]  INT NOT NULL,
        [SaisiePoste] BIT DEFAULT 0 NOT NULL;


GO
PRINT N'Création de [dbo].[UK_PosteChant]...';


GO
ALTER TABLE [dbo].[Poste]
    ADD CONSTRAINT [UK_PosteChant] UNIQUE NONCLUSTERED ([RefPoste] ASC, [ChantierId] ASC);


GO
PRINT N'Modification de [dbo].[Utilisateur]...';


GO
ALTER TABLE [dbo].[Utilisateur]
    ADD [PersonnelId] INT NOT NULL;


GO
PRINT N'Création de contrainte sans nom sur [dbo].[Utilisateur]...';


GO
ALTER TABLE [dbo].[Utilisateur]
    ADD UNIQUE NONCLUSTERED ([PersonnelId] ASC);


GO
PRINT N'Création de contrainte sans nom sur [dbo].[JournalDesTravaux]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux]
    ADD DEFAULT 0.00 FOR [HeuresProd];


GO
PRINT N'Création de [dbo].[FK_PosteId]...';


GO
ALTER TABLE [dbo].[JournalDesTravaux] WITH NOCHECK
    ADD CONSTRAINT [FK_PosteId] FOREIGN KEY ([PosteId]) REFERENCES [dbo].[Poste] ([PosteId]);


GO
PRINT N'Création de [dbo].[FK_ChantierSocId]...';


GO
ALTER TABLE [dbo].[Chantier] WITH NOCHECK
    ADD CONSTRAINT [FK_ChantierSocId] FOREIGN KEY ([SocieteId]) REFERENCES [dbo].[Societe] ([SocieteId]);


GO
PRINT N'Création de [dbo].[FK_PersonnelSocId]...';


GO
ALTER TABLE [dbo].[Personnel] WITH NOCHECK
    ADD CONSTRAINT [FK_PersonnelSocId] FOREIGN KEY ([SocieteId]) REFERENCES [dbo].[Societe] ([SocieteId]);


GO
PRINT N'Création de [dbo].[FK_PosteChantierId]...';


GO
ALTER TABLE [dbo].[Poste] WITH NOCHECK
    ADD CONSTRAINT [FK_PosteChantierId] FOREIGN KEY ([ChantierId]) REFERENCES [dbo].[Chantier] ([ChantierId]);


GO
PRINT N'Création de [dbo].[FK_UtilisateurPersId]...';


GO
ALTER TABLE [dbo].[Utilisateur] WITH NOCHECK
    ADD CONSTRAINT [FK_UtilisateurPersId] FOREIGN KEY ([PersonnelId]) REFERENCES [dbo].[Personnel] ([PersonnelId]);


GO
PRINT N'Modification de [dbo].[V_PersonnelActif]...';


GO
ALTER VIEW [dbo].[V_PersonnelActif]
	AS SELECT T1.PersonnelId,T2.Matricule,T2.Nom,T2.Prenom,T2.ChefEquipe 
	FROM [dbo].[Personnel_Contrat] AS T1 INNER JOIN [dbo].[Personnel] AS T2 ON T2.PersonnelId = T1.PersonnelId  WHERE T1.DateSortie > GETDATE()
GO
PRINT N'Création de [dbo].[V_ChantierActif]...';


GO
CREATE VIEW [dbo].[V_ChantierActif]
	AS SELECT T1.RefChantier,T1.NomChantier,T1.LieuChantier,T2.NomSociete 
	FROM [dbo].[Chantier] AS T1 INNER JOIN [dbo].[Societe] AS T2 ON T2.SocieteId = T1.SocieteId  WHERE T1.Cloture = 0
GO
PRINT N'Création de [dbo].[V_PosteActif]...';


GO
CREATE VIEW [dbo].[V_PosteActif]
	AS SELECT T2.ChantierId,T2.RefChantier,T2.NomChantier,T2.LieuChantier,T1.RefPoste,T1.LibellePoste
	FROM [dbo].[Poste] AS T1 INNER JOIN [dbo].[Chantier] AS T2 ON T2.ChantierId = T1.ChantierId  WHERE T1.SaisiePoste = 1
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
    @Login NVARCHAR(50)
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
    @Login NVARCHAR(50)
AS
	UPDATE [dbo].[JournalDesTravaux] SET
	[PersonnelId]=@PersonnelId,
    [PosteId]= @PosteId, 
    [DateChantier]= @DateChantier, 
    [HeuresProd]=  @HeuresProd, 
    [VoitPerso]=@VoitPerso, 
    [ZoneDepl]=  @ZoneDepl, 
    [ChefChantierId]= @ChefChantierId, 
    [Login]= @Login

	WHERE [JDTId]=@JDTId
GO
PRINT N'Création de [dbo].[SP_UpdateUtilisateur]...';


GO
CREATE PROCEDURE [dbo].[SP_UpdateUtilisateur]
	@UtilisateurId Int,
    @Email NVARCHAR(50), 
    @Login NVARCHAR(50), 
    @MotPasse  NVARCHAR(64)
AS
	UPDATE [dbo].[Utilisateur] SET
	[Email] =@Email,
    [Login]=@Login,
    [MotPasse]=dbo.SF_HashPassword( @MotPasse)
	WHERE [UtilisateurId]=@UtilisateurId
GO
PRINT N'Actualisation de [dbo].[SP_AddPersonnel]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[SP_AddPersonnel]';


GO
PRINT N'Actualisation de [dbo].[SP_AddUtilisateur]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[SP_AddUtilisateur]';


GO
PRINT N'Actualisation de [dbo].[SP_DeleteUtilisateur]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[SP_DeleteUtilisateur]';


GO
-- Étape de refactorisation pour mettre à jour le serveur cible avec des journaux de transactions déployés
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'fb2349df-de91-4028-9877-1093237547e3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('fb2349df-de91-4028-9877-1093237547e3')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a1beb427-3c2e-4e1a-ade7-8f4a22df1730')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a1beb427-3c2e-4e1a-ade7-8f4a22df1730')

GO

GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[JournalDesTravaux] WITH CHECK CHECK CONSTRAINT [FK_PosteId];

ALTER TABLE [dbo].[Chantier] WITH CHECK CHECK CONSTRAINT [FK_ChantierSocId];

ALTER TABLE [dbo].[Personnel] WITH CHECK CHECK CONSTRAINT [FK_PersonnelSocId];

ALTER TABLE [dbo].[Poste] WITH CHECK CHECK CONSTRAINT [FK_PosteChantierId];

ALTER TABLE [dbo].[Utilisateur] WITH CHECK CHECK CONSTRAINT [FK_UtilisateurPersId];


GO
PRINT N'Mise à jour terminée.';


GO
