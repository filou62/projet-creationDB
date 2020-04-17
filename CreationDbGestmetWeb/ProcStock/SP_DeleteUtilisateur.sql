CREATE PROCEDURE [dbo].[SP_DeleteUtilisateur]
	@UtilisateurId INT

AS
	DELETE [dbo].[Utilisateur] WHERE [UtilisateurId]=@UtilisateurId
	