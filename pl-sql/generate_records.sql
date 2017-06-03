-- Procedure creates up to 200 different students
CREATE OR REPLACE PROCEDURE generate_students (
    howmany number
)
AS 
    surname     VARCHAR2(100 char);
    tel_number  NUMBER(9,0);
    email       VARCHAR2(50 byte);
    study_year  NUMBER(2,0);
    study_major VARCHAR2(100 char);
    study_book  VARCHAR2(20 byte);
    study_uni   NUMBER(3,0);
    ind         NUMBER(4,0);
BEGIN
    study_book := 593999;
    ind := 0;
  
    WHILE ind < howmany LOOP
        surname := 'Student' || PERSONS_SEQ.currval;
        tel_number := 789543000 + PERSONS_SEQ.currval;
        email := PERSONS_SEQ.currval || 'random@student.com';
        study_year := MOD(PERSONS_SEQ.currval, 4) + 1;
        study_major := 'Whatever' || PERSONS_SEQ.currval;
        study_book := 593999 - PERSONS_SEQ.currval;
        study_uni := MOD(PERSONS_SEQ.currval, 9);
        ind := ind + 1;
        add_student('Random', surname, tel_number, email, 'Randomology', study_year, study_major, study_book, study_uni);
		IF ind > 200 THEN
			dbms_output.put_line('Added 200 records, it is enough!');
			EXIT;
		END IF;
        
    END LOOP;
    
END generate_students;
/

-- Procedure creates up to 200 different speakers
CREATE OR REPLACE PROCEDURE generate_speakers (
    howmany number
)
AS 
    surname         VARCHAR2(100 char);
    tel_number      NUMBER(9,0);
    email           VARCHAR2(50 byte);
    deg             NUMBER(2);
    years_of_exp    NUMBER(3);
    uni_graduated   NUMBER(4);
    company         NUMBER(4);
    ind             NUMBER(4,0);
BEGIN
    ind := 0; 
    WHILE ind < howmany LOOP
        surname := 'Speaker' || PERSONS_SEQ.currval;
        tel_number := 719543000 + PERSONS_SEQ.currval;
        email := PERSONS_SEQ.currval || 'random@speaker.com';
        deg := MOD(PERSONS_SEQ.currval, 8);
        years_of_exp := MOD(PERSONS_SEQ.currval, 50);
        company := MOD(PERSONS_SEQ.currval, 6)+1;
        uni_graduated := MOD(PERSONS_SEQ.currval, 9);
        ind := ind + 1;
        add_speaker('Random', surname, tel_number, email,  deg, years_of_exp, uni_graduated, company);
		IF ind > 200 THEN
			dbms_output.put_line('Added 200 records, it is enough!');
			EXIT;
		END IF;       
    END LOOP;   
END generate_speakers;
/


-- Procedure creates up to 200 different workshops
CREATE OR REPLACE PROCEDURE generate_workshops (
    howmany number
)
AS 
    WSname          VARCHAR2(200 char);
    WSdate          VARCHAR2(10 byte);
    WSqty           NUMBER(2);
    WSrs            NUMBER(1);
    WSorg           NUMBER(4);
    WSroom          VARCHAR2(10 char);
    ind             NUMBER(4,0);
BEGIN
    ind := 0;
    WHILE ind < howmany LOOP
        WSname := 'Workshop' || WORKSHOPS_SEQ.currval;
        WSdate := MOD(WORKSHOPS_SEQ.currval, 30)+1 || '-04-17';
        WSqty := MOD(WORKSHOPS_SEQ.currval, 100);
        WSrs := MOD(WORKSHOPS_SEQ.currval, 3);
        WSorg := MOD(WORKSHOPS_SEQ.currval, 6)+1;
        WSroom := 'large';
        ind := ind + 1;
        INSERT INTO WORKSHOPS (WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
        VALUES (WSname, TO_DATE(WSdate, 'DD-MM-YY'), WSqty, WSrs, WSorg, WSroom);
        COMMIT WORK;
		IF ind > 200 THEN
			dbms_output.put_line('Added 200 records, it is enough!');
			EXIT;
		END IF;        
    END LOOP;    
END generate_workshops;
/


-- Procedure enrolls every student for given number of workshops
CREATE OR REPLACE PROCEDURE generate_attendances (
    howmany number
)
AS 
    ind             NUMBER(4,0);
    limiter         NUMBER(4,0);
    CURSOR studs is
        SELECT * FROM STUDENTS stud
        WHERE 1=1;
BEGIN
    limiter := howmany;
    DELETE FROM ATTENDS WHERE 1=1;
    IF (limiter >= 7) THEN
        limiter := 7;    
        dbms_output.put_line('Too big number, changing to 7');
    END IF;      
    FOR curs IN studs LOOP
        ind := 0;
        WHILE ind < limiter LOOP
            INSERT INTO ATTENDS (STUD_ID, WS_ID)
            VALUES (curs.STUD_ID, MOD(curs.STUD_ID+ind, 5)+2);
            COMMIT WORK;
            ind := ind+1;
        END LOOP;
    END LOOP;
END generate_attendances;
/

-- Procedure connects every speaker with chosen number of workshops
CREATE OR REPLACE PROCEDURE generate_leads (
    howmany number
)
AS 
    ind             NUMBER(4,0);
    limiter         NUMBER(4,0);
    CURSOR speaks is
        SELECT * FROM SPEAKERS stud
        WHERE 1=1;
BEGIN
    limiter := howmany;
    DELETE FROM LEADS WHERE 1=1;
    IF (limiter >= 5) THEN
        limiter := 5;    
        dbms_output.put_line('Too big number, changing to 5');
    END IF;      
    FOR curs IN speaks LOOP
        ind := 0;
        WHILE ind < limiter LOOP
            INSERT INTO LEADS (SPK_ID, WS_ID)
            VALUES (curs.SPK_ID, MOD(curs.SPK_ID+ind, 5)+2);
            COMMIT WORK;
            ind := ind+1;
        END LOOP;
    END LOOP;

END generate_leads;
/