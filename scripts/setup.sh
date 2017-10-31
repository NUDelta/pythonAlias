#!/bin/bash

if [[ $# -lt 1 ]]
then
  echo ""
  echo "     USAGE: ./setup.sh [StudentID name]"
  echo "        ex: ./setup.sh 12345678 David Weintrop"
  echo ""
  exit
fi

# grab student ID
ID=$1
shift

# Download the appropriate compiler for the user's shell
  # curl -k https://raw.githubusercontent.com/NUDelta/pythonAlias/master/scripts/pythonseer.sh -o ~/pythonseer.sh
  echo "here"
  echo 'alias python="~/pythonseer.sh"' >> ~/.bash_profile
  echo "export STUDENT_ID=\"$ID\"" >> ~/.bash_profile
  echo "export PYTHONSEER_URL=\"http://mighty-lowlands-48531.herokuapp.com\"" >> ~/.bash_profile
  echo "alias has been setup. please close then reopen the terminal."

# Make the research compiler executable
chmod 777  ~/pythonAlias/scripts/pythonseer.sh
