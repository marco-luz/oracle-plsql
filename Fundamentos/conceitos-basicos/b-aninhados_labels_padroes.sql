-- Escopo de Identificadores e Blocos Aninhados

SET SERVEROUTPUT ON
DECLARE
    vbloco1 VARCHAR2(20) := 'Bloco 1';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Referenciando variÃ¡vel do Bloco 1: ' || vbloco1);
    -- Se voce referencia vbloco2 aqui ocorrera Erros
    
    DECLARE
        vbloco2 VARCHAR2(20) := 'Bloco 2';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Referenciando variavel do Bloco 1: ' || vbloco1);
        DBMS_OUTPUT.PUT_LINE('Referenciando variavel do Bloco 2: ' || vbloco2);
    END;
        
    DBMS_OUTPUT.PUT_LINE('Referenciando variÃ¡vel do Bloco 1: ' || vbloco1);
    -- Se voce referencia vbloco2 aqui ocorrera Erro
END;



-- Identificando Blocos atraves de Labels


SET SERVEROUTPUT ON
<<BLOCO1>>
DECLARE
    vbloco1 VARCHAR2(20) := 'Bloco 1';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Referenciando variÃ¡vel do Bloco 1: ' || bloco1.vbloco1);
    -- Se voce referencia vbloco2 aqui ocorrera Erro
    
    <<BLOCO2>>
    DECLARE
        vbloco2 VARCHAR2(20) := 'Bloco 2';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Referenciando variÃ¡vel do Bloco 1: ' || bloco1.vbloco1);
        DBMS_OUTPUT.PUT_LINE('Referenciando variÃ¡vel do Bloco 2: ' || bloco2.vbloco2);
    END;
    
    DBMS_OUTPUT.PUT_LINE('Referenciando variÃ¡vel do Bloco 1: ' || bloco1.vbloco1);
    -- Se voce referencia vbloco2 aqui ocorrera Erro
END;




-------------------------------------------------------------------------------------
-- Padroes de codificacao sugeridos


-- Convenções de Codificação
--
-- Categoria                                Convenção sugerida
-- -------------------------------------    -------------------
-- Comandos SQL                             Letras Maiúsculas
-- Palavras chave                           Letras Maiúsculas
-- Tipos de Dados                           Letras Maiúsculas
-- Nomes de Identificadores e parâmetros    Letras minúsculas
-- Nomes de Tabelas e colunas               Letras minúsculas



-- Convenções de Nomenclatura
-- 
-- Categoria                Convenção
-- ----------------------   -------------
-- Variável                 Prefixo v
-- Constante                Prefixo c
-- Cursor                   Sufixo_cursor
-- Exceção                  Prefixo e
-- Tipo Record              Sufixo_record_type
-- Variável Record          Sufixo_record
-- Parâmetro                Prefixo p
-- Variável Global          Prefixo g


