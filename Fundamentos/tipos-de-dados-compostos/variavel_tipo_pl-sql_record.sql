-- PL/SQL Records
-- · PL/SQL Record é um grupo de itens de dados relacionados armazenados em campos, cada um com seu próprio nome e tipo de dado
-- · Um PL/SQL Record que contém campos como o nome, cidade e data de admissão de um cliente permite tratar os dados como uma unidade lógica
-- · Quando você declara um tipo RECORD para estes campos, eles podem ser manipulados como uma unidade

-- PL/SQL Records - Diretrizes
-- · Cada registro definido pode possuir tantos campos quanto necessarios 
-- · Campos podem ser atribuídos valores iniciais e podem ser definidos como NOT
-- · Campos sem valores iniciais são inicializados com NULL
-- · A palavra chave DEFAULT também podem ser utilizada quando definindo campos


-- Criando um PL/SQL Record 

SET SERVEROUTPUT ON
SET VERIFY OFF  -- desliga a impressão do bloco
ACCEPT pemployee_id PROMPT 'Digite o Id do empregado: '
DECLARE
    TYPE employee_record_type IS RECORD 
         ( employee_id   employees.employee_id%type,
           first_name    employees.first_name%type,
           last_name     employees.last_name%type,
           email         employees.email%type,
           phone_number  employees.phone_number%type );
           
    employee_record  employee_record_type; 

BEGIN
    SELECT employee_id, first_name, last_name, email, phone_number
      INTO employee_record
      FROM employees
     WHERE employee_id = &pemployee_id;
    DBMS_OUTPUT.PUT_LINE(employee_record.employee_id || ' - ' || 
                         employee_record.first_name || ' - ' || 
                         employee_record.last_name || ' - ' || 
                         employee_record.phone_number);
END;


-- Forma mais simples para um PL/SQL Record
-- Criando um PL/SQL Record utilizando atributo %ROWTYPE

-- Vantagens da Utilização do atributo %ROWTYPE
-- · O nome, tipos de dados e tamanho máximo das colunas referenciadas do banco de dados não precisam ser conhecidos
-- · Bastante útil quando recupera-se todas as colunas de uma linha com o comando SELECT *

SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT pemployee_id PROMPT 'Digite o Id do empregado: '
DECLARE
    employee_record   employees%rowtype;
    vEmployee_id      employees.employee_id%type := &pemployee_id;
BEGIN
    SELECT * 
      INTO employee_record
      FROM employees
     WHERE employee_id = vEmployee_id;
    DBMS_OUTPUT.PUT_LINE(employee_record.employee_id || ' - ' || 
                         employee_record.first_name || ' - ' || 
                         employee_record.last_name || ' - ' || 
                         employee_record.phone_number || ' - ' ||
                         employee_record.job_id);
END;
