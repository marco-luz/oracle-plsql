-- Comando IF com ELSIF

SET SERVEROUTPUT ON
ACCEPT pdepartment_id PROMPT 'Digite o Id do departamento: '
DECLARE
    vpercentual     NUMBER(3);
    vDepartment_id  employees.employee_id%type := &pdepartment_id;
BEGIN
    IF vDepartment_id = 80 
        THEN vpercentual := 10; -- Sales
    ELSIF vDepartment_id = 20 
        THEN vpercentual := 15; -- Marketing
    ELSIF vDepartment_id  =  60 
        THEN vpercentual := 20; -- IT
    ELSE vpercentual := 5;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Id do Departamento: ' || vDepartment_id);   
    DBMS_OUTPUT.PUT_LINE('percentual: ' || vpercentual );   

    UPDATE employees 
       SET salary = salary * (1 + vpercentual / 100)
     WHERE department_id =  vDepartment_id;
    COMMIT;
END;


-- Utilizando o comando CASE

SET SERVEROUTPUT ON
ACCEPT pdepartment_id PROMPT 'Digite o Id do departamento: '
DECLARE
    vpercentual     NUMBER(3);
    vDepartment_id  employees.employee_id%type := &pdepartment_id;
BEGIN
    CASE vDepartment_id
        WHEN 80 THEN vpercentual := 10; -- Sales
        WHEN 20 THEN vpercentual := 15; -- Marketing
        WHEN 60 THEN vpercentual := 20; -- IT
        ELSE vpercentual := 5;
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('Id do Departamento: ' || vDepartment_id);   
    DBMS_OUTPUT.PUT_LINE('percentual: ' || vPercentual );   
    
    UPDATE employees 
       SET salary = salary * (1 + vpercentual / 100)
     WHERE department_id =  &pdepartment_id;
    COMMIT; 
END;