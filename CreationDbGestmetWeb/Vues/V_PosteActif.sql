CREATE VIEW [dbo].[V_PosteActif]
	AS SELECT T2.ChantierId,T2.RefChantier,T2.NomChantier,T2.LieuChantier,T1.PosteId,T1.RefPoste,T1.LibellePoste
	FROM [dbo].[Poste] AS T1 INNER JOIN [dbo].[Chantier] AS T2 ON T2.ChantierId = T1.ChantierId  WHERE T1.SaisiePoste = 1
