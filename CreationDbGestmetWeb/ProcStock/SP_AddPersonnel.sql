CREATE PROCEDURE [dbo].[SP_AddPersonnel]
	@Matricule INT,
    @Prenom NVARCHAR(50), 
    @Nom NVARCHAR(50), 
    @DateNaissance DATE, 
    @Qualification NVARCHAR(50), 
    @ChefEquipe BIT
AS
	INSERT INTO[dbo].[Personnel]
	([Matricule],
    [Prenom], 
    [Nom], 
    [DateNaissance], 
    [Qualification], 
    [ChefEquipe])
	VALUES
	(@Matricule,
    @Prenom, 
    @Nom, 
    @DateNaissance, 
    @Qualification, 
    @ChefEquipe)
