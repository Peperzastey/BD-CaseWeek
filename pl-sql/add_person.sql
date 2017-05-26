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
        
    -- catch if constraints not met by user-provided data

END add_person;
