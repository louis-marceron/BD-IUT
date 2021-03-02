--R11
SELECT nomEmploye, prenomEmploye
FROM Employes
WHERE salaireEmploye > 2000;

--R12
SELECT nomCamping
FROM Campings
WHERE villeCamping = 'Palavas'
  AND nbEtoilesCamping = 5;

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
WHERE chef.prenomEmploye = 'Gaspard'
  AND chef.nomEmploye = 'Alizan';

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
WHERE nomClient = 'Zeblouse'
  AND prenomClient = 'Agathe';

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
WHERE nomCamping = 'Les Flots Bleus'
  AND salaireEmploye IN (
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
    FROM Bungalows MINUS
SELECT idBungalow
FROM Proposer );
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
    FROM Employes MINUS
SELECT idEmployeChef
FROM Employes );

--R25
SELECT nomBungalow
FROM Bungalows
WHERE idBungalow IN (
    SELECT idBungalow
    FROM Bungalows MINUS
SELECT b.idBungalow
FROM Bungalows b
         JOIN Proposer p ON b.idBungalow = p.idBungalow
         JOIN Services s ON p.idService = s.idService
WHERE nomService = 'Climatisation'
   OR nomService = 'TV' );

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
    WHERE nomCamping = 'La Décharge Monochrome'
       OR nomCamping = 'The White Majestic'
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
WHERE;

--R3A
SELECT nomEmploye, prenomEmploye
FROM Employes
WHERE idEmployeChef IS NULL;

--R3B
SELECT nomBungalow
FROM Bungalows
WHERE idBungalow IN (
    SELECT idBungalow
    FROM Bungalows MINUS
SELECT idBungalow
FROM Locations );
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
WHERE NOT EXISTS(
        SELECT *
        FROM Locations l
        WHERE b.idBungalow = l.idBungalow
    );

--R30
SELECT nomCamping
FROM Campings c
WHERE NOT EXISTS(
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
WHERE NOT EXISTS(
        SELECT *
        FROM Proposer p
        WHERE b.idBungalow = p.idBungalow
    );

--R32
SELECT nomClient
FROM Clients c
WHERE NOT EXISTS(
        SELECT *
        FROM Locations l
                 JOIN Bungalows b ON l.idBungalow = b.idBungalow
        WHERE c.idClient = l.idClient
          AND b.superficieBungalow < 58)
  AND idClient IN (
    SELECT idClient
    FROM Locations
);

--R33
SELECT nomCamping
FROM Campings
WHERE idCamping IN (
    SELECT idCamping
    FROM Employes MINUS
SELECT idCamping
FROM Employes
WHERE salaireEmploye < 1000 );
--or
SELECT nomCamping
FROM Campings c
WHERE NOT EXISTS(
        SELECT *
        FROM Campings c2
                 JOIN Employes e ON c2.idCamping = e.idCamping
        WHERE c.idCamping = c2.idCamping
          AND e.salaireEmploye < 1000
    )
  AND idCamping IN (
    SELECT idCamping
    FROM Employes
);

--R34
SELECT nomClient
FROM Clients c
WHERE villeClient = 'Montpellier'
  AND NOT EXISTS(
        SELECT *
        FROM Locations l
        WHERE c.idClient = l.idClient
          AND NOT EXISTS(
                SELECT *
                FROM Proposer p
                WHERE l.idBungalow = p.idBungalow
            )
    );

--R40
SELECT DISTINCT c.idClient, nomClient, prenomClient
FROM Clients c
         JOIN Locations l ON c.idClient = l.idClient
         JOIN Bungalows b ON l.idBungalow = b.idBungalow
         JOIN Campings camp ON b.idCamping = camp.idCamping
WHERE villeClient = villeCamping;

--R41
SELECT nomClient, prenomClient
FROM Clients c
WHERE NOT EXISTS(
        SELECT idClient
        FROM Locations l
                 JOIN Bungalows b ON l.idBungalow = b.idBungalow
                 JOIN Campings c ON b.idCamping = c.idCamping
        WHERE nomCamping = 'Les Flots Bleus'
          AND c.idClient = l.idClient
    );

--R42
SELECT COUNT(*)
FROM Clients c
         JOIN Locations l ON c.idClient = l.idClient
         JOIN Bungalows b ON l.idBungalow = b.idBungalow
         JOIN Campings camp ON b.idCamping = camp.idCamping
WHERE nomCamping = 'La Décharge Monochrome'
  AND nomClient = 'Zeblouse'
  AND prenomClient = 'Agathe';

--R43
SELECT sub.nomEmploye, sub.prenomEmploye, NVL(chef.nomEmploye, 'Pas de chef')
FROM Employes sub
         LEFT JOIN Employes chef ON sub.idEmployeChef = chef.idEmploye
ORDER BY sub.nomEmploye;

--R44
SELECT nomBungalow
FROM Bungalows b
WHERE NOT EXISTS(
        SELECT *
        FROM Proposer p
                 JOIN Services s ON p.idService = s.idService
        WHERE b.idBungalow = p.idBungalow
          AND categorieService = 'Loisir'
    );

--R45
SELECT idLocation
FROM Locations l
         JOIN Bungalows b ON l.idBungalow = b.idBungalow
         JOIN Campings c ON b.idCamping = c.idCamping
WHERE (dateFin - dateDebut) IN (
    SELECT MAX(dateFin - dateDebut)
    FROM Locations l
             JOIN Bungalows b ON l.idBungalow = b.idBungalow
             JOIN Campings c ON b.idCamping = c.idCamping
    WHERE nomCamping = 'The White Majestic')
  AND nomCamping = 'The White Majestic';

--R46
SELECT DISTINCT VilleClient
FROM Clients c
WHERE NOT EXISTS(
        SELECT *
        FROM Campings camp
        WHERE c.VilleClient = camp.VilleCamping
    );

--R47
SELECT nomClient, prenomClient
FROM Clients c
         JOIN Locations l ON c.idClient = l.idClient
WHERE dateFin IN (
    SELECT MAX(dateFin)
    FROM Locations l
             JOIN Bungalows b ON l.idBungalow = b.idBungalow
    WHERE nomBungalow = 'La Poubelle'
);

--R48
SELECT nomClient, prenomClient
FROM Clients c1
WHERE NOT EXISTS(
        SELECT c2.idClient
        FROM Clients c2
                 JOIN Locations l ON c2.idClient = l.idClient
        WHERE (dateFin - dateDebut) < 10
          AND c1.idClient = c2.idClient
    )
  AND idClient IN (
    SELECT idClient
    FROM Locations
)
;

--R49
SELECT nomClient, prenomClient
FROM Clients
WHERE idClient IN (
    SELECT idClient
    FROM Locations l
             JOIN Bungalows b ON l.idBungalow = b.idBungalow
             JOIN Campings c ON b.idCamping = c.idCamping
    WHERE nomCamping = 'La Décharge Monochrome'
       OR nomCamping = 'Les Flots Bleus'
    MINUS
    (
    SELECT idClient
    FROM Locations l
    JOIN Bungalows b ON l.idBungalow = b.idBungalow
    JOIN Campings c ON b.idCamping = c.idCamping
    WHERE nomCamping = 'La Décharge Monochrome'
    INTERSECT
    SELECT idClient
    FROM Locations l
    JOIN Bungalows b ON l.idBungalow = b.idBungalow
    JOIN Campings c ON b.idCamping = c.idCamping
    WHERE nomCamping = 'Les Flots Bleus'
    )
    );

--R35
SELECT nomClient, prenomClient
FROM Clients
WHERE idClient NOT IN (
    SELECT idClient
    FROM Locations
);
--ou
SELECT nomClient, prenomClient
FROM Clients
WHERE idClient IN (
    SELECT idClient
    FROM Clients MINUS
SELECT idClient
FROM Locations );
--or
SELECT nomClient, prenomClient
FROM Clients c
WHERE NOT EXISTS(
        SELECT *
        FROM Locations l
        WHERE c.idClient = l.idClient
    );

--R36
SELECT nomCamping
FROM Campings c
WHERE NOT EXISTS(
        SELECT *
        FROM Bungalows b
        WHERE c.idCamping = b.idCamping
          AND superficieBungalow > 50
    );

--R37
SELECT COUNT(*) AS "Nb clients"
FROM Clients c
WHERE NOT EXISTS(
        SELECT *
        FROM Locations l
        WHERE montantLocation >= 990
          AND c.idClient = l.idClient
    )
  AND idClient IN (
    SELECT idClient
    FROM Locations
);

--38
SELECT nomClient
FROM Clients c
WHERE prenomClient LIKE 'J%'
  AND NOT EXISTS(
        SELECT *
        FROM Campings camp
        WHERE c.villeClient = camp.villeCamping
    );

--R39
SELECT DISTINCT categorieService
FROM Services s1
WHERE NOT EXISTS(
        SELECT *
        FROM Services s2
                 JOIN Proposer p ON s2.idService = p.idService
                 JOIN Bungalows b ON p.idBungalow = b.idBungalow
                 JOIN Campings c ON b.idCamping = c.idCamping
        WHERE nomCamping = 'La Décharge Monochrome'
          AND s1.categorieService = s2.categorieService
    );
--ou
SELECT DISTINCT categorieService
FROM Services
WHERE categorieService IN (
    SELECT categorieService
    FROM Services MINUS
SELECT categorieService
FROM Services s
         JOIN Proposer p ON s.idService = p.idService
         JOIN Bungalows b ON p.idBungalow = b.idBungalow
         JOIN Campings c ON b.idCamping = c.idCamping
WHERE nomCamping = 'La Décharge Monochrome' );

--R50
SELECT nomEmploye
FROM Employes e
WHERE idCamping IS NULL;

--R51
SELECT nomEmploye, prenomEmploye
FROM Employes
WHERE idEmploye IN (
    SELECT idEmployeChef
    FROM Employes
    WHERE idEmploye IN (
        SELECT idEmployeChef
        FROM Employes
    )
)

--R52
SELECT DISTINCT nomService
FROM Services s
WHERE NOT EXISTS(
        SELECT *
        FROM Proposer p
                 JOIN Bungalows b ON p.idBungalow = b.idBungalow
        WHERE superficieBungalow > 60
          AND s.idService = p.idService
    );








