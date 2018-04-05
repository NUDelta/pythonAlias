@ECHO off
setlocal EnableDelayedExpansion

IF  "%*"=="" (
pythona 
)ELSE (

pythona %* > tmpFile.txt 2>&1 
type tmpFile.txt
curl --request POST "http://mighty-lowlands-48531.herokuapp.com/polls/"  --data-urlencode "student_id=%STUDENT_ID%" --data-urlencode "pyCall=%*" --data-urlencode "pyProgram@%*" --data-urlencode "pyOutput@tmpFile.txt" 
del tmpFile.txt
)