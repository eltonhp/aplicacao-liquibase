@echo off
echo Iniciando SQL Server no Docker...

REM Verifica se o container já existe
docker ps -a --filter "name=sqlserver" --format "{{.Names}}" | findstr "sqlserver" > nul
IF %ERRORLEVEL% EQU 0 (
    echo Container 'sqlserver' já existe. Iniciando...
    docker start sqlserver
) ELSE (
    echo Criando e iniciando novo container SQL Server...
    docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=SenhaForte123! -p 1433:1433 --name sqlserver -d mcr.microsoft.com/mssql/server:2022-latest
)

echo SQL Server está pronto na porta 1433.
pause
