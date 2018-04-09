# An instrumentation of the java compiler command to log compilation requets on a remote server 

# run javac with the full list of arguments,
# capturing STDERR (2) to STDOUT (&1)
# and store the STDOUT (i.e., the compiler output) in the variable RESULT

if [[ $# -lt 1 ]]
then
python
else 	

RESULT=$(python $@ 2>&1)
PYTHON_CALL="$*"

# read in python file contents
PYTHON_PROGRAM="`cat $1`"
shift
while [[ $# -ge 1 ]]
do
  PYTHON_PROGRAM="$PYTHON_PROGRAM
  
  ---EOF---

  `cat $1`"
  shift
done

fi


# post the data to the server
# note PYTHONSEER_URL and STUDENT_ID are environment vars set by setup.sh
curl --request POST "$PYTHONSEER_URL/polls/" \
          --data-urlencode "student_id=$STUDENT_ID" \
          --data-urlencode "pyCall=$PYTHON_CALL" \
          --data-urlencode "pyProgram=$PYTHON_PROGRAM" \
          --data-urlencode "pyOutput=$RESULT" --silent

# display the compiler output to the user
echo "$RESULT"
