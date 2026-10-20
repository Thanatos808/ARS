CREATE OR REPLACE FUNCTION getCompletedTrainingCount(selectedAirmanId INT)
RETURNS INT AS $$
DECLARE
    completedCount INT;
BEGIN
    SELECT COUNT(*)
    INTO completedCount
    FROM AirmanTraining
    WHERE airmanId = selectedAirmanId
    AND trainingStatus = 'Completed';

    RETURN completedCount;
END;
$$ LANGUAGE plpgsql;

SELECT getCompletedTrainingCount(1) AS "Completed Training Count";

CREATE OR REPLACE PROCEDURE updateDeploymentStatus(
    selectedAirmanId INT,
    newStatus deployment_status_type
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Airman
    SET deploymentStatus = newStatus
    WHERE airmanId = selectedAirmanId;
END;
$$;

CALL updateDeploymentStatus(2, 'Deployable');

SELECT airmanId, firstName, lastName, deploymentStatus
FROM Airman
WHERE airmanId = 2;

CREATE OR REPLACE FUNCTION updateTrainingTimestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.lastUpdated = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_update_training_timestamp ON AirmanTraining;

CREATE TRIGGER trg_update_training_timestamp
BEFORE UPDATE ON AirmanTraining
FOR EACH ROW
EXECUTE FUNCTION updateTrainingTimestamp();

SELECT airmanTrainingId, trainingStatus, completionDate, lastUpdated
FROM AirmanTraining
WHERE airmanTrainingId = 7;

UPDATE AirmanTraining
SET trainingStatus = 'Completed',
    completionDate = CURRENT_DATE
WHERE airmanTrainingId = 7;

SELECT airmanTrainingId, trainingStatus, completionDate, lastUpdated
FROM AirmanTraining
WHERE airmanTrainingId = 7;
