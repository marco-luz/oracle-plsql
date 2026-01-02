-- Exceções Definidas pelo Desenvolvedor

-- · O desenvolvedor pode criar suas próprias exceções declarando um identificador do tipo EXCEPTION na seção DECLARE do bloco PL/SQL
-- · Esse identificador pode ser usado para desviar o fluxo de execução do programa para a seção de tratamento de exceções através do comando RAISE
-- · Esse identificador pode também ser usado para interceptar um erro Oracle existente para o qual não existe exceção pré-definida

-- Excecoes Definidas pelo Desenvolvedor 

SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT pEmployee_id PROMPT 'Digite o Id do Empregado: '
DECLARE
    v_first_name    employees.first_name%Type;
    v_last_name     employees.last_name%Type;
    v_job_id        employees.job_id%type;
    v_employee_id   employees.employee_id%TYPE := &pEmployee_id;
    e_president     EXCEPTION;
BEGIN
    SELECT first_name, last_name, job_id
      INTO v_first_name, v_last_name, v_job_id
      FROM employees
     WHERE employee_id = v_employee_id;

    IF v_job_id = 'AD_PRES' THEN
        RAISE e_president;  
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Empregado nao encontrado, id = ' || TO_CHAR(v_employee_id));
        
    WHEN e_president THEN
        UPDATE employees
           SET salary = salary * 1.5
         WHERE employee_id = v_employee_id;
        COMMIT;
        
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle ' || SQLCODE || SQLERRM);
END;