-- Gerenciando Dependências automático do Oracle

-- · Sempre que um objeto do banco de dados for alterado, 
--   todos os objetos do mesmo banco de dados que dependem diretamente ou indiretamente dele são invalidados (status 'INVALID') automaticamente em cascata.
-- · Quando um programa fizer uma chamada a uma Procedure ou Função com status 'INVALID' o Oracle automaticamente tentará recompilar o objeto


-- Consultando Dependencias Diretas dos objetos do seu schema utilizando a visao USER_DEPENDENCIES 

DESC user_dependencies

SELECT *
  FROM user_dependencies
 WHERE referenced_name = 'EMPLOYEES' AND referenced_type = 'TABLE';
       
-- Consultando Dependencias Diretas e Indiretas dos objetos do seu schema utilizando a visao USER_DEPENDENCIES 

SELECT *
  FROM user_dependencies
 START WITH referenced_name = 'EMPLOYEES'   -- inicia lendo a hierarquia pela tabela employess
       AND referenced_type = 'TABLE'
CONNECT BY PRIOR name = referenced_name     -- SQL hierárquico pela árvore da hierarquia
             AND type = referenced_type;
                  

-- Consultando Dependencias Diretas e Indiretas dos objetos de todos schemas utilizando a visao DBA_DEPENDENCIES        

-- Conecte-se como SYS

DESC DBA_DEPENDENCIES

SELECT *
  FROM dba_dependencies
 START WITH referenced_owner = 'HR' AND referenced_name = 'EMPLOYEES' AND referenced_type = 'TABLE'
CONNECT BY PRIOR owner = referenced_owner AND name =  referenced_name AND type =  referenced_type;
                  
-- Consultando objetos InvÃ¡lidos do schema do seu usuÃ¡rio 

DESC USER_OBJECTS

SELECT object_name, object_type, last_ddl_time, timestamp, status
  FROM user_objects
 WHERE status = 'INVALID';
 
---------------------------------------------------------------------------------------------------------------------


-- Executando o script UTLDTREE

-- · Crie as visões DEPTREE e IDEPTREE executando o script "utldtree.sql" fornecido juntamente com o banco de dados Oracle
-- · O script "utldtree.sql" pode ser encontrado no diretório: ORACLE HOME/rdbms/admin
-- · Execute o script "utldtree.sql" conectado com o usuário owner do objeto para o qual você deseja analisar as dependências



-- Utilizando as Visoes DEPTREE e IDEPTREE

-- Executando o script UTLDTREE

@C:\app\Emilio\product\18.0.0\dbhomeXE\rdbms\admin\utldtree.sql  

@C:\app\marco\product\18.0.0\dbhomeXE\rdbms\admin\utldtree.sql

-- Obs.: Substitua o caminho de pastas pelo sua instalacao

-- Executando a procedure DEPTREE_FILL

exec DEPTREE_FILL('TABLE','HR','EMPLOYEES')

-- Utilizando as Visoes DEPTREE

DESC deptree

SELECT *
  FROM deptree
 ORDER by seq#;


-- Utilizando as Visoes IDEPTREE

desc ideptree

SELECT *
  FROM ideptree;


