-- Utilizando Parametros tipo OUT e IN OUT

-- Parametros Tipo OUT
-- · Devolve um valor como saída para o programa chamador.

-- Parametros Tipo IN OUT
-- · Recebe um valor como entrada passado pelo programa chamador e devolve o valor (modificado ou não) como saída para o programa chamador.


-- · Os parâmetros do tipo "IN" funcionam internamente por referência.
-- . Os parâmetros "OUT" e "IN OUT" funcionam por cópia.


-- Opção NOCOPY

-- · É possível utilizarmos parâmetros "OUT" e "IN OUT" por referência, 
--   de modo que a área de memória usada pela variável do ambiente chamador e pelo parâmetro do subprograma sejam a mesma.



CREATE OR REPLACE PROCEDURE PRC_CONSULTA_EMPREGADO (
        pemployee_id    IN NUMBER,
        pfirst_name     OUT NOCOPY VARCHAR2,
        plast_name      OUT NOCOPY VARCHAR2,
        pemail          OUT NOCOPY VARCHAR2,
        pphone_number   OUT NOCOPY VARCHAR2,
        phire_date      OUT NOCOPY DATE,
        pjob_id         OUT NOCOPY VARCHAR2,
        pSALARY         OUT NOCOPY NUMBER,
        pCOMMISSION_PCT OUT NOCOPY NUMBER,
        pMANAGER_ID     OUT NOCOPY NUMBER,
        pDEPARTMENT_ID  OUT NOCOPY NUMBER 
    ) IS 
    
BEGIN
    SELECT first_name, last_name, email, phone_number, hire_date,
           job_id, salary, commission_pct, manager_id, department_id
      INTO pfirst_name, plast_name, pemail, pphone_number, phire_date,
           pjob_id, psalary, pcommission_pct, pmanager_id, pdepartment_id
      FROM employees
     WHERE employee_id = pemployee_id;
  
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Empregado NÃ£o existe: ' || pemployee_id);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle ' || SQLCODE || SQLERRM);
END;


-- Executando procedure parametro Tipo OUT

-- Metodo posicional

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE 
    r_employees  employees%ROWTYPE;
BEGIN
    PRC_CONSULTA_EMPREGADO(100, r_employees.first_name, r_employees.last_name, r_employees.email,
    r_employees.phone_number, r_employees.hire_date, r_employees.job_id, r_employees.salary, 
    r_employees.commission_pct, r_employees.manager_id, r_employees.department_id);
    
    DBMS_OUTPUT.PUT_LINE(r_employees.first_name || ' ' || 
                         r_employees.last_name || ' - ' ||
                         r_employees.department_id || ' - ' ||
                         r_employees.job_id || ' - ' ||
                         r_employees.phone_number || ' - ' ||
                         LTRIM(TO_CHAR(r_employees.salary, 'L99G999G999D99')));
END;


-- Metodo nomeado

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    VEMPLOYEE_ID NUMBER := 100;
    VFIRST_NAME VARCHAR2(200);
    VLAST_NAME VARCHAR2(200);
    VEMAIL VARCHAR2(200);
    VPHONE_NUMBER VARCHAR2(200);
    VHIRE_DATE DATE;
    VJOB_ID VARCHAR2(200);
    VSALARY NUMBER;
    VCOMMISSION_PCT NUMBER;
    VMANAGER_ID NUMBER;
    VDEPARTMENT_ID NUMBER;
BEGIN

  PRC_CONSULTA_EMPREGADO(
    PEMPLOYEE_ID => VEMPLOYEE_ID,
    PFIRST_NAME => VFIRST_NAME,
    PLAST_NAME => VLAST_NAME,
    PEMAIL => VEMAIL,
    PPHONE_NUMBER => VPHONE_NUMBER,
    PHIRE_DATE => VHIRE_DATE,
    PJOB_ID => VJOB_ID,
    PSALARY => VSALARY,
    PCOMMISSION_PCT => VCOMMISSION_PCT,
    PMANAGER_ID => VMANAGER_ID,
    PDEPARTMENT_ID => VDEPARTMENT_ID
  );

  DBMS_OUTPUT.PUT_LINE('PFIRST_NAME = ' || VFIRST_NAME);
  DBMS_OUTPUT.PUT_LINE('PLAST_NAME = ' || VLAST_NAME);
  DBMS_OUTPUT.PUT_LINE('PEMAIL = ' || VEMAIL);
  DBMS_OUTPUT.PUT_LINE('PPHONE_NUMBER = ' || VPHONE_NUMBER);
  DBMS_OUTPUT.PUT_LINE('PHIRE_DATE = ' || VHIRE_DATE);
  DBMS_OUTPUT.PUT_LINE('PJOB_ID = ' || VJOB_ID);
  DBMS_OUTPUT.PUT_LINE('PSALARY = ' || VSALARY);
  DBMS_OUTPUT.PUT_LINE('PCOMMISSION_PCT = ' || VCOMMISSION_PCT);
  DBMS_OUTPUT.PUT_LINE('PMANAGER_ID = ' || VMANAGER_ID);
  DBMS_OUTPUT.PUT_LINE('PDEPARTMENT_ID = ' || VDEPARTMENT_ID);
END;