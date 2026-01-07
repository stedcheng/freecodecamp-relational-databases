#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

FORMAT_INFO() {
  FILTERED_DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number = $1")
  echo $FILTERED_DATA | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME MELT_C BOIL_C TYPE_ID ATOMIC_MASS
  do
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_C celsius and a boiling point of $BOIL_C celsius."
  done
}

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
  else
    ATOMIC_NUMBER=""
  fi

  if [[ -z $ATOMIC_NUMBER ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
    if [[ -z $ATOMIC_NUMBER ]]
    then
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
      if [[ -z $ATOMIC_NUMBER ]]
      then
        echo "I could not find that element in the database."
      else
        echo $(FORMAT_INFO $ATOMIC_NUMBER)
      fi
    else
      echo $(FORMAT_INFO $ATOMIC_NUMBER)
    fi
  else
    echo $(FORMAT_INFO $ATOMIC_NUMBER)
  fi
fi

# echo A $ATOMIC_NUMBER
# echo S $SYMBOL
# echo N $NAME