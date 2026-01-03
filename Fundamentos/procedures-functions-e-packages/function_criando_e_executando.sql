-- Criando Funções de Banco de Dados

-- · Uma função é uma sub-rotina que sempre retorna um valor
-- · Utilize uma função ao invés de uma procedure quando a rotina retornar obrigatoriamente um valor
-- . Se a rotina retornar nenhum ou mais de um valor, considere o uso de uma procedure

-- Regras para o uso de Funções em comandos SQL

-- · As funções devem ser armazenadas no servidor de banco de dados.
-- · A função deve ser do tipo Single-Row.
-- · No corpo da função, não podem haver comandos DML.
-- · A função deve conter apenas parâmetros do tipo "IN".
-- · Tipos PL/SQL, tais como BOOLEAN, RECORD ou TABLE não sao aceitos como o tipo de retorno da função.
-- · no corpo da função, não são permitidas chamadas à subrotinas que desobedeçam quaisquer das restrições anteriores.



CREATE OR REPLACE FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO (
    p_employee_id   IN NUMBER
) RETURN NUMBER --<<<<<<<<
IS
    v_salary  employees.salary%TYPE;
BEGIN
    SELECT salary
      INTO v_salary
      FROM employees
     WHERE employee_id = p_employee_id;

    RETURN v_salary; --<<<<<<<<
    
EXCEPTION
    WHEN no_data_found THEN
        raise_application_error(-20001, 'Empregado inexistente');
    WHEN OTHERS THEN
        raise_application_error(-20002, 'Erro Oracle '|| SQLCODE|| ' - '|| SQLERRM);
END;


-- Executando a Funcao pelo Bloco PL/SQL

SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT p_employee_id PROMPT 'Digite o Id do empregado: '

DECLARE
    v_employee_id employees.employee_id%TYPE := &p_employee_id;
    v_salary      employees.salary%TYPE;
BEGIN
    v_salary := fnc_consulta_salario_empregado(v_employee_id);
    DBMS_OUTPUT.PUT_LINE('Salario: ' || v_salary);
END;





-- Utilizando Funcoes em comandos SQL

CREATE OR REPLACE FUNCTION FNC_CONSULTA_TITULO_CARGO_EMPREGADO (
    p_job_id   IN jobs.job_id%TYPE
) RETURN VARCHAR2
IS 
    v_job_title jobs.job_title%TYPE;
BEGIN
    SELECT job_title
      INTO v_job_title
      FROM jobs
     WHERE job_id = p_job_id;
    RETURN (v_job_title);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Job inexistente');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle ' || SQLCODE || ' - ' || SQLERRM);
END;

-- Utilizando Funcoes em comandos SQL

SELECT employee_id, first_name, last_name, job_id, FNC_CONSULTA_TITULO_CARGO_EMPREGADO(job_id) "JOB TITLE"
  FROM employees;

-- Executando a Funcao pelo comando SELECT

SELECT FNC_CONSULTA_TITULO_CARGO_EMPREGADO('IT_PROG')
  FROM dual;

-- Executando a Funcao pelo comando SELECT

SELECT FNC_CONSULTA_SALARIO_EMPREGADO(130)
  FROM dual;