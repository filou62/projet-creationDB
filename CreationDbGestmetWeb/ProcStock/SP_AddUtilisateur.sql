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


