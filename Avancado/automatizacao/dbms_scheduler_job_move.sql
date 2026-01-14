BEGIN
    DBMS_SCHEDULER.create_job (
        job_name            => 'JOB_MOVE_ARQUIVO',
        job_type            => 'EXECUTABLE',
        job_action          => 'cmd.exe',
        number_of_arguments => 2,
        enabled             => TRUE
    );

    DBMS_SCHEDULER.set_job_argument_value(
        'JOB_MOVE_ARQUIVO', 1, 'C:\Arquivos_teste\employees.txt'
    );
    
    DBMS_SCHEDULER.set_job_argument_value(
        'JOB_MOVE_ARQUIVO', 2, 'C:\Arquivos\employees.txt'
    );

    --DBMS_SCHEDULER.enable('JOB_MOVE_ARQUIVO');
END;
/

BEGIN
  DBMS_SCHEDULER.run_job(
    job_name => 'JOB_MOVE_ARQUIVO',
    use_current_session => FALSE
  );
END;

-------------------------------------------------------------------------------

-- Funcionou

BEGIN
  DBMS_SCHEDULER.create_job (
    job_name            => 'JOB_MOVE_ARQUIVO_WIN',
    job_type            => 'EXECUTABLE',
    job_action          => 'cmd.exe',
    number_of_arguments => 3,
    enabled             => TRUE,
    auto_drop           => FALSE
  );
END;


BEGIN
  DBMS_SCHEDULER.set_job_argument_value(
    job_name => 'JOB_MOVE_ARQUIVO_WIN',
    argument_position => 1,
    argument_value => '/c'
  );

  DBMS_SCHEDULER.set_job_argument_value(
    job_name => 'JOB_MOVE_ARQUIVO_WIN',
    argument_position => 2,
    argument_value => 'move'
  );

  DBMS_SCHEDULER.set_job_argument_value(
    job_name => 'JOB_MOVE_ARQUIVO_WIN',
    argument_position => 3,
    argument_value => 'C:\Arquivos_teste\employees.txt C:\Arquivos\employees.txt'
  );
END;
/

BEGIN
  DBMS_SCHEDULER.enable('JOB_MOVE_ARQUIVO_WIN');
END;


