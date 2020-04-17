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