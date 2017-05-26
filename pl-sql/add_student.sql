/*
SET TRANSACTION NAME 'ADD_STUDENT__MARIUSZ_NALECZ';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Mariusz', 'Nalecz', '374632111', 'm.nalecz@example.com');
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (PERSONS_SEQ.currval, 'EiTI', 3, 'Informatyka', '423123', null, 1);
COMMIT WORK;

STUD_id				NUMBER NOT NULL,
	STUD_faculty		VARCHAR2 (100 CHAR) NOT NULL,
	STUD_year			NUMBER (2) NOT NULL,
	STUD_major			VARCHAR2 (100 CHAR) NOT NULL,
	STUD_book_num		VARCHAR2 (20 BYTE) NOT NULL,
	STUD_specialization	VARCHAR2 (200),
	STUD_uni			NUMBER (3) NOT NULL,
    
CREATE TABLE PERSONS (
	P_id				NUMBER NOT NULL,
	P_name				VARCHAR2 (100 CHAR) NOT NULL,
	P_surname			VARCHAR2 (100 CHAR) NOT NULL,
	P_tel				VARCHAR2 (20 BYTE) NOT NULL,
	P_email				VARCHAR2 (50 BYTE) NOT NULL,
*/


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
    -- transaction_name VARCHAR2 (50 CHAR);
BEGIN
    -- TODO capitalize name and surname for transaction name
    -- transaction_name := 'ADD_STUDENT__' || name || '_' || surname;

    dbms_output.put_line('Add_student :: ' || name || ' ' || surname);

    -- SET TRANSACTION NAME transaction_name;
    -- COMMIT WORK; -- end previous transaction (if any) -- is it needed?
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
    -- catch if constraints not met by user-provided data

END add_student;
