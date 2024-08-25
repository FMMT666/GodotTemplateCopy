@echo off


rem ========================================================================
rem === Set the name of your template project directory here
rem ===
set srcDir="Akki_TEMPLATE"
rem ===
rem ========================================================================


echo -----

if [%1] == [] (
    :: empty target
    echo ERROR: missing target directory
    echo USAGE: asNewFromTemplate ^<New Project/Directory Name^>
    goto endendend
)

set newDir=%1

if exist "%newDir%" (
    echo ERROR: The directory "%newDir%" already exists.
    goto endendend
)

xcopy "%srcDir%" "%newDir%" /E /I /H /C /K /Y

if %errorlevel% neq 0 (
    echo ERROR: Failed to copy directory
    goto endendend
)

powershell -Command "(Get-Content '%newDir%\project.godot') -replace 'config/name=\"%srcDir%\"', 'config/name=\"%newDir%\"' | Set-Content '%newDir%\project.godot'"


echo DONE


:endendend

