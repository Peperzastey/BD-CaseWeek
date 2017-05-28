-- Test UNIQUE data constraints

DECLARE
  passed BOOLEAN := FALSE;
  test_failure EXCEPTION;
BEGIN
-- ROOM_SETTINGS table, UNIQUE RS_type field
  BEGIN
    passed := FALSE;
    INSERT INTO ROOM_SETTINGS
      SELECT -1, 'test_type' FROM DUAL
      UNION
      SELECT -2, 'test_type' FROM DUAL;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      dbms_output.put_line('PASSED: Unique RS_type.');
      passed := TRUE;
  END;  
  IF passed <> TRUE THEN
    dbms_output.put_line('FAILED: Unique RS_type.');
    DELETE FROM ROOM_SETTINGS WHERE RS_id IN (-1, -2);
    -- RAISE test_failure;
  END IF;
    
-- COMPANIES table, UNIQUE COM_tel field
  BEGIN
    passed := FALSE;
    INSERT INTO COMPANIES
      SELECT -1, 'test_name1', 'test_addr1', '000000000', 'test1@email.com'  
      FROM DUAL
      UNION
      SELECT -2, 'test_name2', 'test_addr2', '000000000', 'test2@email.com' 
      FROM DUAL;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      dbms_output.put_line('PASSED: Unique COM_tel.');
      passed := TRUE;
  END;  
  IF passed <> TRUE THEN
    dbms_output.put_line('FAILED: Unique COM_tel.');
    DELETE FROM COMPANIES WHERE COM_id IN (-1, -2);
    -- RAISE test_failure;
  END IF;
    
-- COMPANIES table, UNIQUE COM_email field
  BEGIN
    passed := FALSE;
    INSERT INTO COMPANIES
      SELECT -3, 'test_name3', 'test_addr3', '000000003', 'test@email.com'  
      FROM DUAL
      UNION
      SELECT -4, 'test_name4', 'test_addr4', '000000004', 'test@email.com' 
      FROM DUAL;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      dbms_output.put_line('PASSED: Unique COM_email.');
      passed := TRUE;
  END;  
  IF passed <> TRUE THEN
    dbms_output.put_line('FAILED: Unique COM_email.');
    DELETE FROM COMPANIES WHERE COM_id IN (-3, -4);
    -- RAISE test_failure;
  END IF;
    
-- PERSONS table, UNIQUE P_tel field
  BEGIN
    passed := FALSE;
    INSERT INTO PERSONS
      SELECT -1, 'test_name1', 'test_surname1', '000000000', 'test1@email.com'  
      FROM DUAL
      UNION
      SELECT -2, 'test_name2', 'test_surname2', '000000000', 'test2@email.com' 
      FROM DUAL;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      dbms_output.put_line('PASSED: Unique P_tel.');
      passed := TRUE;
  END;  
  IF passed <> TRUE THEN
    dbms_output.put_line('FAILED: Unique P_tel.');
    DELETE FROM PERSONS WHERE P_id IN (-1, -2);
    -- RAISE test_failure;
  END IF;
    
-- PERSONS table, UNIQUE P_email field
  BEGIN
    passed := FALSE;
    INSERT INTO PERSONS
      SELECT -3, 'test_name3', 'test_surname3', '000000003', 'test@email.com'  
      FROM DUAL
      UNION
      SELECT -4, 'test_name4', 'test_surname4', '000000004', 'test@email.com' 
      FROM DUAL;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      dbms_output.put_line('PASSED: Unique P_email.');
      passed := TRUE;
  END;  
  IF passed <> TRUE THEN
    dbms_output.put_line('FAILED: Unique P_email.');
    DELETE FROM PERSONS WHERE P_id IN (-3, -4);
    -- RAISE test_failure;
  END IF;
    
-- STUDENTS table, UNIQUE (STUD_uni, STUD_book_num) fields
  BEGIN
  -- TEST SETUP:
  -- Each Student has to have a corresponding tuple in the PERSONS table
    INSERT INTO PERSONS
      SELECT -998, 'test_name998', 'test_surname998', '000000998', 'test998@email.com'  
      FROM DUAL
      UNION
      SELECT -999, 'test_name999', 'test_surname999', '000000999', 'test999@email.com'
      FROM DUAL;
  -- Each Student has to study at a University
  -- Each University is located in a City
    INSERT INTO CITIES
      SELECT -990, 'test_name990' FROM DUAL;
    INSERT INTO UNIVERSITIES
      SELECT -990, 'test_name990', -990 FROM DUAL;
    
    BEGIN
      passed := FALSE;
      INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_uni)
        SELECT -998, 'test_faculty998', 1, 'test_major998', 
        '000000'    /*book num*/, 
        -990        /*uni*/
        FROM DUAL
        UNION
        SELECT -999, 'test_faculty999', 1, 'test_major999', 
        '000000'    /*book num*/, 
        -990        /*uni*/
        FROM DUAL;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      dbms_output.put_line('PASSED: Unique (STUD_uni, STUD_book_num).');
      passed := TRUE;
    END;  
    IF passed <> TRUE THEN
      dbms_output.put_line('FAILED: Unique (STUD_uni, STUD_book_num).');
      DELETE FROM STUDENTS WHERE STUD_id IN (-998, -999);
      -- RAISE test_failure;   
    END IF;
    
  -- should succeed
    BEGIN
      passed := TRUE;
      INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_uni)
        SELECT -998, 'test_faculty998', 1, 'test_major998', 
        '000998'    /*book num*/, 
        -990        /*uni*/
        FROM DUAL
        UNION
        SELECT -999, 'test_faculty999', 1, 'test_major999', 
        '000999'    /*book num*/, 
        -990        /*uni*/
        FROM DUAL;
      -- COMMIT WORK;
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        dbms_output.put_line('FAILED: Unique (STUD_uni, STUD_book_num) constraint should be met. Distinct STUD_book_num');
        passed := FALSE;
        -- RAISE test_failure; 
    END;  
    IF passed = TRUE THEN
      dbms_output.put_line('PASSED: Unique (STUD_uni, STUD_book_num) constraint should be met. Distinct STUD_book_num');        
      DELETE FROM STUDENTS WHERE STUD_id IN (-998, -999);
    END IF;
  
  
    INSERT INTO UNIVERSITIES
      SELECT -991, 'test_name991', -990 FROM DUAL;
      
  -- should succeed
    BEGIN
      passed := TRUE;
      INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_uni)
        SELECT -998, 'test_faculty998', 1, 'test_major998', 
        '000000'    /*book num*/, 
        -990        /*uni*/
        FROM DUAL
        UNION
        SELECT -999, 'test_faculty999', 1, 'test_major999', 
        '000000'    /*book num*/, 
        -991        /*uni*/
        FROM DUAL;
      -- COMMIT WORK;
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        dbms_output.put_line('FAILED: Unique (STUD_uni, STUD_book_num) constraint should be met. Distinct STUD_uni');
        passed := FALSE;
        -- RAISE test_failure; 
    END;  
    IF passed = TRUE THEN
      dbms_output.put_line('PASSED: Unique (STUD_uni, STUD_book_num) constraint should be met. Distinct STUD_uni');        
      DELETE FROM STUDENTS WHERE STUD_id IN (-998, -999);
    END IF;
    
  -- TEST TEARDOWN (clean-up in tables):
    DELETE FROM PERSONS WHERE (P_id = -998 OR P_id = -999);
    DELETE FROM UNIVERSITIES WHERE UNI_id IN (-990, -991);
    DELETE FROM CITIES WHERE CITY_id = -990;
  EXCEPTION
    WHEN test_failure THEN
      DELETE FROM PERSONS WHERE (P_id = -998 OR P_id = -999);
      DELETE FROM UNIVERSITIES WHERE UNI_id IN (-990, -991);
      DELETE FROM CITIES WHERE CITY_id = -990;
      -- RAISE;
  END;
  
EXCEPTION
  WHEN test_failure THEN
    NULL;
END;
