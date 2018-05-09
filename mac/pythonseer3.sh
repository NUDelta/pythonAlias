# An instrumentation of the java compiler command to log compilation requets on a remote server 

# run javac with the full list of arguments,
# capturing STDERR (2) to STDOUT (&1)
# and store the STDOUT (i.e., the compiler output) in the variable RESULT
if [[ $# -lt 1 ]]
then
 	/usr/bin/script log.txt /bin/bash -c python3

	OUT="`cat log.txt`"
	PYTHON_CALL="$*"

	shift
	while [[ $# -ge 1 ]]
	do
	  OUT="$OUT
	  
	  ---EOF---

	  `cat log.txt`"
	  shift
	done

	PYTHON_PROGRAM="pythonInterpreter"
	PYTHON_CALL="pythonInterpreter"
	curl --request POST "$PYTHONSEER_URL/polls/" \
	         --data-urlencode "student_id=$STUDENT_ID" \
	         --data-urlencode "pyCall=$PYTHON_CALL" \
	         --data-urlencode "pyProgram=$PYTHON_PROGRAM" \
	         --data-urlencode "pyOutput=$OUT" --silent
	rm log.txt
else 
	python3 $@  > >(tee -a stdout.txt) 2> >(tee -a stderr.txt >&2)

 	OUT="`cat stdout.txt`"
 	ERROR="`cat stderr.txt`"

 	#read in python file contents
	PYTHON_PROGRAM="`cat $1`"
	PYTHON_CALL="$*"
	
	shift
	while [[ $# -ge 1 ]]
	do
	  PYTHON_PROGRAM="$PYTHON_PROGRAM
	  
	  ---EOF---

	  `cat $1`"
	  shift
	done

	curl --request POST "$PYTHONSEER_URL/pollsMac/" \
	         --data-urlencode "student_id=$STUDENT_ID" \
	         --data-urlencode "pyCall=$PYTHON_CALL" \
	         --data-urlencode "pyProgram=$PYTHON_PROGRAM" \
	         --data-urlencode "pyOutput=$OUT" \
	         --data-urlencode "pyError=$ERROR" --silent
	rm stderr.txt
	rm stdout.txt
fi