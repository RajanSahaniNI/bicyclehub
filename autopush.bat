@echo off
title Auto Git Pusher - Bicycle Hub Vue App
color 0A

echo ====================================
echo  Auto Git Pusher - Every 30 seconds
echo ====================================
echo.

cd /d E:\bicycle-hub-vue-app

REM Initialize git if needed
if not exist ".git" (
    echo Initializing Git repository...
    git init
    git branch -M main
    git remote add origin https://github.com/Princekrcoder/bicycle-hub-vue-app.git
    echo Please add some files and make initial commit manually first!
    echo Creating initial README if none exists...
    if not exist "README.md" (
        echo # Bicycle Hub Vue App > README.md
        echo Auto-generated README >> README.md
    )
    git add .
    git commit -m "Initial commit"
    git push -u origin main
    pause
)

:loop
cls
echo ====================================
echo  Auto Git Pusher - Every 30 seconds
echo ====================================
echo Last run: %date% %time%
echo.

git add .
git status | findstr /C:"nothing to commit" > nul
if %errorlevel% equ 0 (
    echo No changes to commit.
) else (
    echo Committing changes...
    git commit -m "Auto commit: %date% %time%"
    
    echo Pushing to GitHub...
    git push origin main
    if errorlevel 1 (
        echo Trying master branch instead...
        git push origin master
    )
    echo ✓ Push completed at %time%
)

echo.
echo Next update in 30 seconds...
echo Press Ctrl+C to stop
echo.

timeout /t 30 /nobreak > nul
goto loop 