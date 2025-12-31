-- Estruturas de controle de LOOP

-- · LOOP básico: Fornece ações repetitivas sem condições globais
-- · FOR LOOP: Fornece controle de repetições de acoes baseado em um contador
-- . WHILE LOOP Fornece controle de repetições de ações baseado em uma condição
-- . O comando EXIT encerra um LOOP em qualquer tipo de construção.


-- LOOP Basico

SET SERVEROUTPUT ON
ACCEPT pLimite PROMPT 'Digite o valor do limite: '
DECLARE
    vNumero  NUMBER(38) := 1;
    vLimite  NUMBER(38) := &pLimite;
BEGIN
    -- Imprimindo numeros de 1 até o limite
    LOOP 
        DBMS_OUTPUT.PUT_LINE('Numero = ' || to_char(vNumero));
        
        EXIT WHEN vNumero = vLimite;
        
        vNumero := vNumero + 1;
    END LOOP;
END;


-- FOR LOOP

SET SERVEROUTPUT ON
ACCEPT pLimite PROMPT 'Digite o valor do limite: '
DECLARE
    vInicio  INTEGER(3) := 1;
    vFim     NUMBER(38) := &pLimite;
BEGIN
    FOR i IN vinicio..vfim LOOP
        DBMS_OUTPUT.PUT_LINE('Numero = ' || to_char(i) );
    END LOOP;
END;


-- WHILE LOOP

SET SERVEROUTPUT ON
ACCEPT pLimite PROMPT 'Digite o valor do limite: '
DECLARE
    vNumero  NUMBER(38) :=  1;
    vLimite  NUMBER(38) := &pLimite;
BEGIN
    WHILE vNumero <= vLimite LOOP
        DBMS_OUTPUT.PUT_LINE('Numero =  ' || to_char(vNumero));
        vNumero := vNUmero + 1;
    END LOOP;
END;


-- Controlando LOOPs aninhados

SET SERVEROUTPUT ON
DECLARE
    vTotal   NUMBER(38) :=  1;
BEGIN
    <<LOOP1>>
    FOR i IN 1..8 LOOP
        DBMS_OUTPUT.PUT_LINE('I =  ' || to_char(i));
        <<LOOP2>>
        FOR j IN 1..8 LOOP
            DBMS_OUTPUT.PUT_LINE('J =  ' || to_char(j));
            DBMS_OUTPUT.PUT_LINE('Total =  ' || to_char(vTotal,'99G999G999G999G999G999G999G999D99'));
            vTotal := vTotal * 2;
            
            EXIT LOOP1 WHEN vtotal > 1000000;  -- Nesse caso vai sair dos 2 lOOPs pois ao referenciar o LOOP1, mais externo, os LOOPs internos param de executar também
        END LOOP;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total Final =  ' || to_char(vTotal,'99G999G999G999G999G999G999G999D99'));
END;
