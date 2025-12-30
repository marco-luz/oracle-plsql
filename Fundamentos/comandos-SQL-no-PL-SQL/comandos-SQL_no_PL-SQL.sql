-- Utilizando o comando SELECT no PL/SQL

SET SERVEROUTPUT ON
DECLARE
    vFirst_name  employees.first_name%type;
    vLast_name   employees.last_name%type;
    vEmployee_id employees.employee_id%type := 121;
BEGIN
    SELECT first_name, last_name
      INTO vfirst_name, vlast_name
      FROM employees
     WHERE employee_id = vEmployee_id;
    
    DBMS_OUTPUT.PUT_LINE('Fist Name: ' || vFirst_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || vLast_name);
END;

-- Erro ORA-01403 - No Data Found

SET SERVEROUTPUT ON
DECLARE
    vFirst_name  employees.first_name%type;
    vLast_name   employees.last_name%type;
    vEmployee_id employees.employee_id%type := 50;
BEGIN
    SELECT first_name, last_name
      INTO vfirst_name, vlast_name
      FROM employees
     WHERE employee_id = vEmployee_id;
    
    DBMS_OUTPUT.PUT_LINE('Fist Name: ' || vFirst_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || vLast_name);
END;

-- Erro ORA-01422 - Too Many Rows

SET SERVEROUTPUT ON
DECLARE
    vJob_id          employees.job_id%type;
    vAvg_Salary      employees.salary%type;
    vSum_Salary      employees.salary%type;
BEGIN
    SELECT job_id, ROUND(AVG(salary),2), ROUND(SUM(salary),2)
      INTO vJob_id, vAvg_Salary, vSum_Salary 
      FROM employees
     GROUP BY job_id;
     
    DBMS_OUTPUT.PUT_LINE('Cargo: ' || vJob_id);
    DBMS_OUTPUT.PUT_LINE('MÃ©dia de salÃ¡rios: ' || vAvg_Salary);
    DBMS_OUTPUT.PUT_LINE('SomatÃ³rio de salarios: ' || vSum_Salary);
END;


--------------------------------------------------------------------------------
-- Utilizando o comando INSERT no PL/SQL

SET SERVEROUTPUT ON
DECLARE
    vsalary  employees.salary%type := 15000;
BEGIN
    INSERT INTO employees 
        (employee_id, first_name, last_name, email, phone_number, hire_date,
        job_id, salary, commission_pct, manager_id, department_id)
    VALUES 
        (employees_seq.nextval, 'Kobe', 'Bryant', 'KBRYANT', '515.123.45568', SYSDATE,
         'IT_PROG', vsalary, 0.4, 103, 60);
    COMMIT;  
END;


--------------------------------------------------------------------------------
-- Utilizando o comando UPDATE no PL/SQL

SET SERVEROUTPUT ON
DECLARE
    vEmployee_id    employees.employee_id%type := 150;
    vPercentual     NUMBER(3) := 10;
BEGIN
    UPDATE employees 
       SET salary = salary * (1 + vPercentual / 100)
     WHERE employee_id =  vEmployee_id;
    COMMIT;  
END;


--------------------------------------------------------------------------------
-- Utilizando o comando DELETE no PL/SQL

SET SERVEROUTPUT ON
DECLARE
    vEmployee_id  employees.employee_id%type := 207;
BEGIN
    DELETE FROM employees 
     WHERE employee_id = vEmployee_id;
    COMMIT;  
END;


--------------------------------------------------------------------------------
-- Controlando Transacoes do Banco de Dados

SET SERVEROUTPUT ON
BEGIN
    INSERT INTO employees 
        (employee_id, first_name, last_name, email, phone_number, hire_date,
        job_id, salary, commission_pct, manager_id, department_id)
    VALUES 
        (employees_seq.nextval, 'Kobe', 'Bryant', 'KBRYANT', '515.123.45568', SYSDATE,
        'IT_PROG', 15000, 0.4, 103, 60);
    
    SAVEPOINT INSERTOK;  -- cria um ponto de controle
    
    UPDATE employees 
       SET salary = 30000
     WHERE job_id = 'IT_PROG';
    
    ROLLBACK TO INSERTOK;  -- descarta todas as mudanças realizadas a partir do SAVEPOINT, mas não encerra a transação do banco de dados, ou seja, continua na sequencia
    
    COMMIT;  -- neste exemplo 
END;


--------------------------------------------------------------------------------
-- Utilizando atributos de Cursor Implicito

-- · Sempre que você executa um comando SQL, o Servidor Oracle abre uma área de memória 
--   na qual o comando é analisado e executado. Esta área é chamada cursor.
-- · Quando a parte executável (seção BEGIN) de um bloco emite um comando SQL, 
--   o PL/SQL cria um cursor implícito. O PL/SQL administra este cursor automaticamente.

SET SERVEROUTPUT ON
DECLARE
    vdepartment_id  employees.department_id%type := 60;
    vpercentual     NUMBER(3) := 10;
BEGIN
    UPDATE employees 
       SET salary = salary * (1 + vpercentual / 100)
     WHERE department_id = vdepartment_id;
    DBMS_OUTPUT.PUT_LINE('Numero de empregados atualizados: ' || SQL%ROWCOUNT);
    -- COMMIT;  
END;
ROLLBACK;

--Atributos do Cursor SQL
--
-- Atributo            Descrição
-- ------------        -----------------
-- SQL%ROWCOUNT        Número de linhas afetadas pelo cursor, ou seja pelo último comando SQL.
-- SQL%FOUND           Retorna TRUE se o cursor afetou uma ou mais linhas.
-- SQL%NOTFOUND        Retorna TRUE se o cursor não afetou nenhuma linha.
-- SQL%ISOPEN          Retorna FALSE, porque o Oracle controla ocursor implícito automaticamente, fechando o cursor.