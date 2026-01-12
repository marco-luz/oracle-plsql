-- 1. CRIANDO UM PROGRAMA

--  Antes habilitar permissão ao usuário hr para criar job (Conectar como SYS)
GRANT CREATE JOB TO hr;

--------------------------------------------------------------------------------
--  Para testar, criando uma tabela, sequence e uma procedure
CREATE TABLE AGENDA (
    agenda_id    NUMBER,
    agenda_data  DATE
);
 
CREATE SEQUENCE AGENDA_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOMAXVALUE
NOCYCLE;

CREATE OR REPLACE PROCEDURE PRC_INSERE_DATA_AGENDA IS
BEGIN
  INSERT INTO hr.agenda
  VALUES (agenda_seq.NEXTVAL, SYSDATE);
  COMMIT;
END;

--------------------------------------------------------------------------------
--  Criando e Habilitado um Programa

BEGIN
    DBMS_SCHEDULER.create_program(
        program_name => 'HR.PRC_INSERE_AGENDA',  -- Nao eh necessario ser o mesmo nome da procedure
        program_action => 'HR.PRC_INSERE_DATA_AGENDA',
        program_type => 'STORED_PROCEDURE',
        number_of_arguments => 0,
        comments => 'Insere dados na agenda',
        enabled => TRUE);  -- criando ja habilitado
/*
    -- se criar nao habilitado, pode habilitar depois
    DBMS_SCHEDULER.ENABLE(name=>'HR.PRC_INSERE_AGENDA');    
*/
END;

--------------------------------------------------------------------------------
-- Vizualisando o programa
-- Na conexao, 
--   Programador (Scheduler)
--   Programas
--     visualize o programa: PRC_INSERE_AGENDA
--------------------------------------------------------------------------------

-- Removendo um Programa
BEGIN
    DBMS_SCHEDULER.drop_program(
        program_name => 'HR.PRC_INSERE_AGENDA',
        force => TRUE);
END;

--______________________________________________________________________________--

-- 2. CRIANDO UMA AGENDA
 
-- Criando um Schedule (a cada 10 segundos)
 
BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE (
        schedule_name  => 'SCH_A_CADA_10_SEGUNDOS',
        start_date     => SYSTIMESTAMP,       --start_date => TO_TIMESTAMP_TZ('2020-03-17 15:17:36.000000000 AMERICA/SAO_PAULO','YYYY-MM-DD HH24:MI:SS.FF TZR'),
        repeat_interval  => 'FREQ=SECONDLY;INTERVAL=10',  -- a cada segundo, intervalo de 10 segundos
        end_date => TO_TIMESTAMP_TZ('2026-01-12 11:40:00.000000000 AMERICA/SAO_PAULO','YYYY-MM-DD HH24:MI:SS.FF TZR'),
        comments => 'A cada 10 segundos'
    );
END;
--  * start_date:      quando o schedule se tornará ativo, data de inicio de execucao
--  * end_date:        data de encerramento da execucao
--  * repeat_interval: frequencia de execucao do job, utilizando dados do calendario ou sintaxe PL/SQL
--      três partes: clausula de frequencia | intervalo de repeticao | outra clausula de frequencia
--        clausula de frequencia: YEARLY: anualmente
--                                MONTHLY: mensalmente
--                                WEEKLY: semanamente
--                                DAILY: diariamente
--                                HOURLY: | MINUTELY: | SECONDLY:
--  * intervalo de repeticao: 1 a 99
--        outra clausula de freq: BYMONTHLY: por mes
--                                BYWEEKNO: por dia de semana
--                                BYYEARDAY: por dia do ano
--                                BYMONTHDAY: por dia do mes
--                                BYDAY: pelo dia
--                                BYHOUR: | BYMINUTE: | BYSECOND:
--    Exemplo: Todo dia 20 do mes, sem intevalo de repatição (valor default: 1, ou seja, de 1 em 1 mês)
--             'FREQ=MONTHLY;BYMONTHDAY=20'
--    Exemplo: A cada 60 dias
--             'FREQ=DAILY;INTERVAL=60'



--Removendo um Schedule 
BEGIN
    DBMS_SCHEDULER.DROP_SCHEDULE (
        schedule_name  => 'SCH_A_CADA_10_SEGUNDOS',
        force    => FALSE  -- sendo referenciado por um job
        );
END;

--______________________________________________________________________________--

-- 3. CRIANDO UM JOB

BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name => '"HR"."JOB_INSERE_DATA_AGENDA"',
        program_name => '"HR"."PRC_INSERE_AGENDA"',
        schedule_name => '"HR"."SCH_A_CADA_10_SEGUNDOS"',
        enabled => TRUE,
        auto_drop => FALSE,  -- remove o job apos a execucao
        comments => 'Job Insere Data na Agenda',             
        job_style => 'REGULAR');
/*
    DBMS_SCHEDULER.enable(
             name => '"HR"."JOB_INSERE_DATA_AGENDA"');
*/
END;


-- Consultando a tabela AGENDA

SELECT agenda_id, TO_CHAR(agenda_data,'dd/mm/yyyy hh24:mi:ss') AGENDA_DATA
  FROM agenda
 ORDER BY agenda_id DESC;


-- Interromper o job

BEGIN
	DBMS_SCHEDULER.STOP_JOB (
	     job_name => '"HR"."JOB_INSERE_DATA_AGENDA"',
	     force => TRUE);
END;



-- Remover o job

BEGIN
	DBMS_SCHEDULER.DROP_JOB (
	     job_name => '"HR"."JOB_INSERE_DATA_AGENDA"',
	     force => TRUE);
END;


 
