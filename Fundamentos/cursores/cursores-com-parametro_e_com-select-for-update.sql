-- CURSOR SIMPLES Com Parametros

SET SERVEROUTPUT ON
DECLARE
    CURSOR c_employees (p_departament_id NUMBER, p_job_id VARCHAR2) IS
    SELECT *
      FROM employees
     WHERE department_id = p_departament_id
       AND job_id = p_job_id;
       
    r_employees  c_employees%ROWTYPE;
    
BEGIN
    OPEN c_employees(60, 'IT_PROG');
    
    LOOP
        FETCH c_employees
         INTO r_employees;
         
        EXIT WHEN c_employees%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(r_employees.employee_id || ' - ' ||
                         r_employees.first_name || ' ' || 
                         r_employees.last_name || ' - ' ||
                         r_employees.department_id || ' - ' ||
                         r_employees.job_id || ' - ' ||
                         r_employees.phone_number || ' - ' ||
                         LTRIM(TO_CHAR(r_employees.salary, 'L99G999G999D99')));
    END LOOP;
    
    CLOSE c_employees;
END;



-- CURSOR WHILE LOOP Com Parametros

SET SERVEROUTPUT ON
DECLARE
    CURSOR c_employees(p_department_id NUMBER, p_job_id VARCHAR2) IS
    SELECT * 
      FROM employees
     WHERE department_id = p_department_id
       AND job_id = p_job_id;
    
    r_employees  c_employees%ROWTYPE;
    
BEGIN
    OPEN c_employees(60, 'IT_PROG');
    
    -- faz o fetch da primeira linha do cursor
    FETCH c_employees
     INTO r_employees;
     
    WHILE c_employees%FOUND LOOP
        -- faz o fetch a partir da egunda linha do cursor
        FETCH c_employees
         INTO r_employees;
        
         DBMS_OUTPUT.PUT_LINE(r_employees.employee_id || ' - ' ||
                         r_employees.first_name || ' ' || 
                         r_employees.last_name || ' - ' ||
                         r_employees.department_id || ' - ' ||
                         r_employees.job_id || ' - ' ||
                         r_employees.phone_number || ' - ' ||
                         LTRIM(TO_CHAR(r_employees.salary, 'L99G999G999D99')));        
    END LOOP;
    
    CLOSE c_employees;
END;



-- CURSOR FOR LOOP Com Parametros

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR c_employees (p_department_id NUMBER, p_job_id VARCHAR2) IS
    SELECT *
      FROM employees
     WHERE department_id = p_department_id AND job_id = p_job_id;
BEGIN
    FOR r_employees IN  c_employees (60, 'IT_PROG') LOOP
        DBMS_OUTPUT.PUT_LINE(r_employees.employee_id || ' - ' ||
                         r_employees.first_name || ' ' || 
                         r_employees.last_name || ' - ' ||
                         r_employees.department_id || ' - ' ||
                         r_employees.job_id || ' - ' ||
                         r_employees.phone_number || ' - ' ||
                         LTRIM(TO_CHAR(r_employees.salary, 'L99G999G999D99')));
    
    END LOOP;
END;



-- Cursor Explicito com SELECT FOR UPDATE
-- * Raro de ser utilizado pois faz lock nas colunas ou tabelas

SET SERVEROUTPUT ON
DECLARE
    CURSOR employees_cursor (p_job_id VARCHAR2) IS
    SELECT *
      FROM employees
     WHERE job_id = p_job_id
    FOR UPDATE; -- Quando fizer OPEN do cursor, faz lock nas linhas recuperadas
    
BEGIN
    FOR employees_record IN  employees_cursor ('AD_VP') LOOP
        UPDATE employees
           SET salary = salary * (1 + 10 / 100)
         WHERE CURRENT OF employees_cursor; -- Atualiza a linha corrente do cursor
    END LOOP;
    
    COMMIT;
END;
