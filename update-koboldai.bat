@echo off
%~d0
cd %~dp0
TITLE KoboldAI - Updater
SET /P M=<loader.settings
IF %M%==1 GOTO drivemap
IF %M%==2 GOTO subfolder
IF %M%==3 GOTO drivemap_B

:subfolder
SET TEMP=%~DP0MINICONDA3
SET TMP=%~DP0MINICONDA3
call miniconda3\condabin\activate
GOTO GIT

:drivemap
subst K: miniconda3 >nul
SET TEMP=K:\
SET TMP=K:\
call K:\python\condabin\activate
GOTO GIT

:drivemap_B
subst B: miniconda3 >nul
SET TEMP=B:\
SET TMP=B:\
call B:\python\condabin\activate
GOTO GIT

:GIT
ECHO 1. KoboldAI Main (The Official stable version of KoboldAI)
ECHO 2. KoboldAI United (Development Version, new features but may break at any time)
SET /P V=Enter your desired version or type your own GIT URL:
IF %V%==1 (
SET origin=https://github.com/koboldai/koboldai-client
SET branch=main
) ELSE (
	IF %V%==2 (
		SET origin=https://github.com/henk717/koboldai
		SET branch=united
	) ELSE (
		SET origin=%v%
		SET /P branch=Specify the GIT Branch:
	)
)

git init     
git remote remove origin
git remote add origin %origin%    
git fetch --all
git checkout %branch% -f
git reset --hard origin/%branch%
cmd /k