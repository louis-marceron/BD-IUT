--R11
SELECT nomEmploye, prenomEmploye
FROM Employes
WHERE salaireEmploye > 2000;

--R12
SELECT nomCamping
FROM Campings
WHERE villeCamping = 'Palavas' AND nbEtoilesCamping = 5;

--R13
SELECT nomEmploye, prenomEmploye
FROM Employes e
JOIN Campings c ON e.idCamping = c.idCamping
WHERE c.nomCamping = 'Les Flots Bleus'
ORDER BY salaireEmploye;

--R14
SELECT sub.nomEmploye, sub.prenomEmploye
FROM Employes sub
JOIN Employes chef ON sub.idEmployeChef = chef.idEmploye
WHERE chef.prenomEmploye = 'Gaspard' AND chef.nomEmploye = 'Alizan';

--R15
SELECT nomClient, prenomClient
FROM Clients c
JOIN Locations l ON c.idClient = l.idClient
JOIN Bungalows b ON l.idBungalow = b.idBungalow
JOIN Campings camp ON b.idCamping = camp.idCamping
WHERE nomCamping = 'Les Flots Bleus'
AND dateDebut <= '14/07/2017'
AND dateFin >= '14/07/2017';

--R16
SELECT nomClient, prenomClient
FROM Clients
WHERE idClient IN (
SELECT idClient
FROM Locations l
JOIN Bungalows b ON l.idBungalow = b.idBungalow
JOIN Campings c ON b.idCamping = c.idCamping
WHERE nomCamping = 'Les Flots Bleus'
AND dateDebut <= '31/07/2017'
AND dateFin >= '01/07/2017');

--R17
SELECT nomClient, prenomClient
FROM Clients
WHERE villeClient IN (
SELECT villeCamping
FROM Campings);

--R18
SELECT COUNT(*) as "Nombre de services"
FROM Bungalows b
JOIN Proposer p ON b.idBungalow = p.idBungalow
WHERE nomBungalow = 'Le Titanic';

--R19
SELECT MAX(salaireEmploye) as "Salaire max"
FROM Employes e
JOIN Campings c ON e.idCamping = c.idCamping
WHERE nomCamping = 'Les Flots Bleus';

--R20
SELECT COUNT(DISTINCT idCamping) as "Nombre de campings fréquentés"
FROM Clients c
JOIN Locations l ON c.idClient = l.idClient
JOIN Bungalows b ON l.idBungalow = b.idBungalow
WHERE nomClient = 'Zeblouse' AND prenomClient = 'Agathe';

--R21
SELECT nomBungalow
FROM Bungalows
WHERE superficieBungalow IN (
    SELECT MAX(superficieBungalow)
    FROM Bungalows
);

--R22
SELECT nomEmploye, prenomEmploye
FROM Employes e
JOIN Campings c ON e.idCamping = c.idCamping
WHERE nomCamping = 'Les Flots Bleus' AND salaireEmploye IN(
    SELECT MIN(salaireEmploye)
    FROM Employes e
    JOIN Campings c ON e.idCamping = c.idCamping
    WHERE nomCamping = 'Les Flots Bleus'
);

--R23
SELECT nomBungalow
FROM Bungalows
WHERE idBungalow IN (
    SELECT idBungalow
    FROM Bungalows
    MINUS
    SELECT idBungalow
    FROM Proposer
);
--ou
SELECT nomBungalow
FROM Bungalows
WHERE idBungalow NOT IN (
    SELECT idBungalow
    FROM Proposer
);

--R24
SELECT nomEmploye, prenomEmploye
FROM Employes
WHERE idEmploye IN (
    SELECT idEmploye
    FROM Employes
    MINUS
    SELECT idEmployeChef
    FROM Employes
);

--R25
SELECT nomBungalow
FROM Bungalows
WHERE idBungalow IN (
    SELECT idBungalow
    FROM Bungalows
    MINUS
    SELECT b.idBungalow
    FROM Bungalows b
    JOIN Proposer p ON b.idBungalow = p.idBungalow
    JOIN Services s ON p.idService = s.idService
    WHERE nomService = 'Climatisation' OR nomService = 'TV'
);

--R26
SELECT nomService
FROM Services
WHERE idService IN (
    SELECT idService
    FROM Proposer p
    JOIN Bungalows b ON p.idBungalow = b.idBungalow
    JOIN Campings c ON b.idCamping = c.idCamping
    WHERE nomCamping = 'La Décharge Monochrome'
    INTERSECT
    SELECT idService
    FROM Proposer p
    JOIN Bungalows b ON p.idBungalow = b.idBungalow
    JOIN Campings c ON b.idCamping = c.idCamping
    WHERE nomCamping = 'The White Majestic'
);

--R27
SELECT nomClient, prenomClient
FROM Clients
WHERE idClient IN (
    SELECT idClient
    FROM Locations l
    JOIN Bungalows b ON l.idBungalow = b.idBungalow
    JOIN Campings c ON b.idCamping = c.idCamping
    WHERE nomCamping = 'La Décharge Monochrome' OR nomCamping = 'The White Majestic'
)
ORDER BY nomClient, prenomClient;

--R28
SELECT nomEmploye, prenomEmploye, nomCamping
FROM Employes e
LEFT JOIN Campings c ON e.idCamping = c.idCamping
ORDER BY nomEmploye, prenomEmploye;

--R29
SELECT nomClient, prenomClient
FROM Client c
JOIN Locations l ON c.idClient = l.idClient
JOIN Bungalows b ON l.idBungalow = b.idBungalow
JOIN Campings c ON b.idCamping = c.idCamping
WHERE

--R3A
SELECT nomEmploye, prenomEmploye
FROM Employes
WHERE idEmployeChef IS NULL;

--R3B
SELECT nomBungalow
FROM Bungalows
WHERE idBungalow IN (
    SELECT idBungalow
    FROM Bungalows
    MINUS
    SELECT idBungalow
    FROM Locations
);
--ou
SELECT nomBungalow
FROM Bungalows
WHERE idBungalow NOT IN (
    SELECT idBungalow
    FROM Locations
);
--ou
SELECT nomBungalow
FROM Bungalows b
WHERE NOT EXISTS (
    SELECT *
    FROM Locations l
    WHERE b.idBungalow = l.idBungalow
);

--R30
SELECT nomCamping
FROM Campings c
WHERE NOT EXISTS (
    SELECT *
    FROM Employes e
    WHERE c.idCamping = e.idCamping
);
--ou (ne marche pas car il y a des NULL dans la table Employes)
SELECT nomCamping
FROM Campings
WHERE idCamping NOT IN (
    SELECT idCamping
    FROM Employes
);

--R31
SELECT COUNT(idBungalow) as "Nombre de bungalows"
FROM Bungalows b
WHERE NOT EXISTS (
    SELECT *
    FROM Proposer p
    WHERE b.idBungalow = p.idBungalow
);

--R32
SELECT nomClient
FROM Clients c
WHERE NOT EXISTS (
    SELECT *
    FROM Locations l
    JOIN Bungalows b ON l.idBungalow = b.idBungalow
    WHERE c.idClient = l.idClient
     AND b.superficieBungalow < 58 )
AND idClient IN (
    SELECT idClient
    FROM Locations
);

--R33
SELECT nomCamping
FROM Campings
WHERE idCamping IN (
    SELECT idCamping
    FROM Employes
    MINUS
    SELECT idCamping
    FROM Employes
    WHERE salaireEmploye < 1000
);
--or
SELECT nomCaping
FROM Campings c
WHERE NOT EXISTS (

)















