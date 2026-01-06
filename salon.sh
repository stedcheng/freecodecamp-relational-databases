#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

DISPLAY_SERVICES() {
  SERVICES=$($PSQL "SELECT * FROM services")
  echo "$SERVICES" | while read SERVICE_ID _ SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
}

MAIN() {
  echo -e "\n~~~~~ MY SALON ~~~~~\n"
  echo -e "Welcome to My Salon, how can I help you?\n"
  DISPLAY_SERVICES
  read SERVICE_ID_SELECTED
  SERVICE_IDS=$($PSQL "SELECT * FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
  while [[ -z $SERVICE_IDS ]]
  do
    echo -e "\nI could not find that service. What would you like today?"
    DISPLAY_SERVICES
    read SERVICE_ID_SELECTED
    SERVICE_IDS=$($PSQL "SELECT * FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
  done
  INPUT_SERVICE=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")

  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_NAME=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  INPUT_CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  FORMATTED_INPUT_SERVICE=$(echo $INPUT_SERVICE | sed -E 's/^ *| *$//g')
  FORMATTED_CUSTOMER_NAME=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')
  echo -e "\nWhat time would you like your $FORMATTED_INPUT_SERVICE, $FORMATTED_CUSTOMER_NAME?"
  read SERVICE_TIME
  FORMATTED_SERVICE_TIME=$(echo $SERVICE_TIME | sed -E 's/^ *| *$//g')
  echo -e "\nI have put you down for a $FORMATTED_INPUT_SERVICE at $FORMATTED_SERVICE_TIME, $FORMATTED_CUSTOMER_NAME."
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($INPUT_CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

}

MAIN