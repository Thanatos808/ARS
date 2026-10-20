DROP TABLE IF EXISTS DeploymentRecord CASCADE;
DROP TABLE IF EXISTS AirmanCertification CASCADE;
DROP TABLE IF EXISTS AirmanTraining CASCADE;
DROP TABLE IF EXISTS ReadinessRequirement CASCADE;
DROP TABLE IF EXISTS TrainingSession CASCADE;
DROP TABLE IF EXISTS Certification CASCADE;
DROP TABLE IF EXISTS TrainingCourse CASCADE;
DROP TABLE IF EXISTS Instructor CASCADE;
DROP TABLE IF EXISTS Airman CASCADE;
DROP TABLE IF EXISTS Position CASCADE;
DROP TABLE IF EXISTS Unit CASCADE;

DROP TYPE IF EXISTS training_status_type CASCADE;
DROP TYPE IF EXISTS deployment_status_type CASCADE;

CREATE TYPE training_status_type AS ENUM ('Scheduled', 'Completed', 'Failed', 'No Show');
CREATE TYPE deployment_status_type AS ENUM ('Deployable', 'Not Deployable', 'Deployed');

CREATE TABLE Unit (
	unitId INT PRIMARY KEY,
	unitName VARCHAR(100) NOT NULL,
	location VARCHAR(100) NOT NULL
);

CREATE TABLE Position (
	positionId INT PRIMARY KEY,
	positionTitle VARCHAR(100) NOT NULL,
	positionDescription TEXT
);

CREATE TABLE Airman (
	airmanId INT PRIMARY KEY,
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	rank VARCHAR(20) NOT NULL,
	unitId INT NOT NULL,
	positionId INT NOT NULL,
	deploymentStatus deployment_status_type NOT NULL DEFAULT 'Not Deployable',
	CONSTRAINT fk_airman_unit
		FOREIGN KEY (unitId) REFERENCES Unit(unitId),
	CONSTRAINT fk_airman_position
		FOREIGN KEY (positionId) REFERENCES Position(positionId)
);

CREATE TABLE Instructor (
	instructorId INT PRIMARY KEY,
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	unitId INT NOT NULL,
	CONSTRAINT fk_instructor_unit
		FOREIGN KEY (unitId) REFERENCES Unit(unitId)
);

CREATE TABLE TrainingCourse (
	courseId INT PRIMARY KEY,
	courseName VARCHAR(100) NOT NULL,
	courseDescription TEXT,
	expirationMonths INT CHECK (expirationMonths >= 0)
);

CREATE TABLE TrainingSession (
	sessionId INT PRIMARY KEY,
	courseId INT NOT NULL,
	instructorId INT NOT NULL,
	sessionDate DATE NOT NULL,
	location VARCHAR(100) NOT NULL,
	CONSTRAINT fk_session_course
		FOREIGN KEY (courseId) REFERENCES TrainingCourse(courseId),
	CONSTRAINT fk_session_instructor
		FOREIGN KEY (instructorId) REFERENCES Instructor(instructorId)
);

CREATE TABLE Certification (
	certificationId INT PRIMARY KEY,
	certificationName VARCHAR(100) NOT NULL,
	certificationDescription TEXT
);

CREATE TABLE ReadinessRequirement (
	requirementId INT PRIMARY KEY,
	positionId INT NOT NULL,
	courseId INT NOT NULL,
	isRequired BOOLEAN NOT NULL DEFAULT TRUE,
	CONSTRAINT fk_requirement_position
		FOREIGN KEY (positionId) REFERENCES Position(positionId),
	CONSTRAINT fk_requirement_course
		FOREIGN KEY (courseId) REFERENCES TrainingCourse(courseId)
);

CREATE TABLE AirmanTraining (
	airmanTrainingId INT PRIMARY KEY,
	airmanId INT NOT NULL,
	sessionId INT NOT NULL,
	trainingStatus training_status_type NOT NULL,
	completionDate DATE,
	lastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_airmantraining_airman
		FOREIGN KEY (airmanId) REFERENCES Airman(airmanId),
	CONSTRAINT fk_airmantraining_session
		FOREIGN KEY (sessionId) REFERENCES TrainingSession(sessionId)
);

CREATE TABLE AirmanCertification (
	airmanCertificationId INT PRIMARY KEY,
	airmanId INT NOT NULL,
	certificationId INT NOT NULL,
	issueDate DATE NOT NULL,
	expirationDate DATE,
	CONSTRAINT fk_airmancert_airman
		FOREIGN KEY (airmanId) REFERENCES Airman(airmanId),
	CONSTRAINT fk_airmancert_certification
		FOREIGN KEY (certificationId) REFERENCES Certification(certificationId)
);

CREATE TABLE DeploymentRecord (
	deploymentId INT PRIMARY KEY,
	airmanId INT NOT NULL,
	deploymentLocation VARCHAR(100) NOT NULL,
	startDate DATE NOT NULL,
	endDate DATE,
	CONSTRAINT fk_deployment_airman
		FOREIGN KEY (airmanId) REFERENCES Airman(airmanId)
);
