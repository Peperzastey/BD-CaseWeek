-- Tables:

CREATE TABLE CITIES (
	CITY_id				NUMBER (3) NOT NULL,
	CITY_name			VARCHAR2 (100 CHAR) NOT NULL,
	
	CONSTRAINT CITIES_PK PRIMARY KEY (CITY_id)
);

CREATE TABLE ROOM_SIZES (
	RSZ_type			VARCHAR2 (10 BYTE) NOT NULL,
	RSZ_seat_min		NUMBER (3) NOT NULL,
	RSZ_seat_max		NUMBER (3) NOT NULL,
	
	CONSTRAINT ROOM_SIZES_PK PRIMARY KEY (RSZ_type),
    
    -- check constraints
    CONSTRAINT ROOM_SIZES_CHK CHECK (RSZ_seat_min > 0 AND RSZ_seat_max >= RSZ_seat_min)
);

CREATE TABLE ROOM_SETTINGS (
	RS_id				NUMBER (2) NOT NULL,
	RS_type				VARCHAR2 (50 CHAR) UNIQUE NOT NULL,
	
	CONSTRAINT ROOM_SETTINGS_PK PRIMARY KEY (RS_id)
);

CREATE TABLE DEGREES (
	DEG_id				NUMBER (2) NOT NULL,
	DEG_name			VARCHAR2 (50) NOT NULL,
	
	CONSTRAINT DEGREES_PK PRIMARY KEY (DEG_id)
);

CREATE TABLE COMPANIES (
	COM_id				NUMBER (4) NOT NULL,
	COM_name			VARCHAR2 (100 BYTE) NOT NULL,
	COM_address			VARCHAR2 (100 CHAR) NOT NULL,
	COM_tel				VARCHAR2 (20 BYTE) UNIQUE NOT NULL,
	COM_email			VARCHAR2 (50 BYTE) UNIQUE NOT NULL,
	
	CONSTRAINT COMPANIES_PK PRIMARY KEY (COM_id),
    
    -- check constraints
    CONSTRAINT COMPANIES_TEL_CHK   CHECK (REGEXP_LIKE(COM_tel, '^[[:digit:]]{9}$')),  -- 9 digits
    CONSTRAINT COMPANIES_EMAIL_CHK CHECK (COM_email LIKE '%@%')
);

CREATE TABLE PERSONS (
	P_id				NUMBER NOT NULL,
	P_name				VARCHAR2 (100 CHAR) NOT NULL,
	P_surname			VARCHAR2 (100 CHAR) NOT NULL,
	P_tel				VARCHAR2 (20 BYTE) UNIQUE NOT NULL,
	P_email				VARCHAR2 (50 BYTE) UNIQUE NOT NULL,
	
	CONSTRAINT PERSONS_PK PRIMARY KEY (P_id),
    
    -- check constraints
    CONSTRAINT PERSONS_TEL_CHK   CHECK (REGEXP_LIKE(P_tel, '^[[:digit:]]{9}$')),  -- 9 digits
    CONSTRAINT PERSONS_EMAIL_CHK CHECK (P_email LIKE '%@%')                       -- any string containing the '@' character
);

CREATE TABLE UNIVERSITIES (
	UNI_id				NUMBER (3) NOT NULL,
	UNI_name			VARCHAR2 (100 CHAR) NOT NULL,
	UNI_city			NUMBER (3) NOT NULL,
	
	CONSTRAINT UNIVERSITIES_PK PRIMARY KEY (UNI_id),
	CONSTRAINT UNIVERSITIES_CITIES_FK FOREIGN KEY (UNI_city) REFERENCES CITIES (CITY_id) ON DELETE SET NULL -- [?] CASCADE (attrib is NOT NULL)
);

CREATE TABLE LOCAL_COMMITTEES (
	LC_id				NUMBER (4) NOT NULL,
	LC_tel				VARCHAR2 (20 BYTE) NOT NULL,
	LC_email			VARCHAR2 (50 BYTE) NOT NULL,
	LC_uni				NUMBER (3) NOT NULL,
	
	CONSTRAINT LOCAL_COMMITTEES_PK PRIMARY KEY (LC_id),
	CONSTRAINT LOCAL_COMMITTEES_UNI_FK FOREIGN KEY (LC_uni) REFERENCES UNIVERSITIES (UNI_id) ON DELETE CASCADE,
    
    -- check constraints
    CONSTRAINT LOCAL_COMMITTEES_TEL_CHK   CHECK (REGEXP_LIKE(LC_tel, '^[[:digit:]]{9}$')),  -- 9 digits
    CONSTRAINT LOCAL_COMMITTEES_EMAIL_CHK CHECK (LC_email LIKE '%@%')
);

CREATE TABLE STUDENTS (
	STUD_id				NUMBER NOT NULL,
	STUD_faculty		VARCHAR2 (100 CHAR) NOT NULL,
	STUD_year			NUMBER (2) NOT NULL,
	STUD_major			VARCHAR2 (100 CHAR) NOT NULL,
	STUD_book_num		VARCHAR2 (20 BYTE) NOT NULL,
	STUD_specialization	VARCHAR2 (200),
	STUD_uni			NUMBER (3) NOT NULL,
	
	CONSTRAINT STUDENTS_PK PRIMARY KEY (STUD_id),
	-- ISA
	CONSTRAINT STUDENTS_PERSONS_FK FOREIGN KEY (STUD_id) REFERENCES PERSONS (P_id) ON DELETE CASCADE,
	
	CONSTRAINT STUDENTS_UNIVERSITIES_FK FOREIGN KEY (STUD_uni) REFERENCES UNIVERSITIES (UNI_id) ON DELETE SET NULL,
    
    CONSTRAINT STUDENTS_UNI_BOOK_UNIQUE UNIQUE (STUD_uni, STUD_book_num),
    
    -- check constraints
    CONSTRAINT STUDENTS_YEAR_CHK      CHECK (STUD_year > 0),
    CONSTRAINT STUDENTS_BOOK_NUM_CHK  CHECK (REGEXP_LIKE(STUD_book_num, '^[[:digit:][:alpha:]]{6}$'))  -- 6 digits and/or letters
);

CREATE TABLE SPEAKERS (
	SPK_id				NUMBER NOT NULL,
	SPK_degree			NUMBER (2) NOT NULL,
	SPK_years_of_exp	NUMBER (3),
	SPK_graduated		NUMBER (4),
	SPK_company			NUMBER (4) NOT NULL,
	
	CONSTRAINT SPEAKERS_PK PRIMARY KEY (SPK_id),
	-- ISA
	CONSTRAINT SPEAKERS_PERSONS_FK FOREIGN KEY (SPK_id) REFERENCES PERSONS (P_id) ON DELETE CASCADE,
	
	CONSTRAINT SPEAKERS_COMPANIES_FK FOREIGN KEY (SPK_company) REFERENCES COMPANIES (COM_id) ON DELETE SET NULL, -- [?] CASCADE (attrib is NOT NULL)
	CONSTRAINT SPEAKERS_DEGREES_FK FOREIGN KEY (SPK_degree) REFERENCES DEGREES (DEG_id) ON DELETE SET NULL,
	CONSTRAINT SPEAKERS_UNIVERSITIES_FK FOREIGN KEY (SPK_graduated) REFERENCES UNIVERSITIES (UNI_id) ON DELETE SET NULL,
    
    -- check constraints
    CONSTRAINT SPEAKERS_EXP_YEARS_CHK CHECK (SPK_years_of_exp >= 0)
);

CREATE TABLE CONTACTS (
	LC_id				NUMBER (4) NOT NULL,
	COM_id				NUMBER (4) NOT NULL,
	
	CONSTRAINT CONTACTS_PK PRIMARY KEY (LC_id, COM_id),
	CONSTRAINT CONTACTS_LC_FK FOREIGN KEY (LC_id) REFERENCES LOCAL_COMMITTEES (LC_id) ON DELETE CASCADE,
	CONSTRAINT CONTACTS_COMPANIES_FK FOREIGN KEY (COM_id) REFERENCES COMPANIES (COM_id) ON DELETE CASCADE
);

CREATE TABLE WORKSHOPS (
	WS_id				NUMBER (4) NOT NULL,
	WS_name				VARCHAR2 (200 CHAR) NOT NULL,
	WS_date				DATE NOT NULL,
	WS_group_qty		NUMBER (2),
	WS_room_setting		NUMBER (2),
	WS_organizer		NUMBER (4) NOT NULL,
	WS_room_type		VARCHAR2 (10 BYTE) NOT NULL,
	
	CONSTRAINT WORKSHOPS_PK PRIMARY KEY (WS_id),
	CONSTRAINT WORKSHOPS_LC_FK FOREIGN KEY (WS_organizer) REFERENCES LOCAL_COMMITTEES (LC_id) ON DELETE CASCADE,
	CONSTRAINT WORKSHOPS_RS_FK FOREIGN KEY (WS_room_setting) REFERENCES ROOM_SETTINGS (RS_id) ON DELETE SET NULL,
	CONSTRAINT WORKSHOPS_RSZ_FK FOREIGN KEY (WS_room_type) REFERENCES ROOM_SIZES (RSZ_type) ON DELETE SET NULL,
    
    -- check constraints
    CONSTRAINT WS_GROUP_QTY_CHK CHECK (WS_group_qty >= 0)
);

CREATE TABLE LEADS (
	SPK_id				NUMBER NOT NULL,
	WS_id				NUMBER (4) NOT NULL,
	
	CONSTRAINT LEADS_PK PRIMARY KEY (SPK_id, WS_id),
	CONSTRAINT LEADS_SPEAKERS_FK FOREIGN KEY (SPK_id) REFERENCES SPEAKERS (SPK_id) ON DELETE CASCADE,
	CONSTRAINT LEADS_WORKSHOPS_FK FOREIGN KEY (WS_id) REFERENCES WORKSHOPS (WS_id) ON DELETE CASCADE
);

CREATE TABLE ATTENDS (
	STUD_id				NUMBER NOT NULL,
	WS_id				NUMBER (4) NOT NULL,
	
	CONSTRAINT ATTENDS_PK PRIMARY KEY (STUD_id, WS_id),
	CONSTRAINT ATTENDS_STUDENTS_FK FOREIGN KEY (STUD_id) REFERENCES STUDENTS (STUD_id) ON DELETE CASCADE,
	CONSTRAINT ATTENDS_WORKSHOPS_FK FOREIGN KEY (WS_id) REFERENCES WORKSHOPS (WS_id) ON DELETE CASCADE
);


-- Sequences:

CREATE SEQUENCE PERSONS_SEQ
    MINVALUE 0 
	START WITH 0 
	INCREMENT BY 1;

CREATE SEQUENCE WORKSHOPS_SEQ
    MINVALUE 1
	START WITH 1
	INCREMENT BY 1;

	
-- Views:

CREATE OR REPLACE VIEW V_STUDENTS_DATA AS
SELECT pers.P_NAME AS "Name", pers.P_SURNAME AS "Surname", uni.UNI_NAME AS "University", 
stud.STUD_FACULTY AS "Faculty", stud.STUD_MAJOR AS "Major", stud.STUD_YEAR AS "Year" FROM STUDENTS stud
LEFT JOIN PERSONS pers ON pers.P_ID = stud.STUD_ID
LEFT JOIN UNIVERSITIES uni ON uni.UNI_ID = stud.STUD_UNI;

CREATE OR REPLACE VIEW V_EXPERIENCED_WORKSHOP_LEADERS AS
SELECT ws.WS_NAME AS "Workshop", pers.P_NAME AS "Name", pers.P_SURNAME AS "Surname", 
deg.DEG_NAME AS "Degree", uni.UNI_NAME AS "Graduated", cmp.COM_NAME AS "Company" FROM SPEAKERS spk
LEFT JOIN PERSONS pers ON pers.P_ID = spk.SPK_ID
LEFT JOIN DEGREES deg ON deg.DEG_ID = spk.SPK_DEGREE
LEFT JOIN COMPANIES cmp ON cmp.COM_ID = spk.SPK_COMPANY
LEFT JOIN UNIVERSITIES uni ON uni.UNI_ID = spk.SPK_GRADUATED
LEFT JOIN LEADS ls ON ls.SPK_ID = spk.SPK_ID
LEFT JOIN WORKSHOPS ws ON ws.WS_ID = ls.WS_ID
WHERE spk.SPK_YEARS_OF_EXP > '5';

CREATE OR REPLACE VIEW V_ROOM_LIMITS AS
SELECT ws.WS_NAME AS "Workshop", ws.WS_GROUP_QTY AS "Expected group quantity", 
rsz.RSZ_SEAT_MIN AS "Minimum seats", rsz.RSZ_SEAT_MAX AS "Maximum seats" FROM WORKSHOPS ws
LEFT JOIN ROOM_SIZES rsz ON rsz.RSZ_TYPE = ws.WS_ROOM_TYPE;


-- Triggers (autonumber):

CREATE OR REPLACE TRIGGER PERSONS_AUTONR_TRG
  BEFORE INSERT ON PERSONS
  FOR EACH ROW
BEGIN
  IF :new.P_id IS NULL THEN
    :new.P_id := PERSONS_SEQ.nextval;
  END IF;
END PERSONS_AUTONR_TRG;
/

CREATE OR REPLACE TRIGGER WORKSHOPS_AUTONR_TRG
  BEFORE INSERT ON WORKSHOPS
  FOR EACH ROW
BEGIN
  IF :new.WS_id IS NULL THEN
    :new.WS_id := WORKSHOPS_SEQ.nextval;
  END IF;
END WORKSHOPS_AUTONR_TRG;
/

CREATE OR REPLACE PROCEDURE CONVERT_TEL (
    tel IN OUT VARCHAR2
)
IS
  wrong_tel_format EXCEPTION;
BEGIN
  IF REGEXP_LIKE(tel, '^\d{3}[- ]\d{3}[- ]\d{3}$') THEN
    tel := REGEXP_REPLACE(tel, '[- ]'); -- remove all matched patterns  
    -- the first position in the string is 1 (not 0)
    dbms_output.put_line('CONVERT_TEL: tel converted to: ' || tel || '.');    
  ELSIF REGEXP_LIKE(tel, '^\d{9}$') THEN
    NULL;   -- do not change the tel number
  ELSE
    RAISE wrong_tel_format;
  END IF;
  
EXCEPTION
  WHEN wrong_tel_format THEN
    dbms_output.put_line('Wrong tel number format. Expected formats are:
      ddddddddd
      ddd-ddd-ddd
      ddd ddd ddd');
    -- ROLLBACK WORK;
    RAISE;
END CONVERT_TEL;
/

CREATE OR REPLACE TRIGGER PERSONS_TEL_CONVERT_TRG
  BEFORE INSERT OR UPDATE OF P_tel ON PERSONS
  FOR EACH ROW
BEGIN
  CONVERT_TEL(:new.P_tel);

  -- do not catch exception
  -- no inset or update will succeed if the passed tel has wrong format
  
  -- TODO catch user-defined exception and raise application error ?
END PERSONS_TEL_CONVERT_TRG;
/

CREATE OR REPLACE TRIGGER COMPANIES_TEL_CONVERT_TRG
  BEFORE INSERT OR UPDATE OF COM_tel ON COMPANIES
  FOR EACH ROW
BEGIN
  CONVERT_TEL(:new.COM_tel);

  -- do not catch exception
  -- no inset or update will succeed if the passed tel has wrong format
END COMPANIES_TEL_CONVERT_TRG;
/

CREATE OR REPLACE TRIGGER LC_TEL_CONVERT_TRG
  BEFORE INSERT OR UPDATE OF LC_tel ON LOCAL_COMMITTEES
  FOR EACH ROW
BEGIN
  CONVERT_TEL(:new.LC_tel);

  -- do not catch exception
  -- no inset or update will succeed if the passed tel has wrong format
END LC_TEL_CONVERT_TRG;
/

-- Procedure that adds new person to database
-- Using  RAISE and EXCEPTTION

CREATE OR REPLACE PROCEDURE add_person (
    name        IN PERSONS.P_name%TYPE,
    surname     IN PERSONS.P_surname%TYPE,
    tel_number  IN PERSONS.P_tel%TYPE,
    email       IN PERSONS.P_email%TYPE,
    id          IN PERSONS.P_id%TYPE
)
IS  
BEGIN

    --dbms_output.put_line('add_person :: ' || name || ' ' || surname || ' , tel: ' || tel_number || ' , email: ' || email);
    
    INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
    VALUES (id, name, surname, tel_number, email);
    
    --dbms_output.put_line('Person added.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        dbms_output.put_line('Exception: Attempted to insert duplicate UNIQUE value. The tuple was not inserted into the PERSONS table.');
        RAISE; -- reraise current exception (exception name is optional)
        
    -- TODO catch if constraints not met by user-provided data

END add_person;
/

-- Procedure that adds speaker to database
CREATE OR REPLACE PROCEDURE add_speaker (
    name            IN VARCHAR2,
    surname         IN VARCHAR2,
    tel_number      IN VARCHAR2,
    email           IN VARCHAR2,
    DEG_degree      IN NUMBER, -- DEFAULT 0 (none)? --  this tuple in DEGREES must exist + handle exception
    years_of_exp    IN NUMBER DEFAULT NULL,
    UNI_graduated   IN NUMBER DEFAULT NULL, -- or 0 (none)?
    COM_company     IN NUMBER    
)
IS
    id               NUMBER;
    -- transaction_name VARCHAR2 (50 CHAR);
BEGIN
    -- transaction_name := 'ADD_SPEAKER__' || upper(name) || '_' || upper(surname);

    --dbms_output.put_line('Add_speaker :: ' || name || ' ' || surname);

    -- SET TRANSACTION NAME transaction_name;
    id := PERSONS_SEQ.nextval;
    
    add_person(name, surname, tel_number, email, id);
    INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
    VALUES (id, DEG_degree, years_of_exp, UNI_graduated, COM_company);
    COMMIT WORK;

    --dbms_output.put_line('Transaction committed. Added speaker with id ' || id);

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Exception: ... Could not add the new speaker.');  -- TODO - more info
        ROLLBACK WORK;
        RAISE;
    -- TODO catch if constraints not met by user-provided data

END add_speaker;
/
-- Procedure that adds student to database
CREATE OR REPLACE PROCEDURE add_student (
    name        IN VARCHAR2,
    surname     IN VARCHAR2,
    tel_number  IN VARCHAR2,
    email       IN VARCHAR2,
    study_fac   IN VARCHAR2,
    study_year  IN NUMBER,
    study_major IN VARCHAR2,
    study_book  IN VARCHAR2,
    study_uni   IN NUMBER,
    study_spec  IN VARCHAR2 DEFAULT NULL
)
IS
    id          NUMBER;
BEGIN
    --dbms_output.put_line('Add_student :: ' || name || ' ' || surname);

    id := PERSONS_SEQ.nextval;
    
    add_person(name, surname, tel_number, email, id);
    INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
    VALUES (id, study_fac, study_year, study_major, study_book, study_spec, study_uni);
    COMMIT WORK;

    --dbms_output.put_line('Transaction committed. Added student with id ' || id);

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Exception: ... Could not add the new student.');  -- TODO - more info
        ROLLBACK WORK;
        RAISE;
    -- TODO catch if constraints not met by user-provided data

END add_student;
/

-- Procedure that displays name, company and the most experienced speaker of selected workshop
CREATE OR REPLACE PROCEDURE get_WS_logistics_info(
id IN number
)
 
AS

    wsname varchar2(200 char);
    spkname varchar2(100 char);
    spksurname varchar2(100 char);
    degname varchar2(50 byte);
    compname varchar2(100 byte);

BEGIN
 
    
    SELECT ws_name, pers.p_name, pers.p_surname, deg.deg_name, comps.com_name 
    INTO wsname, spkname, spksurname, degname, compname
    FROM WORKSHOPS
    LEFT JOIN LEADS leads ON leads.WS_ID = WORKSHOPS.WS_ID
    LEFT JOIN SPEAKERS spk ON spk.SPK_ID = leads.SPK_ID
    LEFT JOIN PERSONS pers ON pers.P_ID = spk.SPK_ID
    LEFT JOIN DEGREES deg ON deg.DEG_ID = spk.SPK_DEGREE
    LEFT JOIN COMPANIES comps ON comps.COM_ID = spk.SPK_COMPANY
    WHERE WORKSHOPS.WS_id = id 
    AND spk.spk_years_of_exp = (SELECT MAX(spk.spk_years_of_exp) 
        FROM  WORKSHOPS
        LEFT JOIN LEADS leads ON leads.WS_ID = WORKSHOPS.WS_ID
        LEFT JOIN SPEAKERS spk ON spk.SPK_ID = leads.SPK_ID
        WHERE WORKSHOPS.WS_id = id);  
 
   
    dbms_output.put_line('Workshop name: ' || wsname);
    dbms_output.put_line('Company name: ' || compname); 
    dbms_output.put_line('Speaker: ' || degname || ' ' || spkname || ' ' || spksurname); 

END get_WS_logistics_info;
/

-- Procedure that prints names of participants forselected workshop 
-- Using CURSOR and FOR statements
CREATE OR REPLACE PROCEDURE get_WS_participants(
wsnum number
)
AS
    CURSOR WS_part(wsid number) is
        SELECT * FROM STUDENTS stud
        LEFT JOIN PERSONS pers ON stud.STUD_ID = pers.P_ID
        LEFT JOIN ATTENDS att ON stud.STUD_ID = att.STUD_ID
        WHERE att.WS_ID = wsid;
    BEGIN
        FOR curs IN WS_part(wsnum) LOOP
        dbms_output.put_line(curs.P_NAME || ' ' || curs.P_SURNAME);
        END LOOP;
END;
/

-- Function that returns number of participants for selected workshop
CREATE OR REPLACE FUNCTION WS_part_number (
    wsid      IN ATTENDS.WS_ID%TYPE
)
RETURN int
IS  
    ret int;
BEGIN

    SELECT count(wsid) 
    INTO ret
    FROM ATTENDS
    WHERE WS_ID = wsid;
    RETURN ret;

END WS_part_number;
/

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
        INSERT INTO WORKSHOPS (WS_ID, WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)
        VALUES (WORKSHOPS_SEQ.currval, WSname, TO_DATE(WSdate, 'DD-MM-YY'), WSqty, WSrs, WSorg, WSroom);
        COMMIT WORK;       
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
        SELECT * FROM STUDENTS 
        WHERE 1=1;
BEGIN
    limiter := howmany;  
    FOR curst IN studs LOOP
        ind := 0;
        WHILE ind < limiter LOOP
            INSERT INTO ATTENDS (STUD_ID, WS_ID)
            VALUES (curst.STUD_ID, MOD(curst.STUD_ID+ind, 5)+1);
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
        SELECT * FROM SPEAKERS
        WHERE 1=1;
BEGIN
    limiter := howmany; 
    FOR cursp IN speaks LOOP
        ind := 0;
        WHILE ind < limiter LOOP
            INSERT INTO LEADS (SPK_ID, WS_ID)
            VALUES (cursp.SPK_ID, MOD(cursp.SPK_ID+ind, 4)+1);
            COMMIT WORK;
            ind := ind+1;
        END LOOP;
    END LOOP;

END generate_leads;
/