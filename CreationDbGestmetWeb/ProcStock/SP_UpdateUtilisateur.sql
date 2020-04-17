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