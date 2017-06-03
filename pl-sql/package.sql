CREATE OR REPLACE PACKAGE BODY WSPKG AS
    -- Procedure that displays name, company and the most experienced speaker of selected workshop
    PROCEDURE get_WS_logistics_info(
    id IN number
    ) 
    AS
        wsname varchar2(200 char);
        spkname varchar2(100 char);
        spksurname varchar2(100 char);
        degname varchar2(50 byte);
        compname varchar2(100 byte);
    BEGIN    
        SELECT ws_name, pers.p_name, pers.p_surname, deg.deg_name, comps.com_name 
        INTO wsname, spkname, spksurname, degname, compname
        FROM WORKSHOPS
        LEFT JOIN LEADS leads ON leads.WS_ID = WORKSHOPS.WS_ID
        LEFT JOIN SPEAKERS spk ON spk.SPK_ID = leads.SPK_ID
        LEFT JOIN PERSONS pers ON pers.P_ID = spk.SPK_ID
        LEFT JOIN DEGREES deg ON deg.DEG_ID = spk.SPK_DEGREE
        LEFT JOIN COMPANIES comps ON comps.COM_ID = spk.SPK_COMPANY
        WHERE WORKSHOPS.WS_id = id 
        AND spk.spk_years_of_exp = (SELECT MAX(spk.spk_years_of_exp) 
            FROM  WORKSHOPS
            LEFT JOIN LEADS leads ON leads.WS_ID = WORKSHOPS.WS_ID
            LEFT JOIN SPEAKERS spk ON spk.SPK_ID = leads.SPK_ID
            WHERE WORKSHOPS.WS_id = id);     
        dbms_output.put_line('Workshop name: ' || wsname);
        dbms_output.put_line('Company name: ' || compname); 
        dbms_output.put_line('Speaker: ' || degname || ' ' || spkname || ' ' || spksurname); 
    END get_WS_logistics_info;
    
    -- Procedure that prints names of participants forselected workshop 
    -- Using CURSOR and FOR statements
    PROCEDURE get_WS_participants(
    wsnum number
    )
    AS
        CURSOR WS_part(wsid number) is
            SELECT * FROM STUDENTS stud
            LEFT JOIN PERSONS pers ON stud.STUD_ID = pers.P_ID
            LEFT JOIN ATTENDS att ON stud.STUD_ID = att.STUD_ID
            WHERE att.WS_ID = wsid;
        BEGIN
            FOR curs IN WS_part(wsnum) LOOP
            dbms_output.put_line(curs.P_NAME || ' ' || curs.P_SURNAME);
            END LOOP;
    END;

-- Function that returns number of participants for selected workshop
    FUNCTION WS_part_number (
    wsid      IN ATTENDS.WS_ID%TYPE
    )
    RETURN int
    IS  
        ret int;
    BEGIN
        SELECT count(wsid) 
        INTO ret
        FROM ATTENDS
        WHERE WS_ID = wsid;
        RETURN ret;
    END WS_part_number;
END pkg;
/

