-- PRAGMA EXCEPTION INIT

-- · Declara-se um identificador do tipo EXCEPTION e associa-se ele ao Erro Oracle previsto através de uma chamada pragma EXCEPTION INIT
-- · Dessa forma, se o erro ocorrer durante a execução do subprograma, 
--   o fluxo de execução será automaticamente desviado para a seção EXCEPTION, onde e Exceção será tratada


DECLARE
    v_employee_id    employees.employee_id%TYPE := 300;
    v_first_name     employees.first_name%TYPE := 'Robert';
    v_last_name      employees.last_name%TYPE := 'Ford';
    v_job_id         employees.job_id%TYPE := 'XX_YYYY';
    v_phone_number   employees.phone_number%TYPE := '650.511.9844';
    v_email          employees.email%TYPE := 'RFORD';
    
    e_fk_inexistente EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_fk_inexistente, -2291);  -- erro de violação de constrait foreign key

BEGIN
    INSERT INTO employees (employee_id, first_name, last_name, phone_number, email, hire_date,job_id)
           VALUES (v_employee_id, v_first_name, v_last_name, v_phone_number, v_email, sysdate, v_job_id);
    
EXCEPTION
    WHEN e_fk_inexistente THEN
        RAISE_APPLICATION_ERROR(-20003, 'Job inexistente!');
        
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle ' || SQLCODE || SQLERRM);
END;

-- Forcando o Erro para descobrir o codigo de Erro a ser tratado

INSERT INTO employees (employee_id, first_name, last_name, phone_number, email, hire_date, job_id)
VALUES (employees_seq.nextval, 'Joseph', 'Smith', '3333333', 'JSMITH', sysdate, 'ZZZZ_XX');