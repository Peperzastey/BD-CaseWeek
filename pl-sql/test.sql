-- Tests for add_student and add_speaker procedures (and indirectly also add_person)

EXECUTE add_student('Mark1', 'Halfrod', '434-432-533', 'm.halfrod@poisonnull\0elka.pw.edu.pl', 'DROP TABLE STUDENTS;', 1, 'major', '3zX9QT', 1);
    
EXECUTE caseweek.add_student('Mark2', 'Halfrod', '434 432 533', 'm.halfrod@poisonnull\0elka.pw.edu.pl', 'DROP TABLE STUDENTS;', 22, 'major', '3zX9QT', 1);

EXECUTE caseweek.add_student('Mark1', 'Halfrod', '434 432 533', 'm.halfrod@poisonnull\0elka.pw.edu.pl', 'DROP TABLE STUDENTS;', -1, 'major', '3zX9QT', 1);
    
EXECUTE caseweek.add_student('Mark3', 'Halfrod', '434432533', 'm.halfrod@poisonnull\0elka.pw.edu.pl', 'DROP TABLE STUDENTS;', -32.4325, 'major', '3zX9QT', 1);
    
EXECUTE caseweek.add_student('Mark4', 'Halfrod', '434432533', 'm.halfrod@poisonnull\0elka.pw.edu.pl', 'DROP TABLE STUDENTS;', 0.3, 'major', '3zX9QT', 1);
    
EXECUTE caseweek.add_student('Mark5', 'Halfrod', '434432533', 'm.halfrod@poisonnull\0elka.pw.edu.pl', 'DROP TABLE STUDENTS;', 1.4, 'major', '3zX9QT', 1);
    
EXECUTE caseweek.add_student('Mark6', 'Halfrod', '434432533', 'm.halfrod@poisonnull\0elka.pw.edu.pl', 'DROP TABLE STUDENTS;', 43.7353252352, 'major', '3zX9QT', 1);
    
-- add_student('Mark', 'Halfrod', '95-434-432-533', 'm.halfrod@poisonnull\0elka.pw.edu.pl', 'DROP TABLE STUDENTS;', -4342.432, 'major', 'abcdefghijklmnopqrstuvwxyz>20, really: 111222', 1); -- max 20 bytes for book number (20 ascii characters)
-- add_student('TeSt!@#$%^&*()', 'TeStowskY!@#$%^&*()', '0!#$@%^&*', 'mymail#!$%(*&^%)', 'Test \`n\`   ,.      tab    Break%^&*()', 0, 'Test#@', '-1.,', 1, '!@#$.`');
    
-- TODO catch exception, when too large input value passed into the procedure

BEGIN
    /*caseweek.*/add_speaker(
        name            => 'Spk1', 
        surname         => 'Test', 
        tel_number      => '000000000', 
        email           => 'null@null', 
        -- years_of_exp    => 0,
        COM_company     => 1,
        DEG_degree      => 0
    );
END;
/

-- EXECUTE works only for one-line calls
-- See: https://stackoverflow.com/questions/4529665/what-is-the-correct-syntax-to-break-a-pl-sql-procedure-call-in-multiple-lines
