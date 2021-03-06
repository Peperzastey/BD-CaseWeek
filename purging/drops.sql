-- Triggers:

DROP TRIGGER PERSONS_AUTONR_TRG;

DROP TRIGGER WORKSHOPS_AUTONR_TRG;

DROP TRIGGER PERSONS_TEL_CONVERT_TRG;

DROP TRIGGER COMPANIES_TEL_CONVERT_TRG;

DROP TRIGGER LC_TEL_CONVERT_TRG;

-- DROP PACKAGE CASEWEEK;   -- drop both the body and specification of the package


-- Procedures:

DROP PROCEDURE CONVERT_TEL;

DROP PROCEDURE ADD_STUDENT;

DROP PROCEDURE ADD_SPEAKER;

DROP PROCEDURE ADD_PERSON;

DROP PROCEDURE GENERATE_STUDENTS;

DROP PROCEDURE GENERATE_SPEAKERS;

DROP PROCEDURE GENERATE_WORKSHOPS;

DROP PROCEDURE GENERATE_ATTENDANCES;

DROP PROCEDURE GENERATE_LEADS;

DROP PROCEDURE GET_WS_LOGISTICS_INFO;

DROP PROCEDURE GET_WS_PARTICIPANTS;

-- Functions:

DROP FUNCTION WS_PART_NUMBER;

-- Tables:

DROP TABLE ATTENDS;

DROP TABLE CONTACTS;

DROP TABLE LEADS;

DROP TABLE WORKSHOPS;

DROP TABLE STUDENTS;

DROP TABLE SPEAKERS;

DROP TABLE PERSONS;

DROP TABLE LOCAL_COMMITTEES;

DROP TABLE UNIVERSITIES;

DROP TABLE COMPANIES;

DROP TABLE CITIES;

DROP TABLE DEGREES;

DROP TABLE ROOM_SETTINGS;

DROP TABLE ROOM_SIZES;


-- Sequences:

DROP SEQUENCE PERSONS_SEQ;

DROP SEQUENCE WORKSHOPS_SEQ;


-- Views:

DROP VIEW V_STUDENTS_DATA;

DROP VIEW V_EXPERIENCED_WORKSHOP_LEADERS;

DROP VIEW V_ROOM_LIMITS;
