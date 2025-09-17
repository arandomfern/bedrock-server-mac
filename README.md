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

You can not run commands. Use add-op.sh to add operators

----

# add-op.sh

To add an operator, because the commands r broken, you need to use this workaround

Steps:

Install add-op.sh and put it in your server's folder

Give the script permission to run:

`chmod +x add-op.sh`

Run the script:

`./add-op.sh`

It will prompt you to enter your gamertag

`Enter gamertag: ARandomFern`

It should now work.

Edit permissions.json to edit the users permission or just do it in game


