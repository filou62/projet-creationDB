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