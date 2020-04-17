CREATE PROCEDURE [dbo].[SP_DeleteJDT]
	@JDTId INT
    
AS
	DELETE [dbo].[JournalDesTravaux] 
	WHERE [JDTId]=@JDTId
