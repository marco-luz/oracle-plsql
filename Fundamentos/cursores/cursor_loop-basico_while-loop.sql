-- Tipos de Cursor: 

-- Implícito
--   Cursores implícitos são declarados implicitamente para todos os comandos DML e para comandos SELECT que retornam somente uma linha.

-- Explícito
--   Para consultas que retornam mais de uma linha, um cursor explícito pode ser declarado e nomeado pelo programador 
--   e manipulado através de comandos específicos no bloco PL/SQL.

-----------------------------------------------------------------------------------------------------------------------------
-- Controlando um Cursor Explícito
-- 
-- DECLARE
--  . Crie uma área SQL nomeada
-- OPEN
--  · Identifique o conjunto ativo (result set)
-- FETCH
--  . Carregue a linha atual para variáveis
-- LOOP
--  · Verifique se ainda existem linhas, executando um novo FETCH até não encontrar mais nada
-- CLOSE
--  . Libere o conjunto ativo (result set)
--
--
-- 1. Declare o cursor nomeando e definindo a estrutura de consulta a ser executada dentro dele
-- 2. Abra o cursor. O comando OPEN executa a consulta. 
--    As linhas identificadas pela consulta são chamadas de active set (conjunto ativo) e ficam disponíveis para recuperação
-- 3. Recupere os dados do cursor. O comando FETCH recupera a linha corrente do cursor para variáveis. 
--    Cada fetch move o ponteiro do cursor para a próxima linha do active set.
--    Portanto, cada fetch acessa uma linha diferente retornada pela consulta
-- 4. Feche o cursor. O comando CLOSE libera o conjunto ativo de linhas.

-----------------------------------------------------------------------------------------------------------------------------
-- Atributos de Cursor Explícito
--
-- Método       Tipo        Tipos de Collections
-- -------      --------    ----------------------
-- %ISOPEN      Boolean     Retorna TRUE se o cursor estiver aberto.
-- %NOTFOUND    Boolean     Retorna TRUE se o último FETCH não retornou uma linha.
-- %FOUND       Boolean     Retorna TRUE se o último FETCH retornou uma linha
-- %ROWCOUNT    Number      Retorna o numero de linhas reperadas por FETCH até o momento.
-----------------------------------------------------------------------------------------


-- Controlando um Cursor Explicito com LOOP Basico

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employees_cursor IS
    SELECT *
      FROM employees;  -- Declaracao do Cursor
    
    employees_record  employees_cursor%rowtype;  -- Declaracao da variavel Record baseado na estrutura do Cursor
  
BEGIN
    /* Inicializa */
    OPEN  employees_cursor;  -- Abrindo o Cursor (executa o select do cursor e coloca as linhas na memoria)
    
    /* Loop */
    LOOP  -- Loop Basico
        FETCH  employees_cursor  
        INTO  employees_record; -- Fetch do Cursor (insere todas as colunas do select nesta variavel Record, linha a linha comforme o ponteiro)
        
        EXIT WHEN employees_cursor%notfound;  -- Valida se existe linha, se não existir mais sai do cursor
        
        DBMS_OUTPUT.PUT_LINE(employees_record.employee_id || ' - ' ||
                             employees_record.first_name || ' ' || 
                             employees_record.last_name || ' - ' ||
                             employees_record.department_id || ' - ' ||
                             employees_record.job_id || ' - ' ||
                             employees_record.phone_number || ' - ' ||
                             LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
    END LOOP;
    
    CLOSE employees_cursor; -- Close do Cursor
END;


--------------------------------------------------------------------------------
-- Controlando um Cursor Explicito com WHILE LOOP

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employees_cursor  IS
    SELECT *
      FROM employees; -- Declaracao do Cursor
      
    employees_record  employees_cursor%rowtype;   -- Declaracao da variavel Record baseado na estrutura do Cursor
    
BEGIN
    /* Inicializa */
    OPEN  employees_cursor; -- Abrindo o Cursor
    
    FETCH  employees_cursor  -- Fetch da primeira linha
    INTO  employees_record;  -- Fetch do Cursor (insere todas as colunas do select nesta variavel Record, da 1a. linha comforme o ponteiro)
    
    /* Loop */  -- Enquanto found (existir)  -- Se no Fetch da primeira linha não encontrou nada, não entra no Loop
    WHILE employees_cursor%found LOOP
        DBMS_OUTPUT.PUT_LINE(employees_record.employee_id || ' - ' ||
                             employees_record.first_name || ' ' || 
                             employees_record.last_name || ' - ' ||
                             employees_record.department_id || ' - ' ||
                             employees_record.job_id || ' - ' ||
                             employees_record.phone_number || ' - ' ||
                             LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
                             
        FETCH  employees_cursor   -- Fetch da segunda linha 
        INTO  employees_record;   -- (insere todas as colunas do select nesta variavel Record, a partir da 2a. linha, linha a linha comforme o ponteiro)
    END LOOP;
    
    CLOSE employees_cursor; -- Close do Cursor
END;
