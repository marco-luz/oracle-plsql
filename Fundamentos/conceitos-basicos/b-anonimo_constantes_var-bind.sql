-- Bloco Anonimo

SET SERVEROUTPUT ON   -- SET é um comando do SQL*PLUS e deve ser executado fora do bloco PL/SQL
DECLARE
    vNumero1  NUMBER(11,2) := 2000;
    vNumero2  NUMBER(11,2) := 5000;
    vMedia    NUMBER(11,2);
BEGIN
    vMedia := (vnumero1 + vnumero2) / 2;
    DBMS_OUTPUT.PUT_LINE('Media = ' || vMedia);
EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Erro Oracle: ' || SQLCODE || SQLERRM);
END;



-- Declarando Constantes

SET SERVEROUTPUT ON
DECLARE
    vPi    CONSTANT NUMBER(38,15) := 3.141592653589793;
BEGIN
    DBMS_OUTPUT.PUT_LINE('PI = ' ||   vPi);
END;



-- Variavel Bind
-- 
-- · Uma variável tipo BIND é uma variável que você declara em um ambiente externo ao bloco, e então a utiliza para passar valores em tempo de execução, 
--   para um ou mais blocos PL/SQL que podem utilizá-la como qualquer outra variável.
-- · Você pode referenciar variáveis BIND declaradas em um ambiente externo ao bloco dentro do bloco PL/SQL.


SET SERVEROUTPUT ON
VARIABLE gmedia NUMBER
DECLARE
    vnumero1  NUMBER(11,2) := 2000;
    vnumero2  NUMBER(11,2) := 5000;
BEGIN  
    :gmedia := (vnumero1 + vnumero2) / 2;
    DBMS_OUTPUT.PUT_LINE('Media = ' || TO_CHAR(:gmedia));
EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Erro Oracle: ' || SQLCODE || SQLERRM);
END;

