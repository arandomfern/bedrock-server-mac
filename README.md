# Bedrock Server for Mac

A script to run Bedrock server on Mac

----

Quick start:

Install homebrew
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

Chmod the script
`chmod +x bedrockserverinstaller.sh`

Run it
`./bedrockserverinstaller.sh`

After its installed:
`cd bedrock-server`
`wine bedrock_server.exe`

Running wine may prompt you to do a system update to install Rosetta 2, for Apple silicon Macs.

You may also have to go into privacy and security settings to allow wine to run

----
Known issues:

You can not run commands. I will make a script that contacts microsoft servers gets ur id and puts it into ops.json for u

