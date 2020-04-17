CREATE PROCEDURE [dbo].[SP_UpdateJDT]
	@JDTId INT,
    @PersonnelId INT, 
    @PosteId INT, 
    @DateChantier DATE, 
    @HeuresProd DECIMAL(10, 2), 
    @VoitPerso BIT, 
    @ZoneDepl NVARCHAR(50), 
    @ChefChantierId INT, 
    @Login INT,
    @EstValide BIT
AS
	UPDATE [dbo].[JournalDesTravaux] SET
	[PersonnelId]=@PersonnelId,
    [PosteId]= @PosteId, 
    [DateChantier]= @DateChantier, 
    [HeuresProd]=  @HeuresProd, 
    [VoitPerso]=@VoitPerso, 
    [ZoneDepl]=  @ZoneDepl, 
    [ChefChantierId]= @ChefChantierId, 
    [Login]= @Login,
    [EstValide]=@EstValide

	WHERE [JDTId]=@JDTId
	
    
    
   
    
   
   
   