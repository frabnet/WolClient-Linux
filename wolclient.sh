#!/bin/sh

COOKIEFILE="wolclient.cookie"
CONFIGFILE="wolclient.config"

#Read config
if [ -e "$CONFIGFILE" ]; then
        . "./$CONFIGFILE"
else
        echo "Config file \"$CONFIGFILE\" not found."
        exit 1
fi

echo "Sending request..."

#Homepage
RESPONSE=$(curl -sS --insecure --location --cookie-jar "$COOKIEFILE" "$PFSENSEURL")
CSRF=$(echo $RESPONSE | grep -Po "(?<=csrfMagicToken = \")(.*?)(?=\")")

#Login
RESPONSE=$(curl -sS --insecure --location --cookie "$COOKIEFILE" --cookie-jar "$COOKIEFILE" "$PFSENSEURL" --data "__csrf_magic=$CSRF&login=Login&usernamefld=$PFSENSEUSER&passwordfld=$PFSENSEPASSWORD")
CSRF=$(echo $RESPONSE | grep -Po "(?<=csrfMagicToken = \")(.*?)(?=\")")

#WakeOnLan
RESPONSE=$(curl -sS --insecure --location --cookie "$COOKIEFILE" --cookie-jar "$COOKIEFILE" "$PFSENSEURL/services_wol.php" --data "__csrf_magic=$CSRF&if=lan&mac=$MAC&Submit=Send")
CSRF=$(echo $RESPONSE | grep -Po "(?<=csrfMagicToken = \")(.*?)(?=\")")
STATUS=$(echo $RESPONSE | grep -Po "(?<=\<\/button\>\<div class=\"pull-left\"\>)(.*?)(?=\<)")
echo "Result: $STATUS"

#Logout
RESPONSE=$(curl -sS --insecure --location --cookie "$COOKIEFILE" --cookie-jar "$COOKIEFILE" "$PFSENSEURL/index.php?logout" --data "__csrf_magic=$CSRF&logout=\"\"")

rm "$COOKIEFILE"
exit 0