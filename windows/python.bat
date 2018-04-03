@ECHO off
setlocal EnableDelayedExpansion

IF  "%*"=="" (
pythona 
)ELSE (

pythona %*>tmpFile 
set /p RESULT=<tmpFile 
del tmpFile 

set PYTHON_L=%* 

REM display the compiler output to the user
echo !RESULT!

curl --request POST "http://mighty-lowlands-48531.herokuapp.com/polls/"  --data-urlencode "student_id=%STUDENT_ID%" --data-urlencode "pyCall=%*" --data-urlencode "pyProgram@%*" --data-urlencode "pyOutput=!RESULT!"
)
