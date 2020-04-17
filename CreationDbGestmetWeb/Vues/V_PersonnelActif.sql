CREATE VIEW [dbo].[V_PersonnelActif]
	AS SELECT T1.PersonnelId,T2.Matricule,T2.Nom,T2.Prenom,T2.ChefEquipe 
	FROM [dbo].[Personnel_Contrat] AS T1 INNER JOIN [dbo].[Personnel] AS T2 ON T2.PersonnelId = T1.PersonnelId  WHERE T1.DateSortie > GETDATE()