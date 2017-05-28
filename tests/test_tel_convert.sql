-- Test PERSONS_TEL_CONVERT_TRG

DECLARE
  expected_val CONSTANT CHAR(9) := '000000000'; -- string length constraint must be provided
  real_val     VARCHAR2(20 BYTE);               -- string length constraint must be provided
  test_failure EXCEPTION;
BEGIN
-- Tel format ddddddddd (9 digits)
  BEGIN
    real_val := NULL;
    INSERT INTO PERSONS
      SELECT -1, 'test_name1', 'test_surname1', '000000000', 'test1@email.com'  
      FROM DUAL;
    -- COMMIT WORK;
    SELECT P_tel INTO real_val
      FROM PERSONS
      WHERE P_id = -1;
      
    -- clean-up:
    DELETE FROM PERSONS WHERE P_id = -1;
    IF real_val = expected_val THEN
      dbms_output.put_line('PASSED: Tel format ddddddddd.');    
    ELSE
      dbms_output.put_line('FAILED: Tel format ddddddddd.
        real_val: ' || real_val || ' expected_val: ' || expected_val);
      -- RAISE test_failure;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('FAILED: Tel format ddddddddd.
        Did not insert value.');
      -- RAISE test_failure;
  END;
  
-- Tel format ddd-ddd-ddd (9 digits in groups of 3)
  BEGIN
    real_val := NULL;
    INSERT INTO PERSONS
      SELECT -2, 'test_name2', 'test_surname2', '000-000-000', 'test2@email.com'  
      FROM DUAL;
    -- COMMIT WORK;
    SELECT P_tel INTO real_val
      FROM PERSONS
      WHERE P_id = -2;
      
    -- clean-up:
    DELETE FROM PERSONS WHERE P_id = -2;
    IF real_val = expected_val THEN
      dbms_output.put_line('PASSED: Tel format ddd-ddd-ddd.');     
    ELSE
      dbms_output.put_line('FAILED: Tel format ddd-ddd-ddd.
        real_val: ' || real_val || ' expected_val: ' || expected_val);
      -- RAISE test_failure;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('FAILED: Tel format ddd-ddd-ddd.
        Did not insert value.');
      -- RAISE test_failure;
  END;
  
-- Tel format ddd ddd ddd (9 digits in groups of 3)
  BEGIN
    real_val := NULL;
    INSERT INTO PERSONS
      SELECT -3, 'test_name3', 'test_surname3', '000 000 000', 'test3@email.com'  
      FROM DUAL;
    -- COMMIT WORK;
    SELECT P_tel INTO real_val
      FROM PERSONS
      WHERE P_id = -3;
      
    -- clean-up:
    DELETE FROM PERSONS WHERE P_id = -3;
    IF real_val = expected_val THEN
      dbms_output.put_line('PASSED: Tel format ddd ddd ddd.');     
    ELSE
      dbms_output.put_line('FAILED: Tel format ddd ddd ddd.
        real_val: ' || real_val || ' expected_val: ' || expected_val);
      -- RAISE test_failure;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('FAILED: Tel format ddd ddd ddd.
        Did not insert value.');
      -- RAISE test_failure;
  END;
  
-- Wrong tel format e.g. ddd@ddd@ddd (9 digits in groups of 3)
  BEGIN
    real_val := NULL;
    INSERT INTO PERSONS
      SELECT -4, 'test_name4', 'test_surname4', '000@000@000', 'test4@email.com'  
      FROM DUAL;
    -- COMMIT WORK;
    SELECT P_tel INTO real_val
      FROM PERSONS
      WHERE P_id = -4;
      
    -- clean-up, the following should not be executed:
    DELETE FROM PERSONS WHERE P_id = -4;
    
    -- should raise an exception, value should not be inserted
    dbms_output.put_line('FAILED: Tel format ddd@ddd@ddd.
      Inserted value: ' || real_val);     
    -- RAISE test_failure;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('PASSED: Tel format ddd@ddd@ddd.
        Did not insert value.');
    WHEN OTHERS THEN
      dbms_output.put_line('PASSED: Tel format ddd@ddd@ddd.
        Raised exception.');
  END;
  
EXCEPTION
  WHEN test_failure THEN
    NULL;
END;