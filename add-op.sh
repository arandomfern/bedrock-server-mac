PERMISSIONS_FILE="permissions.json"

get_xuid() {
    local GAMERTAG="$1"
    local ENCODED_TAG
    ENCODED_TAG=$(echo "$GAMERTAG" | sed 's/ /%20/g')

    local RESPONSE
    RESPONSE=$(curl -s "https://api.geysermc.org/v2/xbox/xuid/$ENCODED_TAG")

    local XUID
    XUID=$(echo "$RESPONSE" | jq -r '.xuid')

    if [ "$XUID" == "null" ]; then
        echo "Error: Unable to retrieve XUID for $GAMERTAG"
        exit 1
    fi

    echo "$XUID"
}

add_permission() {
    local XUID="$1"
    local PERMISSION="operator"

    if [ ! -f "$PERMISSIONS_FILE" ]; then
        echo "[]" > "$PERMISSIONS_FILE"
    fi

    if jq -e --arg xuid "$XUID" '.[] | select(.xuid==$xuid)' "$PERMISSIONS_FILE" > /dev/null; then
        echo "XUID $XUID already has a permission entry."
        return
    fi

    jq --arg xuid "$XUID" --arg perm "$PERMISSION" \
       '. += [{"xuid": $xuid, "permission": $perm}]' \
       "$PERMISSIONS_FILE" > tmp.$$.json && mv tmp.$$.json "$PERMISSIONS_FILE"

    echo "Added $XUID with permission $PERMISSION to $PERMISSIONS_FILE"
}

read -p "Enter gamertag: " GAMERTAG
XUID=$(get_xuid "$GAMERTAG")

add_permission "$XUID"
