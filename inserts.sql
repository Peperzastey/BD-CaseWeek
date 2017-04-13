INSERT INTO CITIES (CITIES_id, CITIES_name)
VALUES (1, 'Warszawa');
INSERT INTO CITIES (CITIES_id, CITIES_name)
VALUES (2, 'Krakow');
INSERT INTO CITIES (CITIES_id, CITIES_name)
VALUES (3, 'Rzeszow');
INSERT INTO CITIES (CITIES_id, CITIES_name)
VALUES (4, 'Gdansk');
INSERT INTO CITIES (CITIES_id, CITIES_name)
VALUES (5, 'Lublin');

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

INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (1, 'Ksztalt U');
INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (2, 'Gniazda');
INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (3, 'Szkolne');
INSERT INTO ROOM_SETTINGS (RS_id, RS_type)
VALUES (4, 'Bez stolow');

INSERT INTO ROOM_SIZES (RSZ_type, RSZ_seat_min, RSZ_seat_max)
VALUES ('small', 1, 10);
INSERT INTO ROOM_SIZES (RSZ_type, RSZ_seat_min, RSZ_seat_max)
VALUES ('medium', 11, 30);
INSERT INTO ROOM_SIZES (RSZ_type, RSZ_seat_min, RSZ_seat_max)
VALUES ('large', 31, 90);

INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (1, 'Politechnika Warszawska', 1);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (2, 'Politechnika Gdanska', 4);
INSERT INTO UNIVERSITIES (UNI_id, UNI_name, UNI_city)
VALUES (3, 'Politechnika Lubelska', 5);

INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Tomasz', 'Nowak', '333222111', 't.nowak@example.com');
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Tomasz', 'Kowal', '323111510', 't.kowal@example.com');
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Mariusz', 'Nalecz', '374632111', 'm.nalecz@example.com');
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Karol', 'Janiszek', '730385483', 'k.janiszek@example.com');
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Marcin', 'Kula', '746204542', 'm.kula@example.com');
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Fryderyk', 'Malinowski', '846246432', 'f.malinowski@example.com');

INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (1, 'EiTI', 3, 'Informatyka', '453643', null, 1);
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (3, 'EiTI', 3, 'Informatyka', '423123', null, 1);
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (6, 'EiTI', 3, 'Informatyka', '123456', null, 1);

INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (1, 'Deloitte', '21-435 Warszawa', '532654424', 'deloitte@example.com');
INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (2, 'Comarch', '54-321 Warszawa', '532432557', 'comarch@example.com');
INSERT INTO COMPANIES (COM_id, COM_name, COM_address, COM_tel, COM_email)
VALUES (3, 'Samsung', '65-234 Warszawa', '543677664', 'samsung@example.com');

INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (2, 5, 10, null, 3);
INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (4, 1, 3, null, 2);
INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (5, 3, 6, null, 2);

INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (1, '324435466', 'com1@example.com', 1);
INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (2, '854356235', 'com2@example.com', 2);
INSERT INTO LOCAL_COMMITTEES (LC_id, LC_tel, LC_email, LC_uni)
VALUES (3, '644325466', 'com3@example.com', 3);

INSERT INTO WORKSHOPS (WS_id, WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES (1, 'Pisanie CV', TO_DATE('21-03-17', 'DD-MM-YY'), 1, 3, 1, 'medium');
INSERT INTO WORKSHOPS (WS_id, WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES (2, 'Programowanie w C++', TO_DATE('28-03-17', 'DD-MM-YY'), 4, 2, 2, 'large');
INSERT INTO WORKSHOPS (WS_id, WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
VALUES (3, 'Bazy danych Oracle', TO_DATE('2-04-17', 'DD-MM-YY'), 3, 1, 3, 'large');

INSERT INTO ATTENDS (STUD_ID, WS_ID)
VALUES (1, 2);
INSERT INTO ATTENDS (STUD_ID, WS_ID)
VALUES (1, 3);
INSERT INTO ATTENDS (STUD_ID, WS_ID)
VALUES (3, 2);