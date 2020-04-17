CREATE PROCEDURE [dbo].[SP_DeleteTransactionAcces]
	@TransAccesId INT
AS

	DELETE [dbo].[Transaction_Acces]
	WHERE [TransAccesId] = @TransAccesId
