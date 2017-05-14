CREATE OR REPLACE PROCEDURE add_student (
    name IN PERSONS.P_name%TYPE,
    surname IN PERSONS.P_surname%TYPE
)
AS
    email PERSONS.P_email%TYPE;
    id PERSONS.P_id%TYPE;
    -- transaction_name VARCHAR2 (50 CHAR);
BEGIN
    -- TODO capitalize name and surname for transaction name
    -- transaction_name := 'ADD_STUDENT__' || name || '_' || surname;

    -- TODO get only the first letter of the name
    email := name || '.' || surname || '@example.com';
    -- TODO set tel as random __9-digit__ seq

    dbms_output.put_line('Got: ' || name || ' ' || surname || ' , email: ' || email);

    -- SET TRANSACTION NAME transaction_name;
    -- COMMIT WORK; -- end previous transaction (if any) -- is it needed?
    id := PERSONS_SEQ.nextval;
    
    INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
    VALUES (id, name, surname, '111111111', email);
    INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
    VALUES (id, 'Test', 1, 'Test', '111111', null, 1);
    COMMIT WORK;

    dbms_output.put_line('Transaction committed. Added student with id ' || id);

-- EXCEPTION
    -- catch if constraints not met by user-provided data

END add_student;
