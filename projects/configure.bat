@echo off

echo.^>%~dpnx0

setlocal

if not defined NEST_LVL set NEST_LVL=0

set /A NEST_LVL+=1

(
  echo.@echo off
  echo.
  echo.set PROJECT_NAME=orbittools
  echo.set "WCROOT_OFFSET=../../../../_%%PROJECT_NAME%%"
  echo.
  echo.set "ORBITTOOLS_DEPLOY.SVN.REPOROOT=https://%%SVN.HUB_ROOT%%/orbittools/deploy"
  echo.set "ORBITTOOLS_ORBITTOOLS.SVN.REPOROOT=https://%%SVN.HUB_ROOT%%/orbittools/orbittools"
  echo.set "ORBITTOOLS_SQP4.SVN.REPOROOT=https://%%SVN.HUB_ROOT%%/orbittools/sgp4"
  echo.set "ORBITTOOLS_QD.SVN.REPOROOT=https://%%SVN.HUB_ROOT%%/orbittools/qd_"
  echo.
  echo.set "ORBITTOOLS_DEPLOY.GIT.ORIGIN=https://%%GIT.USER%%@%%GIT.HUB_ROOT%%/%%GIT.REPO_OWNER%%/orbittools--deploy.git"
  echo.set "ORBITTOOLS_ORBITTOOLS.GIT.ORIGIN=https://%%GIT.USER%%@%%GIT.HUB_ROOT%%/%%GIT.REPO_OWNER%%/orbittools--orbittools.git"
  echo.set "ORBITTOOLS_SGP4.GIT.ORIGIN=https://%%GIT.USER%%@%%GIT.HUB_ROOT%%/%%GIT.REPO_OWNER%%/orbittools--sgp4.git"
  echo.set "ORBITTOOLS_QD.GIT.ORIGIN=https://%%GIT.USER%%@%%GIT.HUB_ROOT%%/%%GIT.REPO_OWNER%%/orbittools--qd.git"
  echo.
  echo.set "ORBITTOOLS_DEPLOY.GIT2.ORIGIN=https://%%GIT2.USER%%@%%GIT2.HUB_ROOT%%/%%GIT2.REPO_OWNER%%/orbittools-deploy.git"
  echo.set "ORBITTOOLS_ORBITTOOLS.GIT2.ORIGIN=https://%%GIT2.USER%%@%%GIT2.HUB_ROOT%%/%%GIT2.REPO_OWNER%%/orbittools-orbittools.git"
  echo.set "ORBITTOOLS_SGP4.GIT2.ORIGIN=https://%%GIT2.USER%%@%%GIT2.HUB_ROOT%%/%%GIT2.REPO_OWNER%%/orbittools-sgp4.git"
  echo.set "ORBITTOOLS_QD.GIT2.ORIGIN=https://%%GIT2.USER%%@%%GIT2.HUB_ROOT%%/%%GIT2.REPO_OWNER%%/orbittools-qd.git"
  echo.
) > "%~dp0configure.user.bat"

for /F "usebackq eol=	 tokens=* delims=" %%i in (`dir /A:D /B "%~dp0*.*"`) do (
  set "DIR=%%i"
  call :PROCESS_DIR
)

set /A NEST_LVL-=1

if %NEST_LVL% LEQ 0 pause

exit /b 0

:PROCESS_DIR
rem ignore directories beginning by `.`
if "%DIR:~0,1%" == "." exit /b 0

if exist "%~dp0%DIR%\configure.bat" call :CMD "%%~dp0%%DIR%%\configure.bat"

exit /b

:CMD
echo.^>%*
(%*)
