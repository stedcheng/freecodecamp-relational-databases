#!/bin/bash

NUMBER=$(( RANDOM % 1000 + 1 ))
PSQL="psql --username=freecodecamp --dbname=guessing_game -t --no-align -c"

echo Enter your username:
read USERNAME
USERNAME_EXISTS=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME'")
if [[ -z $USERNAME_EXISTS ]]
then
  echo Welcome, $USERNAME! It looks like this is your first time here.
  CREATE_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
else
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id = $USER_ID")
  BEST_SCORE=$($PSQL "SELECT MAX(score) FROM games WHERE user_id = $USER_ID")
  echo Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_SCORE guesses.
fi

echo Guess the secret number between 1 and 1000:
DONE_GUESSING=0

GUESS_NUMBER() {
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    echo That is not an integer, guess again:  
  else
    if [[ $1 < $NUMBER ]]
    then
      echo -e "\nIt's higher than that, guess again:"
    else
      if [[ $1 > $NUMBER ]]
      then
        echo -e "\nIt's lower than that, guess again:"
      else
        DONE_GUESSING=1
      fi
    fi
  fi
}

NUM_GUESSES=0
while (( $DONE_GUESSING == 0 ))
do
  read INPUT
  GUESS_NUMBER $INPUT
  (( NUM_GUESSES++ ))
done

echo You guessed it in $NUM_GUESSES tries. The secret number was $NUMBER. Nice job!
CREATE_GAME=$($PSQL "INSERT INTO games(user_id, score) VALUES($USER_ID, $NUM_GUESSES)")