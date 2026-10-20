BEGIN;

SELECT airmanId, firstName, lastName, deploymentStatus
FROM Airman
WHERE airmanId = 6;

UPDATE Airman
SET deploymentStatus = 'Deployable'
WHERE airmanId = 6;

INSERT INTO AirmanCertification
VALUES
(10, 6, 5, CURRENT_DATE, CURRENT_DATE + INTERVAL '12 months');

COMMIT;

SELECT airmanId, firstName, lastName, deploymentStatus
FROM Airman
WHERE airmanId = 6;

SELECT *
FROM AirmanCertification
WHERE airmanId = 6;
