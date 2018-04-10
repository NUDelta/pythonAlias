#!/bin/bash

if [[ $# -lt 1 ]]
then
	echo ""
	echo " USAGE: ./setup.sh [StudyID]"
	echo " ex: ./setup.sh 12345"
	echo ""
	exit
fi

#grab student ID
id=$1
shift

#Download the appropriate compiler
	curl -k https://raw.githubusercontent.com/NUDelta/pythonAlias/master/mac/pythonseer.sh -o ~/pythonseer.sh
	curl -k https://raw.githubusercontent.com/NUDelta/pythonAlias/master/mac/pythonseer3.sh -o ~/pythonseer3.sh
	echo 'alias python="~/pythonseer.sh"' >> ~/.bash_profile
	echo 'alias python3="~/pythonseer3.sh"' >> ~/.bash_profile

	echo "export STUDENT_ID=\"ID\"" >> ~/.bash_profile
	echo "export PYTHONSEER_URL=\"http://mighty-lowlands-48531.herokuapp.com\"" >> ~/.bash_profile
	echo "alias has been setup. please close and reopen the terminal."

#make the research compiler executable
chmod 777 ~/pythonseer.sh
chmod 777 ~/pythonseer3.sh
