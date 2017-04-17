-- Insertion in table 'STUDENTS' including insertion in table 'PERSONS'
SET TRANSACTION NAME 'ADD_STUDENT__JOHN_DOE';
INSERT INTO PERSONS (P_id, P_name, P_surname, P_tel, P_email)
VALUES (PERSONS_SEQ.nextval, 'John', 'Doe', '000000000', 'john@doe.com');
INSERT INTO STUDENTS (STUD_id, STUD_faculty, STUD_year, STUD_major, STUD_book_num, STUD_specialization, STUD_uni)
VALUES (PERSONS_SEQ.currval, 'None', 0, 'None', '000000', null, 0);
COMMIT WORK;

-- Query selecting companies and their contacting local committees, icluding all contact data, for 3 first LCs on the list
SELECT comp.COM_NAME AS "Name", comp.COM_ADDRESS AS "Address", 
comp.COM_TEL AS "Company phone", comp.COM_EMAIL AS "Company e-mail", 
uni.UNI_NAME AS "Contacting LC name", lc.LC_TEL AS "LC phone", lc.LC_EMAIL AS "LC e-mail" FROM COMPANIES comp
LEFT JOIN CONTACTS cs ON cs.COM_ID = comp.COM_ID
LEFT JOIN LOCAL_COMMITTEES lc ON lc.LC_ID = cs.LC_ID
LEFT JOIN UNIVERSITIES uni ON uni.UNI_ID = lc.LC_UNI
WHERE lc.LC_ID < '4'
ORDER BY comp.COM_NAME ASC, uni.UNI_NAME ASC;