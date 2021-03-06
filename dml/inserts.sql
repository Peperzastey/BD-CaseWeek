-- This is an exemplary script for CaseWeek database populating.

-- Add cities:

INSERT INTO CITIES (CITY_id, CITY_name)
VALUES (0, 'N/I');
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
INSERT INTO CITIES (CITY_id, CITY_name)
VALUES (6, 'Wroclaw');
INSERT INTO CITIES (CITY_id, CITY_name)
VALUES (8, 'Lodz');
INSERT INTO CITIES (CITY_id, CITY_name)
VALUES (7, 'Szczecin') ;
INSERT INTO CITIES (CITY_id, CITY_name)
VALUES (11, 'Poznan');
COMMIT WORK;							-- end of current transaction


-- Add degrees:

INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (0, 'none');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (1, 'inz.');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (2, 'mgr');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (3, 'mgr inz.');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (4, 'dr');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (5, 'dr inz.');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (6, 'dr hab.');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (7, 'dr hab. inz.');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (8, 'lic.');
INSERT INTO DEGREES (DEG_id, DEG_name)
VALUES (10, 'prof.');
COMMIT WORK;


-- Add room settings:

INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (0, 'Dowolne');
INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (1, 'Ksztalt U');
INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (2, 'Gniazda');
INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (3, 'Szkolne');
INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (4, 'Bez stolow');
COMMIT WORK;


-- Add room sizes:

INSERT INTO ROOM_SIZES (RSZ_type, RSZ_seat_min, RSZ_seat_max)
VALUES ('small', 1, 10);
INSERT INTO ROOM_SIZES (RSZ_type, RSZ_seat_min, RSZ_seat_max)
VALUES ('medium', 11, 30);
INSERT INTO ROOM_SIZES (RSZ_type, RSZ_seat_min, RSZ_seat_max)
VALUES ('large', 31, 90);
COMMIT WORK;


-- Add universities:

INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (0, 'None', 0);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (1, 'Politechnika Warszawska', 1);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (2, 'Politechnika Krakowska', 2);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (3, 'Politechnika Rzeszowska', 3);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (4, 'Politechnika Gdanska', 4);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (5, 'Politechnika Lubelska', 5);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (6, 'Politechnika Lodzka', 8);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (7, 'Uniwersytet Warszawski', 1);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (8, 'Akademia Gorniczo-Hutnicza', 2);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (9, 'Wojskowa Akkdemia Techniczna', 1);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (11, 'Politechnika Poznanska', 11);
COMMIT WORK;


-- Add companies:

INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (1, 'Deloitte', '21-435 Warszawa', '532654424', 'deloitte@example.com');
INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (2, 'Comarch', '54-321 Krakow', '532432557', 'comarch@example.com');
INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (3, 'Samsung', '65-234 Warszawa', '543677664', 'samsung@example.com');
INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (4, 'Igus', '67-564 Piastow', '346947234', 'igus@example.com');
INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (5, 'Oracle', '00-567 Warszawa', '973087123', 'oracle@example.com');
INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (6, 'Comtegra', '30-303 Piaseczno', '188523102', 'comtegra@example.com');
INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (7, 'MI5', '99-007 Londyn', '007007007', 'hq@topsecret.co.uk');
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

SET TRANSACTION NAME 'ADD_SPEAKER__PIOTR_PAN';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Piotr', 'Pan', '675893829', 'jp.100@example.com');
INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (PERSONS_SEQ.currval, 7, 11, 4, 4);
COMMIT WORK;

SET TRANSACTION NAME 'ADD_SPEAKER__JAMES_BOND';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'James', 'Bond', '007007007', 'james.bond@topsecret.co.uk');
INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (PERSONS_SEQ.currval, 10, 55, 2, 7);
COMMIT WORK;

SET TRANSACTION NAME 'ADD_SPEAKER__GALL_ANONIM';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Gall', 'Anonim', '500659302', 'nobody@example.com');
INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (PERSONS_SEQ.currval, 8, 2, 11, 6);
COMMIT WORK;

EXECUTE generate_speakers(200);

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

SET TRANSACTION NAME 'ADD_STUDENT__WIKTOR_TRAKTOR';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Wiktor', 'Traktor', '345958009', 'w.traktor@example.com');
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (PERSONS_SEQ.currval, 'SiMR', 1, 'Mechatronika pojazdow', '584930', 'Ciagniki', 1);
COMMIT WORK; 

SET TRANSACTION NAME 'ADD_STUDENT__JAN_PAN';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Jan', 'Pan', '749347023', 'lubie.dzwony@example.com');
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (PERSONS_SEQ.currval, 'Odlewnictwo', 2, 'Dzwony', '459834', null, 8);
COMMIT WORK; 

SET TRANSACTION NAME 'ADD_STUDENT__TOMASZ_WAS';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Tomasz', 'Was', '506098478', 'noshave@example.com');
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (PERSONS_SEQ.currval, 'Elektryczny', 5, 'Urzadzenia elektryczne', '250987', 'Golarki', 5);
COMMIT WORK; 

EXECUTE generate_students(200);

-- Add LCs:

INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (1, '324435466', 'com1@example.com', 1);
INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (2, '854356235', 'com2@example.com', 2);
INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (3, '644325466', 'com3@example.com', 3);
INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (4, '456875222', 'com4@example.com', 4);
INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (5, '238975433', 'com5@example.com', 5);
COMMIT WORK;


-- Connect LCs with contacted companies:

INSERT INTO CONTACTS (LC_id, COM_id)
VALUES (1, 1);
INSERT INTO CONTACTS (LC_id, COM_id)
VALUES (1, 2);
INSERT INTO CONTACTS (LC_id, COM_id)
VALUES (2, 3); 
INSERT INTO CONTACTS (LC_id, COM_id)
VALUES (2, 4); 
INSERT INTO CONTACTS (LC_id, COM_id)
VALUES (3, 5); 
INSERT INTO CONTACTS (LC_id, COM_id)
VALUES (4, 6); 
INSERT INTO CONTACTS (LC_id, COM_id)
VALUES (1, 7); 
COMMIT WORK; 


-- Add workshops, uses autonumber:

INSERT INTO WORKSHOPS (WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES ('Pisanie CV', TO_DATE('21-03-17', 'DD-MM-YY'), 1, 3, 1, 'medium');
COMMIT WORK;

INSERT INTO WORKSHOPS (WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES ('Programowanie w C++', TO_DATE('28-03-17', 'DD-MM-YY'), 4, 2, 2, 'large');
COMMIT WORK;

INSERT INTO WORKSHOPS (WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES ('Bazy danych Oracle', TO_DATE('2-04-17', 'DD-MM-YY'), 3, 1, 3, 'large');
COMMIT WORK;

INSERT INTO WORKSHOPS (WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES ('Fajne bazy danych', TO_DATE('2-04-19', 'DD-MM-YY'), 35, 0, 5, 'large');
COMMIT WORK;

INSERT INTO WORKSHOPS (WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES ('Bezpieczenstwo sieci i systemow', TO_DATE('2-04-25', 'DD-MM-YY'), 18, 4, 4, 'medium');
COMMIT WORK;

--EXECUTE generate_workshops(200);

-- Assign speakers to lead given workshops:
-- NOTE: For this to work, insertions into the PERSONS table (when inserting into SPEAKERS) must be executed in the order presented in this script,
--       with the sequence in its initial state (initial value = 1, increment = 1) before the first insert  !!!

--INSERT INTO LEADS (SPK_id, WS_id)
--VALUES (1, 1);
--COMMIT WORK;
--
--INSERT INTO LEADS (SPK_id, WS_id)
--VALUES (2, 2);
--COMMIT WORK;
--
--INSERT INTO LEADS (SPK_id, WS_id)
--VALUES (3, 2);
--COMMIT WORK;
--
--INSERT INTO LEADS (SPK_id, WS_id)
--VALUES (1, 3);
--COMMIT WORK;
--
--INSERT INTO LEADS (SPK_id, WS_id)
--VALUES (4, 3);
--COMMIT WORK;
--
--INSERT INTO LEADS (SPK_id, WS_id)
--VALUES (5, 5);
--COMMIT WORK;
--
--INSERT INTO LEADS (SPK_id, WS_id)
--VALUES (6, 4);
--COMMIT WORK;

EXECUTE generate_leads(2);

-- Enroll students for workshops:
-- NOTE: For this to work, insertions into the PERSONS table (when inserting into STUDENTS) must be executed in the order presented in this script,
--       with the sequence in state past 6 references to nextval (next value = 7, increment = 1) before the first insert  !!!

--INSERT INTO ATTENDS (STUD_ID, WS_ID)
--VALUES (7, 2);
--COMMIT WORK;
--
--INSERT INTO ATTENDS (STUD_ID, WS_ID)
--VALUES (7, 3);
--COMMIT WORK;
--
--INSERT INTO ATTENDS (STUD_ID, WS_ID)
--VALUES (8, 1);
--COMMIT WORK;
--
--INSERT INTO ATTENDS (STUD_ID, WS_ID)
--VALUES (9, 2);
--COMMIT WORK;
--
--INSERT INTO ATTENDS (STUD_ID, WS_ID)
--VALUES (10, 5);
--COMMIT WORK;
--
--INSERT INTO ATTENDS (STUD_ID, WS_ID)
--VALUES (11, 5);
--COMMIT WORK;
--
--INSERT INTO ATTENDS (STUD_ID, WS_ID)
--VALUES (12, 4);
--COMMIT WORK;
--
--INSERT INTO ATTENDS (STUD_ID, WS_ID)
--VALUES (11, 3);
--COMMIT WORK;

EXECUTE generate_attendances(3);