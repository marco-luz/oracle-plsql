-- Controlando um Cursor Explicito utilizando CURSOR FOR LOOP

SET SERVEROUTPUT ON
DECLARE
    CURSOR c_employees IS
    SELECT *
      FROM employees;
      
BEGIN
    FOR r_employees IN c_employees LOOP
        DBMS_OUTPUT.PUT_LINE(r_employees.employee_id || ' - ' ||
                             r_employees.first_name || ' ' || 
                             r_employees.last_name || ' - ' ||
                             r_employees.department_id || ' - ' ||
                             r_employees.job_id || ' - ' ||
                             r_employees.phone_number || ' - ' ||
                             LTRIM(TO_CHAR(r_employees.salary, 'L99G999G999D99')));
    END LOOP;
END;


-- CURSOR FOR LOOP utilizando Sub-consulta

SET SERVEROUTPUT ON
BEGIN
    FOR r_employees IN (SELECT * FROM employees) LOOP
        DBMS_OUTPUT.PUT_LINE(r_employees.employee_id || ' - ' ||
                             r_employees.first_name || ' ' || 
                             r_employees.last_name || ' - ' ||
                             r_employees.department_id || ' - ' ||
                             r_employees.job_id || ' - ' ||
                             r_employees.phone_number || ' - ' ||
                             LTRIM(TO_CHAR(r_employees.salary, 'L99G999G999D99')));
    END LOOP;
END;
