#!/bin/bash

# --- Wine check ---
if command -v wine >/dev/null 2>&1; then
    echo "Wine is already installed."
else
    echo "Wine is not installed. Installing..."
    if command -v brew >/dev/null 2>&1; then
        brew install --cask wine-stable
    else
        echo "Homebrew not found. Install Homebrew first: https://brew.sh/"
        exit 1
    fi
fi

# --- Python check ---
if command -v python3 >/dev/null 2>&1; then
    echo "Python3 installed."
else
    echo "Installing Python3..."
    brew install python3
fi

# --- Set download folder ---
DEST="$HOME/bedrock-server"
mkdir -p "$DEST"
cd "$DEST" || exit 1

API_URL="https://net-secondary.web.minecraft-services.net/api/v1.0/download/links"
DOWNLOAD_URL=$(curl -sL "$API_URL" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    links = data.get('result', {}).get('links', [])
    win_links = [l.get('downloadUrl') for l in links if l.get('downloadType')=='serverBedrockWindows']
    print(win_links[0] if win_links else '')
except Exception as e:
    print('', end='')
")

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Failed to get Bedrock server download URL."
    exit 1
fi

ZIP_FILE="$DEST/bedrock-server.zip"
echo "Downloading latest Bedrock server from $DOWNLOAD_URL ..."
curl -L -A "Mozilla/5.0" -o "$ZIP_FILE" "$DOWNLOAD_URL"

if [ ! -f "$ZIP_FILE" ]; then
    echo "Download failed."
    exit 1
fi

echo "Unzipping server..."
for zip in bedrock-server*.zip; do
    [ -f "$zip" ] || continue
    unzip -o "$zip" -d "$DEST"
done

rm "$ZIP_FILE"

echo ""
echo "Bedrock server is ready in '$DEST'."
echo "Run it with:"
echo "  cd $DEST"
echo "  wine bedrock_server.exe"
echo ""
echo "You may also want to edit 'server.properties' before first launch."
