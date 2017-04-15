-- This script presents some examples of insert transactions.

COMMIT WORK; 										-- end any ongoing transaction in the session

SET TRANSACTION NAME 'ADD_STUDENT__KAMIL_KAMILSKI';	-- if present, must be the first statement of the transaction
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Kamil', 'Kamilski', '963724123', 'k.kamilski@example.com');
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (PERSONS_SEQ.currval, 'EiTI', 2, 'Elektronika', '321435', null, 1);
COMMIT WORK;

SET TRANSACTION NAME 'ADD_SPEAKER__RYSZARD_RYSZARDSKI';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Ryszard', 'Ryszardski', '908453671', 'r.ryszardski@example.com');
INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (PERSONS_SEQ.currval, 3, 4, null, 2);
COMMIT WORK;


-- Rollback:

SET TRANSACTION NAME 'ADD_SPEAKER__MACIEJ_MACIEJSKI';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'Maciej', 'Maciejski', '239649201', 'm.maciejski@example.com');
INSERT INTO SPEAKERS (SPK_id, SPK_degree, SPK_years_of_exp, SPK_graduated, SPK_company)
VALUES (PERSONS_SEQ.currval, 1, 2, null, 1);
ROLLBACK WORK;