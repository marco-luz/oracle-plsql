-- Criando uma Procedure de Banco de Dados

CREATE OR REPLACE PROCEDURE PRC_INSERE_EMPREGADO (
        pfirst_name    IN VARCHAR2,
        plast_name     IN VARCHAR2,
        pemail         IN VARCHAR2,
        pphone_number  IN VARCHAR2,
        phire_date     IN DATE DEFAULT SYSDATE,
        pjob_id        IN VARCHAR2,
        pSALARY        IN NUMBER,
        pCOMMICION_PCT IN NUMBER,
        pMANAGER_ID    IN NUMBER,
        pDEPARTMENT_ID IN NUMBER
    ) IS 
    -- Nenhuma variavel declarada
    BEGIN
        INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date,
                               job_id, salary, commission_pct, manager_id, department_id)
               VALUES (employees_seq.nextval, pfirst_name, plast_name, pemail, pphone_number, phire_date,
                       pjob_id, psalary, pcommicion_pct, pmanager_id, pdepartment_id );
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Erro Oracle ' || SQLCODE || SQLERRM);
END;


-- Execurtando a Procedure
-- Existem diversar formar de executar uma Procedure



-- Executando a Procedure pelo Bloco PL/SQL

-- Execução por posição (não recomendada)
--   Os parâmetros seguem a ordem exata da definição, código frágil a mudanças e menor legibilidade
BEGIN
    PRC_INSERE_EMPREGADO('David', 'Bowie','DBOWIE','515.127.4861',SYSDATE,'IT_PROG',15000,NULL,103,60);
    COMMIT;
END;

-- Execução por nome (recomendada)
--   Ordem irrelevante, código autoexplicativo, menos erros em refatorações
BEGIN
    PRC_INSERE_EMPREGADO(
        pfirst_name     => 'David',
        plast_name      => 'Bowie',
        pemail          => 'DBOWIE',
        pphone_number   => '515.127.4861',
        phire_date      => SYSDATE,
        pjob_id         => 'IT_PROG',
        pSALARY         => 15000,
        pCOMMICION_PCT  => NULL,
        pMANAGER_ID     => 103,
        pDEPARTMENT_ID  => 60
    );
    COMMIT;
END;



-- Executando a Procedure com o comando EXECUTE do SQL*PLUS

EXEC PRC_INSERE_EMPREGADO('Greg', 'Lake','GLAKE','515.127.4961',SYSDATE,'IT_PROG',15000,NULL,103,60)
COMMIT;


-- Outra forma de executar pelo Executar Instrução no Developer na procedure

DECLARE
    PFIRST_NAME VARCHAR2(200);
    PLAST_NAME VARCHAR2(200);
    PEMAIL VARCHAR2(200);
    PPHONE_NUMBER VARCHAR2(200);
    PHIRE_DATE DATE;
    PJOB_ID VARCHAR2(200);
    PSALARY NUMBER;
    PCOMMICION_PCT NUMBER;
    PMANAGER_ID NUMBER;
    PDEPARTMENT_ID NUMBER;
BEGIN
    PFIRST_NAME := 'David';
    PLAST_NAME := 'Bowie';
    PEMAIL := 'DBOWIE';
    PPHONE_NUMBER := '515.127.4861';
    PHIRE_DATE := SYSDATE;
    PJOB_ID := 'IT_PROG';
    PSALARY := 15000;
    PCOMMICION_PCT := NULL;
    PMANAGER_ID := 103;
    PDEPARTMENT_ID := 60;

    PRC_INSERE_EMPREGADO(
        PFIRST_NAME => PFIRST_NAME,
        PLAST_NAME => PLAST_NAME,
        PEMAIL => PEMAIL,
        PPHONE_NUMBER => PPHONE_NUMBER,
        PHIRE_DATE => PHIRE_DATE,
        PJOB_ID => PJOB_ID,
        PSALARY => PSALARY,
        PCOMMICION_PCT => PCOMMICION_PCT,
        PMANAGER_ID => PMANAGER_ID,
        PDEPARTMENT_ID => PDEPARTMENT_ID
    );
    --COMMIT; 
END;


-- Consultando os empregados inseridos

SELECT *
  FROM employees
 WHERE first_name IN ('David','Greg')
   AND last_name = 'Bowie';


