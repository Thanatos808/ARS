GRANT SELECT, INSERT, UPDATE, DELETE
ON Airman, AirmanCertification, AirmanTraining, Certification,
DeploymentRecord, Instructor, Position, ReadinessRequirement,
TrainingCourse, TrainingSession, Unit
TO CURRENT_USER;

GRANT EXECUTE
ON FUNCTION getCompletedTrainingCount(INT)
TO CURRENT_USER;

GRANT EXECUTE
ON PROCEDURE updateDeploymentStatus(INT, deployment_status_type)
TO CURRENT_USER;

SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE table_name IN (
    'airman',
    'airmancertification',
    'airmantraining',
    'certification',
    'deploymentrecord',
    'instructor',
    'position',
    'readinessrequirement',
    'trainingcourse',
    'trainingsession',
    'unit'
)
ORDER BY table_name, privilege_type;
