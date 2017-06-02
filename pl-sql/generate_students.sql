-- TODO check why after one run of procedure there is error with unique constraints

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
    tel_number := 789543000;
    study_book := 593999;
    ind := 0;
  
    WHILE ind < howmany LOOP
        surname := 'Student' || ind;
        tel_number := tel_number + ind;
        email := ind || 'random@student.com';
        study_year := MOD(ind, 4) + 1;
        study_major := 'Whatever' || ind;
        study_book := study_book - ind;
        study_uni := MOD(ind, 9);
        ind := ind + 1;
        add_student('Random', surname, tel_number, email, 'Randomology', study_year, study_major, study_book, study_uni);
		IF ind > 200 THEN
			dbms_output.put_line('Added 200 records, it is enough!');
			EXIT;
		END IF;
        
    END LOOP;
    
END generate_students;
/
