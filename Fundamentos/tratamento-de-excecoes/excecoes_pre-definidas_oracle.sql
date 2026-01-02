-- Tratando Excecoes

-- · Excecoes sao eventos (normalmente erros), que podem ser tratados designando acoes a serem tomadas quando uma excecao ocorre.
-- · Quando uma Excecao ocorrer durante a execucao do bloco PL/SQL, e nao houver um tratamento para Excecao, 
--   a Excecao se propagara para o ambiente chamador do bloco PL/SQL.
-- · Se a Excecao nao for tratada no programa então propagara um Erro Oracle.


-- Tipos de Excecoes

-- · Excecoes pre-definidas Oracle
-- · Excecoes definidas pelo desenvolvedor e disparadas utilizando o comando RAISE
-- · Excecoes que interceptam erros Oracle nao pre-definidos utilizando pragma EXCEPTION_INIT


-- Excecao Propagada

-- · Se a Excecao disparada na secao BEGIN (executável) do bloco e nao existir um tratamento de Excecao correspondente 
--   na secao EXCEPTION do respectivo bloco onde a Excecao ocorreu, a Excecao será propagada para o ambiente chamador.
-- · A Excecao que foi propagada poderá ser tratada na secao EXCEPTION do ambiente chamador.


-- Interrupções de Programa

-- · Eh possivel interromper a execucao de um programa PL/SQL atraves de uma chamada a procedure pre-definida Oracle RAISE_APPLICATION_ERROR.
-- · A chamada a procedure RAISE_APPLICATION_ERROR gera uma Excecao que voce nao tratara no seu programa, 
--   encerrando a execucao do programa de forma anormal e retornando para o ambiente chamador uma mensagem no formato de mensagem de erro Oracle.

-- RAISE APPLICATION ERROR

-- · A procedure possui tres parametros: um numero, uma string e um valor boleano.
-- · O numero eh o codigo de erro a ser mostrado, e deve estar no intervalo [-20000, -20999].
-- · A string contem o texto da mensagem de erro com ate 2048 bytes de tamanho.
-- · Por último, opcionalmente, vem um valor tipo BOOLEAN que, se for TRUE, cdloca o erro na pilha de erros previos, e se for FALSE (o default), o erro sobrepõe outros erros.

-- SQLCODE e SQLERRM

-- · A Funcao SQLCODE retorna o codigo de erro Oracle que disparou a Excecao.
-- · A Funcao SQLERRM retorna a mensagem do erro Oracle que disparou a Excecao.
-- · Com essas duas funções, podemos identificar uma excecao e capturar sua mensagem.

-----------------------------------------------------------------------------------------------------------
-- Diferencas entre RAISE_APPLICATION_ERROR e DBMS_OUTPUT.PUT_LINE na clausula EXCEPTION:

-- 1. RAISE_APPLICATION_ERROR
-- Finalidade:
--   Lançar uma Excecao explicita, interrompendo o fluxo do programa e retornando um erro formal ao chamador (aplicação, job, trigger, procedure externa etc.).
-- Características principais:
-- · Gera um erro Oracle com codigo entre -20000 e -20999.
-- · Interrompe a execucao imediatamente.
-- · Pode ser tratado por um bloco EXCEPTION superior.
-- · O erro propaga para a aplicacao (Java, .NET, ERP, job, etc.).
-- · Adequado para regras de negocio e validacoes criticas.

-- 2. DBMS_OUTPUT.PUT_LINE
-- Finalidade:
--   Apenas exibir uma mensagem informativa no buffer de saida da sessao.
-- Características principais:
-- · nao lança erro.
-- · nao interrompe a execucao.
-- · A mensagem so aparece se:
--   · SET SERVEROUTPUT ON estiver habilitado.
--   · O ambiente permitir leitura do buffer (SQL Developer, SQL*Plus, etc.).
-- · nao eh visível para aplicacoes externas.

-----------------------------------------------------------------------------------------------------------


-- Tratamento de Excecoes Pre-definidas Oracle


SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT  p_employee_id PROMPT 'Digite o Id do Empregado: '
DECLARE
    v_first_name   employees.first_name%TYPE;
    v_last_name    employees.last_name%TYPE;
    v_employee_id  employees.employee_id%TYPE := &p_employee_id;
BEGIN
    SELECT first_name, last_name
      INTO v_first_name, v_last_name
      FROM employees
     WHERE employee_id = v_employee_id;
    
    DBMS_OUTPUT.PUT_LINE('Empregado: ' || v_first_name || ' ' || v_last_name);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Empregado nao encontrado, id = ' || TO_CHAR(v_employee_id)); -- Na mensagem eh possivel colocar uma variavel
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle - ' || SQLCODE || SQLERRM);
END;