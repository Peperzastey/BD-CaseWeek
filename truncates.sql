-- Use this script to delete all tuples in given Table(s).

TRUNCATE TABLE ATTENDS;

TRUNCATE TABLE CONTACTS;

TRUNCATE TABLE LEADS;

TRUNCATE TABLE WORKSHOPS;

TRUNCATE TABLE STUDENTS;

TRUNCATE TABLE SPEAKERS;

TRUNCATE TABLE PERSONS;

TRUNCATE TABLE LOCAL_COMMITTEES;

TRUNCATE TABLE UNIVERSITIES;

TRUNCATE TABLE COMPANIES;

TRUNCATE TABLE CITIES;

TRUNCATE TABLE DEGREES;

TRUNCATE TABLE ROOM_SETTINGS;

TRUNCATE TABLE ROOM_SIZES;

-- For now, the above statements doesn't work properly.
-- The problem to solve is about enabled references from foreign keys.

-- A little on that matter from Oracle Documentation: https://docs.oracle.com/cd/B28359_01/server.111/b28286/statements_10007.htm#SQLRF01707
/* You cannot truncate the parent table of an enabled foreign key constraint.
   You must disable the constraint before truncating the table.
   An exception is that you can truncate the table if the integrity constraint is self-referential. */
   
   
-- As a temporary solution, use these statements instead:

DELETE FROM ATTENDS WHERE 1=1;

DELETE FROM CONTACTS WHERE 1=1;

DELETE FROM LEADS WHERE 1=1;

DELETE FROM WORKSHOPS WHERE 1=1;

DELETE FROM STUDENTS WHERE 1=1;

DELETE FROM SPEAKERS WHERE 1=1;

DELETE FROM PERSONS WHERE 1=1;

DELETE FROM LOCAL_COMMITTEES WHERE 1=1;

DELETE FROM UNIVERSITIES WHERE 1=1;

DELETE FROM COMPANIES WHERE 1=1;

DELETE FROM CITIES WHERE 1=1;

DELETE FROM DEGREES WHERE 1=1;

DELETE FROM ROOM_SETTINGS WHERE 1=1;

DELETE FROM ROOM_SIZES WHERE 1=1;