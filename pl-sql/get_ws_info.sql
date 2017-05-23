-- Displays name, company and the most experienced speaker of selected workshop

CREATE OR REPLACE PROCEDURE get_WS_logistics_info(
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