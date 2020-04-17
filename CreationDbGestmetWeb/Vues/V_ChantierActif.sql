CREATE VIEW [dbo].[V_ChantierActif]
	AS SELECT T1.ChantierId,T1.RefChantier,T1.NomChantier,T1.LieuChantier,T2.NomSociete 
	FROM [dbo].[Chantier] AS T1 INNER JOIN [dbo].[Societe] AS T2 ON T2.SocieteId = T1.SocieteId  WHERE T1.Cloture = 0