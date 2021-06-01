#!/bin/bash
shopt -s nocasematch
for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)
    case "$KEY" in
            request)          REQUEST=${VALUE} ;;
            url)              URL=${VALUE} ;;
            id)               ID=${VALUE} ;;
            token)            TOKEN=${VALUE} ;;
            data_file)        DATA_FILE=${VALUE} ;;
            *)
    esac
done

echo "REQUEST TYPE: $REQUEST"
echo "URL: $URL"
echo "ID: $ID"
echo "TOKEN: $TOKEN"
echo "DATA_FILE: $DATA_FILE"

curl -k --location --request $REQUEST "$URL" \
  -H 'Accept: application/json'              \
  -H 'Content-Type: application/json'        \
  -H "id: $ID"                               \
  -H "token: $TOKEN"                         \
  --data "@$DATA_FILE"                       \
  -v | jq .
