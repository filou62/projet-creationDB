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
