/* -----------------------------------------------------------------------
Requètes SQL : weJeux
Auteur : Mohamed-Amine BOUKLIKHA & Ayman AJLIL 
------------------------------------------------------------------------- */

-- Requètes 1:

--Cette requête récupère toutes les colonnes de la table jeu

SELECT * 
FROM weJeux.utilisateur;

------------------------------------------------------------

-- Requètes 2:

-- Affiche tout les jeux dont le temps de jeu dépasse 10 heures.

SELECT titre, tempsJeu 
FROM weJeux.solo 
WHERE tempsJeu > '10h';

------------------------------------------------------------

-- Requètes 3:

-- Lister les noms des jeux multijoueurs, les noms des serveurs associés, et leur capacité maximale, mais uniquement pour les serveurs ayant une capacité supérieure à 100.

SELECT multijoueur.titre, serveur.nom, serveur.capaciteMax
FROM weJeux.multijoueur INNER JOIN weJeux.serveur ON multijoueur.idJeu = serveur.idJeuMulti
WHERE serveur.capaciteMax > 100;

------------------------------------------------------------

-- Requètes 4:

-- Lister les jeux multijoueurs avec leurs titres, le nombre de serveurs associés (ayant une capacité maximale supérieure à 100), mais uniquement pour les jeux ayant 2 serveurs ou plus.

SELECT multijoueur.titre, COUNT(serveur.adresseIP) 
FROM weJeux.multijoueur INNER JOIN weJeux.serveur ON multijoueur.idJeu = serveur.idJeuMulti 
WHERE serveur.capaciteMax > 100
GROUP BY multijoueur.titre
HAVING COUNT(serveur.adresseIP) >= 2;

------------------------------------------------------------

--Requètes 5:

-- Lister les utilisateurs ayant gagné des parties sur des serveurs associés à des jeux multijoueurs ayant plus de 3 extensions, avec le nombre total de parties gagnées par utilisateur. Trier par nombre de victoires en ordre décroissant

SELECT gagnant.nomUtilisateur_gagnant, COUNT(*) 
FROM weJeux.gagnant INNER JOIN weJeux.serveur ON gagnant.IP = serveur.adresseIP INNER JOIN weJeux.multijoueur ON serveur.idJeuMulti = multijoueur.idJeu
WHERE multijoueur.nbExtensions > 3
GROUP BY gagnant.nomUtilisateur_gagnant
ORDER BY COUNT(nomUtilisateur_gagnant) DESC;




