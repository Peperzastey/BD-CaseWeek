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
