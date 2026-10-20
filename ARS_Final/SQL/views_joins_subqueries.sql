CREATE OR REPLACE VIEW vw_airman_readiness AS
SELECT
    a.airmanId,
    a.rank,
    a.firstName || ' ' || a.lastName AS airmanName,
    u.unitName,
    p.positionTitle,
    a.deploymentStatus,
    COUNT(at.airmanTrainingId) FILTER (WHERE at.trainingStatus = 'Completed') AS completedTrainingCount
FROM Airman a
INNER JOIN Unit u
    ON a.unitId = u.unitId
INNER JOIN Position p
    ON a.positionId = p.positionId
LEFT JOIN AirmanTraining at
    ON a.airmanId = at.airmanId
GROUP BY
    a.airmanId,
    a.rank,
    a.firstName,
    a.lastName,
    u.unitName,
    p.positionTitle,
    a.deploymentStatus;

SELECT
    a.airmanId AS "Airman ID",
    a.rank AS "Rank",
    a.firstName || ' ' || a.lastName AS "Airman Name",
    u.unitName AS "Unit",
    p.positionTitle AS "Position",
    a.deploymentStatus AS "Deployment Status"
FROM Airman a
INNER JOIN Unit u
    ON a.unitId = u.unitId
INNER JOIN Position p
    ON a.positionId = p.positionId
ORDER BY a.lastName;

SELECT * FROM vw_airman_readiness;

SELECT
    a.airmanId AS "Airman ID",
    a.rank AS "Rank",
    a.firstName || ' ' || a.lastName AS "Airman Name",
    p.positionTitle AS "Position",
    tc.courseName AS "Missing Required Course"
FROM Airman a
INNER JOIN Position p
    ON a.positionId = p.positionId
INNER JOIN ReadinessRequirement rr
    ON p.positionId = rr.positionId
INNER JOIN TrainingCourse tc
    ON rr.courseId = tc.courseId
WHERE rr.isRequired = TRUE
AND rr.courseId NOT IN (
    SELECT ts.courseId
    FROM AirmanTraining at
    INNER JOIN TrainingSession ts
        ON at.sessionId = ts.sessionId
    WHERE at.airmanId = a.airmanId
    AND at.trainingStatus = 'Completed'
)
ORDER BY a.lastName, tc.courseName;

SELECT *
FROM vw_airman_readiness
WHERE completedTrainingCount > (
    SELECT AVG(completedTrainingCount)
    FROM vw_airman_readiness
);
