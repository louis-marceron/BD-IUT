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















