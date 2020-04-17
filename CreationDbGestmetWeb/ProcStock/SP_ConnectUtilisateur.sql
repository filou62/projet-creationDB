CREATE PROCEDURE [dbo].[SP_ConnectUtilisateur]
	
    @Login NVARCHAR(50), 
    @MotPasse  NVARCHAR(64)
AS
	SELECT * FROM [dbo].[Utilisateur] 
	WHERE [Login]=@Login AND [MotPasse]=dbo.SF_HashPassword( @MotPasse)