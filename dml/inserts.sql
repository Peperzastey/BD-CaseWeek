-- This is an exemplary script for CaseWeek database populating.

INSERT INTO CITIES (CITY_id, CITY_name)
VALUES (1, 'Warszawa');
INSERT INTO CITIES (CITY_id, CITY_name)
VALUES (2, 'Krakow');
INSERT INTO CITIES (CITY_id, CITY_name)
VALUES (3, 'Rzeszow');
INSERT INTO CITIES (CITY_id, CITY_name)
VALUES (4, 'Gdansk');
INSERT INTO CITIES (CITY_id, CITY_name)
VALUES (5, 'Lublin');
COMMIT WORK;											-- end of current transaction

INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (1, 'inz.');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (2, 'mgr');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (3, 'mgr inz.');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (4, 'dr');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (5, 'prof.');
COMMIT WORK;

INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (1, 'Ksztalt U');
INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (2, 'Gniazda');
INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (3, 'Szkolne');
INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (4, 'Bez stolow');
COMMIT WORK;

INSERT INTO ROOM_SIZES (RSZ_type, RSZ_seat_min, RSZ_seat_max)
VALUES ('small', 1, 10);
INSERT INTO ROOM_SIZES (RSZ_type, RSZ_seat_min, RSZ_seat_max)
VALUES ('medium', 11, 30);
INSERT INTO ROOM_SIZES (RSZ_type, RSZ_seat_min, RSZ_seat_max)
VALUES ('large', 31, 90);
COMMIT WORK;

INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (1, 'Politechnika Warszawska', 1);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (2, 'Politechnika Gdanska', 4);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (3, 'Politechnika Lubelska', 5);
COMMIT WORK;

INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (1, 'Deloitte', '21-435 Warszawa', '532654424', 'deloitte@example.com');
INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (2, 'Comarch', '54-321 Warszawa', '532432557', 'comarch@example.com');
INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (3, 'Samsung', '65-234 Warszawa', '543677664', 'samsung@example.com');
COMMIT WORK;


-- Add speakers:

SET TRANSACTION NAME 'ADD_SPEAKER__TOMASZ_KOWAL';		-- begin named transaction
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Tomasz', 'Kowal', '323111510', 't.kowal@example.com');
INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (PERSONS_SEQ.currval, 5, 10, 1, 3);
COMMIT WORK;											-- end of transaction

SET TRANSACTION NAME 'ADD_SPEAKER__FRYDERYK_MALINOWSKI';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Fryderyk', 'Malinowski', '846246432', 'f.malinowski@example.com');
INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (PERSONS_SEQ.currval, 1, 3, null, 2);
COMMIT WORK;

SET TRANSACTION NAME 'ADD_SPEAKER__MARCIN_KULA';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Marcin', 'Kula', '746204542', 'm.kula@example.com');
INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (PERSONS_SEQ.currval, 3, 6, 2, 2);
COMMIT WORK;


-- Add students:

SET TRANSACTION NAME 'ADD_STUDENT__TOMASZ_NOWAK';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Tomasz', 'Nowak', '333222111', 't.nowak@example.com');
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (PERSONS_SEQ.currval, 'EiTI', 3, 'Informatyka', '453643', null, 1);
COMMIT WORK;

SET TRANSACTION NAME 'ADD_STUDENT__MARIUSZ_NALECZ';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Mariusz', 'Nalecz', '374632111', 'm.nalecz@example.com');
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (PERSONS_SEQ.currval, 'EiTI', 3, 'Informatyka', '423123', null, 1);
COMMIT WORK;

SET TRANSACTION NAME 'ADD_STUDENT__KAROL_JANISZEK';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Karol', 'Janiszek', '730385483', 'k.janiszek@example.com');
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (PERSONS_SEQ.currval, 'EiTI', 3, 'Informatyka', '123456', null, 1);
COMMIT WORK;

-- ================

INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (1, '324435466', 'com1@example.com', 1);
INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (2, '854356235', 'com2@example.com', 2);
INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (3, '644325466', 'com3@example.com', 3);
COMMIT WORK;

INSERT INTO CONTACTS (LC_id, COM_id)
VALUES (1, 1);
INSERT INTO CONTACTS (LC_id, COM_id)
VALUES (1, 2);
INSERT INTO CONTACTS (LC_id, COM_id)
VALUES (2, 3);
COMMIT WORK;


-- Add workshops:

INSERT INTO WORKSHOPS (WS_id, WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES (WORKSHOPS_SEQ.nextval, 'Pisanie CV', TO_DATE('21-03-17', 'DD-MM-YY'), 1, 3, 1, 'medium');
COMMIT WORK;

INSERT INTO WORKSHOPS (WS_id, WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES (WORKSHOPS_SEQ.nextval, 'Programowanie w C++', TO_DATE('28-03-17', 'DD-MM-YY'), 4, 2, 2, 'large');
COMMIT WORK;

INSERT INTO WORKSHOPS (WS_id, WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES (WORKSHOPS_SEQ.nextval, 'Bazy danych Oracle', TO_DATE('2-04-17', 'DD-MM-YY'), 3, 1, 3, 'large');
COMMIT WORK;


-- Assign speakers to lead given workshops:
-- NOTE: For this to work, insertions into the PERSONS table must be executed in the order presented in this script,
--       with the sequence in its initial state (initial value = 1, increment = 1) before the first insert  !!!

INSERT INTO LEADS (SPK_id, WS_id)
VALUES (1, 1);
COMMIT WORK;

INSERT INTO LEADS (SPK_id, WS_id)
VALUES (2, 2);
COMMIT WORK;

INSERT INTO LEADS (SPK_id, WS_id)
VALUES (3, 2);
COMMIT WORK;

INSERT INTO LEADS (SPK_id, WS_id)
VALUES (1, 3);
COMMIT WORK;


-- Enroll students for workshops:
-- NOTE: For this to work, insertions into the PERSONS table must be executed in the order presented in this script,
--       with the sequence in state past 3 references to nextval (next value = 4, increment = 1) before the first insert  !!!

INSERT INTO ATTENDS (STUD_ID, WS_ID)
VALUES (4, 2);
COMMIT WORK;

INSERT INTO ATTENDS (STUD_ID, WS_ID)
VALUES (5, 3);
COMMIT WORK;

INSERT INTO ATTENDS (STUD_ID, WS_ID)
VALUES (5, 1);
COMMIT WORK;

INSERT INTO ATTENDS (STUD_ID, WS_ID)
VALUES (6, 2);
COMMIT WORK;
