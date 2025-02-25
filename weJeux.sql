
/* -----------------------------------------------------------------------
BASE de DONNEES : weJeux
Auteur : Mohamed-Amine BOUKLIKHA & Ayman AJLIL
------------------------------------------------------------------------- */


DROP SCHEMA IF EXISTS weJeux cascade;
CREATE SCHEMA weJeux;

------------------------------------------------------------
-- Table: utilisateur
------------------------------------------------------------

CREATE TABLE weJeux.utilisateur(
	nomUtilisateur VARCHAR(50),
	nom VARCHAR(50),
	prenom VARCHAR(50),
	email VARCHAR(50),
	numTelephone VARCHAR(15),
	numCredit VARCHAR(16),
	CONSTRAINT pk_utilisateur PRIMARY KEY (nomUtilisateur)
);

------------------------------------------------------------
-- Table: jeu
------------------------------------------------------------

CREATE TABLE weJeux.jeu(
	idJeu INT,
	titre VARCHAR(50),
	descriptif VARCHAR(50),
	CONSTRAINT pk_jeu PRIMARY KEY (idJeu)
);

CREATE TABLE weJeux.solo(
	idJeu INT PRIMARY KEY, 
    	tempsJeu VARCHAR(50)
    	
) INHERITS (weJeux.jeu);

CREATE TABLE weJeux.multijoueur(
	idJeu INT PRIMARY KEY,
    	nbExtensions INT
    
) INHERITS (weJeux.jeu);


------------------------------------------------------------
-- Table: serveur
------------------------------------------------------------

CREATE TABLE weJeux.serveur(
	adresseIP VARCHAR(50),
	nom VARCHAR(50),
	capaciteMax INT,
	idJeuMulti INT,
	CONSTRAINT pk_serveur PRIMARY KEY (adresseIP)
	
	,CONSTRAINT fk_serveur_multijoueur FOREIGN KEY (idJeuMulti) REFERENCES weJeux.multijoueur(idJeu)
);

------------------------------------------------------------
-- Table: sauver
------------------------------------------------------------
CREATE TABLE weJeux.sauver(
	idJeu_solo       INT,
	nomUtilisateur   VARCHAR(50),
	nbVies           INT,
	score            INT,
	niveau           INT,
	CONSTRAINT pk_sauver PRIMARY KEY (idJeu_solo,nomUtilisateur)
	
	,CONSTRAINT fk_sauver_solo FOREIGN KEY (idJeu_solo) REFERENCES weJeux.solo(idJeu)
	,CONSTRAINT fk_sauver_utilisateur FOREIGN KEY (nomUtilisateur) REFERENCES weJeux.utilisateur(nomUtilisateur)
);

------------------------------------------------------------
-- Table: gagnant
------------------------------------------------------------
CREATE TABLE weJeux.gagnant(
	nomUtilisateur VARCHAR(50),
	IP   VARCHAR(50),
	nomUtilisateur_gagnant  VARCHAR(50),
	CONSTRAINT pk_gagnant PRIMARY KEY (nomUtilisateur,IP,nomUtilisateur_gagnant)

	,CONSTRAINT fk_gagnant_utilisateur FOREIGN KEY (nomUtilisateur) REFERENCES weJeux.utilisateur(nomUtilisateur)
	,CONSTRAINT fk_gagnant_serveur FOREIGN KEY (IP) REFERENCES weJeux.serveur(adresseIP)
	,CONSTRAINT fk_gagnant_utilisateur1 FOREIGN KEY (nomUtilisateur_gagnant) REFERENCES weJeux.utilisateur(nomUtilisateur)
);


------------------------------------------------------------
-- INSERTIONS : Utilisateurs
------------------------------------------------------------

INSERT INTO weJeux.utilisateur(nomUtilisateur, nom, prenom, email, numTelephone, numCredit) VALUES 
('momo91', 'Bouklikha', 'Mohamed-Amine', 'moha@gmail.com', '0612345678', '1234567812345678'),
('ayman93', 'Ajlil', 'Ayman', 'ayman@gmail.com', '0712345678', '8765432187654321'),
('sergioaguero75', 'Aguero', 'Sergio', 'sergio.aguero@yahoo.com', '0812345678', '1122334455667788'),
('sergio93230', 'Teixeira', 'Sergio', 'lucie.petit@hotmail.com', '0912345678', '2233445566778899'),
('chadi94', 'El-Khouly', 'Chadi', 'claire.lemoine@gmail.com', '0611223344', '3344556677889900'),
('boboche', 'Boucherie', 'Bob', 'alex.morel@gmail.com', '0622334455', '4455667788990011'),
('lionelmessi', 'Messi', 'Leo', 'emma.fournier@gmail.com', '0633445566', '5566778899001122'),
('user8', 'Roux', 'Maxime', 'maxime.roux@yahoo.com', '0644556677', '6677889900112233'),
('user99', 'Vincent', 'Elodie', 'elodie.vincent@gmail.com', '0655667788', '7788990011223344'),
('imd93', 'Fadil', 'Imad', 'thomas.garcia@yahoo.com', '0666778899', '8899001122334455'),
('wamax93100', 'Bensaoud', 'Wael', 'julie.bernard@hotmail.com', '0677889900', '9900112233445566'),
('user12', 'Leroy', 'Jules', 'jules.leroy@gmail.com', '0688990011', '0011223344556677'),
('kaiser', 'Renaud', 'Laura', 'laura.renaud@outlook.com', '0699001122', '1122334455667788'),
('user14', 'Collet', 'Hugo', 'hugo.collet@icloud.com', '0600112233', '2233445566778899'),
('user15', 'Perret', 'Alice', 'alice.perret@gmail.com', '0611001122', '3344556677889900'),
('mb230', 'Albert', 'Moha', 'louis.caron@gmail.com', '0622001122', '4455667788990011'),
('user17', 'Blanc', 'Chloé', 'chloe.blanc@icloud.com', '0633001122', '5566778899001122'),
('user18', 'Henry', 'Nicolas', 'nicolas.henry@gmail.com', '0644001122', '6677889900112233'),
('user19', 'Perrin', 'Sarah', 'sarah.perrin@gmail.com', '0655001122', '7788990011223344'),
('bassem69000', 'Braiki', 'Bassem', 'bass.69@gmail.com', '0666001122', '8899001122334455');

------------------------------------------------------------
-- INSERTIONS : Jeux
------------------------------------------------------------

-- Jeux solos
INSERT INTO weJeux.solo(idJeu, titre, descriptif, tempsJeu) VALUES
(1, 'Solo Quest', 'Jeu aventure solo', '10h'),
(2, 'Uncharted 4', 'Jeu aventure', '15h'),
(3, 'God of War', 'Jeu de viking', '20h'),
(4, 'GTA V', 'Jeu histoire', '72h'),
(5, 'Minecraft', 'Jeu de bac à sables', '12h');

-- Jeux multijoueurs
INSERT INTO weJeux.multijoueur(idJeu, titre, descriptif, nbExtensions) VALUES
(6, 'Battle Arena', 'Combat multijoueur', 3),
(7, 'League of Legends', 'Jeu de rôle', 5),
(8, 'CSGO', 'Course multijoueur', 2),
(9, 'Valorant', 'Survie multijoueur', 4),
(10, 'Galaxy Conquest', 'Conquête spatiale', 6);

------------------------------------------------------------
-- INSERTIONS : Serveurs
------------------------------------------------------------

INSERT INTO weJeux.serveur(adresseIP, nom, capaciteMax, idJeuMulti) VALUES
('192.168.1.1', 'Serveur Alpha', 100, 6),
('192.168.1.2', 'Serveur Beta', 150, 7), 
('192.168.1.3', 'Serveur Gamma', 200, 8), 
('192.168.1.4', 'Serveur Delta', 120, 9), 
('192.168.1.5', 'Serveur Epsilon', 250, 10),
('192.168.1.6', 'Serveur Zeta', 180, 9), 
('192.168.1.7', 'Serveur Eta', 110, 7),
('192.168.1.8', 'Serveur Theta', 180, 9),
('192.168.1.9', 'Serveur Iota', 90, 9), 
('192.168.1.10', 'Serveur Kappa', 300, 10); 

------------------------------------------------------------
-- INSERTIONS : Parties
------------------------------------------------------------

-- Parties solos
INSERT INTO weJeux.sauver(idJeu_solo, nomUtilisateur, nbVies, score, niveau) VALUES
(1, 'kaiser', 3, 500, 10),
(2, 'lionelmessi', 5, 450, 8),
(3, 'boboche', 4, 300, 7),
(4, 'imd93', 2, 600, 9),
(5, 'momo91', 1, 700, 12),
(1, 'user14', 3, 550, 10),
(2, 'mb230', 4, 480, 8),
(3, 'user99', 3, 350, 7),
(4, 'user19', 2, 650, 9),
(5, 'ayman93', 1, 750, 12);

-- Parties multijoueurs
INSERT INTO weJeux.gagnant(nomUtilisateur, IP, nomUtilisateur_gagnant) VALUES
('chadi94', '192.168.1.1', 'kaiser'),
('user17', '192.168.1.2', 'ayman93'),
('user12', '192.168.1.3', 'wamax93100'),
('ayman93', '192.168.1.4', 'momo91'),
('user12', '192.168.1.5', 'user99'),
('sergioaguero75', '192.168.1.6', 'ayman93'),
('imd93', '192.168.1.7', 'momo91'),
('kaiser', '192.168.1.8', 'user99'),
('momo91', '192.168.1.9', 'boboche'),
('bassem69000', '192.168.1.10', 'user99');



