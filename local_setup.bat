:: generated from ament_package/template/package_level/local_setup.bat.in
@echo off

:: the current prefix is two levels up from the package specific share folder
for %%p in ("%~dp0..\..") do set "AMENT_CURRENT_PREFIX=%%~fp"

:: always start with an empty list of environment hooks for this package
set "AMENT_ENVIRONMENT_HOOKS[rclpy]="

:: these are the environment hooks of this package
call:ament_append_value AMENT_ENVIRONMENT_HOOKS[rclpy] "%AMENT_CURRENT_PREFIX%\share\rclpy\environment\ament_prefix_path.bat"
call:ament_append_value AMENT_ENVIRONMENT_HOOKS[rclpy] "%AMENT_CURRENT_PREFIX%\share\rclpy\environment\path.bat"
call:ament_append_value AMENT_ENVIRONMENT_HOOKS[rclpy] "%AMENT_CURRENT_PREFIX%\share\rclpy\environment\pythonpath.bat"

:: if not returning the environment hooks to the parent scope
if not defined AMENT_RETURN_ENVIRONMENT_HOOKS (
  :: source all environment hooks of this package
  for %%f in ("%AMENT_ENVIRONMENT_HOOKS[rclpy]:;=";"%") do (
    call:call_file %%f
  )

  set "AMENT_ENVIRONMENT_HOOKS[rclpy]="
)
set "AMENT_CURRENT_PREFIX="

goto:eof


:: Append values to environment variables
:: using semicolons as separators and avoiding leading separators.
:: first argument: the name of the result variable
:: second argument: the value
:ament_append_value
  setlocal enabledelayedexpansion
  :: arguments
  set "listname=%~1"
  set "value=%~2"
  :: expand the list variable
  set "list=!%listname%!"
  :: if not empty, append a semi-colon
  if "!list!" NEQ "" set "list=!list!;"
  :: append the value
  set "list=!list!%value%"
  )
  endlocal & (
    :: set result variable in parent scope
    set "%~1=%list%"
  )
goto:eof

:: Append non-duplicate values to environment variables
:: using semicolons as separators and avoiding trailing separators.
:: first argument: the name of the result variable
:: second argument: the value
:ament_append_unique_value
  setlocal enabledelayedexpansion
  :: arguments
  set "listname=%~1"
  set "value=%~2"
  :: expand the list variable
  set "list=!%listname%!"
  :: check if the list contains the value
  set "is_duplicate="
  if "%list%" NEQ "" (
    for %%v in ("%list:;=";"%") do (
      if "%%~v" == "%value%" set "is_duplicate=1"
    )
  )
  :: if it is not a duplicate append it
  if "%is_duplicate%" == "" (
    :: if not empty, append a semi-colon
    if "!list!" NEQ "" set "list=!list!;"
    :: append the value
    set "list=!list!%value%"
  )
  endlocal & (
    :: set result variable in parent scope
    set "%~1=%list%"
  )
goto:eof

:: Call the specified batch file and output the name when tracing is requested.
:: first argument: the batch file
:call_file
  if "%AMENT_TRACE_SETUP_FILES%" NEQ "" echo call "%~1"
  if exist "%~1" call "%~1%"
goto:eof
