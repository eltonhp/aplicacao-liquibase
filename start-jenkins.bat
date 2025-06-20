@echo off
setlocal

REM Define container name and ports
set CONTAINER_NAME=jenkins-lab
set HOST_PORT=8080
set JENKINS_HOME_DIR=%cd%\jenkins_home

REM Cria pasta persistente
if not exist "%JENKINS_HOME_DIR%" mkdir "%JENKINS_HOME_DIR%"

REM Puxa a imagem oficial do Jenkins LTS
docker pull jenkins/jenkins:lts

REM Executa o Jenkins com Docker
docker run -d ^
  --name %CONTAINER_NAME% ^
  -p %HOST_PORT%:8080 -p 50000:50000 ^
  -v "%JENKINS_HOME_DIR%":/var/jenkins_home ^
  -v //var/run/docker.sock:/var/run/docker.sock ^
  -v "%cd%":/workspace ^
  jenkins/jenkins:lts

echo Jenkins iniciado com sucesso.
echo Acesse em: http://localhost:%HOST_PORT%
echo
echo Para a senha inicial, execute:
echo   docker exec -it %CONTAINER_NAME% cat /var/jenkins_home/secrets/initialAdminPassword
endlocal
