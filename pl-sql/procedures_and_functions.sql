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

    dbms_output.put_line('add_person :: ' || name || ' ' || surname || ' , tel: ' || tel_number || ' , email: ' || email);
    
    INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
    VALUES (id, name, surname, tel_number, email);
    
    dbms_output.put_line('Person added.');

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

    dbms_output.put_line('Add_speaker :: ' || name || ' ' || surname);

    -- SET TRANSACTION NAME transaction_name;
    id := PERSONS_SEQ.nextval;
    
    add_person(name, surname, tel_number, email, id);
    INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
    VALUES (id, DEG_degree, years_of_exp, UNI_graduated, COM_company);
    COMMIT WORK;

    dbms_output.put_line('Transaction committed. Added speaker with id ' || id);

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
    dbms_output.put_line('Add_student :: ' || name || ' ' || surname);

    id := PERSONS_SEQ.nextval;
    
    add_person(name, surname, tel_number, email, id);
    INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
    VALUES (id, study_fac, study_year, study_major, study_book, study_spec, study_uni);
    COMMIT WORK;

    dbms_output.put_line('Transaction committed. Added student with id ' || id);

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
