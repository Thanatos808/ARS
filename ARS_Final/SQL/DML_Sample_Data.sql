INSERT INTO Unit VALUES
(1, '325th Fighter Wing', 'Tyndall AFB'),
(2, '325th Operations Group', 'Tyndall AFB'),
(3, '325th Operations Support Squadron', 'Tyndall AFB'),
(4, '95th Fighter Squadron', 'Tyndall AFB');

INSERT INTO Position VALUES
(1, 'Air Traffic Controller', 'Controls and coordinates air traffic.'),
(2, 'Airfield Management Specialist', 'Supports airfield operations and safety.'),
(3, 'Weather Specialist', 'Provides weather support to flight ops.'),
(4, 'Intelligence Analyst', 'Support mission planning and ops intelligence.'),
(5, 'Commander Support Staff', 'Supports administrative and ops readiness functions.');

INSERT INTO Airman VALUES
(1, 'James', 'Carter', 'SrA', 3, 1, 'Deployable'),
(2, 'Maria', 'Lopez', 'A1C', 3, 1, 'Not Deployable'),
(3, 'Ethan', 'Brooks', 'SSgt', 3, 2, 'Deployable'),
(4, 'Olivia', 'Reed', 'SrA', 3, 3, 'Deployed'),
(5, 'Daniel', 'Hayes', 'TSgt', 2, 4, 'Deployable'),
(6, 'Ava', 'Mitchell', 'A1C', 4, 4, 'Not Deployable');

INSERT INTO Instructor VALUES
(1, 'Robert', 'King', 3),
(2, 'Laura', 'Smith', 3),
(3, 'Kevin', 'Anderson', 2);

INSERT INTO TrainingCourse VALUES
(1, 'Cyber Awareness', 'Annual cybersecurity awareness training.', 12),
(2, 'Tower Operations', 'Refresher training for tower control ops.', 12),
(3, 'RAPCON Operations', 'Refresher training for radar approach control ops.', 12),
(4, 'Airfield Driving', 'Required training for operating vehicles on the airfield.', 24),
(5, 'Deployment Readiness', 'Pre-deployment readiness and mobility training.', 12),
(6, 'Weather Operations', 'Refresher training for weather operations support.', 12);

INSERT INTO TrainingSession VALUES
(1, 1, 1, '2026-05-01', 'OSS Training Room'),
(2, 2, 2, '2026-05-03', 'Tower Training Room'),
(3, 3, 2, '2026-05-04', 'RAPCON Simulator Lab'),
(4, 4, 1, '2026-05-05', 'Airfield Management Office'),
(5, 5, 3, '2026-05-10', 'Deployment Processing Center'),
(6, 6, 2, '2026-05-15', 'Weather Ops conference room');

INSERT INTO Certification VALUES
(1, 'ATC Certification', 'Certification for qualified ATC personnel.'),
(2, 'Tower Qualification', 'Qualification for tower control operations.'),
(3, 'RAPCON Qualification', 'Qualification for radar approach control operations.'),
(4, 'Airfield Driver License', 'License for airfield vehicle use.'),
(5, 'Deployment Qualified', 'Certification showing Airman is qualified for deployment.'),
(6, 'Weather Operations Certification', 'Certification for weather operations personnel.');

INSERT INTO ReadinessRequirement VALUES
(1, 1, 1, TRUE),
(2, 1, 2, TRUE),
(3, 1, 3, TRUE),
(4, 1, 5, TRUE),
(5, 2, 1, TRUE),
(6, 2, 4, TRUE),
(7, 2, 5, TRUE),
(8, 3, 1, TRUE),
(9, 3, 6, TRUE),
(10, 3, 5, TRUE),
(11, 4, 1, TRUE),
(12, 4, 5, TRUE),
(13, 5, 1, TRUE),
(14, 5, 5, TRUE);

INSERT INTO AirmanTraining VALUES
(1, 1, 1, 'Completed', '2026-05-01', CURRENT_TIMESTAMP),
(2, 1, 2, 'Completed', '2026-05-03', CURRENT_TIMESTAMP),
(3, 1, 3, 'Completed', '2026-05-04', CURRENT_TIMESTAMP),
(4, 1, 5, 'Completed', '2026-05-10', CURRENT_TIMESTAMP),
(5, 2, 1, 'Completed', '2026-05-01', CURRENT_TIMESTAMP),
(6, 2, 2, 'Completed', '2026-05-03', CURRENT_TIMESTAMP),
(7, 2, 3, 'No Show', NULL, CURRENT_TIMESTAMP),
(8, 3, 1, 'Completed', '2026-05-01', CURRENT_TIMESTAMP),
(9, 3, 4, 'Completed', '2026-05-05', CURRENT_TIMESTAMP),
(10, 4, 1, 'Completed', '2026-05-01', CURRENT_TIMESTAMP),
(11, 4, 6, 'Completed', '2026-05-15', CURRENT_TIMESTAMP),
(12, 5, 1, 'Completed', '2026-05-01', CURRENT_TIMESTAMP),
(13, 5, 5, 'Completed', '2026-05-10', CURRENT_TIMESTAMP),
(14, 6, 1, 'Scheduled', NULL, CURRENT_TIMESTAMP);

INSERT INTO AirmanCertification VALUES
(1, 1, 1, '2026-01-01', '2027-01-01'),
(2, 1, 2, '2026-05-03', '2027-05-03'),
(3, 1, 3, '2026-05-04', '2027-05-04'),
(4, 1, 5, '2026-05-10', '2027-05-10'),
(5, 2, 1, '2026-01-15', '2027-01-15'),
(6, 2, 2, '2026-05-03', '2027-05-03'),
(7, 3, 4, '2026-05-05', '2028-05-05'),
(8, 4, 6, '2026-05-15', '2027-05-15'),
(9, 5, 5, '2026-05-10', '2027-05-10');

INSERT INTO DeploymentRecord VALUES
(1, 4, 'Osan Air Base', '2026-04-01', NULL),
(2, 1, 'Ramstein Air Base', '2025-06-01', '2025-12-01'),
(3, 5, 'Al Udeid Air Base', '2024-03-01', '2024-09-01');
