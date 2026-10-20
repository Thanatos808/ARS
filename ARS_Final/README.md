# Airman Readiness System Final Project

## Overview
The ARS is a PSQL database project designed to The Airman Readiness System is a PostgreSQL database project designed to track military readiness information for a simplified unit structure based around the 325th Fighter Wing, 325th Operations Group, and 325th Operations Support Squadron at Tyndall AFB.

The system stores and reports information about Airmen, units, positions, training courses, training sessions, certifications, readiness requirements, and deployment records. The goal is to demonstrate a working relational database system using PostgreSQL concepts covered throughout the semester.

## Contents
- SQL scripts used to create and populate the database
- SQL scripts demonstrating viiews, joins, subqueries, functions, procedures, triggers, transactions, and security
- screenshots showing successful script execution and query output
- A Python Tkinter user interface file
- Supporting documentation including the ERD and data dictionary, 

## How to run the SQL scripts

The SQL scripts should be run in PostgreSQL/PSQL in the following order:

```sql
\i DDL_Create_Tables.sql
\i DML_Sample_Data.sql
\i views_joins_subqueries
\i functions_procedures_triggers.sql
\i transactions.sql
\i security.sql
```
To run the user interface first install the PostgreSQL Python connector:

python -m pip install psycopg2-binary

Then run:
python ars_ui.py

## UI connection note

The Python Tkinter interface was created to serve as a front-end tool for the PSQL backend. The interface opens successfully, prompts for database login information, and includes buttons for 
Airman readiness, missing required training, training records, certification records, and deployment records.

When tested from a local Windows computer, the school PSQL server timed out on port 5432. This indicated that direct PSQL connection from outside the school Linux/PuTTY environment are blocked. The PSQL backend and SQL queries were verified separately through PuTTY/PSQL screenshots included in the submission.

Because of this server access limitation, the UI source code is included to demonstrate the front-end implementation and intended SQL backend integration, while the screenshots from PSQL demonstrate that the database and queries work correctly on the school server.
