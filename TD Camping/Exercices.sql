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

--R53
SELECT nomCamping
FROM Campings
WHERE nbEtoilesCamping IN (
    SELECT MAX(nbEtoilesCamping)
    FROM Campings
    WHERE villeCamping = 'Palavas'
)
  AND villeCamping = 'Palavas';

--R54
SELECT nomBungalow
FROM Bungalows
WHERE idBungalow IN (
    SELECT idBungalow
    FROM Proposer p
             JOIN Services s ON p.idService = s.idService
    WHERE nomService = 'Chaine Hi-Fi'
    INTERSECT
    SELECT idBungalow
    FROM Proposer p
             JOIN Services s ON p.idService = s.idService
    WHERE nomService = 'Climatisation'
);

--R55
SELECT nomService
FROM Services s
WHERE NOT EXISTS(
        SELECT *
        FROM Proposer p
                 JOIN Bungalows b ON p.idBungalow = b.idBungalow
                 JOIN Campings c ON b.idCamping = c.idCamping
        WHERE nomCamping = 'The White Majestic'
          AND s.idService = p.idService
    )
   OR categorieService = 'Loisir';

--R56
SELECT nomClient
FROM Clients
WHERE idClient IN (
    SELECT idClient
    FROM Locations l
             JOIN Bungalows b ON l.idBungalow = b.idBungalow
             JOIN Campings c ON b.idCamping = c.idCamping
    WHERE nomCamping = 'La Décharge Monochrome'
);

--R57
SELECT nomBungalow
FROM Bungalows b1
WHERE superficieBungalow IN (
    SELECT MIN(superficieBungalow)
    FROM Bungalows b
    WHERE NOT EXISTS(
            SELECT *
            FROM Locations l
            WHERE b.idBungalow = l.idBungalow
        )
      AND NOT EXISTS(
            SELECT *
            FROM Locations l
            WHERE b1.idBungalow = l.idBungalow
        )
);

--R58
SELECT nomCamping
FROM Campings c
WHERE NOT EXISTS(
        SELECT *
        FROM Bungalows b
        WHERE c.idCamping = b.idCamping
          AND NOT EXISTS(
                SELECT *
                FROM Proposer p
                WHERE b.idBungalow = p.idBungalow
            )
    )
  AND c.idCamping IN (
    SELECT idCamping
    FROM Bungalows
);

-- --R59
-- SELECT nomBungalow, nomService
-- FROM Services s
--          JOIN Proposer p ON s.idService = p.idService
--          JOIN Bungalows b ON p.idBungalow = b.idBungalow
-- WHERE idCamping = 'CAMP1'
--   AND NOT EXISTS(
--     SELECT *
--     FROM Services s1
--              JOIN Proposer p ON s1.idService = p.idService
--              JOIN Bungalows b ON p.idBungalow = b.idBungalow
--     WHERE idCamping = 'CAMP1'
--       AND categorieService = 'Luxe'
--       AND s.idBungalow = s1.idBungalow
--
--       )

--R6A
SELECT categorieService, COUNT(*)
FROM Services
GROUP BY categorieService;

--R6B
SELECT villeClient
FROM Clients
GROUP BY villeClient
HAVING COUNT(*) >= 3;

--R6C
SELECT nomCamping, AVG(salaireEmploye)
FROM Employes e
         JOIN Campings c ON e.idCamping = c.idCamping
GROUP BY nomCamping, c.idCamping;

--R6D
SELECT nomCamping
FROM Campings c
         JOIN Employes e ON c.idCamping = e.idCamping
GROUP BY c.idCamping, nomCamping
HAVING COUNT(*) > 3;

--R60
SELECT nomClient, prenomClient, COUNT(*)
FROM Clients c
         JOIN Locations l ON c.idClient = l.idClient
GROUP BY nomClient, prenomClient, c.idClient
ORDER BY COUNT(*) DESC;

--R61
SELECT nomCamping
FROM Campings c
         JOIN Employes e ON c.idCamping = e.idCamping
GROUP BY c.idCamping, nomCamping
HAVING AVG(salaireEmploye) > 1400;

--R62
SELECT nomClient, prenomClient
FROM Clients c
         JOIN Locations l ON c.idClient = l.idClient
         JOIN Bungalows b ON l.idBungalow = b.idBungalow
GROUP BY nomClient, prenomClient, c.idClient
HAVING COUNT(DISTINCT idCamping) = 2
ORDER BY nomClient, prenomClient;

--R63
SELECT nomBungalow, COUNT(idService)
FROM Bungalows b
         LEFT JOIN Proposer p ON b.idBungalow = p.idBungalow
GROUP BY nomBungalow, b.idBungalow
ORDER BY COUNT(idService) DESC;

--R64
SELECT nomCamping
FROM Campings c
         JOIN Bungalows b ON c.idCamping = b.idCamping
WHERE superficieBungalow < 65
GROUP BY nomCamping, c.idCamping
ORDER BY COUNT(*);

--R65
SELECT nomCamping
FROM Campings c
         JOIN Employes e ON c.idCamping = e.idCamping
GROUP BY nomCamping, c.idCamping
HAVING MIN(salaireEmploye) >= 1000;

--R66
SELECT nomBungalow
FROM Bungalows b
         JOIN Proposer p ON b.idBungalow = p.idBungalow
GROUP BY nomBungalow, b.idBungalow
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM Bungalows b
             JOIN Proposer p ON b.idBungalow = p.idBungalow
    WHERE nomBungalow = 'Le Royal'
);

--R67
SELECT nomBungalow, COUNT(l.idBungalow)
FROM Bungalows b
         LEFT JOIN Locations l ON b.idBungalow = l.idBungalow
         JOIN Campings c ON b.idCamping = c.idCamping
WHERE nomCamping = 'La Décharge Monochrome'
GROUP BY nomBungalow, b.idBungalow
ORDER BY COUNT(*) DESC;

--R68
SELECT nomClient, prenomClient
FROM Clients c
         JOIN Locations l ON c.idClient = l.idClient
GROUP BY nomClient, prenomClient, c.idClient
HAVING COUNT(*) >= 2
   AND AVG(montantLocation) > 1100;

--R69
SELECT nomBungalow
FROM Bungalows b
         JOIN Proposer p ON b.idBungalow = p.idBungalow
GROUP BY nomBungalow, b.idBungalow
HAVING COUNT(*) = ((SELECT MAX(COUNT(*))
                    FROM Bungalows b
                             JOIN Proposer p ON b.idBungalow = p.idBungalow
                    GROUP BY nomBungalow, b.idBungalow);

--R70
SELECT villeCamping, COUNT(*) AS "Nb de campings"
FROM Campings
GROUP BY villeCamping;

--R71
SELECT nomCamping
FROM Campings c
         JOIN Employes e ON c.idCamping = e.idCamping
GROUP BY nomCamping, c.idCamping
HAVING COUNT(*) > 3;

--R72
SELECT nomCamping, COUNT(idEmploye)
FROM Campings c
         LEFT JOIN Employes e ON c.idCamping = e.idCamping
GROUP BY nomCamping, c.idCamping
ORDER BY COUNT(idEmploye) DESC;

--R73
SELECT nomService, COUNT(DISTINCT b.idCamping)
FROM Services s
         LEFT JOIN Proposer p ON s.idService = p.idService
         LEFT JOIN Bungalows b ON p.idBungalow = b.idBungalow
WHERE categorieService = 'Luxe'
GROUP BY nomService, s.idService;

--R74
SELECT nomClient, prenomClient
FROM Clients c
         JOIN Locations l ON c.idClient = l.idClient
GROUP BY nomClient, prenomClient, c.idClient
HAVING COUNT(*) = (
    SELECT MAX(COUNT(*))
    FROM Clients c
             JOIN Locations l ON c.idClient = l.idClient
    GROUP BY nomClient, prenomClient, c.idClient
);

--R80
SELECT nomBungalow
FROM Bungalows
WHERE idBungalow IN (
    SELECT p.idBungalow
    FROM Proposer p
             JOIN Locations l ON p.idBungalow = l.idBungalow
             JOIN Services s ON p.idService = s.idService
    WHERE nomService = 'Kit de Bain'
);

--R81
SELECT nomBungalow
FROM Bungalows b
         JOIN Locations l ON b.idBungalow = l.idBungalow
GROUP BY nomBungalow, b.idBungalow
HAVING COUNT(*) > 4;

--R82
SELECT COUNT(*) AS "Nombre de clients"
FROM Clients c
WHERE NOT EXISTS(
        SELECT *
        FROM Campings camp
        WHERE c.villeClient = camp.villeCamping
    );

--R83
SELECT nomBungalow, COUNT(idService)
FROM Bungalows b
         LEFT JOIN Proposer p ON b.idBungalow = p.idBungalow
         JOIN Campings c ON b.idCamping = c.idCamping
WHERE nomCamping = 'La Décharge Monochrome'
GROUP BY nomBungalow, b.idBungalow;

--84
SELECT nomBungalow
FROM Bungalows b
         JOIN Campings c ON b.idCamping = c.idCamping
WHERE nomCamping = 'Les Flots Bleus'
  AND superficieBungalow = (
    SELECT MIN(superficieBungalow)
    FROM Bungalows b
             JOIN Campings c ON b.idCamping = c.idCamping
    WHERE nomCamping = 'Les Flots Bleus'
);

--R85
SELECT nomBungalow
FROM Bungalows
WHERE idBungalow IN (
    SELECT idBungalow
    FROM Locations
    GROUP BY idBungalow
    HAVING COUNT(*) > 2
    INTERSECT
    SELECT idBungalow
    FROM Proposer
    GROUP BY idBungalow
    HAVING COUNT(*) > 1
);

--R86
SELECT nomBungalow
FROM Bungalows b
WHERE NOT EXISTS(
        SELECT *
        FROM Locations l
        WHERE dateDebut <= '31/08/2017'
          AND dateFin >= '01/08/2017'
          AND b.idBungalow = l.idBungalow
    );

--R87
SELECT chef.nomEmploye
FROM Employes chef
         JOIN Employes sub ON chef.idEmploye = sub.idEmployeChef
GROUP BY chef.nomEmploye, chef.idEmploye
HAVING COUNT(*) > 1;

--R88
SELECT nomClient, prenomClient
FROM Clients c
WHERE NOT EXISTS(
        SELECT *
        FROM Locations l
        WHERE montantLocation <= 1200
          AND c.idClient = l.idClient
    )
  AND c.idClient IN (
    SELECT idClient
    FROM Locations
);

--R89
SELECT nomCamping
FROM Campings c
WHERE NOT EXISTS(
        SELECT *
        FROM Bungalows b
                 JOIN Proposer p ON b.idBungalow = p.idBungalow
        WHERE c.idCamping = b.idCamping
        GROUP BY b.idCamping
        HAVING COUNT(*) > 4
    );

--R90
SELECT nomBungalow
FROM Bungalows b
WHERE superficieBungalow IN (
    SELECT MIN(superficieBungalow)
    FROM Bungalows b
    WHERE NOT EXISTS(
            SELECT *
            FROM Locations l
            WHERE b.idBungalow = l.idBungalow
        )
)
  AND NOT EXISTS(
        SELECT *
        FROM Locations l
        WHERE b.idBungalow = l.idBungalow
    );

--R91 (FAUX)
SELECT nomClient, prenomClient, SUM(montantLocation)
FROM Clients c
         LEFT JOIN Locations l ON c.idClient = l.idClient
WHERE villeClient = 'Paris'
  AND dateDebut <= '31/08/2017'
  AND dateFin >= '01/08/2017'
GROUP BY nomClient, prenomClient, c.idClient;
UNION
SELECT nomClient, prenomClient, SUM(montantLocation)
FROM Clients c
         LEFT JOIN Locations l ON c.idClient = l.idClient
WHERE villeClient = 'Paris'
  AND nomClient != 'Tare'

--R92
SELECT nomCamping, nomEmploye, prenomEmploye
FROM Campings c
         JOIN Employes e ON c.idCamping = e.idCamping
WHERE salaireEmploye IN (
    SELECT MAX(salaireEmploye)
    FROM Employes
)

--R100
SELECT nomBungalow
FROM Bungalows b
WHERE NOT EXISTS(
        SELECT idService
        FROM Services MINUS
        SELECT idService
        FROM Proposer p
        WHERE b.idBungalow = p.idBungalow
    );
--ou
SELECT nomBungalow
FROM Bungalows b
         JOIN Proposer p ON b.idBungalow = p.idBungalow
GROUP BY nomBungalow, b.idBungalow
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM Services
);

--R101
SELECT nomBungalow
FROM Bungalows b
WHERE NOT EXISTS(
        SELECT idService
        FROM Services
        WHERE categorieService = 'Luxe'
        MINUS
        SELECT idService
        FROM Proposer p
        WHERE b.idBungalow = p.idBungalow
    );
--ou
SELECT nomBungalow
FROM Bungalows b
         JOIN Proposer p ON b.idBungalow = p.idBungalow
         JOIN Services s ON p.idService = s.idService
WHERE categorieService = 'Luxe'
GROUP BY nomBungalow, b.idBungalow
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM Services
    WHERE categorieService = 'Luxe'
);

--R102
SELECT nomBungalow
FROM Bungalows b
WHERE NOT EXISTS(
        SELECT s.idService
        FROM Services s
                 JOIN Proposer p ON s.idService = p.idService
                 JOIN Bungalows b ON p.idBungalow = b.idBungalow
        WHERE nomBungalow = 'La Poubelle'
        MINUS
        SELECT p.idService
        FROM Proposer p
        WHERE b.idBungalow = p.idBungalow
    );
--ou
SELECT nomBungalow
FROM Bungalows b
         JOIN Proposer p ON b.idBungalow = p.idBungalow
WHERE idService IN (
    SELECT idService
    FROM Proposer p
             JOIN Bungalows b ON p.idBungalow = b.idBungalow
    WHERE nomBungalow = 'La Poubelle'
)
GROUP BY nomBungalow, b.idBungalow
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM Bungalows b
             JOIN Proposer p ON b.idBungalow = p.idBungalow
    WHERE nomBungalow = 'La Poubelle'
);

--R103
SELECT nomClient
FROM Clients c
         JOIN Locations l ON c.idClient = l.idClient
         JOIN Bungalows b ON l.idBungalow = b.idBungalow
         JOIN Campings camp ON b.idCamping = camp.idCamping
GROUP BY nomClient, c.idClient
HAVING COUNT(DISTINCT villeCamping) = (
    SELECT COUNT(DISTINCT villeCamping)
    FROM Campings
);
--ou
SELECT nomClient
FROM Clients c
WHERE NOT EXISTS(
        SELECT villeCamping
        FROM Campings MINUS
        SELECT villeCamping
        FROM Campings camp
        JOIN Bungalows b ON camp.idCamping = b.idCamping
        JOIN Locations l ON b.idBungalow = l.idBungalow
        WHERE c.idClient = l.idClient
    );

--R104
select nomclient
from clients c
where not exists(
        select l.idbungalow
        from locations l
                 join clients c on l.idclient = c.idclient
        where nomclient = 'Zeblouse'
          and prenomclient = 'Agathe'
        minus
        select l.idbungalow
        from locations l
        where c.idclient = l.idclient);
--ou
select nomclient
from clients c
         join locations l on c.idclient = l.idclient
where idbungalow in (
    select idbungalow
    from locations l
             join clients c on l.idclient = c.idclient
    where nomclient = 'Zeblouse'
      and prenomclient = 'Agathe'
)
group by nomclient, c.idclient
having count(*) =
       (select count(*)
        from locations l
                 join clients c on l.idclient = c.idclient
        where nomclient = 'Zeblouse'
          and prenomclient = 'Agathe');

--R105
select nomclient, prenomclient
from clients c
where not exists(
        select idcamping
        from bungalows b
                 join locations l on b.idbungalow = l.idbungalow
                 join clients c on l.idclient = c.idclient
        where prenomclient = 'Agathe'
          and nomclient = 'Zeblouse'
        minus
        select idcamping
        from bungalows b
        join locations l on b.idbungalow = l.idbungalow
        where c.idclient = l.idclient
    )
  and not exists(
        select idcamping
        from bungalows b
                 join locations l on b.idbungalow = l.idbungalow
        where c.idclient = l.idclient
        minus
        select idcamping
        from bungalows b
        join locations l on b.idbungalow = l.idbungalow
        join clients c on l.idclient = c.idclient
        where prenomclient = 'Agathe' and nomclient = 'Zeblouse'
    );
--ou
select nomclient, prenomclient
from clients c
         join locations l on c.idclient = l.idclient
         join bungalows b on l.idbungalow = b.idbungalow
where not exists(
        select b.idcamping
        from bungalows b
                 join locations l on b.idbungalow = l.idbungalow
        where c.idclient = l.idclient
        minus
        select b.idcamping
        from bungalows b
        join locations l on b.idbungalow = l.idbungalow
        join clients c on l.idclient = c.idclient
        where prenomclient = 'Agathe' and nomclient = 'Zeblouse')
group by nomclient, prenomclient, c.idclient
having count(distinct idcamping) = (
    select count(distinct idcamping)
    from bungalows b
             join locations l on b.idbungalow = l.idbungalow
             join clients c on l.idclient = c.idclient
    where prenomclient = 'Agathe'
      and nomclient = 'Zeblouse');

--R110
select nomservice
from services s
where not exists(
        select idbungalow
        from bungalows
        where superficiebungalow > 60
        minus
        select b.idbungalow
        from bungalows b
        join proposer p on b.idbungalow = p.idbungalow
        where s.idservice = p.idservice);

--R111
select c.idclient, nomclient, prenomclient
from clients c
         join locations l on c.idclient = l.idlocation
         join bungalows b on l.idbungalow = b.idbungalow
         join campings camp on camp.idcamping = b.idbungalow
where not exists(
        select idcamping
        from campings
        where villecamping = 'Palavas'
        minus
        select idcamping
        from campings
        where idcamping = camp.idcamping);

--Vues et Confidentialité de la base de données
--1)
create
or replace view bungalowslfb as
select idbungalow, nombungalow, superficiebungalow
from bungalows b
         join campings c on b.idcamping = c.idcamping
where nomcamping = 'Les Flots Bleus';
--
select count(*)
from bungalowslfb;

--2)
create
or replace view locationslfb as
select idlocation, c.idclient, nomclient, prenomclient, b.idbungalow, nombungalow
from bungalowslfb b
         join locations l on b.idbungalow = l.idbungalow
         join clients c on l.idclient = c.idclient;
--
select idbungalow, nombungalow, count(*)
from locationslfb
group by idbungalow, nombungalow

--3)
create
or replace view employessanscamping as
select idEmploye, nomEmploye, prenomEmploye, salaireEmploye, idEmployeChef
from employes e
where not exists(
        select *
        from campings c
        where e.idcamping = c.idcamping);
-- ° Il est possible d'insérer des lignes dans la table employessanscamping car la clef primaire de la table source
-- est comprise dans la vue.
-- ° Il possible de supprimer/modifier des lignes de la table employessanscamping car elle n'est pas en lecture seule,
-- elle n'a pas de fonctions DISTINCT ou AVG/SUM/MIN et elle n'a pas de GROUP BY, de ORDER BY ou de HAVING.

insert into employessanscamping
values ('E100', 'Stiko', 'Judas', 3000, null);

update employessanscamping
set nomemploye = 'Nana'
where idemploye = 'E100';

delete
from employessanscamping
where idemploye = 'E100';

--4)
create
or replace view employeaveccamping as
select nomEmploye, prenomEmploye, salaireEmploye
from employes e
         join campings c on e.idcamping = c.idcamping;

-- ° Il n'est pas possible d'insérer des lignes dans la table employessanscamping car la clef primaire de la table source
-- n'est pas comprise dans la vue.
-- ° Il possible de supprimer/modifier des lignes de la table employessanscamping car elle n'est pas en lecture seule,
-- elle n'a pas de fonctions DISTINCT ou AVG/SUM/MIN et elle n'a pas de GROUP BY, de ORDER BY ou de HAVING.

insert into employeaveccamping
values ('Nana', 'Stiko', 'Judas', 5000);

update employeaveccamping
set nomemploye = 'Javel'
where prenomemploye = 'Aude';

delete
from employeaveccamping
where prenomemploye = 'Aude';

--5)
create
or replace view clientsparville as
select villeclient, count(*) as nbClients
from clients
group by villeclient;

-- ° Il n'est pas possible d'insérer des lignes dans la table employessanscamping car la clef primaire de la table source
-- n'est pas comprise dans la vue.
-- ° Il possible de supprimer/modifier des lignes de la table employessanscamping car elle a un GROUP BY.

insert into clientsparville
values ('Rodez', 3);

update clientsparville
set villeclients = 'Lunel'
where villeclients = 'Montpellier';

delete from clientsparville
where count(*) = 2;

--6)
create or replace view BungalowsEtCampings as
select idBungalow, nomBungalow, superficieBungalow, b.idCamping, nomCamping
from bungalows b
         join campings c on b.idcamping = c.idcamping;

insert into BungalowsEtCampings
values ( 'B13', 'Le Souterrain', 75, 'CAMP10', 'Yellow Shark');
-- Ce n'est pas possible d'inserer

insert into BungalowsEtCampings
values ( 'B13', 'Le Souterrain', 75, 'CAMP10', 'Yellow Shark');

--1)
set serveroutput on;

declare
v_nbJoueursC1 number;
begin
    select count(*) into v_nbJoueursC1
    from joueurs
    where idclub = 'C1';
    dbms_output.put_line('Il y a ' || v_nbJoueursC1 || ' joueurs dans le club C1');
end;

--2)
accept s_idClub prompt 'Saisir l''identifiant du club';
declare
v_nbJoueurs number;
begin
    select count(*) into v_nbJoueurs
    from joueurs
    where idclub = '&s_idClub';
    dbms_output.put_line(
end;

--3)
accept s_idClub prompt 'Saisir l''identifiant du club';
declare
v_nbJoueurs number;
v_clubExiste number;
begin
    select count(*) into v_clubExiste
    from clubs
    where idClub = '&s_idClub';
    if v_clubExiste > 0 then
        select count(*) into v_nbJoueurs
        from joueurs
        where idClub = '&s_idClub';
        dbms_output.put_line ('Il y a ' || v_nbJoueurs || ' joueurs dans le club ' || '&s_idClub');
    else
        dbms_output.put_line('Le club n''existe pas');
        end if;
end;

--4)
accept s_idClub prompt 'Saisir l''identifiant du club';
declare
v_nbJoueurs number;
v_clubExiste Clubs.idClub%TYPE;
begin
    select idClub into v_clubExiste
    from clubs
    where idClub = '&s_idClub';
    select count(*) into v_nbJoueurs
    from joueurs
    where idClub = '&s_idClub';
    dbms_output.put_line ('Il y a ' || v_nbJoueurs || ' joueurs dans le club ' || '&s_idClub');
exception
    when no_data_found then
        dbms_output.put_line('Le club n''existe pas');
end;

--5)
declare
v_Tournois Tournois%ROWTYPE;
begin
    select * into v_Tournois
    from tournois
    where idTournoi = 'T1';
    dbms_output.put_line ('Identifiant du tournoi : ' || v_Tournois.idTournoi ||
     ' | Nom tournoi : ' || v_Tournois.nomTournoi || ' | Ville tournoi : ' || v_Tournois.lieuTournoi ||
     ' | Nombre de ronde de tournoi : ' || v_Tournois.nbRondesTournoi);
end;

--6)
CREATE OR REPLACE FUNCTION nbJoueursParClub
(p_idClub IN Clubs.idClub%TYPE)
RETURN NUMBER IS
    v_nbJoueurs NUMBER;
    v_idClub Clubs.idClub%TYPE;
BEGIN
SELECT idClub INTO v_idClub
FROM Clubs
WHERE idClub = p_idClub;

SELECT COUNT(*) INTO v_nbJoueurs
FROM Joueurs
WHERE idClub = p_idClub;
RETURN v_nbJoueurs;
EXCEPTION WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;

--7.1)
CREATE OR REPLACE FUNCTION nbJoueursParLigue
(p_idLigue IN Ligues.idLigue%TYPE)
RETURN NUMBER IS
    v_nbJoueurs NUMBER;
BEGIN
SELECT SUM(nbJoueursParClub(idClub)) INTO v_nbJoueurs
FROM Clubs
WHERE idLigue = p_idLigue;

RETURN v_nbJoueurs;
END;

--7.2)
UPDATE Ligues
SET nbJoueursLigue = nbJoueursParLigue(idLigue)

SELECT nbJoueursLigue
FROM Ligues
WHERE nomLigue = 'Languedoc'

--8)
CREATE OR REPLACE PROCEDURE affichageInfosTournoi
(p_idTournoi IN Tournois.idTournoi%TYPE)
IS
    rty_Tournoi Tournois%ROWTYPE;
    v_idTournoi Tournois.idTournoi%TYPE;
BEGIN
SELECT idTournoi INTO v_idTournoi
FROM Tournois
WHERE idTournoi = p_idTournoi;

SELECT * INTO rty_Tournoi
FROM Tournois
WHERE idTournoi = p_idTournoi;

DBMS_OUTPUT.PUT_LINE('Identifiant du tournoi : ' || rty_Tournoi.idTournoi);
    DBMS_OUTPUT.PUT_LINE('Nom du tournoi : ' || rty_Tournoi.nomTournoi);
    DBMS_OUTPUT.PUT_LINE('Lieu du tournoi : ' || rty_Tournoi.lieuTournoi);
    DBMS_OUTPUT.PUT_LINE('Nombre de rondes du tournoi : ' || rty_Tournoi.nbRondesTournoi);
EXCEPTION WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Le tournoi ' || p_idTournoi || ' n''existe pas ');
END;

--9)
CREATE OR REPLACE PROCEDURE miseAJourNbParticipantsTournoi
IS
BEGIN
UPDATE Tournois
SET nbParticipantsTournoi = (SELECT COUNT(*)
                             FROM Participer p
                             WHERE Tournois.idTournoi = p.idTournoi);
END;

--10)
create or replace procedure affichageParticipantsTournoi(p_idTournoi IN Tournois.idTournoi%TYPE) is
    cursor curs_participantsTournoi is
        select nomJoueur, prenomJoueur, eloJoueur
        from Joueurs j
        join Participer p on j.idJoueur = p.idJoueur
        where idTournoi = p_idTournoi
        order by eloJoueur desc, nomJoueur;
    v_idTournoi Tournois.idTournoi%TYPE;
begin
    select idTournoi into v_idTournoi
    from Tournois
    where idTournoi = p_idTournoi;

    for v_ligne in curs_participantsTournoi loop
        dbms_output.put_line(v_ligne.nomJoueur || ' ' || v_ligne.prenomJoueur || ' ' || v_ligne.eloJoueur);
    end loop;

exception when no_data_found then
    dbms_output.put_line('Le tournoi ' || p_idTournoi || ' n''existe pas ');
end;

--11)
create or replace procedure affichageToutTournoi(p_idTournoi IN Tournois.idTournoi%TYPE) is
    v_idTournoi Tournois.idTournoi%TYPE;
begin
    select idTournoi into v_idTournoi
    from Tournois
    where idTournoi = p_idTournoi;

    affichageInfosTournoi(p_idTournoi);
    dbms_output.put_line('Liste des participants :');
    affichageParticipantsTournoi(p_idTournoi);

exception when no_data_found then
    dbms_output.put_line('Le tournoi ' || p_idTournoi || ' n''existe pas ');
end;

--12)
create or replace PROCEDURE affichageJoueursParLigueEtClub(p_idLigue IN Ligues.idLigue%TYPE) is
    v_idLigue Tournois.idTournoi%TYPE;
    cursor curs_clubsLigue is
        select idClub, nomClub
        from Clubs
        where idLigue = p_idLigue
        order by nomClub;

    cursor curs_joueursClub (v_idClub Clubs.idClub%TYPE) is
        select nomJoueur, prenomJoueur, eloJoueur, count(idTournoi) as nombreTournois
        from Joueurs j
        left join Participer p on j.idJoueur = p.idJoueur
        where idClub = v_idClub
        group by j.idJoueur, nomJoueur, prenomJoueur, eloJoueur
        order by nombreTournois desc, eloJoueur desc;
begin
    select idLigue into v_idLigue
    from Ligues
    where idLigue = p_idLigue;

    for v_club in curs_clubsLigue loop
        dbms_output.put_line('Club : ' || v_club.idClub || ' ' || v_club.nomClub || ' ' || '(' || nbJoueursParClub(v_club.idClub) || ' joueurs)');
        for v_joueurClub in curs_joueursClub(v_club.idClub) loop
            dbms_output.put_line('-----> ' || v_joueurClub.nomJoueur || ' ' || v_joueurClub.prenomJoueur || ' ' || v_joueurClub.eloJoueur || ' a participé à ' || v_joueurClub.nombreTournois || ' tournoi(s)');
        end loop;
    end loop;
exception when no_data_found then
    dbms_output.put_line('La ligue ' || p_idLigue || ' n''existe pas ');
end;
