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
    -- catch if constraints not met by user-provided data

END add_speaker;
